	.LINK 1000

        EMT     14	
START:	MOV	#40000,R1
	MOV	#377,R2
ROW:	MOV	#20,R3
COL:	MOVB	#377,(R1)+
	MOVB	#252,(R1)+
	MOVB	#125,(R1)+
	MOVB	#000,(R1)+
	DEC	R3
	CMP	R3,#0
	BNE	COL
	DEC	R2
	CMP	R2,#0
	BNE	ROW
	JMP	START

make_bk0010_rom "test_video.bin", 1000
