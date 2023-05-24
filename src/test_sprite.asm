	.LINK 1000

        EMT     14	

        MOV	#SPRUNICORN_MIRR,-(SP)   ; Спрайт
        MOV	#10,-(SP)   ; X
        MOV	#300,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

        MOV	#SPRUNICORN,-(SP)   ; Спрайт
        MOV	#320,-(SP)   ; X
        MOV	#300,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; Восстановить стек на 2*число аргументов

	HALT

.include "proc_drawsprite.inc"
.include "sprites_data.inc"

.EVEN
.END

make_bk0010_rom "test_sprite.bin", 1000
