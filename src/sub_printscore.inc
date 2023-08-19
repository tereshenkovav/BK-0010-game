SUB_PRINTSCORE:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#10,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

        MOV	@#TEKSCORE,-(SP)   ; Процедура принимает число                    
        MOV	#STRBUF,-(SP) ; указатель на буфер                           
        MOV	#0,-(SP)  ; символ добивки слева или #0, если без добивки
        JSR PC, @#INT2STR
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

	MOV	#STRBUF,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2               
	EMT	20               

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC
