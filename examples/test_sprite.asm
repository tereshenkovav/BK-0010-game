	.LINK 1000

        EMT     14	

	MOV	#10,R0
	MOV	#320,R1
START:

        MOV	#SPRUNICORN_MIRR,-(SP)   ; —прайт
        MOV	R0,-(SP)   ; X
        MOV	#300,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ¬осстановить стек на 2*число аргументов

        MOV	#SPRUNICORN,-(SP)   ; —прайт
        MOV	R1,-(SP)   ; X
        MOV	#200,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ¬осстановить стек на 2*число аргументов

        MOV	#SPRUNICORN_MIRR,-(SP)   ; —прайт
        MOV	R0,-(SP)   ; X
        MOV	#100,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ¬осстановить стек на 2*число аргументов

	MOV 	#30000,R2
PAUSE1:	NOP
	SOB	R2,PAUSE1

	; «атирание пр€мого хода
        MOV	R0,-(SP)   ; X
        MOV	#300,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; ¬осстановить стек на 2*число аргументов

        ; «атирание обратного хода с конца
        MOV	R1,R2
	ADD	#34,R2
        MOV	R2,-(SP)   ; X - в конце спрайта при обратном ходе
        MOV	#200,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; ¬осстановить стек на 2*число аргументов

	; «атирание пр€мого хода
        MOV	R0,-(SP)   ; X
        MOV	#100,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - размер затираемой области по движению
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; ¬осстановить стек на 2*число аргументов

	ADD	#4,R0
	SUB	#4,R1

	JMP 	START

	HALT

.include "proc_drawsprite.inc"
.include "sprites_data.inc"

.EVEN
.END

make_bk0010_rom "test_sprite.bin", 1000
