	.LINK 1000

        EMT     14
	MOV    #233,R0  ; режим 32 символа
	EMT    16
	MOV    #232,R0  ; скрытие курсора
	EMT    16

	MOV	#40000,R0
	MOV	#17000,R1
FILL_ZERO:
        MOV	#0,(R0)+
	SOB	R1,FILL_ZERO

	MOV	#1000,R1
FILL_GROUND:
        MOV	#125252,(R0)+
	SOB	R1,FILL_GROUND

	MOV	#0,@#212  ; цвет и фон
	MOV	#125252,@#214   

	; Запрещаем прерывания от клавиатуры, чтобы не мешало игре
	BIS	#100,@#177660 

	; Начальная позиция пони, скорость, взгляд
	MOV	#200,@#PONYX
	MOV	#320,@#PONYY
	MOV	@#PONYX,@#PONYRENDERX
	MOV	#0,@#PONYDX
	MOV	#4,@#PONYDIR
	MOV	#0,@#TEKSCORE
	MOV	#10,@#DIAMONDSDROP
	MOV	#0,@#DIAMONDSONAIR
	MOV	#0,@#GAMEOVER

	MOV	@#GENINTERVAL,@#GENCOUNTER

	JSR PC, @#SUB_PRINTCAPTIONS
        JSR PC, @#SUB_PRINTSCORE
        JSR PC, @#SUB_PRINTDIAMONDS

        MOV	#123,R0 ; Начальное значение генерации
        JSR PC, @#SETRNDSEED

        ; Инициализация массива ссылок на спрайты
        MOV	#ARR_SPRITES,R0
        MOV	#SPRDIAMOND1,(R0)+
        MOV	#SPRDIAMOND2,(R0)+
        MOV	#SPRDIAMOND3,(R0)+
        MOV	#SPRDIAMOND4,(R0)+
        MOV	#SPRDIAMOND5,(R0)+
        MOV	#SPRDIAMOND6,(R0)+
        MOV	#SPRDIAMOND7,(R0)+
        MOV	#SPRDIAMOND8,(R0)+
        MOV	#SPRDIAMOND9,(R0)+
        MOV	#SPRDIAMOND10,(R0)+
        MOV	#SPRDIAMOND11,(R0)+
        MOV	#SPRDIAMOND12,(R0)+

	; Инициализация массива алмазов
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_INIT:
	MOV	#-1,(R0)+
	MOV	#0,(R0)+
	MOV	#0,(R0)+
	SOB 	R1,CICLE_INIT

START:
	MOV	#3777,@#177706  ; Длительность фрейма (3777 - примерно 10 FPS)
        MOV	#24,@#177712  ; Разрешаем счет и индикацию

; ===== блок опроса клавиатуры ======
        JSR PC, @#KEY_TESTER

	CMP	R1,#0       ;не было нажатий и нет удержания
        BEQ     END_KEY

        CMP	R1,#2       ; если режим удержания (2), пропускаем
        BEQ     END_KEY

        ; Иначе режим нажатия (1) и мы его парсим
	CMP	R0,#31      ; клавиша "курсор вправо"?
	BNE     KEYSTEP1
       	MOV	#4,@#PONYDX ; Смена скорости
       	MOV	#4,@#PONYDIR; Смена поворота
KEYSTEP1:  
	CMP	R0,#10      ; клавиша "курсор влево"?
	BNE     KEYSTEP2
       	MOV	#-4,@#PONYDX ; Смена скорости
       	MOV	#-4,@#PONYDIR; Смена поворота
KEYSTEP2:
	CMP	R0,#40      ; клавиша "пробел"?
	BNE     KEYSTEP3
       	MOV	#0,@#PONYDX ; Смена скорости
KEYSTEP3:
	CMP	R0,#12      ; клавиша "ввод"?
	BNE     KEYSTEP4
	CMP	#1,@#GAMEOVER
	BNE	KEYSTEP4
       	HALT
KEYSTEP4:

END_KEY:        

