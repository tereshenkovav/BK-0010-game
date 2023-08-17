	.LINK 1000

        EMT     14

	MOV    #233,R0  ; режим 32 символа
	EMT    16	
	MOV    #232,R0  ; скрытие курсора
	EMT    16

	; Установка переменных
	MOV	#7,@#X
	MOV	#22,@#Y
	MOV	#1,@#DX
	MOV	#-1,@#DY

START:
	MOV	@#X,R1   ; позиция курсора
	MOV	@#Y,R2
	EMT	24

	MOV	#0,@#212   ;черный фон
	MOV	@#GREEN,@#214   ;зеленый цвет
	MOV	@#SYMB,R0
	EMT	16

        ; Отладочная печать DX и DY
	MOV	#102,R0
	ADD     @#DX,R0
	MOV	#0,R1
        EMT	22
	MOV	#102,R0
	ADD     @#DY,R0
	MOV	#1,R1
        EMT	22

        ; Пауза
	MOV 	@#PAUSE,R3
DELAY:	NOP
	SOB	R3,DELAY

	MOV	@#X,R1   ; позиция курсора
	MOV	@#Y,R2
	EMT	24

	MOV	#0,@#212   ;черный фон;
	MOV	#0,@#214   ;черный цвет
	MOV	@#SYMB,R0
	EMT	16

	ADD	@#DX,@#X
	ADD	@#DY,@#Y

	; Отражение от стен
	CMP	@#X,#35
	BNE     NEXT1
	MOV     #-1,@#DX
NEXT1:
	CMP	@#X,#0
	BNE     NEXT2
	MOV     #1,@#DX
NEXT2: 
	CMP	@#Y,#24
	BNE     NEXT3
	MOV     #-1,@#DY
NEXT3:
	CMP	@#Y,#0
	BNE     NEXT4
	MOV     #1,@#DY
NEXT4:

	JMP	START

; Блок переменных два байта
X:      .WORD   0
Y:      .WORD   0
DX:     .WORD   0
DY:     .WORD   0
GREEN:  .WORD   125252
SYMB:   .WORD   44
PAUSE:  .WORD   7777
        .EVEN
        .END

make_bk0010_rom "test_vars.bin", 1000
