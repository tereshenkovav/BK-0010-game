CLEAR_SCREEN:
	; ������� ������ 100%
	MOV	R0,-(SP)

	MOV	#40000,R0
CICLE_CLEAR_SCREEN:
	CLR	(R0)+
	CMP	R0,#100000
        BNE	CICLE_CLEAR_SCREEN

	MOV     (SP)+,R0

	RTS	PC

DRAW_HORZ_LINE:
        ; ���������� ���������
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)
        MOV	R5,-(SP)

        ; ���������� ����������
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

        ; �������������� ���������
	MOV     (SP)+,R5
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

	RTS	PC

DRAW_VERT_LINE:
        ; ���������� ���������
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)
        MOV	R5,-(SP)

        ; ���������� ����������
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

        ; �������������� ���������
	MOV     (SP)+,R5
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

	RTS	PC

; ��������� ��������� � ����� ����� �������� �������� � ����� �������
PLAY_SOUND_LEN_PERIOD:
        ; ���������� ���������
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)

        ; ���������� ����������
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

        ; �������������� ���������
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; ��������� ��������� � ����� ����� ������ � ���������� Y ��� ������ �� ������
PRINT_STRING_CENTERED:
        ; ���������� ���������
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)

        ; ���������� ����������
        ADD	#12,SP
        MOV     (SP)+,R2
        MOV     (SP),R3
        SUB	#14,SP

	MOV	R3,R0   ; ��������� ����� ������ ����� ������� ������ � �����
	DEC	R0  ; ��������� ���������� ������ ������ ������
LAB_CALC_LEN:
	INC	R0
	CMPB	(R0),#0
	BNE	LAB_CALC_LEN

	SUB	R3,R0  ; �������� �����, ����� �� 2 � �������� �� 16
	ASR	R0
	MOV	#20,R1
	SUB	R0,R1  ; ��� �������� ������� ������� �� X
	EMT	24 ; R2 - Y ��� ������� �� �����

	; ����� ������ �� ��������� � ����� �� �����
	MOV	R3,R1
	MOV	#0,R2
	EMT	20

        ; �������������� ���������
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; ��������� ��������� � R0 ����� ������ ���������� ����, ������� � �����
PRINT_STRING_BY_COLOR_AND_POS:
        ; ���������� ���������
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOVB	(R0),R1   ; ������� �������
	INC	R0
	MOVB	(R0),R2
	EMT	24

	INC	R0
	MOV	R0,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2
	EMT	20

        ; �������������� ���������
	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

; ��������� ��������� � R0 ����� ����� ��� �������
PRINT_SCENE:

NEXT_TEXT_LINE:
        JSR PC, @#PRINT_STRING_BY_COLOR_AND_POS

        DEC	R0 ; ��������� ���������� ������ ������ ������
LAB_CALC_LEN1:
        INC	R0
	CMPB	(R0),#0
	BNE	LAB_CALC_LEN1

	INC	R0
	CMP	(R0),#0
	BNE	NEXT_TEXT_LINE

        RTS PC