; ===== блок чистки старой сцены ======
        CMP	@#PONYX, @#PONYRENDERX
        BEQ	NO_CLEARZONE
        ;[!] Добавить выбор, где чистить, чтобы избежать лишних вызовов

	; Затирание прямого хода
        MOV	@#PONYRENDERX,-(SP)   ; X
        MOV	@#PONYY,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        ; Затирание обратного хода с конца
        MOV	@#PONYRENDERX,R0
	ADD	#34,R0
        MOV	R0,-(SP)   ; X - в конце спрайта при обратном ходе
        MOV	@#PONYY,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

NO_CLEARZONE:

        ; Затирание алмазов
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_CLEAR:
	MOV	(R0)+,R2
	CMP	R2,#-1
	BEQ	SKIP_ARRAY_ELEM3

        MOV	(R0)+,-(SP)   ; X
        MOV	(R0)+,R3
        SUB	@#DIAMONDSPEED,R3
        MOV	R3,-(SP)  ; Y
        MOV	#10,-(SP)  ; DX 
        MOV	@#DIAMONDSPEED,-(SP)  ; DY - размер затираемой области по движению
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов
        
        SOB 	R1,CICLE_DIAMONDS_CLEAR
SKIP_ARRAY_ELEM3:
        ADD	#4,R0
	SOB 	R1,CICLE_DIAMONDS_CLEAR

; ===== блок рендера ======

        CMP	@#PONYDIR,#4      ; Выбор типа спрайта
	BNE     MIRRPONYSPR
        MOV	#SPRUNICORN,-(SP)   ; Спрайт
        JMP	DODRAWPONYSPR
MIRRPONYSPR:
        MOV	#SPRUNICORN_MIRR,-(SP)   ; Спрайт
DODRAWPONYSPR:
        MOV	@#PONYX,-(SP)   ; X
        MOV	@#PONYY,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	@#PONYX,@#PONYRENDERX   ; Запомним позицию рендера

        ; Вывод алмазов
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_RENDER:
	MOV	(R0)+,R2
	CMP	R2,#-1
	BEQ	SKIP_ARRAY_ELEM

	MOV	#ARR_SPRITES,R3
	ADD	R2,R3
	ADD	R2,R3
        MOV	(R3),-(SP)   ; Спрайт алмаза
        MOV	(R0)+,-(SP)   ; X
        MOV	(R0)+,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        SOB 	R1,CICLE_DIAMONDS_RENDER
SKIP_ARRAY_ELEM:
        ADD	#4,R0
	SOB 	R1,CICLE_DIAMONDS_RENDER

; ===== блок обновления состояния игры ======
	ADD	@#PONYDX,@#PONYX ; Движение
	CMP	@#PONYX,#0
	BGE     NEXT_FRAME_1
	MOV	#0,@#PONYX
NEXT_FRAME_1:
	CMP	@#PONYX,#340
	BLE     NEXT_FRAME_2
	MOV	#340,@#PONYX
NEXT_FRAME_2:

        ; обсчет алмазов
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_FRAME:
	MOV	(R0)+,R2
	CMP	R2,#-1
	BEQ	SKIP_ARRAY_ELEM2

	MOV	(R0)+,R4 ; Запомним X в R4 для хитбокса
        ; Добавляем скорость к Y
        ADD	@#DIAMONDSPEED,(R0)

        ; Если нужно, помечаем алмаз как удаленный
        MOV	R2,R3   ; idx
        MOV	(R0),R5   ; Y
        JSR PC, @#SUB_HITBOX
        CMP	R4,#0
        BEQ	SKIP_REMOVE_DIAMOND

        SUB	#4,R0
	MOV	#-1,(R0)+

	; И затираем его
        MOV	(R0)+,-(SP)   ; X
        MOV	(R0),R3
        SUB	@#DIAMONDSPEED,R3
        MOV	R3,-(SP)  ; Y
        MOV	#10,-(SP)  ; DX 
        MOV	#40,-(SP)  ; DY 
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

	ADD	R5,@#TEKSCORE
	DEC	@#DIAMONDSONAIR
	JSR PC, @#SUB_PRINTSCORE
        JSR PC, @#SUB_PRINTDIAMONDS

        MOV	@#DIAMONDSONAIR,R3
        ADD	@#DIAMONDSDROP,R3
        CMP	R3,#0
	BNE	SKIP_REMOVE_DIAMOND

	MOV	#1,@#GAMEOVER
	JSR PC, @#SUB_PRINTGAMEOVER

