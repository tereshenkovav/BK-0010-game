	.LINK 1000

        EMT     14
	MOV    #233,R0  ; режим 32 символа
	EMT    16
	MOV    #232,R0  ; скрытие курсора
	EMT    16
	; Запрещаем прерывания от клавиатуры, чтобы не мешало игре
	BIS	#100,@#177660 

	; Начальная позиция пони, скорость, взгляд
	MOV	#200,@#PONYX
	MOV	@#PONYX,@#PONYRENDERX
	MOV	#0,@#PONYDX
	MOV	#4,@#PONYDIR

        ; Инициализация массива ссылок на спрайты
        MOV	#ARR_SPRITES,R0
        MOV	#SPRDIAMOND1,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND2,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND3,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND4,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND5,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND6,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND7,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND8,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND9,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND10,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND11,(R0)
        ADD	#2,R0
        MOV	#SPRDIAMOND12,(R0)
        ADD	#2,R0

	; Инициализация массива алмазов
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_INIT:
	MOV	#-1,(R0)
	ADD	#2,R0
	MOV	#0,(R0)
	ADD	#2,R0
	MOV	#0,(R0)
	ADD	#2,R0
	SOB 	R1,CICLE_INIT

	; Временные данные алмазов	
        MOV	#ARR_DIAMONDS,R0
	MOV	#0,(R0)
	ADD	#2,R0
	MOV	#100,(R0)
	ADD	#2,R0
	MOV	#200,(R0)
	ADD	#2,R0

	MOV	#2,(R0)
	ADD	#2,R0
	MOV	#200,(R0)
	ADD	#2,R0
	MOV	#150,(R0)
	ADD	#2,R0

	MOV	#5,(R0)
	ADD	#2,R0
	MOV	#300,(R0)
	ADD	#2,R0
	MOV	#250,(R0)
	ADD	#2,R0

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

END_KEY:        

; ===== блок чистки старой сцены ======
        CMP	@#PONYX, @#PONYRENDERX
        BEQ	NO_CLEARZONE
        ;[!] Добавить выбор, где чистить, чтобы избежать лишних вызовов

	; Затирание прямого хода
        MOV	@#PONYRENDERX,-(SP)   ; X
        MOV	#300,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        ; Затирание обратного хода с конца
        MOV	@#PONYRENDERX,R0
	ADD	#34,R0
        MOV	R0,-(SP)   ; X - в конце спрайта при обратном ходе
        MOV	#300,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

NO_CLEARZONE:

; ===== блок рендера ======

        CMP	@#PONYDIR,#4      ; Выбор типа спрайта
	BNE     MIRRPONYSPR
        MOV	#SPRUNICORN,-(SP)   ; Спрайт
        JMP	DODRAWPONYSPR
MIRRPONYSPR:
        MOV	#SPRUNICORN_MIRR,-(SP)   ; Спрайт
DODRAWPONYSPR:
        MOV	@#PONYX,-(SP)   ; X
        MOV	#300,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	@#PONYX,@#PONYRENDERX   ; Запомним позицию рендера

        ; Вывод алмазов
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_RENDER:
	MOV	(R0),R2
	CMP	R2,#-1
	BEQ	SKIP_ARRAY_ELEM

	MOV	#ARR_SPRITES,R3
	ADD	R2,R3
	ADD	R2,R3
        MOV	(R3),-(SP)   ; Спрайт алмаза
        ADD	#2,R0
        MOV	(R0),-(SP)   ; X
      	ADD	#2,R0
        MOV	(R0),-(SP)  ; Y
       	ADD	#2,R0
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        SOB 	R1,CICLE_DIAMONDS_RENDER
SKIP_ARRAY_ELEM:
        ADD	#6,R0
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

; ===== блок формирования длины фрейма ======
TIMERCICLEWAIT:
        BIT	#200,@#177712 ; Тестируем признак прохода через ноль - бит 7
        BEQ	TIMERCICLEWAIT         ; Крутим, пока не дошли

	JMP 	START

	HALT

.include "proc_drawsprite.inc"
.include "proc_keytester.inc"
.include "sprites.inc"

PONYX:      .WORD   0
PONYRENDERX:      .WORD   0
PONYDX:     .WORD   0
PONYDIR:    .WORD   0
ARR_DIAMONDS_SIZE: .WORD 32
ARR_DIAMONDS: .WORD 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
              .WORD 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
              .WORD 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
              .WORD 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
ARR_SPRITES: .WORD 0,0,0,0, 0,0,0,0, 0,0,0,0
.EVEN
.END

make_bk0010_rom "ponydiamonds.bin", 1000
