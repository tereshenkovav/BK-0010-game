SUB_PRINTCAPTIONS:
        MOV	R0,-(SP)

        MOV	#CAPTIONSCENE,R0
	JSR PC, @#PRINT_SCENE

	MOV     (SP)+,R0

        RTS PC

SUB_PRINTSCORE:
        MOV 	#177777,@#214

        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	@#POSVSCORE,R1   ; ������� �������
	MOV	#0,R2
	EMT	24

        MOV	@#TEKSCORE,-(SP)   ; ��������� ��������� �����                    
        MOV	#STRBUF,-(SP) ; ��������� �� �����                           
        MOV	#0,-(SP)  ; ������ ������� ����� ��� #0, ���� ��� �������
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#STRBUF,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2               
	EMT	20               

	MOV	@#POSVMAX,R1   ; ������� �������
	MOV	#0,R2
	EMT	24

        MOV	@#MAXSCORE,-(SP)   ; ��������� ��������� �����                    
        MOV	#STRBUF,-(SP) ; ��������� �� �����                           
        MOV	#0,-(SP)  ; ������ ������� ����� ��� #0, ���� ��� �������
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#STRBUF,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2               
	EMT	20               

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTDIAMONDS:
        MOV 	#177777,@#214

        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	@#POSVDIAMONDS,R1   ; ������� �������
	MOV	#0,R2
	EMT	24

	MOV	@#DIAMONDSDROP,R1
	ADD	@#DIAMONDSONAIR,R1
        MOV	R1,-(SP)   ; ��������� ��������� �����                    
        MOV	#STRBUF,-(SP) ; ��������� �� �����                           
        MOV	#0,-(SP)  ; ������ ������� ����� ��� #0, ���� ��� �������
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#STRBUF,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOVB	#0,2(R1) ; ������ ����� ����� ���� 2 ����
	MOV	#0,R2               
	EMT	20               

	MOV	#SPACEBUF,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2               
	EMT	20               

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTGAMEOVER:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#3,R1   ; ������� �������
	MOV	#10,R2
	EMT	24

	MOV	@#GAMEOVERCOLOR,@#214
	MOV	#MSGGAMEOVER,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2
	EMT	20

	MOV	#125252,@#214

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTGAMERESULT:
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)

	MOV	#11,R1   ; ������� �������
	MOV	#12,R2
	EMT	24

	; ������������, ��� ����� ���� 100%, ���� ���, �� ����� � ������
	MOV	#144,R4
	CMP	@#MAXSCORE,@#TEKSCORE
	BEQ	FIN_DIV100

	; ��������� ��� ����� ���, ����� TEKSCORE ��� �� ����� 320
SHIFT_BEFORE_DIV:
	ASR	@#TEKSCORE
	ASR	@#MAXSCORE
	CMP	@#TEKSCORE,#501
        BGE	SHIFT_BEFORE_DIV

	; ��������� TEKSCORE �� 100
	MOV	#0,R3
	MOV	#144,R4
LAB_MUL100:
	ADD	@#TEKSCORE,R3
	SOB	R4,LAB_MUL100

	; ����� �� MAXSCORE, ������� �� ����
	MOV	#0,R4
LAB_DIV100:
	SUB	@#MAXSCORE,R3
	CMP	R3,#0
	BLE	FIN_DIV100
	INC	R4
	JMP	LAB_DIV100

FIN_DIV100:
	MOV	#MSGSCOREVALUE,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2
	EMT	20

	MOV 	#177777,@#214

        MOV	R4,-(SP)   ; ��������� ��������� �����                    
        MOV	#STRBUF,-(SP) ; ��������� �� �����                           
        MOV	#0,-(SP)  ; ������ ������� ����� ��� #0, ���� ��� �������
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#STRBUF,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2
	EMT	20

	MOV	#MSGSCOREPERC,R1
	MOV	#0,R2
	EMT	20

	MOV	#125252,@#214

	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTDEBUG:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

;	MOV	#5,R1   ; ������� �������
;	MOV	#5,R2
;	EMT	24

        MOV	@#DEBUG,-(SP)   ; ��������� ��������� �����                    
        MOV	#STRBUF,-(SP) ; ��������� �� �����                           
        MOV	#40,-(SP)  ; ������ ������� ����� ��� #0, ���� ��� �������
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#STRBUF,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTMENU:
	MOV 	#125252,@#214

        MOV	#MSGVER,-(SP)   ; ������
        MOV	#5,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#MENUSCENE,R0
	JSR PC, @#PRINT_SCENE

        JSR PC, @#SUB_PRINTSOUND
        JSR PC, @#SUB_PRINTJOYSTICK

        RTS PC

SUB_PRINTSOUND:

	CMP	@#SOUNDON,#0
	BEQ	LAB_NOSOUND
	MOV	#TEXTON, R0
	JMP	LAB_DO_PRINTSOUND
LAB_NOSOUND:
	MOV	#TEXTOFF, R0
LAB_DO_PRINTSOUND:
        JSR PC, @#PRINT_STRING_BY_COLOR_AND_POS

	RTS PC

SUB_PRINTJOYSTICK:

	CMP	@#JOYSTICKON,#0
	BEQ	LAB_NOJOYSTICK
	MOV	#TEXTJOY, R0
	JMP	LAB_DO_PRINTJOYSTICK
LAB_NOJOYSTICK:
	MOV	#TEXTKEY, R0
LAB_DO_PRINTJOYSTICK:
        JSR PC, @#PRINT_STRING_BY_COLOR_AND_POS

	RTS PC
