SUB_PRINTCAPTIONS:
	MOV 	#125252,@#214

        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#1,R1   ; ������� �������
	MOV	#0,R2
	EMT	24

	MOV	#MSGSCORE,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2
	EMT	20

	MOV	#15,R1   ; ������� �������
	MOV	#0,R2
	EMT	24

	MOV	#MSGDIAMONDS,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTSCORE:
        MOV 	#177777,@#214

        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#7,R1   ; ������� �������
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

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTDIAMONDS:
        MOV 	#177777,@#214

        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#26,R1   ; ������� �������
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

SUB_PRINTDEBUG:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#5,R1   ; ������� �������
	MOV	#5,R2
	EMT	24

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
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV 	#125252,@#214

        MOV	#MSGTITLE,-(SP)   ; ������
        MOV	#5,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#MSGVER,-(SP)   ; ������
        MOV	#6,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#MSGMENUSTARTEASY,-(SP)   ; ������
        MOV	#10,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#MSGMENUSTARTHARD,-(SP)   ; ������
        MOV	#11,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#MSGMENUSOUND,-(SP)   ; ������
        MOV	#12,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        JSR PC, @#SUB_PRINTSOUND

        MOV	#MSGMENUHELP,-(SP)   ; ������
        MOV	#13,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#MSGMENUEXIT,-(SP)   ; ������
        MOV	#14,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#MSGAUTHOR,-(SP)   ; ������
        MOV	#23,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#MSGGITHUB0,-(SP)   ; ������
        MOV	#24,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#MSGGITHUB1,-(SP)   ; ������
        MOV	#25,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

	MOV     (SP)+,R2
	MOV     (SP)+,R1

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
