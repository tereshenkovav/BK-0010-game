; R3 - адрес текущей звезды
SUB_DRAW_STAR:
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#1,R0

	MOV	(R3),@#214

	MOV	4(R3),R1
	MOV	6(R3),R2

        CMP	2(R3),#1
	BEQ	IS_STAR_TYPE_1

        EMT	30

	ADD	#1,R1
	ADD	#1,R2
        EMT	30

	SUB	#2,R1
        EMT	30

	SUB	#2,R2
        EMT	30

	ADD	#2,R1
        EMT	30

	ADD	#1,R1
	ADD	#3,R2
        EMT	30

	SUB	#4,R1
        EMT	30

	SUB	#4,R2
        EMT	30

	ADD	#4,R1
        EMT	30

	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

IS_STAR_TYPE_1:

	ADD	#1,R1
        EMT	30

	ADD	#1,R1
        EMT	30

	SUB	#3,R1
        EMT	30

	SUB	#1,R1
        EMT	30

	ADD	#2,R1
	SUB	#1,R2
        EMT	30

	SUB	#1,R2
        EMT	30

	ADD	#3,R2
        EMT	30

	ADD	#1,R2
        EMT	30

	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC
