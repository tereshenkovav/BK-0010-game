; Аргументы в стеке: адрес звезды, адрес экрана
DRAWSTAR:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)

        ; Извлечение аргументов
        ADD	#6,SP
        MOV     (SP)+,R1 ; Видеоадрес
        MOV     (SP),R0 ; Адрес звезды
        SUB	#10,SP
        
	MOV	(R0)+,(R1)+
	ADD	#76,R1
	MOV	(R0)+,(R1)+
	ADD	#76,R1
	MOV	(R0)+,(R1)+
	ADD	#76,R1
	MOV	(R0)+,(R1)+
	ADD	#76,R1
	MOV	(R0)+,(R1)+
	ADD	#76,R1

        ; Восстановление регистров
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; Аргументы в стеке: адрес звезды, адрес экрана
CLEARSTAR:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)

        ; Извлечение аргументов
        ADD	#6,SP
        MOV     (SP)+,R1 ; Видеоадрес
        ; Адрес звезды не нужен
        SUB	#10,SP

	MOV	#0,R0
	MOV	R0,(R1)+
	ADD	#76,R1
	MOV	R0,(R1)+
	ADD	#76,R1
	MOV	R0,(R1)+
	ADD	#76,R1
	MOV	R0,(R1)+
	ADD	#76,R1
	MOV	R0,(R1)+
	ADD	#76,R1

        ; Восстановление регистров
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

SPR_STAR_CROSS_RED:
.BYTE 14,14
.BYTE 60,3
.BYTE 300,0
.BYTE 60,3
.BYTE 14,14

SPR_STAR_CROSS_GREEN:
.BYTE 10,10
.BYTE 40,2
.BYTE 200,0
.BYTE 40,2
.BYTE 10,10

SPR_STAR_CROSS_BLUE:
.BYTE 4,4
.BYTE 20,1
.BYTE 100,0
.BYTE 20,1
.BYTE 4,4

SPR_STAR_PLUS_RED:
.BYTE 300,0
.BYTE 300,0
.BYTE 74,17
.BYTE 300,0
.BYTE 300,0

SPR_STAR_PLUS_GREEN:
.BYTE 200,0
.BYTE 200,0
.BYTE 50,12
.BYTE 200,0
.BYTE 200,0

SPR_STAR_PLUS_BLUE:
.BYTE 100,0
.BYTE 100,0
.BYTE 24,5
.BYTE 100,0
.BYTE 100,0
