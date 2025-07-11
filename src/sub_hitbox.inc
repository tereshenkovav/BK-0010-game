SUB_HITBOX:
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        
        MOV	R4,R0  ; X ������
        MOV	R5,R1  ; Y ������

        MOV	#ARR_SPRITES,R2 ; ���������� ������ ������
        ADD	R3,R2
        ADD	R3,R2           ; ������� ������� ������ � �������
	MOV	(R2),R2         ; �������� �����, ������ ��������� �� ������
        MOV	(R2),@#INT_DIAMOND_W  
        MOV	2(R2),@#INT_DIAMOND_H ; ��������� ������ ������� ������ 
        ASL     @#INT_DIAMOND_W
        ASL     @#INT_DIAMOND_W   ; ��������� ������ ������� ������

        MOV	#0,R4  ; �� ���������, �� ������� � �� ��������� ����
        MOV	#0,R5

        MOV	@#PONYY,R2 ; ���������� ������� ������� ����
        SUB	@#INT_DIAMOND_H,R2
        CMP	R1,R2
	BLT	PONY_HIT_BOX ; ���� �� ����� �� ������� ���� ������

	; ���������� ������� ������ � ���� �� X
	; ���� ������ ���� ������ ����� ������ ���� ����, �� ����
        MOV	R0,R2
	ADD	@#INT_DIAMOND_W,R2
        CMP	R2,@#PONYX
        BLT	PONY_HIT_BOX

	; ���� ����� ���� ������ ������ ������� ���� ����, �� ����
        MOV	@#PONYX,R2
	ADD	#40,R2
        CMP	R2,R0
        BLT	PONY_HIT_BOX

	MOV	#ARR_SCORES,R0 ; ��������� ������� � ������� ����� �� ��������
	ADD	R3,R0
	ADD	R3,R0
        MOV	#1,R4  ; ������ � ��������� ����
        MOV	(R0),R5

        JMP 	END_HIT_BOX

PONY_HIT_BOX:

        MOV	@#LOWBORDER,R2 ; ���������� ����
        ; ������ �� ������� �� ������� �������, ��������� ������ ���������
        ;SUB	@#INT_DIAMOND_H,R2
        CMP	R1,R2
	BLT	END_HIT_BOX

        MOV	#1,R4  ; ������ ������, ��� ���������� �����

END_HIT_BOX:

	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; � R4 - �������� ���������� ������ ������
; � R0 ������ #1, ���� ���� ����������� � ������������� � �������
SUB_IS_X_OVER_DIAMONDS:
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R5,-(SP)

	MOV	#0, R5

	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_OVER:
	CMP	(R0),#-1
	BEQ	SKIP_ARRAY_DIAMONDS_OVER

        MOV	2(R0),R3   ; X
        ; ��������� ������ ���������� ����� ������� � ������� � R4
	CMP	R3,R4
	BLT	MODULE_1

	MOV	R3,R2
	SUB	R4,R2
	JMP	MODULE_2
MODULE_1:
	MOV	R4,R2
	SUB	R3,R2
MODULE_2:

        CMP	#40,R2 ; ���� ������ 32, �� ������ ������� � R5
	BLT	SKIP_ARRAY_DIAMONDS_OVER

	MOV	#1,R5

SKIP_ARRAY_DIAMONDS_OVER:
        ADD	#10,R0
	SOB 	R1,CICLE_DIAMONDS_OVER

	MOV	R5,R0  ; ������� ������� �� R5 � R0

	MOV     (SP)+,R5
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1

	RTS PC

IS_ANY_DIAMOND_OVER_STAR:

        ; ���������� ���������
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)

        ; ���������� ����������
        ADD	#14,SP
        MOV     (SP)+,R3 ; Y ������
        MOV     (SP),R2 ; X ������
        SUB	#16,SP

	MOV	#0,R5

        ; ���� �� �������
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_STAR_HITBOX:
	CMP	(R0),#-1
	BEQ	SKIP_ARRAY_ELEM5

        MOV	#ARR_SPRITES,R4 ; ���������� ������ ������
        ADD	(R0),R4
        ADD	(R0),R4        ; ������� ������� ������ � �������
	MOV	(R4),R4         ; �������� �����, ������ ��������� �� ������
        MOV	(R4),@#INT_DIAMOND_W
        MOV	2(R4),@#INT_DIAMOND_H ; ��������� ������ ������� ������ 
        ASL     @#INT_DIAMOND_W
        ASL     @#INT_DIAMOND_W   ; ��������� ������ ������� ������

	; ���������� ������� ������ � ������ �� X
	; ������ ���� ������ � ����� ���� ������
        MOV	2(R0),R4
	ADD	@#INT_DIAMOND_W,R4
        CMP	R4,R2
        BLT	SKIP_ARRAY_ELEM5

        ; ����� ���� ������ � ������ ���� ������
        MOV	R2,R4
	ADD	#10,R4
        CMP	R4,2(R0)
        BLT	SKIP_ARRAY_ELEM5

	; ���������� ������� ������ � ������ �� Y
        MOV	4(R0),R4
	ADD	@#INT_DIAMOND_H,R4
        CMP	R4,R3
        BLT	SKIP_ARRAY_ELEM5

	MOV	R3,R4
	ADD	#10,R4
        CMP	R4,4(R0)
        BLT	SKIP_ARRAY_ELEM5

        MOV	#1,R5

SKIP_ARRAY_ELEM5:
        ADD	#10,R0
	SOB 	R1,CICLE_DIAMONDS_STAR_HITBOX

        ; �������������� ���������
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

	RTS PC

INT_DIAMOND_W:	.WORD	0
INT_DIAMOND_H:	.WORD	0
