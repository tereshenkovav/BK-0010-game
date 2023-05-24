	.LINK 1000

        EMT     14

	MOV    #233,R0  ; ����� 32 �������
	EMT    16	

	MOV	#0,R1   ; ������� �������
	MOV	#0,R2
	EMT	24

	MOV	#0,@#212  ; ���� � ���
	MOV	#125252,@#214   

	MOV	#MSG,R1     ; ����� ������ �� ��������� � ����� �� �����
	MOV	#0,R2               
	EMT	20               
        
	MOV	#377, R3 ; ������ ���������

        MOV	#54321,R0 ; ��������� ��������
        JSR PC, @#SETRNDSEED

CICLE:
        MOV	#17,R0 ; ��������� ����� � ��������� �� 0 �� 7
        JSR PC, @#GENRNDVALUE

        MOV	R0,-(SP)   ; ��������� ��������� �����                    
        MOV	#BUF,-(SP) ; ��������� �� �����                           
        MOV	#0,-(SP)  ; ������ ������� ����� ��� #0, ���� ��� �������
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������
	
	MOV	#BUF,R1     ; ����� ������ � �����
	MOV	#0,R2
	EMT	20

	MOV	#40,R0      ; ������
	EMT	16
        
	SOB	R3,CICLE

	HALT

.include "proc_genrnd.inc"
.include "proc_int2str.inc"

BUF:    .BYTE   0,0,0,0,0,0 
MSG:    .ASCIZ  "Press any key"
        .EVEN
        .END

make_bk0010_rom "test_rnd.bin", 1000

