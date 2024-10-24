CLEAR_SCREEN:
	; Очистка экрана 100%
	MOV	R0,-(SP)

	MOV	#40000,R0
CICLE_CLEAR_SCREEN:
	CLR	(R0)+
	CMP	R0,#100000
        BNE	CICLE_CLEAR_SCREEN

	MOV     (SP)+,R0

	RTS	PC

DRAW_HORZ_LINE:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)
        MOV	R5,-(SP)

        ; Извлечение аргументов
        ADD	#16,SP
        MOV     (SP)+,R4 ; C
        MOV     (SP)+,R5 ; DX
        MOV     (SP)+,R2 ; Y
        MOV     (SP),R1 ; X
        SUB	#24,SP

        JSR PC, @#CALC_VIDEOMEM_POS_BY_XY

	MOV	R5,R3
	ASR	R3
	ASR	R3
COL_LINE:
	MOVB	R4,(R1)+
	SOB	R3,COL_LINE

        ; Восстановление регистров
	MOV     (SP)+,R5
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

	RTS	PC

DRAW_VERT_LINE:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)
        MOV	R5,-(SP)

        ; Извлечение аргументов
        ADD	#16,SP
        MOV     (SP)+,R4 ; C
        MOV     (SP)+,R5 ; DY
        MOV     (SP)+,R2 ; Y
        MOV     (SP),R1 ; X
        SUB	#24,SP

        JSR PC, @#CALC_VIDEOMEM_POS_BY_XY

	MOV	R5,R3
COL_LINE1:
	MOVB	R4,(R1)+
	ADD	#77,R1
	SOB	R3,COL_LINE1

        ; Восстановление регистров
	MOV     (SP)+,R5
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

	RTS	PC

; Процедура принимает в стеке число периодов звучания и длину периода
PLAY_SOUND_LEN_PERIOD:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)

        ; Извлечение аргументов
        ADD	#10,SP
        MOV     (SP)+,R1
        MOV     (SP),R0
        SUB	#12,SP

SOUND_CICLE0:
	MOV 	#100,@#177716 ; speaker on 
	MOV 	R1,R2
SOUND_CICLE1:
	NOP
	SOB	R2,SOUND_CICLE1
	MOV	#0,@#177716   ; speaker off
	MOV	R1,R2
SOUND_CICLE2:
	NOP
	SOB	R2,SOUND_CICLE2
	SOB	R0,SOUND_CICLE0

        ; Восстановление регистров
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; Процедура принимает в стеке адрес строки и координату Y для вывода по центру
PRINT_STRING_CENTERED:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)

        ; Извлечение аргументов
        ADD	#12,SP
        MOV     (SP)+,R2
        MOV     (SP),R3
        SUB	#14,SP

	MOV	R3,R0   ; Вычисляем длину строки через разницу начала и конца
	DEC	R0  ; Позволяет обработать случай пустой строки
LAB_CALC_LEN:
	INC	R0
	CMPB	(R0),#0
	BNE	LAB_CALC_LEN

	SUB	R3,R0  ; Получаем длину, делим на 2 и вычитаем из 16
	ASR	R0
	MOV	#20,R1
	SUB	R0,R1  ; так получаем позицию курсора по X
	EMT	24 ; R2 - Y уже получен из стека

	; Вывод строки по умолчанию с нулем на конце
	MOV	R3,R1
	MOV	#0,R2
	EMT	20

        ; Восстановление регистров
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; Процедура принимает в R0 адрес строки содержащей цвет, позицию и текст
PRINT_STRING_BY_COLOR_AND_POS:
        ; Сохранение регистров
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOVB	(R0),R1   ; позиция курсора
	INC	R0
	MOVB	(R0),R2
	EMT	24

	INC	R0
	MOV	R0,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

        ; Восстановление регистров
	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

; Процедура принимает в R0 адрес сцены для рендера
PRINT_SCENE:

NEXT_TEXT_LINE:
        JSR PC, @#PRINT_STRING_BY_COLOR_AND_POS

        DEC	R0 ; Позволяет обработать случай пустой строки
LAB_CALC_LEN1:
        INC	R0
	CMPB	(R0),#0
	BNE	LAB_CALC_LEN1

	INC	R0
	CMP	(R0),#0
	BNE	NEXT_TEXT_LINE

        RTS PC
