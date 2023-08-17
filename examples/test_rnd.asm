	.LINK 1000

        EMT     14

	MOV    #233,R0  ; режим 32 символа
	EMT    16	

	MOV	#0,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

	MOV	#0,@#212  ; цвет и фон
	MOV	#125252,@#214   

	MOV	#MSG,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2               
	EMT	20               
        
        ; Генерация начального значения по ожиданию клавиатуры
        MOV	#0,R2	
KEYWAIT:
        INC	R2
        JSR PC, @#KEY_TESTER
	CMP	R1,#0       ;не было нажатий и нет удержания
        BEQ     KEYWAIT

        MOV	R2,R0 ; Начальное значение
        JSR PC, @#SETRNDSEED

	MOV	#377, R3 ; Повтор генерации

CICLE:
        MOV	#17,R0 ; Указываем число в интервале от 0 до 15
        JSR PC, @#GENRNDVALUE

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
        
	SOB	R3,CICLE

	MOV	#MSG,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2               
	EMT	20               

KEYWAIT2:        
        JSR PC, @#KEY_TESTER
	CMP	R1,#0       ;не было нажатий и нет удержания
        BEQ     KEYWAIT2

	EMT     14

	MOV	#40000, R1 ; Начало видеопамяти
	MOV	#40000, R3 ; Повтор генерации
CICLE2:
        MOV	#377,R0 ; Указываем число в интервале от 0 до 255
        JSR PC, @#GENRNDVALUE

	MOVB	R0,(R1)+

        SOB	R3,CICLE2

	HALT

.include "proc_genrnd.inc"
.include "proc_int2str.inc"
.include "proc_keytester.inc"

BUF:    .BYTE   0,0,0,0,0,0 
MSG:    .ASCIZ  "Press any key"
        .EVEN
        .END

make_bk0010_rom "test_rnd.bin", 1000

