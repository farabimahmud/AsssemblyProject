;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ROUTINES.ASM IS A LIBRARY TO IMPLEMENT SHOOTING ROUTINES;;
;;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

;;;PUBLIC FUNCTIONS:;;
PUBLIC MOVE_BALL,ANGLESHOT,ONE_SHOT,IMPACT_COL,IMPACT_ROW


;;;;;EXTERN FUNCTIONS;;;;;
EXTRN DRAW_BALL:NEAR,ERASE_BALL:NEAR,DRAW_AIM:NEAR,ERASE_AIM:NEAR,FIX_AIM:NEAR
EXTRN FIXED_COL:WORD,FIXED_ROW:WORD
EXTRN SET_BOUNDARY:NEAR,READ_KEY:NEAR

;;;code;;;;;

.MODEL SMALL
.STACK 100h
.DATA
divisor db ?
D_COLUMN db ?
D_ROW db ?
IMPACT_COL dw ?
IMPACT_ROW dw ?


.CODE

;;;---------------------------------------------------------------------------------------------------;;;;;
ANGLESHOT PROC NEAR
;;;ANGLESHOT PROCEDURE CALCULATES THE SLOP AND RETURNS LAST POSITION     
;input (AX,BX) (CX,DX) in (column,row) format
;output(AX,newBX) angle shot     
;input AX,BX-->push AX,BX--->Call (AX,BX)-->do necessary things on (AX,BX)-->POP BX,AX 
MOV D_ROW,1
MOV D_COLUMN,-1
ok_:
mov divisor,AL                                    

sub divisor,CL

                                    


CMP divisor,0
JNL okdone
MOV D_COLUMN,1
NEG divisor
okdone:   
CMP divisor,0
JNE okdone1
MOV D_COLUMN,0
RET
okdone1:      

PUSH AX

MOV AX,DX
SUB AX,BX

DIV divisor
MOV D_ROW,AL

XOR BH,BH
ADD BL,AH 
;;;;
; PUSH CX
; PUSH DX

; MOV CX,AX
; MOV DX,BX
; CALL DRAW_BALL

;

; POP DX
; POP CX
 
 
POP AX 
    

RET 
    
ANGLESHOT ENDP

;;;---------------------------------------------------------------------------------------------------;;;;;
;;;---------------------------------------------------------------------------------------------------;;;;;


MOVE_BALL PROC NEAR
;;;MOVE_BALL PROCEDURE MOVES THE BALL FROM SRC TO DEST ALONG THE SLOP CALCULATED BY ANGLESHOT 
;input (dest ax,bx) (src cx,dx)
;output (dest cx,dx)
;input on AX,BX,CX,DX-->PUSH CX,DX-->CALL(AX,BX,CX,DX) -->POP DX,CX

	
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
    
     
	CMP AX,CX
	JNE LPOUTER
	CMP BX,DX
	JE DONE
	LPOUTER:
		CALL DRAW_BALL
		
		PUSH AX
		MOV AX, 20000
		LP1:
			DEC AX
			CMP AX,0 
			JNLE LP1
		POP AX	
		
		CALL ERASE_BALL
		SUB CL,D_COLUMN
		SUB DL,D_ROW
		
		CMP DX,BX
		JNE labels
		

		 CMP CX,AX
		 JE DONE
		
		labels:
		JMP LPOUTER	
	
	
DONE:
    CALL DRAW_BALL
	POP DX
	POP CX
	POP BX
	POP AX
	
	MOV CX,AX
	MOV DX,BX
	RET
MOVE_BALL ENDP

;;;---------------------------------------------------------------------------------------------------;;;;;
;;;---------------------------------------------------------------------------------------------------;;;;;

ONE_SHOT PROC NEAR
;;;ONE_SHOT PROCEDURE TAKES ONE SHOT AT A TIME
;;INPUT NONE
;;OUTPUT IMPACT_COL,IMPACT_ROW==>Coord of last position of ball,edit as per needed

	MOV CX,160
	MOV DX,160
	CALL DRAW_BALL
 
	MOV CX,160
	MOV DX,50
	CALL DRAW_AIM
	CALL FIX_AIM
	
	PUSH CX
	PUSH DX
	CALL ERASE_AIM
	PUSH DX
	PUSH CX
	
 
	MOV CX,160
	MOV DX,160
 
	CALL ANGLESHOT
	CALL MOVE_BALL
	MOV AX,FIXED_COL
	MOV BX,FIXED_ROW
 
	CALL ANGLESHOT
	CALL MOVE_BALL
    MOV IMPACT_COL,CX
	MOV IMPACT_ROW,DX
	
	
	
	CALL SET_BOUNDARY
	
	
    RET 	

ONE_SHOT ENDP
END  
