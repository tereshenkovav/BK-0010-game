; Аргументы в стеке: адрес спрайта, X, Y
DRAWSPRITE:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)

        ; Извлечение аргументов
        ADD	#14,SP
        MOV     (SP)+,R2 ; Y
        MOV     (SP)+,R1 ; X
        MOV     (SP),R0 ; Адрес спрайта
        SUB	#20,SP

	MOV	#40000,R3 ; Вычисляем позицию в видеопамяти
	ASR	R1	  ; Делим X на 4 путем сдвига вправо 2 раза
	ASR	R1
	ADD	R1,R3
	ASL	R2        ; Умножение #100 на Y путем сдвига влево 6 раз
	ASL	R2
	ASL	R2
	ASL	R2
	ASL	R2
	ASL	R2
	ADD	R2,R3   
	MOV	R3,R1     ; В R1 теперь конечный адрес назначения
	
        MOV	(R0),R4	  ; Получаем размеры спрайта
        ADD	#2,R0
        MOV	(R0),R3
	ADD	#2,R0

ROW:    MOV	R4,R2
        ASR	R2 ; Делим на 2 для перехода к двухбайтной операции

COL:	MOVB	(R0)+,(R1)+
        MOVB	(R0)+,(R1)+
	SOB	R2,COL

	ADD	#100,R1
	SUB	R4,R1

	SOB	R3,ROW

        ; Восстановление регистров
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; Аргументы в стеке: адрес спрайта, X, Y
CLEARSPRITE:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)

        ; Извлечение аргументов
        ADD	#14,SP
        MOV     (SP)+,R2 ; Y
        MOV     (SP)+,R1 ; X
        MOV     (SP),R0 ; Адрес спрайта
        SUB	#20,SP
                          ; Много дублирования с кодом выше
	MOV	#40000,R3 ; Вычисляем позицию в видеопамяти
	ASR	R1	  ; Делим X на 4 путем сдвига вправо 2 раза
	ASR	R1
	ADD	R1,R3
	ASL	R2        ; Умножение #100 на Y путем сдвига влево 6 раз
	ASL	R2
	ASL	R2
	ASL	R2
	ASL	R2
	ASL	R2
	ADD	R2,R3
	MOV	R3,R1     ; В R1 теперь конечный адрес назначения
        MOV	(R0),R4	  ; Получаем размеры спрайта
        ADD	#2,R0
        MOV	(R0),R3
        
	MOV	#0,R0

ROW1:    MOV	R4,R2
	ASR	R2 ; Делим на 2 для перехода к двухбайтной операции
        
COL1:	MOVB	R0,(R1)+
        MOVB	R0,(R1)+
	SOB	R2,COL1

	ADD	#100,R1
	SUB	R4,R1

	SOB	R3,ROW1

        ; Восстановление регистров
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

; Аргументы в стеке: X, Y, DX, DY
CLEARZONE:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)
        MOV	R5,-(SP)

        ; Извлечение аргументов
        ADD	#16,SP
        MOV     (SP)+,R5 ; DY
        MOV     (SP)+,R4 ; DX
        MOV     (SP)+,R2 ; Y
        MOV     (SP),R1 ; X
        SUB	#24,SP
                          ; Много дублирования с кодом выше
	MOV	#40000,R3 ; Вычисляем позицию в видеопамяти
	ASR	R1	  ; Делим X на 4 путем сдвига вправо 2 раза
	ASR	R1
	ADD	R1,R3
	ASL	R2        ; Умножение #100 на Y путем сдвига влево 6 раз
	ASL	R2
	ASL	R2
	ASL	R2
	ASL	R2
	ASL	R2
	ADD	R2,R3
	MOV	R3,R1     ; В R1 теперь конечный адрес назначения
       
	MOV	R5,R3

	MOV	#0,R0
ROW2:	MOV	R4,R2
        
COL2:	MOVB	R0,(R1)+
	SOB	R2,COL2

	ADD	#100,R1
	SUB	R4,R1

	SOB	R3,ROW2

        ; Восстановление регистров
	MOV     (SP)+,R5
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC
