SUB_PRINTCAPTIONS:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#1,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

	MOV	#MSGSCORE,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#15,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

	MOV	#MSGDIAMONDS,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTSCORE:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#7,R1   ; позиция курсора
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

SUB_PRINTDIAMONDS:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#26,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

	MOV	@#DIAMONDSDROP,R1
	ADD	@#DIAMONDSONAIR,R1
        MOV	R1,-(SP)   ; Процедура принимает число                    
        MOV	#STRBUF,-(SP) ; указатель на буфер                           
        MOV	#0,-(SP)  ; символ добивки слева или #0, если без добивки
        JSR PC, @#INT2STR
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

	MOV	#STRBUF,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2               
	EMT	20               

	MOV	#SPACEBUF,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2               
	EMT	20               

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTGAMEOVER:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#1,R1   ; позиция курсора
	MOV	#2,R2
	EMT	24

	MOV	@#GAMEOVERCOLOR,@#214
	MOV	#MSGGAMEOVER,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#125252,@#214

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTDEBUG:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#5,R1   ; позиция курсора
	MOV	#5,R2
	EMT	24

        MOV	@#DEBUG,-(SP)   ; Процедура принимает число                    
        MOV	#STRBUF,-(SP) ; указатель на буфер                           
        MOV	#40,-(SP)  ; символ добивки слева или #0, если без добивки
        JSR PC, @#INT2STR
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

	MOV	#STRBUF,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTMENU:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

        MOV	#MSGTITLE,-(SP)   ; Строка
        MOV	#5,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        MOV	#MSGVER,-(SP)   ; Строка
        MOV	#6,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        MOV	#MSGMENUSTARTEASY,-(SP)   ; Строка
        MOV	#10,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        MOV	#MSGMENUSTARTHARD,-(SP)   ; Строка
        MOV	#11,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        MOV	#MSGMENUSOUND,-(SP)   ; Строка
        MOV	#12,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        JSR PC, @#SUB_PRINTSOUND

        MOV	#MSGMENUHELP,-(SP)   ; Строка
        MOV	#13,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        MOV	#MSGMENUEXIT,-(SP)   ; Строка
        MOV	#14,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        MOV	#MSGAUTHOR,-(SP)   ; Строка
        MOV	#23,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        MOV	#MSGGITHUB0,-(SP)   ; Строка
        MOV	#24,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

        MOV	#MSGGITHUB1,-(SP)   ; Строка
        MOV	#25,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

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
