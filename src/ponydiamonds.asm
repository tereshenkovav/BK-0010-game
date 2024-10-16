	.LINK 1000

        EMT     14
	MOV    #233,R0  ; ����� 32 �������
	EMT    16
	MOV    #232,R0  ; ������� �������
	EMT    16

	MOV	#0,@#212  ; ���� � ���
	MOV	#125252,@#214   

	; ��������� ���������� �� ����������, ����� �� ������ ����
	BIS	#100,@#177660 
	; ������ �� ���� ������ �����
	MOV	#EXIT_BY_STOP,@#4

	JSR PC, @#SHOW_INTRO

        MOV	#0,R5
MENU_KEY_WAIT_INTRO:
        JSR PC, @#IS_KEY_PRESSED

        INC	R5
	CMP	R5,#120000
	BEQ	MAIN_MENU_ENTRY

	CMP	R0,#0       ;�� ���� �������
        BEQ     MENU_KEY_WAIT_INTRO

MAIN_MENU_ENTRY:
	JSR PC, @#CLEAR_SCREEN
	JSR PC, @#SUB_PRINTMENU

	MOV	#ARR_SPRITES,R2	
        MOV	(R2)+,-(SP)   ; ������ ������
        MOV	#70,-(SP)   ; X
        MOV	#30,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

        MOV	(R2)+,-(SP)   ; ������ ������
        MOV	#170,-(SP)   ; X
        MOV	#30,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

        MOV	(R2)+,-(SP)   ; ������ ������
        MOV	#270,-(SP)   ; X
        MOV	#30,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

        MOV	#SPRUNICORN,-(SP)   ; ������
        MOV	#154,-(SP)   ; X
        MOV	#240,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#0,R5  ; ���������� ���������� ��������
MENU_KEY_WAIT:
        INC	R5
        JSR PC, @#IS_KEY_PRESSED

	CMP	R0,#0       ;�� ���� �������
        BEQ     MENU_KEY_WAIT

        ; ����� ������
	CMP	R0,#61      ; ������� "1"
	BNE     KEYMENU1
	MOV	#14,@#DIFFGENTYPE
        JMP 	GAME_START_ENTRY
KEYMENU1:
	CMP	R0,#62      ; ������� "2"
	BNE     KEYMENU2
	MOV	#15,@#DIFFGENTYPE
        JMP 	GAME_START_ENTRY
KEYMENU2:
	CMP	R0,#63      ; ������� "3"
	BNE     KEYMENU3
	MOV	#1,R2
	SUB	@#SOUNDON,R2
	MOV	R2,@#SOUNDON
	JSR PC, @#SUB_PRINTSOUND
        JMP 	MENU_KEY_WAIT
KEYMENU3:
	CMP	R0,#64      ; ������� "4"
	BNE     KEYMENU4
        JMP 	HELP_ENTRY
KEYMENU4:
	CMP	R0,#60      ; ������� "0"
	BNE     KEYMENU5
	EMT	14
	HALT
KEYMENU5:
       	JMP 	MENU_KEY_WAIT

HELP_ENTRY:
	JSR PC, @#CLEAR_SCREEN
        MOV	#HELPSCENE,R0
	JSR PC, @#PRINT_SCENE

MENU_HELP_WAIT:
        JSR PC, @#IS_KEY_PRESSED

	CMP	R0,#0       ;�� ���� ������� 
        BEQ     MENU_HELP_WAIT

        JMP MAIN_MENU_ENTRY

GAME_START_ENTRY:
        MOV	R5,R0 ; ��������� �������� ���������
        JSR PC, @#SETRNDSEED

	; ������� � ������� �����
	MOV	#40000,R0
FILL_SKY:
	CLR	(R0)+
	CMP	R0,#76000
        BNE	FILL_SKY

	MOV	#1000,R1
FILL_GROUND:
        MOV	#125252,(R0)+
	SOB	R1,FILL_GROUND

	; ��������� ������� ����, ��������, ������
	MOV	#200,@#PONYX
	MOV	#320,@#PONYY
	MOV	@#PONYX,@#PONYRENDERX
	MOV	#0,@#PONYDX
	MOV	#4,@#PONYDIR
	MOV	#0,@#TEKSCORE
	MOV	@#TOTALDIAMONDSINGAME,@#DIAMONDSDROP
	MOV	#0,@#DIAMONDSONAIR
	MOV	#125252,@#GAMEOVERCOLOR
	MOV	@#GENINTERVAL,@#GENCOUNTER

	JSR PC, @#SUB_PRINTCAPTIONS
        JSR PC, @#SUB_PRINTSCORE
        JSR PC, @#SUB_PRINTDIAMONDS

	; ������������� ������� �������
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_INIT:
	MOV	#-1,(R0)+
	MOV	#0,(R0)+
	MOV	#0,(R0)+
	MOV	#0,(R0)+
	SOB 	R1,CICLE_INIT

START:
	MOV	#3777,@#177706  ; ������������ ������ (3777 - �������� 10 FPS)
        MOV	#24,@#177712  ; ��������� ���� � ���������

; ===== ���� ������ ���������� ======
        JSR PC, @#IS_KEY_PRESSED

	CMP	R0,#0       ;�� ���� ������� 
        BEQ     END_KEY

        ; ����� ����� ������� (1) � �� ��� ������
	CMP	R0,#31      ; ������� "������ ������"?
	BNE     KEYSTEP1
       	MOV	#4,@#PONYDX ; ����� ��������
       	MOV	#4,@#PONYDIR; ����� ��������
KEYSTEP1:  
	CMP	R0,#10      ; ������� "������ �����"?
	BNE     KEYSTEP2
       	MOV	#-4,@#PONYDX ; ����� ��������
       	MOV	#-4,@#PONYDIR; ����� ��������
KEYSTEP2:
	CMP	R0,#40      ; ������� "������"?
	BNE     KEYSTEP3
       	MOV	#0,@#PONYDX ; ����� ��������
KEYSTEP3:
	CMP	R0,#3      ; ������� "��"?
	BNE     END_KEY
	JMP	MAIN_MENU_ENTRY
END_KEY:        

; ===== ���� ������ ������ ����� ======
        CMP	@#PONYX, @#PONYRENDERX
        BEQ	NO_CLEARZONE
        ;[!] �������� �����, ��� �������, ����� �������� ������ �������

	; ��������� ������� ����
        MOV	@#PONYRENDERX,-(SP)   ; X
        MOV	@#PONYY,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - ������ ���������� ������� �� ��������
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; ������������ ���� �� 2*����� ����������

        ; ��������� ��������� ���� � �����
        MOV	@#PONYRENDERX,R0
	ADD	#34,R0
        MOV	R0,-(SP)   ; X - � ����� ������� ��� �������� ����
        MOV	@#PONYY,-(SP)  ; Y
        MOV	#1,-(SP)  ; DX - ������ ���������� ������� �� ��������
        MOV	#40,-(SP)  ; DY
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; ������������ ���� �� 2*����� ����������

NO_CLEARZONE:

        ; ��������� �������
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_CLEAR:
	CMP	(R0),#-1
	BEQ	SKIP_ARRAY_ELEM3

        MOV	2(R0),-(SP)   ; X
        MOV	4(R0),R3
        SUB	6(R0),R3
        MOV	R3,-(SP)  ; Y
        MOV	#10,-(SP)  ; DX 
        MOV	6(R0),-(SP)  ; DY - ������ ���������� ������� �� ��������
        JSR PC, @#CLEARZONE
        ADD	#10, SP     ; ������������ ���� �� 2*����� ����������
        
SKIP_ARRAY_ELEM3:
        ADD	#10,R0
	SOB 	R1,CICLE_DIAMONDS_CLEAR

        ; ��������� ��������� ����� ����
	MOV	@#ARR_STARS_SIZE,R1
	MOV	#ARR_STARS,R2
