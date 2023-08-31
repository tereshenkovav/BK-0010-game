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

	MOV	#25,R1   ; позиция курсора
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

	MOV	#MSGGAMEOVER,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

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

	MOV	#4,R1   ; позиция курсора
	MOV	#5,R2
	EMT	24

	MOV	#MSGTITLE,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#12,R1   ; позиция курсора
	MOV	#10,R2
	EMT	24

	MOV	#MSGMENUSTART,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#12,R1   ; позиция курсора
	MOV	#11,R2
	EMT	24

	MOV	#MSGMENUHELP,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#12,R1   ; позиция курсора
	MOV	#12,R2
	EMT	24

	MOV	#MSGMENUEXIT,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#10,R1   ; позиция курсора
	MOV	#23,R2
	EMT	24

	MOV	#MSGAUTHOR,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#4,R1   ; позиция курсора
	MOV	#24,R2
	EMT	24

	MOV	#MSGGITHUB0,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#11,R1   ; позиция курсора
	MOV	#25,R2
	EMT	24

	MOV	#MSGGITHUB1,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTHELP:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#1,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

	MOV	#HELP1,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#1,R2
	EMT	24

	MOV	#HELP2,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#2,R2
	EMT	24

	MOV	#HELP21,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#4,R2
	EMT	24

	MOV	#HELP3,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#5,R2
	EMT	24

	MOV	#0,@#212    ;черный фон;
        MOV	#177777,@#214   ;красный цвет

	MOV	#HELP4,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#6,R2
	EMT	24

	MOV	#0,@#212   ;черный фон
	MOV	#52525,@#214   ;синий цвет;

	MOV	#HELP5,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#7,R2
	EMT	24

	MOV	#0,@#212  ; цвет и фон по умолчанию
	MOV	#125252,@#214   

	MOV	#HELP6,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#10,R2
	EMT	24

	MOV	#HELP7,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#11,R2
	EMT	24

	MOV	#HELP8,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#13,R2
	EMT	24

	MOV	#HELP9,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#14,R2
	EMT	24

	MOV	#HELP10,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#1,R1   ; позиция курсора
	MOV	#15,R2
	EMT	24

	MOV	#HELP11,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC
