; Процедура принимает в R0 число-маску с единицами слева, 
; до которых будет обрезан вывод
; Например #7 - 111 - будет выдавать числа от 0 до 7
;          #377 - 11111111 - будет выдавать числа от 0 до 255
; Возвращает в R0 число в заданном диапазоне
;  Схема генерации:
;  x ^= x << 7;
;  x ^= x >> 9;
;  x ^= x << 8;
GENRNDVALUE:
        ; Сохранение регистров
        MOV	R1,-(SP)
        MOV	R2,-(SP)
        MOV	R3,-(SP)

	MOV 	@#TEKRNDVALUE,R1

	MOV	R1,R2
	MOV	#7,R3
G1:     ROL     R2
        SOB	R3,G1
	XOR	R2,R1

	MOV	R1,R2
	MOV	#11,R3
G2:	ROR     R2
        SOB	R3,G2
	XOR	R2,R1

	MOV	R1,R2
	MOV	#10,R3
G3:	ROL     R2
        SOB	R3,G3
	XOR	R2,R1

	MOV 	R1,@#TEKRNDVALUE

	; Обрезка до заданной маски
        COM	R0
        BIC	R0,R1
        MOV	R1,R0

        ; Восстановление регистров
	MOV     (SP)+,R3
	MOV     (SP)+,R2
	MOV     (SP)+,R1

        RTS PC

; Установка начального значения генератора
SETRNDSEED:
        MOV	R0, @#TEKRNDVALUE
        RTS PC

TEKRNDVALUE:    .WORD   0