CICLE_STAR_RENDER:
        SUB	#1,(R2)  ; �������� ������� ������
        CMP	(R2),#0
        BNE	NOT_NOL_STAR_LIFECICLE
        MOV	#100,(R2) ;  ���� ������ ����, ������ �� 100
NOT_NOL_STAR_LIFECICLE:

        MOV	4(R2),-(SP)   ; X
        MOV	6(R2),-(SP)  ; Y
        JSR PC, @#IS_ANY_DIAMOND_OVER_STAR
	ADD	#4, SP     ; ������������ ���� �� 2*����� ����������
	CMP	R5, #1
	BEQ	NEXT_STAR_CICLE

        MOV	2(R2),-(SP)   ; ������
        MOV	4(R2),-(SP)   ; X
        MOV	6(R2),-(SP)  ; Y

        CMP	(R2),#3    ; ��� �������� ����� 3 - �������, ����� ���������
	BLT     CLEAR_CURRENT_STAR
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������
	JMP	NEXT_STAR_CICLE
CLEAR_CURRENT_STAR:
        JSR PC, @#CLEARSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������
NEXT_STAR_CICLE:

	ADD	#10,R2
	SOB	R1,CICLE_STAR_RENDER

; ===== ���� ������� ======

        CMP	@#PONYDIR,#4      ; ����� ���� �������
	BNE     MIRRPONYSPR
        MOV	#SPRUNICORN,-(SP)   ; ������
        JMP	DODRAWPONYSPR
MIRRPONYSPR:
        MOV	#SPRUNICORN_MIRR,-(SP)   ; ������
DODRAWPONYSPR:
        MOV	@#PONYX,-(SP)   ; X
        MOV	@#PONYY,-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

        MOV	@#PONYX,@#PONYRENDERX   ; �������� ������� �������

        ; ����� �������
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_RENDER:
	CMP	(R0),#-1
	BEQ	SKIP_ARRAY_ELEM

	MOV	#ARR_SPRITES,R3
	ADD	(R0),R3
	ADD	(R0),R3
        MOV	(R3),-(SP)   ; ������ ������
        MOV	2(R0),-(SP)   ; X
        MOV	4(R0),-(SP)  ; Y
        JSR PC, @#DRAWSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

SKIP_ARRAY_ELEM:
        ADD	#10,R0
	SOB 	R1,CICLE_DIAMONDS_RENDER

; ===== ���� ���������� ��������� ���� ======
	ADD	@#PONYDX,@#PONYX ; ��������
	CMP	@#PONYX,#0
	BGE     NEXT_FRAME_1
	MOV	#0,@#PONYX
NEXT_FRAME_1:
	CMP	@#PONYX,#340
	BLE     NEXT_FRAME_2
	MOV	#340,@#PONYX
NEXT_FRAME_2:

        ; ������ �������
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_FRAME:
	CMP	(R0),#-1
	BEQ	SKIP_ARRAY_ELEM2

        ; ��������� �������� � Y
        ADD	6(R0),4(R0)

        ; ���� �����, ������������ ����� ��� ���������
        MOV	(R0),R3   ; idx
	MOV	2(R0),R4  ; X 
        MOV	4(R0),R5  ; Y
        JSR PC, @#SUB_HITBOX
        CMP	R4,#0
        BEQ	SKIP_REMOVE_DIAMOND

	CMP	#14,(R0)
	BEQ	IT_IS_STONE2
	DEC	@#DIAMONDSONAIR
        JSR PC, @#SUB_PRINTDIAMONDS
IT_IS_STONE2:

	CMP	R5,#1 ; �� ������ ���� ������� ������, ���� ����� ����� 0 ��� ������
	BLT	NO_PLAY_SOUND
	JSR PC, @#SOUND_PLAY_HIT

NO_PLAY_SOUND:

	CMP	R5,#-1
	BNE	NO_STONE_HITTING
	MOV	#177777,@#GAMEOVERCOLOR
	JMP	ENTER_GAMEOVER
NO_STONE_HITTING:

	; ������� �������� ���
	MOV	#ARR_SPRITES,R3
	ADD	(R0),R3
	ADD	(R0),R3
        MOV	(R3),-(SP)   ; ������ ������
        MOV	2(R0),-(SP)   ; X
        MOV	4(R0),R3
        SUB	6(R0),R3
        MOV	R3,-(SP)  ; Y
        JSR PC, @#CLEARSPRITE
        ADD	#6, SP     ; ������������ ���� �� 2*����� ����������

        ; ����� �������� ��� ���������
	MOV	#-1,(R0)

	ADD	R5,@#TEKSCORE
	JSR PC, @#SUB_PRINTSCORE

        MOV	@#DIAMONDSONAIR,R3
        ADD	@#DIAMONDSDROP,R3
        CMP	R3,#0
	BEQ	ENTER_GAMEOVER

SKIP_REMOVE_DIAMOND:	

SKIP_ARRAY_ELEM2:
        ADD	#10,R0
	DEC	R1
	CMP	R1,#0
	BNE	CICLE_DIAMONDS_FRAME

	; ��������� ����� �������
	CMP	@#DIAMONDSDROP,#0
	BEQ	SKIP_NEW_DIAMOND

	DEC	@#GENCOUNTER
	CMP	@#GENCOUNTER,#0
	BNE	SKIP_NEW_DIAMOND
	
	MOV	@#GENINTERVAL,@#GENCOUNTER
	
	MOV	#ARR_DIAMONDS,R0
        MOV	@#ARR_DIAMONDS_SIZE,R1
CICLE_DIAMONDS_NEW:
	CMP	(R0),#-1
	BNE	SKIP_ARRAY_ELEM4

	MOV	R0,R2 ; save

        MOV	#17,R0 ; ��������� ����� � ��������� �� 0 �� 15
        JSR PC, @#GENRNDVALUE
	CMP	R0,@#DIFFGENTYPE
	BLT	NO_SUB_RND1
	MOV	@#DIFFGENTYPE,R0
	DEC	R0
NO_SUB_RND1:
	MOV	R0,R3

        MOV	#377,R0 ; ��������� ����� � ��������� �� 0 �� 255
        JSR PC, @#GENRNDVALUE
	CMP	R0,#337
	BLT	NO_SUB_RND2
	SUB	#40,R0
NO_SUB_RND2:
	MOV	R0,R4

	MOV	#5,R5 ; �� ��������� �������� ��������
	JSR PC,	@#SUB_IS_X_OVER_DIAMONDS
	CMP	R0,#0
	BEQ	NO_FIX_NEWVELOCITY ; ��������� ����������� � ���� ��� ����
	MOV	#3,R5  ; �� ����� ��������� ��������
NO_FIX_NEWVELOCITY:

	MOV	R2,R0 ; restore

	CMP	R3,#14 ; ���� ����� ������, �� �� ����� ������ ���� �������
	BEQ     IT_IS_STONE
	DEC	@#DIAMONDSDROP
	INC	@#DIAMONDSONAIR
        JSR PC, @#SUB_PRINTDIAMONDS
IT_IS_STONE:

       	MOV	R3,(R0)
	MOV	R4,2(R0)
	MOV	@#DIAMONDSTARTY,4(R0)
	MOV	R5,6(R0)

        JMP	SKIP_NEW_DIAMOND
SKIP_ARRAY_ELEM4:
        ADD	#10,R0
	SOB	R1,CICLE_DIAMONDS_NEW

SKIP_NEW_DIAMOND:
	
; ===== ���� ������������ ����� ������ ======
TIMERCICLEWAIT:
        BIT	#200,@#177712 ; ��������� ������� ������� ����� ���� - ��� 7
        BEQ	TIMERCICLEWAIT         ; ������, ���� �� �����

	JMP 	START

ENTER_GAMEOVER:
        JSR PC, @#SUB_PRINTGAMEOVER
	JSR PC, @#SOUND_PLAY_GAMEOVER

WAIT_ENTER_AT_GAMEOVER:	
        JSR PC, @#IS_KEY_PRESSED

	CMP	R0,#12      ; ������� "����"?
	BNE     WAIT_ENTER_AT_GAMEOVER
       	JMP	MAIN_MENU_ENTRY

