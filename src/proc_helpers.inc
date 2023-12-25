CLEAR_SCREEN:
	; Очистка экрана 100%
	MOV	R0,-(SP)

	MOV	#40000,R0
CICLE_CLEAR_SCREEN:
	CLR	(R0)+
	CMP	R0,#100000
        BNE	CICLE_CLEAR_SCREEN

	MOV     (SP)+,R3

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
LAB_CALC_LEN:
	CMPB	(R0),#0
	BEQ	LAB_CALC_LEN_FIN
	INC     R0
	JMP	LAB_CALC_LEN
LAB_CALC_LEN_FIN:

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