SKIP_REMOVE_DIAMOND:	
	ADD	#2,R0

        SOB 	R1,CICLE_DIAMONDS_FRAME
SKIP_ARRAY_ELEM2:
        ADD	#4,R0
	SOB 	R1,CICLE_DIAMONDS_FRAME

	; Генерация новых алмазов
	CMP	@#DIAMONDSDROP,#0
	BEQ	SKIP_NEW_DIAMOND

	DEC	@#GENCOUNTER
	CMP	@#GENCOUNTER,#0
	BNE	SKIP_NEW_DIAMOND
	
	MOV	@#GENINTERVAL,@#GENCOUNTER
	DEC	@#DIAMONDSDROP
	INC	@#DIAMONDSONAIR

        JSR PC, @#SUB_PRINTDIAMONDS
	
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_NEW:
	CMP	(R0),#-1
	BNE	SKIP_ARRAY_ELEM4

	MOV	R0,R2 ; save

        MOV	#17,R0 ; Указываем число в интервале от 0 до 15
        JSR PC, @#GENRNDVALUE
	CMP	R0,#13
	BLT	NO_SUB_RND1
	SUB	#4,R0
NO_SUB_RND1:
	MOV	R0,R3

        MOV	#377,R0 ; Указываем число в интервале от 0 до 255
        JSR PC, @#GENRNDVALUE
	CMP	R0,#337
	BLT	NO_SUB_RND2
	SUB	#40,R0
NO_SUB_RND2:
	MOV	R0,R4

	MOV	R2,R0 ; restore

       	MOV	R3,(R0)+
	MOV	R4,(R0)+
	MOV	@#DIAMONDSTARTY,(R0)

        JMP	SKIP_NEW_DIAMOND
SKIP_ARRAY_ELEM4:
        ADD	#6,R0
	SOB 	R1,CICLE_DIAMONDS_NEW

SKIP_NEW_DIAMOND:
	
; ===== блок формирования длины фрейма ======
TIMERCICLEWAIT:
        BIT	#200,@#177712 ; Тестируем признак прохода через ноль - бит 7
        BEQ	TIMERCICLEWAIT         ; Крутим, пока не дошли

	JMP 	START

	HALT

.include "proc_drawsprite.inc"
.include "proc_keytester.inc"
.include "proc_genrnd.inc"
.include "proc_int2str.inc"
.include "sub_prints.inc"
.include "sub_hitbox.inc"
.include "sprites.inc"

PONYX:      .WORD   0
PONYY:      .WORD   0
PONYRENDERX:      .WORD   0
PONYDX:     .WORD   0
PONYDIR:    .WORD   0
DIAMONDSPEED:    .WORD   4
LOWBORDER:    .WORD   320
DIAMONDSTARTY:  .WORD   34
DIAMONDSDROP:  .WORD   0
DIAMONDSONAIR:  .WORD   0
GENINTERVAL:	.WORD  14
GENCOUNTER:    .WORD   0
TEKSCORE:	.WORD	0
GAMEOVER:	.WORD	0
DEBUG:	.WORD	0
STRBUF:    .BYTE   0,0,0,0,0,0 
ARR_DIAMONDS_SIZE: .WORD 32
ARR_DIAMONDS: .WORD 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
              .WORD 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
              .WORD 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
              .WORD 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
ARR_SPRITES: .WORD 0,0,0,0, 0,0,0,0, 0,0,0,0
ARR_SCORES:  .WORD 1,2,3, 4,5,6, 7,10,11, 12,13,14
MSGSCORE:    .ASCIZ  "SCORE:"
MSGDIAMONDS: .ASCIZ  "DIAMONDS:"
MSGGAMEOVER: .ASCIZ  "GAME OVER, PRESS ENTER TO MENU"
.EVEN
.END

make_bk0010_rom "ponydiamonds.bin", 1000
