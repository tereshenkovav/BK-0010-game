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