; Процедура принимает в R0 число с единицами слева, до которых будет обрезан вывод
; Например 7 - 111 - будет выдавать числа от 0 до 7
; Возвращает в R0 число в заданном диапазоне
GENRNDVALUE:
        ; Сохранение регистров
        MOV	R1,-(SP)
        MOV	R2,-(SP)

	MOV 	@#TEKRNDVALUE,R1

	MOV	R1,R2
	ROL     R2
	XOR	R2,R1

	MOV	R1,R2
	ROR     R2
	XOR	R2,R1

	MOV	R1,R2
	ROL     R2
	XOR	R2,R1

	MOV 	R1,@#TEKRNDVALUE

	; Обрезка до заданной маски
        COM	R0
        BIC	R0,R1
        MOV	R1,R0

        ; Восстановление регистров
	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

; Установка начального значения генератора
SETRNDSEED:
        MOV	R0, @#TEKRNDVALUE
        RTS PC

TEKRNDVALUE:    .WORD   0
