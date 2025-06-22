SUB_PRINTCAPTIONS:
        MOV	R0,-(SP)

        MOV	#CAPTIONSCENE,R0
	JSR PC, @#PRINT_SCENE

	MOV     (SP)+,R0

        RTS PC

SUB_PRINTSCORE:
        MOV 	#177777,@#214

        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	@#POSVSCORE,R1   ; позиция курсора
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

	MOV	@#POSVMAX,R1   ; позиция курсора
	MOV	#0,R2
	EMT	24

        MOV	@#MAXSCORE,-(SP)   ; Процедура принимает число                    
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
        MOV 	#177777,@#214

        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV	@#POSVDIAMONDS,R1   ; позиция курсора
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
	MOVB	#0,2(R1) ; Запрет вывод чисел шире 2 цифр
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

	MOV	#3,R1   ; позиция курсора
	MOV	#10,R2
	EMT	24

	MOV	@#GAMEOVERCOLOR,@#214
	MOV	#MSGGAMEOVER,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#125252,@#214

	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTGAMERESULT:
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)

	MOV	#11,R1   ; позиция курсора
	MOV	#12,R2
	EMT	24

	; Предполагаем, что может быть 100%, если так, то сразу к финалу
	MOV	#144,R4
	CMP	@#MAXSCORE,@#TEKSCORE
	BEQ	FIN_DIV100

	; Уменьшает оба числа так, чтобы TEKSCORE был не более 320
SHIFT_BEFORE_DIV:
	ASR	@#TEKSCORE
	ASR	@#MAXSCORE
	CMP	@#TEKSCORE,#501
        BGE	SHIFT_BEFORE_DIV

	; Домножаем TEKSCORE на 100
	MOV	#0,R3
	MOV	#144,R4
LAB_MUL100:
	ADD	@#TEKSCORE,R3
	SOB	R4,LAB_MUL100

	; Делим на MAXSCORE, вычитая по разу
	MOV	#0,R4
LAB_DIV100:
	SUB	@#MAXSCORE,R3
	CMP	R3,#0
	BLE	FIN_DIV100
	INC	R4
	JMP	LAB_DIV100

FIN_DIV100:
	MOV	#MSGSCOREVALUE,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV 	#177777,@#214

        MOV	R4,-(SP)   ; Процедура принимает число                    
        MOV	#STRBUF,-(SP) ; указатель на буфер                           
        MOV	#0,-(SP)  ; символ добивки слева или #0, если без добивки
        JSR PC, @#INT2STR
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

	MOV	#STRBUF,R1     ; Вывод строки по умолчанию с нулем на конце
	MOV	#0,R2
	EMT	20

	MOV	#MSGSCOREPERC,R1
	MOV	#0,R2
	EMT	20

	MOV	#125252,@#214

	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

SUB_PRINTDEBUG:
        MOV	R1,-(SP)
        MOV	R2,-(SP)

;	MOV	#5,R1   ; позиция курсора
;	MOV	#5,R2
;	EMT	24

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
	MOV 	#125252,@#214

        MOV	#MSGVER,-(SP)   ; Строка
        MOV	#5,-(SP)   ; Y
        JSR PC, @#PRINT_STRING_CENTERED
        ADD	#4, SP     ; Восстановить стек на 2*число аргументов

	MOV	#MENUSCENE,R0
	JSR PC, @#PRINT_SCENE

        JSR PC, @#SUB_PRINTSOUND
        JSR PC, @#SUB_PRINTJOYSTICK

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

SUB_PRINTJOYSTICK:

	CMP	@#JOYSTICKON,#0
	BEQ	LAB_NOJOYSTICK
	MOV	#TEXTJOY, R0
	JMP	LAB_DO_PRINTJOYSTICK
LAB_NOJOYSTICK:
	MOV	#TEXTKEY, R0
LAB_DO_PRINTJOYSTICK:
        JSR PC, @#PRINT_STRING_BY_COLOR_AND_POS

	RTS PC
