; Аргументы в стеке: адрес спрайта, X, Y
DRAWSPRITE:
        ; Сохранение регистров
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)
        MOV	R4,-(SP)
        MOV	R5,-(SP)

        ; Извлечение аргументов
        ADD	#16,SP
        MOV     (SP)+,R2 ; Y
        MOV     (SP)+,R1 ; X
        MOV     (SP),R0 ; Адрес спрайта
        SUB	#22,SP

	MOV	#40000,R3 ; Вычисляем позицию в видеопамяти
	ASR	R1	
	ASR	R1
	ADD	R1,R3
CALCY:	ADD	#100,R3   ; Неоптимальное умножение #100 на Y
	SOB	R2,CALCY	
	MOV	R3,R1     ; В R1 теперь конечный адрес назначения
	
        MOV	(R0),R4	  ; Получаем размеры спрайта
        ADD	#2,R0
        MOV	(R0),R5	
        ADD	#2,R0
        
	MOV	R5,R3

ROW:    MOV	R4,R2
        
COL:	MOVB	(R0)+,(R1)+  ; Неоптимально, если можно сделать 2 байта
	SOB	R2,COL

	ADD	#100,R1
	SUB	R4,R1

	SOB	R3,ROW

        ; Восстановление регистров
	MOV     (SP)+,R5
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
        MOV	R5,-(SP)

        ; Извлечение аргументов
        ADD	#16,SP
        MOV     (SP)+,R2 ; Y
        MOV     (SP)+,R1 ; X
        MOV     (SP),R0 ; Адрес спрайта
        SUB	#22,SP
                          ; Много дублирования с кодом выше
	MOV	#40000,R3 ; Вычисляем позицию в видеопамяти
	ASR	R1	
	ASR	R1
	ADD	R1,R3
CALCY1:	ADD	#100,R3   ; Неоптимальное умножение #100 на Y
	SOB	R2,CALCY1	
	MOV	R3,R1     ; В R1 теперь конечный адрес назначения
	
        MOV	(R0),R4	  ; Получаем размеры спрайта
        ADD	#2,R0
        MOV	(R0),R5	
        ADD	#2,R0
        
	MOV	R5,R3

ROW1:    MOV	R4,R2
        
COL1:	MOVB	#0,(R1)+  ; Неоптимально, если можно сделать 2 байта
	SOB	R2,COL1

	ADD	#100,R1
	SUB	R4,R1

	SOB	R3,ROW1

        ; Восстановление регистров
	MOV     (SP)+,R5
	MOV     (SP)+,R4
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC
