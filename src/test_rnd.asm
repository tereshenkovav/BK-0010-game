	.LINK 1000

        EMT     14

	MOV    #233,R0  ; режим 32 символа
	EMT    16	

	MOV	#0,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

	MOV	#0,@#212  ; цвет и фон
	MOV	#125252,@#214   

	MOV	#12345, R4 ; Начальное значение
	MOV	#377, R3 ; Повтор генерации
CICLE:
        MOV	R4,R0
        MOV	#7,R2
        COM	R2
        BIC	R2,R0
        MOV	R0,-(SP)   ; Процедура принимает число                    
        MOV	#BUF,-(SP) ; указатель на буфер                           
        MOV	#0,-(SP)  ; символ добивки слева или #0, если без добивки
        JSR PC, @#INT2STR
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов
	
	MOV	#BUF,R1     ; Вывод строки с нулем
	MOV	#0,R2
	EMT	20

	MOV	#40,R0      ; Пробел
	EMT	16

	; R4 - старое значение
	MOV	R4,R5
	ROL     R5
	XOR	R5,R4

	MOV	R4,R5
	ROR     R5
	XOR	R5,R4

	MOV	R4,R5
	ROL     R5
	XOR	R5,R4
        
	SOB	R3,CICLE

	HALT

.include "proc_int2str.inc"

BUF:    .BYTE   0,0,0,0,0,0 
        .EVEN
        .END

make_bk0010_rom "test_rnd.bin", 1000

