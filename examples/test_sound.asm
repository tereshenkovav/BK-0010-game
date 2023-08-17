	.LINK 1000 

	MOV	#377,R0  ; count of impulse
	MOV	#777,R1  ; len impulse      
M03:	MOV 	#100,@#177716 ; speaker on 
	MOV 	R1,R2
M01:	NOP
	SOB	R2,M01
	MOV	#0,@#177716   ; speaker off
	MOV	R1,R2
M02:	NOP
	SOB	R2,M02
	SOB	R0,M03

	MOV	#377,R0
	MOV	#400,R1        
M3:	MOV 	#100,@#177716  
	MOV 	R1,R2
M1:	NOP
	SOB	R2,M1
	MOV	#0,@#177716
	MOV	R1,R2
M2:	NOP
	SOB	R2,M2
	SOB	R0,M3
        
	MOV	#377,R0
	MOV	#200,R1        
M13:	MOV 	#100,@#177716
	MOV 	R1,R2
M11:	NOP
	SOB	R2,M11
	MOV	#0,@#177716
	MOV	R1,R2
M12:	NOP
	SOB	R2,M12
	SOB	R0,M13

	MOV	#377,R0
	MOV	#100,R1        
M23:	MOV 	#100,@#177716
	MOV 	R1,R2
M21:	NOP
	SOB	R2,M21
	MOV	#0,@#177716
	MOV	R1,R2
M22:	NOP
	SOB	R2,M22
	SOB	R0,M23

make_bk0010_rom "test_sound.bin", 1000