SOUND_PLAY_HIT:
	CMP	@#SOUNDON,#0
	BEQ	SKIP_SOUND_PLAY_HIT

	MOV	#37,-(SP)
        MOV	#47,-(SP)
        JSR PC, @#PLAY_SOUND_LEN_PERIOD
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

SKIP_SOUND_PLAY_HIT:
	RTS PC

SOUND_PLAY_GAMEOVER:
	CMP	@#SOUNDON,#0
	BEQ	SKIP_SOUND_PLAY_GAMEOVER

	MOV	#277,-(SP)
        MOV	#47,-(SP)
        JSR PC, @#PLAY_SOUND_LEN_PERIOD
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#177,-(SP)
        MOV	#77,-(SP)
        JSR PC, @#PLAY_SOUND_LEN_PERIOD
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

	MOV	#77,-(SP)
        MOV	#147,-(SP)
        JSR PC, @#PLAY_SOUND_LEN_PERIOD
        ADD	#4, SP     ; ������������ ���� �� 2*����� ����������

SKIP_SOUND_PLAY_GAMEOVER:
	RTS PC

EXIT_BY_STOP:
	EMT	14
	HALT

.include "proc_drawsprite.inc"
.include "proc_keytester.inc"
.include "proc_genrnd.inc"
.include "proc_int2str.inc"
.include "proc_helpers.inc"
.include "sub_prints.inc"
.include "sub_hitbox.inc"
.include "sub_intro.inc"
.include "sprites.inc"
.include "intro.inc"

DIFFGENTYPE:      .WORD   0
SOUNDON:	.WORD   1
PONYX:      .WORD   0
PONYY:      .WORD   0
PONYRENDERX:      .WORD   0
PONYDX:     .WORD   0
PONYDIR:    .WORD   0
LOWBORDER:    .WORD   360
DIAMONDSTARTY:  .WORD   35
DIAMONDSDROP:  .WORD   0
DIAMONDSONAIR:  .WORD   0
GENINTERVAL:	.WORD  14
GENCOUNTER:    .WORD   0
TEKSCORE:	.WORD	0
GAMEOVERCOLOR:  .WORD  0
TOTALDIAMONDSINGAME: .WORD 100
DEBUG:	.WORD	0
STRBUF:    .BYTE   0,0,0,0,0,0 
SPACEBUF:    .ASCIZ "   "
ARR_DIAMONDS_SIZE: .WORD 32
ARR_DIAMONDS: .WORD 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
              .WORD 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
              .WORD 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
              .WORD 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
ARR_SPRITES:
  .WORD SPRDIAMOND7, SPRDIAMOND9, SPRDIAMOND11,SPRDIAMOND8
  .WORD SPRDIAMOND10,SPRDIAMOND12,SPRDIAMOND1, SPRDIAMOND3
  .WORD SPRDIAMOND5, SPRDIAMOND2, SPRDIAMOND4, SPRDIAMOND6
  .WORD SPRSTONE
ARR_SCORES:  .WORD 12,24,36, 24,50,74, 24,50,74, 50,120,170, -1
ARR_STARS_SIZE: .WORD 12
ARR_STARS: .WORD 5,SPR_STAR_PLUS_GREEN,101,142, 15,SPR_STAR_PLUS_RED,42,220
  .WORD 20,SPR_STAR_CROSS_GREEN,126,221,        30,SPR_STAR_PLUS_BLUE,311,104
  .WORD 35,SPR_STAR_PLUS_RED,251,122,           45,SPR_STAR_CROSS_GREEN,113,55
  .WORD 50,SPR_STAR_PLUS_GREEN,332,157 ,        60,SPR_STAR_CROSS_BLUE,145,50
  .WORD 65,SPR_STAR_CROSS_GREEN,217,206,        70,SPR_STAR_CROSS_RED,203,62
.include "strings.inc"
.EVEN
.END

make_bk0010_rom "ponydiamonds.bin", 1000
