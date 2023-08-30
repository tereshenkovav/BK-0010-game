SUB_HITBOX:
        MOV	R0,-(SP)
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        
        MOV	R4,R0  ; X алмаза
        MOV	R5,R1  ; Y алмаза

        MOV	#ARR_SPRITES,R2 ; Вычисление высоты алмаза
        ADD	R3,R2
        ADD	R3,R2           ; Позиция спрайта алмаза в массиве
	MOV	(R2),R2         ; Копируем адрес, теперь указатель на спрайт
        MOV	(R2),@#INT_DIAMOND_W  
        MOV	2(R2),@#INT_DIAMOND_H ; Сохранена высота спрайта алмаза 
        ASL     @#INT_DIAMOND_W
        ASL     @#INT_DIAMOND_W   ; Сохранена ширина спрайта алмаза

        MOV	#0,R4  ; По умолчанию, не убираем и не начисляем очки
        MOV	#0,R5

        MOV	@#PONYY,R2 ; Координата верхней границы пони
        SUB	@#INT_DIAMOND_H,R2
        CMP	R1,R2
	BLT	PONY_HIT_BOX ; Если не дошли до границы пони сверху

	; Сравниваем позиции алмаза и пони по X
	; Если правый край алмаза левее левого края пони, то мимо
        MOV	R0,R2
	ADD	@#INT_DIAMOND_W,R2
        CMP	R2,@#PONYX
        BLT	PONY_HIT_BOX

	; Если левый край алмаза правее правого края пони, то мимо
        MOV	@#PONYX,R2
	ADD	#40,R2
        CMP	R2,R0
        BLT	PONY_HIT_BOX

	MOV	#ARR_SCORES,R0 ; Вычисляем позицию в массиве очков по спрайтам
	ADD	R3,R0
	ADD	R3,R0
        MOV	#1,R4  ; Убрать и начислить очки
        MOV	(R0),R5

        JMP 	END_HIT_BOX

PONY_HIT_BOX:

        MOV	@#LOWBORDER,R2 ; Координата пола
        SUB	@#INT_DIAMOND_H,R2
        CMP	R1,R2
	BLT	END_HIT_BOX

        MOV	#1,R4  ; Только убрать, без начисления очков

END_HIT_BOX:

	MOV     (SP)+,R2
	MOV     (SP)+,R1
	MOV     (SP)+,R0

        RTS PC

INT_DIAMOND_W:	.WORD	0
INT_DIAMOND_H:	.WORD	0
