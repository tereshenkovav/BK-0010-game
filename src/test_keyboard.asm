	.LINK 1000

        EMT     14
	MOV	#55000,R3

START:	MOV	R3,R1
	MOVB	#377,(R1)+
	MOVB	#377,(R1)+
	MOVB	#377,(R1)+
	MOVB	#252,(R1)+
	MOVB	#252,(R1)+
	MOVB	#252,(R1)+
	MOVB	#125,(R1)+
	MOVB	#125,(R1)+
	MOVB	#125,(R1)+

	MOV	#7777,R2
DELAY:	NOP
	SOB	R2,DELAY

	MOV	R3,R1
	MOVB	#0,(R1)+
	MOVB	#0,(R1)+
	MOVB	#0,(R1)+
	MOVB	#0,(R1)+
	MOVB	#0,(R1)+
	MOVB	#0,(R1)+
	MOVB	#0,(R1)+
	MOVB	#0,(R1)+
	MOVB	#0,(R1)+

	MOV	@#177662,R0 ;код нажатой клавиши в регистр R0
	CMP	R0,#10      ;нажата клавиша "курсор влево"?
        BNE     NEXT1
	DEC	R3
	 
NEXT1:	CMP	R0,#31      ;нажата клавиша "курсор вправо"?
	BNE     NEXT2
       	INC	R3
NEXT2:
	JMP	START

make_bk0010_rom "test_keyboard.bin", 1000
