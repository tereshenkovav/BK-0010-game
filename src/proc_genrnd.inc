; ��������� ��������� � R0 ����� � ��������� �����, �� ������� ����� ������� �����
; �������� 7 - 111 - ����� �������� ����� �� 0 �� 7
; ���������� � R0 ����� � �������� ���������
GENRNDVALUE:
        ; ���������� ���������
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV 	@#TEKRNDVALUE,R1

	MOV	R1,R2
	ROL     R2
	XOR	R2,R1

	MOV	R1,R2
	ROR     R2
	XOR	R2,R1

	MOV	R1,R2
	ROL     R2
	XOR	R2,R1

	MOV 	R1,@#TEKRNDVALUE

	; ������� �� �������� �����
        COM	R0
        BIC	R0,R1
        MOV	R1,R0

        ; �������������� ���������
	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

; ��������� ���������� �������� ����������
SETRNDSEED:
        MOV	R0, @#TEKRNDVALUE
        RTS PC

TEKRNDVALUE:    .WORD   0