	.LINK 1000

        EMT     14  ; Чистим экран

	MOV	#55000,R3  ; Позиции линий
        MOV	#45000,R4

	; Запрещаем прерывания от клавиатуры, чтобы не мешало игре
	MOV	#100,@#177660 

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
        	
        TSTB    @#177660 ; Проверка клавиатуры, есть ли нажатие
        BPL     NO_KEY   ; Если нет, то пропуск обработки клавиш

	MOV	@#177662,R0 ;код нажатой клавиши в регистр R0
	CMP	R0,#10      ;нажата клавиша "курсор влево"?
        BNE     NEXT1
	DEC	R4          ; Сдвиг позиции линии
	 
NEXT1:	CMP	R0,#31      ;нажата клавиша "курсор вправо"?
	BNE     NEXT2
       	INC	R4          ; Сдвиг позиции линии
NEXT2:  

NO_KEY:

        INC     R3          ; В любом случае двигаем вторую линию

	JMP	START

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
	MOVB	#0,(R0)+
	MOVB	#0,(R0)+
	MOVB	#0,(R0)+
	MOVB	#0,(R0)+
	MOVB	#0,(R0)+
	MOVB	#0,(R0)+
	MOVB	#0,(R0)+
	MOVB	#0,(R0)+
	MOVB	#0,(R0)+
	RTS PC    

        ; Процедура паузы через операцию NOP
PAUSE:
	MOV	#7777,R0
DELAY:	NOP
	SOB	R0,DELAY
	RTS PC

make_bk0010_rom "test_keyboard.bin", 1000
