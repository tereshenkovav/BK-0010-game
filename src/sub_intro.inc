; Вывод картинки по адресу
SHOW_INTRO:
        JSR PC, @#CLEAR_SCREEN

	MOV	@#INTRO_INDEXES,R1
	MOV	#INTRO_INDEXES,R0
	ADD	#2,R0
CICLE_INTRO_MAP:
        MOV     (R0),R2 ; IDX
        ADD	#2,R0
	CLR	R3
        BISB    (R0),R3 ; X
        INC	R0
	CLR	R4
        BISB    (R0),R4 ; Y
        INC	R0

	MOV	#40000,R5 ; Вычисляем позицию в видеопамяти
	ADD	R3,R5
	ASL	R4        ; Умножение #100 на Y путем сдвига влево 6 раз
	ASL	R4
	ASL	R4
	ASL	R4
	ASL	R4
	ASL	R4
	ADD	R4,R5  ; В R5 теперь конечный адрес назначения

CICLE_INTRO_ROW:
	MOV	#INTRO_BLOCKS,R3
	ASL	R2
	ASL	R2
	ADD	R2,R3
	MOVB	(R3)+,(R5)
        ADD	#100,R5
	MOVB	(R3)+,(R5)
        ADD	#100,R5
	MOVB	(R3)+,(R5)
        ADD	#100,R5
	MOVB	(R3)+,(R5)

	MOV	#40,R4
CICEL_INTRO_DELAY:
	NOP
	SOB	R4,CICEL_INTRO_DELAY

	SOB	R1,CICLE_INTRO_MAP

        RTS PC
