;;;;;tester program


;;;PUBLIC FUNCTIONS

;;EXTERN FUNCTIONS
EXTRN READ_KEY:NEAR,SET_TM:NEAR,DOS_EXIT:NEAR,FIX_AIM:NEAR
EXTRN SET_FIELD:NEAR,SET_BOUNDARY:NEAR,SET_GOALPOST:NEAR,DRAW_BALL:NEAR,ERASE_BALL:NEAR,DRAW_AIM:NEAR,ERASE_AIM:NEAR
EXTRN MOVE_BALL:NEAR,ANGLESHOT:NEAR,ONE_SHOT:NEAR
EXTRN FIXED_COL:WORD,FIXED_ROW:WORD
;;;;
.MODEL SMALL
.STACK 100h
.DATA
.CODE
 
 MAIN PROC
 
 CALL SET_FIELD
 CALL SET_BOUNDARY
 CALL SET_GOALPOST
 
 ;CALL ONE_SHOT
 MOV CX,160
	MOV DX,160
	CALL DRAW_BALL
 
	MOV CX,160
	MOV DX,50
	CALL DRAW_AIM
	CALL FIX_AIM
	
	; PUSH CX
	; PUSH DX
	; CALL ERASE_AIM
	; PUSH DX
	; PUSH CX
	
 
	MOV CX,160
	MOV DX,160
 
	CALL ANGLESHOT
	CALL MOVE_BALL
	MOV AX,FIXED_COL
	MOV BX,FIXED_ROW
 
	 CALL ANGLESHOT
	 CALL MOVE_BALL
    ; MOV IMPACT_COL,CX
	; MOV IMPACT_ROW,DX
	
	
	
	CALL SET_BOUNDARY
	
	
 CALL READ_KEY
 CALL SET_TM
 CALL DOS_EXIT
 MAIN ENDP
 
 
 
 END
  
 



