	.LINK 1000

        EMT     14	

	MOV	#200,R0
START:

        MOV	#SPRUNICORN,-(SP)   ; Спрайт
        MOV	R0,-(SP)   ; X
        MOV	#300,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND1,-(SP)   ; Спрайт
        MOV	#50,-(SP)   ; X
        MOV	#100,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND2,-(SP)   ; Спрайт
        MOV	#50,-(SP)   ; X
        MOV	#200,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND3,-(SP)   ; Спрайт
        MOV	#150,-(SP)   ; X
        MOV	#100,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND4,-(SP)   ; Спрайт
        MOV	#150,-(SP)   ; X
        MOV	#200,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND5,-(SP)   ; Спрайт
        MOV	#250,-(SP)   ; X
        MOV	#100,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND6,-(SP)   ; Спрайт
        MOV	#250,-(SP)   ; X
        MOV	#200,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND7,-(SP)   ; Спрайт
        MOV	#50,-(SP)   ; X
        MOV	#150,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND8,-(SP)   ; Спрайт
        MOV	#50,-(SP)   ; X
        MOV	#250,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND9,-(SP)   ; Спрайт
        MOV	#150,-(SP)   ; X
        MOV	#150,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND10,-(SP)   ; Спрайт
        MOV	#150,-(SP)   ; X
        MOV	#250,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND11,-(SP)   ; Спрайт
        MOV	#250,-(SP)   ; X
        MOV	#150,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRDIAMOND12,-(SP)   ; Спрайт
        MOV	#250,-(SP)   ; X
        MOV	#250,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

	MOV 	#30000,R2
PAUSE1:	NOP
	SOB	R2,PAUSE1

	; Затирание прямого хода
;        MOV	R0,-(SP)   ; X
;        MOV	#300,-(SP)  ; Y
;        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
;        MOV	#40,-(SP)  ; DY
;        JSR PC, @#CLEARZONE
;        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

        ; Затирание обратного хода с конца
;        MOV	R1,R2
;	ADD	#34,R2
;        MOV	R2,-(SP)   ; X - в конце спрайта при обратном ходе
;        MOV	#200,-(SP)  ; Y
;        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
;        MOV	#40,-(SP)  ; DY
;        JSR PC, @#CLEARZONE
;        ADD	#10, SP     ; Восстановить стек на 2*число аргументов

;	ADD	#4,R0

	JMP 	START

	HALT

.include "proc_drawsprite.inc"
.include "sprites.inc"

.EVEN
.END

make_bk0010_rom "ponydiamondsgame.bin", 1000
