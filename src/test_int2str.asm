	.LINK 1000

        EMT     14

	MOV    #233,R0  ; режим 32 символа
	EMT    16	

	MOV	#0,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

	MOV	#0,@#212  ; цвет и фон
	MOV	#125252,@#214   

	MOV	#0, R5
	MOV	#1, R4
CICLE:
	MOV	R5, R0    ; Процедура принимает в R0 - число
	MOV	#BUF,R1   ; в R1 - указатель на буфер
        JSR PC, @#INT2STR
		
	MOV	#BUF,R1     ; Вывод строки с нулем
	MOV	#0,R2
	EMT	20

	MOV	#40,R0      ; Пробел
	EMT	16

	ADD     R4, R5  ; Увеличиваем число и его счет
	ADD	#4, R4

	CMP 	R5,#62342
	BLT	CICLE

	HALT

.include "proc_int2str.inc"

BUF:    .BYTE   0,0,0,0,0,0 
        .EVEN
        .END

make_bk0010_rom "test_int2str.bin", 1000
