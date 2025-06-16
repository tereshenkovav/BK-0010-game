        EMT     14
	MOV    #233,R0  ; режим 32 символа
	EMT    16
	MOV    #232,R0  ; скрытие курсора
	EMT    16

	MOV	#0,@#212  ; цвет и фон
	MOV	#125252,@#214   

	; Запрещаем прерывания от клавиатуры, чтобы не мешало игре
	BIS	#100,@#177660 
	; Ставим на СТОП полный выход
	MOV	#EXIT_BY_STOP,@#4

INTRO_REPLAY:
	JSR PC, @#SHOW_INTRO

        MOV	#0,R5
MENU_KEY_WAIT_INTRO:
        JSR PC, @#IS_KEY_PRESSED

        INC	R5
	CMP	R5,#120000
	BEQ	MAIN_MENU_ENTRY

	CMP	R0,#0       ;не было нажатий
        BEQ     MENU_KEY_WAIT_INTRO

MAIN_MENU_ENTRY:
	JSR PC, @#CLEAR_SCREEN
	JSR PC, @#SUB_PRINTMENU

        MOV	#20,-(SP)   ; X
        MOV	#62,-(SP)  ; Y
        MOV	#156,-(SP)  ; Height
        MOV	#2,-(SP)  ; Color
        JSR PC, @#DRAW_VERT_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#360,-(SP)   ; X
        MOV	#62,-(SP)  ; Y
        MOV	#156,-(SP)  ; Height
        MOV	#2,-(SP)  ; Color
        JSR PC, @#DRAW_VERT_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#20,-(SP)   ; X
        MOV	#62,-(SP)  ; Y
        MOV	#340,-(SP)  ; Width
        MOV	#125252,-(SP)  ; Color
        JSR PC, @#DRAW_HORZ_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#20,-(SP)   ; X
        MOV	#120,-(SP)  ; Y
        MOV	#340,-(SP)  ; Width
        MOV	#125252,-(SP)  ; Color
        JSR PC, @#DRAW_HORZ_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#20,-(SP)   ; X
        MOV	#237,-(SP)  ; Y
        MOV	#340,-(SP)  ; Width
        MOV	#125252,-(SP)  ; Color
        JSR PC, @#DRAW_HORZ_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

	MOV	#ARR_SPRITES,R2	
        MOV	(R2)+,-(SP)   ; Спрайт алмаза
        MOV	#70,-(SP)   ; X
        MOV	#24,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	(R2)+,-(SP)   ; Спрайт алмаза
        MOV	#170,-(SP)   ; X
        MOV	#24,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	(R2)+,-(SP)   ; Спрайт алмаза
        MOV	#270,-(SP)   ; X
        MOV	#24,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRUNICORN,-(SP)   ; Спрайт
        MOV	#154,-(SP)   ; X
        MOV	#250,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

	MOV	#0,R5  ; Накопление случайного значения
MENU_KEY_WAIT:
        INC	R5
        JSR PC, @#IS_KEY_PRESSED

	CMP	R0,#0       ;не было нажатий
        BEQ     MENU_KEY_WAIT

        ; Иначе парсим
	CMP	R0,#61      ; клавиша "1"
	BNE     KEYMENU1
	MOV	#14,@#DIFFGENTYPE
        JMP 	GAME_START_ENTRY
KEYMENU1:
	CMP	R0,#62      ; клавиша "2"
	BNE     KEYMENU2
	MOV	#15,@#DIFFGENTYPE
        JMP 	GAME_START_ENTRY
KEYMENU2:
	CMP	R0,#63      ; клавиша "3"
	BNE     KEYMENU3
	MOV	#1,R2
	SUB	@#SOUNDON,R2
	MOV	R2,@#SOUNDON
	JSR PC, @#SUB_PRINTSOUND
        JMP 	MENU_KEY_WAIT
KEYMENU3:
	CMP	R0,#64      ; клавиша "4"
	BNE     KEYMENU4
	MOV	#1,R2
	SUB	@#JOYSTICKON,R2
	MOV	R2,@#JOYSTICKON
	JSR PC, @#SUB_PRINTJOYSTICK
        JMP 	MENU_KEY_WAIT
KEYMENU4:
	CMP	R0,#65      ; клавиша "5"
	BNE     KEYMENU5
        JMP 	HELP_ENTRY
KEYMENU5:
	CMP	R0,#66      ; клавиша "6"
	BNE     KEYMENU6
        JMP 	INTRO_REPLAY
KEYMENU6:
	CMP	R0,#60      ; клавиша "0"
	BNE     KEYMENU7
	EMT	14
	HALT
KEYMENU7:
       	JMP 	MENU_KEY_WAIT

HELP_ENTRY:
	JSR PC, @#CLEAR_SCREEN
        MOV	#HELPSCENE,R0
	JSR PC, @#PRINT_SCENE

MENU_HELP_WAIT:
        JSR PC, @#IS_KEY_PRESSED

	CMP	R0,#0       ;не было нажатий 
        BEQ     MENU_HELP_WAIT

        JMP MAIN_MENU_ENTRY

GAME_START_ENTRY:
        MOV	R5,R0 ; Начальное значение генерации
        JSR PC, @#SETRNDSEED

	; Очистка и заливка земли
	MOV	#40000,R0
FILL_SKY:
	CLR	(R0)+
	CMP	R0,#76000
        BNE	FILL_SKY

	MOV	#ARR_GROUND_PATTERNS,R1

FILL_GROUND:

	MOV	#40,R2
FILL_GROUND_ROW:
        MOV	(R1),(R0)+
	SOB	R2,FILL_GROUND_ROW

	ADD	#2,R1
	CMP	(R1),#0
	BNE	FILL_GROUND

	; Линии интерфейса очков и алмазов
        MOV	#0,-(SP)   ; X 
        MOV	#14,-(SP)  ; Y
        MOV	#400,-(SP)  ; Width
        MOV	#125252,-(SP)  ; Color
        JSR PC, @#DRAW_HORZ_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#0,-(SP)   ; X
        MOV	#34,-(SP)  ; Y
        MOV	#400,-(SP)  ; Width
        MOV	#125252,-(SP)  ; Color
        JSR PC, @#DRAW_HORZ_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

	; Начальная позиция пони, скорость, взгляд
	MOV	#200,@#PONYX
	MOV	#320,@#PONYY
	MOV	@#PONYX,@#PONYRENDERX
	MOV	#0,@#PONYDX
	MOV	#4,@#PONYDIR
	MOV	#0,@#TEKSCORE
	MOV	@#TOTALDIAMONDSINGAME,@#DIAMONDSDROP
	MOV	#0,@#DIAMONDSONAIR
	MOV	#125252,@#GAMEOVERCOLOR
	MOV	#2,@#GAMEOVERCOLOR_LINE
	MOV	@#GENINTERVAL,@#GENCOUNTER

	JSR PC, @#SUB_PRINTCAPTIONS
        JSR PC, @#SUB_PRINTSCORE
        JSR PC, @#SUB_PRINTDIAMONDS

	; Инициализация массива алмазов
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_INIT:
	MOV	#-1,(R0)+
	MOV	#0,(R0)+
	MOV	#0,(R0)+
	MOV	#0,(R0)+
	SOB 	R1,CICLE_INIT

START:
	MOV	#3777,@#177706  ; Длительность фрейма (3777 - примерно 10 FPS)
        MOV	#24,@#177712  ; Разрешаем счет и индикацию

        MOV	#0,@#PONYDX ; Сброс скорости на случай отсутствия удержаний

; ===== блок опроса клавиатуры ======
        JSR PC, @#IS_KEY_HOLDED

	CMP	R0,#0       ;не было нажатий 
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
       	MOV	#0,@#PONYDX ; Остановка движения
KEYSTEP3:
	CMP	R0,#3      ; клавиша "КТ"?
	BNE     END_KEY
	JMP	MAIN_MENU_ENTRY
END_KEY:

        ; Обработка джойстика
	CMP	@#JOYSTICKON,#0
	BEQ	END_JOY

	MOV	@#177714,R0

	BIT	#000002,R0
	BEQ	JOYSTEP1
	MOV	#4,@#PONYDX ; Смена скорости
	MOV	#4,@#PONYDIR; Смена поворота
JOYSTEP1:
	BIT	#000010,R0
	BEQ	END_JOY
	MOV	#-4,@#PONYDX ; Смена скорости
	MOV	#-4,@#PONYDIR; Смена поворота
END_JOY:

        ; Начальное рисование звезд фона
	MOV	@#ARR_STARS_SIZE,R1
	MOV	#ARR_STARS,R2
CICLE_STAR_RENDER:
        SUB	#1,(R2)  ; Вычитаем счетчик звезды
        CMP	(R2),#0
        BNE	NOT_NOL_STAR_LIFECICLE
        MOV	#100,(R2) ;  Если достиг нуля, ставим на 100
NOT_NOL_STAR_LIFECICLE:

        MOV	6(R2),-(SP)   ; X
        MOV	10(R2),-(SP)  ; Y
        JSR PC, @#IS_ANY_DIAMOND_OVER_STAR
	ADD	#4, SP     ; Восстановить стек на 2*число аргументов
	CMP	R5, #1
	BEQ	NEXT_STAR_CICLE

        MOV	2(R2),-(SP)   ; Звезда
        MOV	4(R2),-(SP)   ; Позиция видеопамяти

        CMP	(R2),#3    ; Для счетчика менее 3 - очистка, иначе рисование
	BLT     CLEAR_CURRENT_STAR
        JSR PC, @#DRAWSTAR
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов
	JMP	NEXT_STAR_CICLE
CLEAR_CURRENT_STAR:
        JSR PC, @#CLEARSTAR
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов
NEXT_STAR_CICLE:

	ADD	#12,R2
	SOB	R1,CICLE_STAR_RENDER

; ===== блок чистки старой сцены и вывода новой ======
        CMP	@#PONYX, @#PONYRENDERX
        BEQ	NO_CLEARZONE
        BLT	CLEAR_ZONE_FROM_BACK
        	
	; Затирание прямого хода пони
        MOV	@#PONYRENDERX,-(SP)   ; X
        MOV	@#PONYY,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

	JMP	NO_CLEARZONE

CLEAR_ZONE_FROM_BACK:
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
        ; Вывод пони
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

        ; Затирание и вывод алмазов
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_CLEAR:
	CMP	(R0),#-1
	BEQ	SKIP_ARRAY_ELEM3

	; затирание алмаза
        CMP	4(R0),@#DIAMONDSTARTY
	BEQ	NO_CLEAR_NEW_DIAMOND

        MOV	2(R0),-(SP)   ; X
        MOV	4(R0),R3
        SUB	6(R0),R3
        MOV	R3,-(SP)  ; Y
        MOV	#10,-(SP)  ; DX 
        MOV	6(R0),-(SP)  ; DY - размер затираемой области по движению
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

NO_CLEAR_NEW_DIAMOND:
        ; Вывод алмаза
	MOV	#ARR_SPRITES,R3
	ADD	(R0),R3
	ADD	(R0),R3
        MOV	(R3),-(SP)   ; Спрайт алмаза
        MOV	2(R0),-(SP)   ; X
        MOV	4(R0),-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

SKIP_ARRAY_ELEM3:
        ADD	#10,R0
	SOB 	R1,CICLE_DIAMONDS_CLEAR

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
	CMP	(R0),#-1
	BEQ	SKIP_ARRAY_ELEM2

        ; Добавляем скорость к Y
        ADD	6(R0),4(R0)

        ; Если нужно, обрабатываем алмаз как удаленный
        MOV	(R0),R3   ; idx
	MOV	2(R0),R4  ; X 
        MOV	4(R0),R5  ; Y
        JSR PC, @#SUB_HITBOX
        CMP	R4,#0
        BEQ	SKIP_REMOVE_DIAMOND

	CMP	#14,(R0)
	BEQ	IT_IS_STONE2
	DEC	@#DIAMONDSONAIR
        JSR PC, @#SUB_PRINTDIAMONDS
IT_IS_STONE2:

	CMP	R5,#1 ; Не играть звук подбора алмаза, если число очков 0 или меньше
	BLT	NO_PLAY_SOUND
	JSR PC, @#SOUND_PLAY_HIT

NO_PLAY_SOUND:

	CMP	R5,#-1
	BNE	NO_STONE_HITTING
	MOV	#177777,@#GAMEOVERCOLOR
	MOV	#3,@#GAMEOVERCOLOR_LINE
	JMP	ENTER_GAMEOVER
NO_STONE_HITTING:

	; Сначала затираем его
	MOV	#ARR_SPRITES,R3
	ADD	(R0),R3
	ADD	(R0),R3
        MOV	(R3),-(SP)   ; Спрайт алмаза
        MOV	2(R0),-(SP)   ; X
        MOV	4(R0),R3
        SUB	6(R0),R3
        MOV	R3,-(SP)  ; Y
        JSR PC, @#CLEARSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        ; Потом помечаем как удаленный
	MOV	#-1,(R0)

	ADD	R5,@#TEKSCORE
	JSR PC, @#SUB_PRINTSCORE

        MOV	@#DIAMONDSONAIR,R3
        ADD	@#DIAMONDSDROP,R3
        CMP	R3,#0
	BEQ	ENTER_GAMEOVER

SKIP_REMOVE_DIAMOND:	

SKIP_ARRAY_ELEM2:
        ADD	#10,R0
	DEC	R1
	CMP	R1,#0
	BNE	CICLE_DIAMONDS_FRAME

	; Генерация новых алмазов
	CMP	@#DIAMONDSDROP,#0
	BEQ	SKIP_NEW_DIAMOND

	DEC	@#GENCOUNTER
	CMP	@#GENCOUNTER,#0
	BNE	SKIP_NEW_DIAMOND
	
	MOV	@#GENINTERVAL,@#GENCOUNTER
	
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_NEW:
	CMP	(R0),#-1
	BNE	SKIP_ARRAY_ELEM4

	MOV	R0,R2 ; save

        MOV	#17,R0 ; Указываем число в интервале от 0 до 15
        JSR PC, @#GENRNDVALUE
	CMP	R0,@#DIFFGENTYPE
	BLT	NO_SUB_RND1
	MOV	@#DIFFGENTYPE,R0
	DEC	R0
NO_SUB_RND1:
	MOV	R0,R3

        MOV	#37,R0 ; Указываем число в интервале от 0 до 31
        JSR PC, @#GENRNDVALUE
	CMP	R0,#33
	BLT	NO_SUB_RND2
	SUB	#4,R0
NO_SUB_RND2:
        ASL	R0 ; Умножаем на 8, делая X-позицию кратной 8
        ASL	R0
        ASL	R0
	MOV	R0,R4

	MOV	#5,R5 ; По умолчанию скорость максимум
	JSR PC,	@#SUB_IS_X_OVER_DIAMONDS
	CMP	R0,#0
	BEQ	NO_FIX_NEWVELOCITY ; Проверили пересечение и если оно есть
	MOV	#3,R5  ; то нужно уменьшить скорость
NO_FIX_NEWVELOCITY:

	MOV	R2,R0 ; restore

	CMP	R3,#14 ; Если выпал камень, то не нужно делать счет алмазам
	BEQ     IT_IS_STONE
	DEC	@#DIAMONDSDROP
	INC	@#DIAMONDSONAIR
        JSR PC, @#SUB_PRINTDIAMONDS
IT_IS_STONE:

       	MOV	R3,(R0)
	MOV	R4,2(R0)
	MOV	@#DIAMONDSTARTY,4(R0)
	MOV	R5,6(R0)

        JMP	SKIP_NEW_DIAMOND
SKIP_ARRAY_ELEM4:
        ADD	#10,R0
	SOB	R1,CICLE_DIAMONDS_NEW

SKIP_NEW_DIAMOND:
	
; ===== блок формирования длины фрейма ======
TIMERCICLEWAIT:
        BIT	#200,@#177712 ; Тестируем признак прохода через ноль - бит 7
        BEQ	TIMERCICLEWAIT         ; Крутим, пока не дошли

	JMP 	START

ENTER_GAMEOVER:

        MOV	#20,-(SP)   ; X
        MOV	#124,-(SP)  ; Y
        MOV	#360,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#20,-(SP)   ; X
        MOV	#124,-(SP)  ; Y
        MOV	#41,-(SP)  ; Height
        MOV	@#GAMEOVERCOLOR_LINE,-(SP)  ; Color
        JSR PC, @#DRAW_VERT_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#360,-(SP)   ; X
        MOV	#124,-(SP)  ; Y
        MOV	#41,-(SP)  ; Height
        MOV	@#GAMEOVERCOLOR_LINE,-(SP)  ; Color
        JSR PC, @#DRAW_VERT_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#20,-(SP)   ; X
        MOV	#124,-(SP)  ; Y
        MOV	#340,-(SP)  ; Width
        MOV	@#GAMEOVERCOLOR,-(SP)  ; Color
        JSR PC, @#DRAW_HORZ_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        MOV	#20,-(SP)   ; X
        MOV	#164,-(SP)  ; Y
        MOV	#340,-(SP)  ; Width
        MOV	@#GAMEOVERCOLOR,-(SP)  ; Color
        JSR PC, @#DRAW_HORZ_LINE
        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        JSR PC, @#SUB_PRINTGAMEOVER
	JSR PC, @#SOUND_PLAY_GAMEOVER

WAIT_ENTER_AT_GAMEOVER:	
        JSR PC, @#IS_KEY_PRESSED

	CMP	R0,#12      ; клавиша "ввод"?
	BNE     WAIT_ENTER_AT_GAMEOVER
       	JMP	MAIN_MENU_ENTRY

EXIT_BY_STOP:
	EMT	14
	HALT

.include "proc_drawsprite.inc"
.include "proc_keytester.inc"
.include "proc_genrnd.inc"
.include "proc_int2str.inc"
.include "proc_helpers.inc"
.include "sub_prints.inc"
.include "sub_hitbox.inc"
.include "sub_intro.inc"
.include "sub_sounds.inc"
.include "sub_stars.inc"
.include "sprites.inc"
.include "intro.inc"
.include "vars.inc"
.include "version.inc"
.include "strings.inc"
.EVEN
.END

make_bk0010_rom "ponydiamonds.bin", 1000
