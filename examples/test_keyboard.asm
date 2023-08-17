	.LINK 1000

        EMT     14  ; Чистим экран

	MOV	#55000,R3  ; Позиции линий
        MOV	#45000,R4

	; Запрещаем прерывания от клавиатуры, чтобы не мешало игре
	BIS	#100,@#177660 

START:	
        MOV	R3,R0          ; Рисуем одну линию
        JSR PC, @#DRAW_LINE

        MOV	R4,R0          ; Рисуем вторую линию
        JSR PC, @#DRAW_LINE
        
	JSR PC, PAUSE          ; Делаем паузу

	MOV	R3,R0          ; Стираем одну линию
	JSR PC,	@#CLEAR_LINE

	MOV	R4,R0          ; Стираем другую линию
	JSR PC,	@#CLEAR_LINE
        	
        JSR PC, @#KEY_TESTER

	CMP	R1,#0       ;не было нажатий и нет удержания
        BEQ     NO_KEY

        CMP	R1,#1       ; если режим нажатия (1), идем в KEY1
        BEQ     KEY1
	 
	; Обработка клавиш при удержании
	CMP	R0,#31      ; удерживается клавиша "курсор вправо"?
	BNE     S1
       	INC	R4          ; Сдвиг позиции линии горизонталь
S1:  
	CMP	R0,#10      ; удерживается клавиша "курсор влево"?
	BNE     S2
       	DEC	R4          ; Сдвиг позиции линии горизонталь

S2:
        JMP	NO_KEY
KEY1:
        ; Обработка клавиш при нажатии
	CMP	R0,#33      ; нажата клавиша "курсор вниз"?
	BNE     S3
       	ADD	#400, R4    ; Сдвиг позиции линии вертикаль
S3:  
	CMP	R0,#32      ; нажата клавиша "курсор вверх"?
	BNE     S4
       	SUB	#400, R4    ; Сдвиг позиции линии вертикаль

S4:

NO_KEY:

        INC     R3          ; В любом случае двигаем вторую линию
     
	JMP	START

.include "proc_keytester.inc"

        ; Процедура рисования линии трехцветной
        ; R0 - позиция экрана
DRAW_LINE:
	MOVB	#377,(R0)+
	MOVB	#377,(R0)+
	MOVB	#377,(R0)+
	MOVB	#252,(R0)+
	MOVB	#252,(R0)+
	MOVB	#252,(R0)+
	MOVB	#125,(R0)+
	MOVB	#125,(R0)+
	MOVB	#125,(R0)+
	RTS PC

        ; Процедура стирания линии трехцветной
        ; R0 - позиция экрана
CLEAR_LINE:
	CLRB	(R0)+
	CLRB	(R0)+
	CLRB	(R0)+
	CLRB	(R0)+
	CLRB	(R0)+
	CLRB	(R0)+
	CLRB	(R0)+
	CLRB	(R0)+
	CLRB	(R0)+
	RTS PC    

        ; Процедура паузы через операцию NOP
PAUSE:
	MOV	#7777,R0
DELAY:	NOP
	SOB	R0,DELAY
	RTS PC

make_bk0010_rom "test_keyboard.bin", 1000
