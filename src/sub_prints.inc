SUB_PRINTCAPTIONS:
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
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#10,R1   ; ������� �������
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
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#27,R1   ; ������� �������
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

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTGAMEOVER:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#1,R1   ; ������� �������
	MOV	#2,R2
	EMT	24

	MOV	#MSGGAMEOVER,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC