SUB_PRINTCAPTIONS:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#1,R1   ; позици€ курсора
	MOV	#0,R2
	EMT	24

	MOV	#MSGSCORE,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#15,R1   ; позици€ курсора
	MOV	#0,R2
	EMT	24

	MOV	#MSGDIAMONDS,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTSCORE:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#7,R1   ; позици€ курсора
	MOV	#0,R2
	EMT	24

        MOV	@#TEKSCORE,-(SP)   ; ѕроцедура принимает число                    
        MOV	#STRBUF,-(SP) ; указатель на буфер                           
        MOV	#0,-(SP)  ; символ добивки слева или #0, если без добивки
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ¬осстановить стек на 2*число аргументов

	MOV	#STRBUF,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2               
	EMT	20               

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTDIAMONDS:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#25,R1   ; позици€ курсора
	MOV	#0,R2
	EMT	24

	MOV	@#DIAMONDSDROP,R1
	ADD	@#DIAMONDSONAIR,R1
        MOV	R1,-(SP)   ; ѕроцедура принимает число                    
        MOV	#STRBUF,-(SP) ; указатель на буфер                           
        MOV	#0,-(SP)  ; символ добивки слева или #0, если без добивки
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ¬осстановить стек на 2*число аргументов

	MOV	#STRBUF,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2               
	EMT	20               

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTGAMEOVER:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#1,R1   ; позици€ курсора
	MOV	#2,R2
	EMT	24

	MOV	#MSGGAMEOVER,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTDEBUG:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#5,R1   ; позици€ курсора
	MOV	#5,R2
	EMT	24

        MOV	@#DEBUG,-(SP)   ; ѕроцедура принимает число                    
        MOV	#STRBUF,-(SP) ; указатель на буфер                           
        MOV	#40,-(SP)  ; символ добивки слева или #0, если без добивки
        JSR PC, @#INT2STR
        ADD	#6, SP     ; ¬осстановить стек на 2*число аргументов

	MOV	#STRBUF,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTMENU:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	#4,R1   ; позици€ курсора
	MOV	#5,R2
	EMT	24

	MOV	#MSGTITLE,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#12,R1   ; позици€ курсора
	MOV	#10,R2
	EMT	24

	MOV	#MSGMENUSTART,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#12,R1   ; позици€ курсора
	MOV	#11,R2
	EMT	24

	MOV	#MSGMENUHELP,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#12,R1   ; позици€ курсора
	MOV	#12,R2
	EMT	24

	MOV	#MSGMENUEXIT,R1     ; ¬ывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC
