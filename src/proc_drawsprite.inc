; ��������� � �����: ����� �������, X, Y
DRAWSPRITE:
        ; ���������� ���������
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)

        ; ���������� ����������
        ADD	#14,SP
        MOV     (SP)+,R2 ; Y
        MOV     (SP)+,R1 ; X
        MOV     (SP),R0 ; ����� �������
        SUB	#20,SP
        
	JSR PC, @#CALC_VIDEOMEM_POS_BY_XY
	
        MOV	(R0)+,R4	  ; �������� ������� �������
        MOV	(R0)+,R3

        ; ��������� �� ������ ������� ��� �������� ������ �� 2,4,6 � 8 ����
	CMP	R4,#2
	BEQ	ROW_W_2
	CMP	R4,#4
	BEQ	ROW_W_4
	CMP	R4,#6
	BEQ	ROW_W_6
	CMP	R4,#10
	BEQ	ROW_W_8
        JMP	ROW

	; �������� �� 2 �����
ROW_W_2:
	CMP	R1,@#FINISHRENDERZONE
	BGE	DRAW_SPRITE_FIN
	CMP	R1,@#STARTRENDERZONE
	BGE	ROW_W_2_OK

	ADD	#2,R0
	ADD	#100,R1
	SOB	R3,ROW_W_2
        JMP DRAW_SPRITE_FIN
ROW_W_2_OK:
	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	ADD	#76,R1
	SOB	R3,ROW_W_2
        JMP DRAW_SPRITE_FIN

	; �������� �� 4 �����
ROW_W_4:
	CMP	R1,@#FINISHRENDERZONE
	BGE	DRAW_SPRITE_FIN
	CMP	R1,@#STARTRENDERZONE
	BGE	ROW_W_4_OK

	ADD	#4,R0
	ADD	#100,R1
	SOB	R3,ROW_W_4
        JMP DRAW_SPRITE_FIN
ROW_W_4_OK:
	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	ADD	#74,R1
	SOB	R3,ROW_W_4
        JMP DRAW_SPRITE_FIN

	; �������� �� 6 ����
ROW_W_6:
	CMP	R1,@#FINISHRENDERZONE
	BGE	DRAW_SPRITE_FIN
	CMP	R1,@#STARTRENDERZONE
	BGE	ROW_W_6_OK

	ADD	#6,R0
	ADD	#100,R1
	SOB	R3,ROW_W_6
        JMP DRAW_SPRITE_FIN
ROW_W_6_OK:

	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	ADD	#72,R1
	SOB	R3,ROW_W_6
        JMP DRAW_SPRITE_FIN

	; �������� �� 8 ����
ROW_W_8:
	CMP	R1,@#FINISHRENDERZONE
	BGE	DRAW_SPRITE_FIN
	CMP	R1,@#STARTRENDERZONE
	BGE	ROW_W_8_OK

	ADD	#10,R0
	ADD	#100,R1
	SOB	R3,ROW_W_8
        JMP DRAW_SPRITE_FIN
ROW_W_8_OK:

	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	ADD	#70,R1
	SOB	R3,ROW_W_8
        JMP DRAW_SPRITE_FIN

	; ����������� �������� ������������ ������
ROW:    MOV	R4,R2
        ASR	R2 ; ����� �� 2 ��� �������� � ����������� ��������

	CMP	R1,@#FINISHRENDERZONE
	BGE	DRAW_SPRITE_FIN
	CMP	R1,@#STARTRENDERZONE
	BGE	ROW_W_ANY_OK

	ADD	R4,R0
	ADD	#100,R1
	SOB	R3,ROW
        JMP DRAW_SPRITE_FIN
ROW_W_ANY_OK:

COL:	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	SOB	R2,COL

	ADD	#100,R1
	SUB	R4,R1
	SOB	R3,ROW

DRAW_SPRITE_FIN:

        ; �������������� ���������
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; ��������� � �����: ����� �������, X, Y
CLEARSPRITE:
        ; ���������� ���������
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)

        ; ���������� ����������
        ADD	#14,SP
        MOV     (SP)+,R2 ; Y
        MOV     (SP)+,R1 ; X
        MOV     (SP),R0 ; ����� �������
        SUB	#20,SP
	
	JSR PC, @#CALC_VIDEOMEM_POS_BY_XY

        MOV	(R0)+,R4	  ; �������� ������� �������
        MOV	(R0)+,R3
        
	MOV	#0,R0

ROW1:    MOV	R4,R2
	ASR	R2 ; ����� �� 2 ��� �������� � ����������� ��������

	CMP	R1,@#FINISHRENDERZONE
	BGE	CLEAR_SPRITE_FIN
	CMP	R1,@#STARTRENDERZONE
	BGE	ROW1_W_ANY_OK

	ADD	#100,R1
	SOB	R3,ROW1
        JMP 	CLEAR_SPRITE_FIN
ROW1_W_ANY_OK:

COL1:	MOVB	R0,(R1)+
        MOVB	R0,(R1)+
	SOB	R2,COL1

	ADD	#100,R1
	SUB	R4,R1
	SOB	R3,ROW1

CLEAR_SPRITE_FIN:
        ; �������������� ���������
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; ��������� � �����: X, Y, DX, DY
CLEARZONE:
        ; ���������� ���������
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)
        MOV	R5,-(SP)

        ; ���������� ����������
        ADD	#16,SP
        MOV     (SP)+,R5 ; DY
        MOV     (SP)+,R4 ; DX
        MOV     (SP)+,R2 ; Y
        MOV     (SP),R1 ; X
        SUB	#24,SP

        JSR PC, @#CALC_VIDEOMEM_POS_BY_XY

	MOV	R5,R3

	MOV	#0,R0
ROW2:	MOV	R4,R2

	CMP	R1,@#FINISHRENDERZONE
	BGE	CLEAR_ZONE_FIN
	CMP	R1,@#STARTRENDERZONE
	BGE	ROW2_W_ANY_OK

	ADD	#100,R1
	SOB	R3,ROW2
        JMP 	CLEAR_ZONE_FIN
ROW2_W_ANY_OK:

COL2:	MOVB	R0,(R1)+
	SOB	R2,COL2

	ADD	#100,R1
	SUB	R4,R1

	SOB	R3,ROW2

CLEAR_ZONE_FIN:
        ; �������������� ���������
	MOV     (SP)+,R5
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; ��������� �� R1=x,R2=y - � R1 ������� �����������. ���������� R3
CALC_VIDEOMEM_POS_BY_XY:
	MOV	#40000,R3 ; ��������� ������� � �����������
	ASR	R1	  ; ����� X �� 4 ����� ������ ������ 2 ����
	ASR	R1
	ADD	R1,R3
	ASL	R2        ; ��������� #100 �� Y ����� ������ ����� 6 ���
	ASL	R2
	ASL	R2
	ASL	R2
	ASL	R2
	ASL	R2
	ADD	R2,R3
	MOV	R3,R1     ; � R1 ������ �������� ����� ����������

	RTS PC

; ������� ������� �������, ������ ������������� � ����
STARTRENDERZONE: .WORD 40000
; ������ ������� �������, ����� ������ ������ ����������
FINISHRENDERZONE: .WORD 76000
