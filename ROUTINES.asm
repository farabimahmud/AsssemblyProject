;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ROUTINES.ASM IS A LIBRARY TO IMPLEMENT SHOOTING ROUTINES;;
;;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

;;;PUBLIC FUNCTIONS:;;
PUBLIC MOVE_BALL,ANGLESHOT,ONE_SHOT,IMPACT_COL,IMPACT_ROW,RANDOM,REFRESH


;;;;;EXTERN FUNCTIONS;;;;;
EXTRN DRAW_BALL:NEAR,ERASE_BALL:NEAR,DRAW_AIM:NEAR,ERASE_AIM:NEAR,FIX_AIM:NEAR
EXTRN FIXED_COL:WORD,FIXED_ROW:WORD
EXTRN SET_BOUNDARY:NEAR,READ_KEY:NEAR,SET_FIELD:NEAR,SET_GOALPOST:NEAR,DRAW_KEEPER:NEAR,ERASE_KEEPER:NEAR 
EXTRN COL_GK_L:WORD,COL_GK_R:WORD

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
		CALL DRAW_KEEPER
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
	CALL DRAW_KEEPER
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

	CALL SET_BOUNDARY
	CALL SET_GOALPOST
	MOV CX,160
	MOV DX,160
	CALL DRAW_BALL
 
	MOV CX,160
	MOV DX,50
	CALL DRAW_AIM
	CALL FIX_AIM
	CALL ERASE_KEEPER
	CALL RANDOM
	
	;check
	
	
 
	MOV CX,160
	MOV DX,160
 
	CALL ANGLESHOT
	CALL DRAW_KEEPER
	
	CALL MOVE_BALL
	MOV AX,FIXED_COL
	MOV BX,FIXED_ROW
 
	CALL ANGLESHOT
	CALL MOVE_BALL
    
	
	
	CALL SET_BOUNDARY
    RET 	

ONE_SHOT ENDP

;;;---------------------------------------------------------------------------------------------------;;;;;
;;;---------------------------------------------------------------------------------------------------;;;;;


RANDOM PROC NEAR
;;;;RANDOM PROCEDURE generates random number in [93,207]             
;;;input none
;;;output: COL_GK_L,COL_GK_R
;;;no restriction
PUSH AX
PUSH BX
PUSH CX
PUSH DX
                 
             
mov ah,2ch
int 21h 
mov ah,0
mov al,dh          ;ch=h cl=min dh=sec

IMUL DH ;second*second

MOV DH,115

IDIV DH  

MOV AL,AH
XOR AH,AH

ADD AL,93

MOV COL_GK_L,AX
ADD AX,20
MOV COL_GK_R,AX


POP DX
POP CX
POP BX
POP AX             
RET
RANDOM ENDP
;;;---------------------------------------------------------------------------------------------------;;;;;
;;;---------------------------------------------------------------------------------------------------;;;;;

REFRESH PROC NEAR
;;REFRESH PROCEDURE vanishes the keeper and the ball;;
;;input output none,no use problem
CALL ERASE_KEEPER
MOV CX,FIXED_COL
MOV DX,FIXED_ROW
CALL ERASE_BALL
CALL ERASE_AIM
RET
REFRESH ENDP
END  
