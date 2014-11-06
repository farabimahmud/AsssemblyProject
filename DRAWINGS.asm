;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DRAWINGS .ASM IS A LIBRARY TO IMPLEMENT DRAWING ROUTINES;;
;;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


;;;PUBLIC FUNCTIONS:;;
PUBLIC SET_FIELD,SET_BOUNDARY,SET_GOALPOST,DRAW_BALL,ERASE_BALL,DRAW_AIM,ERASE_AIM


;;;;;EXTERN FUNCTIONS;;;;;


;;;code;;;;;

.MODEL SMALL

;;;;----------------------------------------------------------------------------------------------------;;;;
;;DRAW_ROW X,Y,Z draws a row in Xth row from Y th to Z th column;;

DRAW_ROW MACRO X,Y,Z
LOCAL L1
   
   MOV CX,Y
   MOV DX,X
   MOV AH,0Ch
   MOV AL,3 
   
   
   L1:
     INT 10h
	 INC CX
	 CMP CX,Z
	 JLE L1
	 
ENDM


;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;
	 
;;DRAW_COLUMN X,Y,Z draws a COLUMN in Xth column from Y th to Z th row;;

DRAW_COLUMN MACRO X,Y,Z
LOCAL L2
   
   MOV CX,X
   MOV DX,Y
   MOV AH,0Ch
   MOV AL,3
   
   
   L2:
     INT 10h
	 INC DX
	 CMP DX,Z
	 JLE L2
	 
ENDM

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;

;;DRAW_POINT X,Y,A,B draws a point in column X,row Y with Pal A code B


DRAW_POINT MACRO X,Y,A,B

	MOV AH,0Bh
	MOV BH,1
	MOV BL,A 
	INT 10h
    ;writing pixel
	MOV AH,0Ch
	MOV AL,B
	;
	MOV DX,Y
	MOV CX,X
	INT 10h
	
ENDM
;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;


;;;CODE SEGMENT;;;;

.CODE

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;;SET_FIELD PROCEDURE DRAWS A GREEN FIELD

SET_FIELD  PROC NEAR


	;set Graphics 320*200 4 colour

	MOV AX,04H
	INT 10H;


	;draw green background

    MOV AH,0Bh
	MOV BH,0
	MOV BL,0010b ;set pixel as green
	INT 10H
	
	RET

SET_FIELD ENDP 


;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;SET_BOUNDARY PROCEDURE DRAWS THE GOALLINE 

SET_BOUNDARY PROC NEAR

	;select pallete
    MOV AH,0Bh
	MOV BH,1
	MOV BL,1
	
	INT 10h
    
	
	;writing pixel
	
	MOV AH,0Ch
	MOV AL,3
	;
	
	DRAW_ROW 80,10,310
	DRAW_ROW 190,10,310
	
	DRAW_COLUMN 10,80,190
	DRAW_COLUMN 310,80,190
	
	RET

SET_BOUNDARY ENDP   

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;
SET_GOALPOST PROC NEAR
;;;SET_GOALPOST PROCEDURE DRAWS THE GOALPOST

	;select pallete
    MOV AH,0Bh
	MOV BH,1
	MOV BL,1
	
	INT 10h
    
	
	;writing pixel
	
	MOV AH,0Ch
	MOV AL,3
	;

	DRAW_ROW 20,90,230
	DRAW_COLUMN 90,20,80
	DRAW_COLUMN 230,20,80
 
	
 
RET
SET_GOALPOST ENDP 

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;
;;;;;????????????PENDING???????????/;;;;;;
DRAW_BALL PROC NEAR
;;;DRAW_BALL PROCEDURE DRAWS A BALL CENTERED AT CX,DX

;;INPUT (CX,DX)
;;OUTPUT DRAWN BALL
;;input on CX,DX-->PUSH CX,DX-->CALL DRAW_BALL-->do calculations-->POP DX,CX

PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	; select pallete
    MOV AH,0Bh
	MOV BH,1
	MOV BL,1
	
	INT 10h   
	; writing pixel
	
	MOV AH,0Ch
	MOV AL, 2
	
	SUB CX,3	
	INT 10h
	
	DEC DX
	INT 10H
	
	DEC DX
	INC CX
	INT 10H
	
	DEC DX
	INC CX
	INT 10H
	
	INC CX
	INT 10H
	
	INC CX
	INT 10H
	
	INC CX
	INC DX
	INT 10H
	
	INC CX
	INC DX
	INT 10H
	
	INC DX
	INT 10H
	
	INC DX
	INT 10H
	
	DEC CX
	INC DX
	INT 10H
	
	DEC CX
	INC DX
	INT 10H
	
	DEC CX
	INT 10H
	
	DEC CX
	INT 10H
	
	DEC CX
	DEC DX
	INT 10H
	
	DEC CX
	DEC DX
	INT 10H
	
	POP DX
	POP CX
	POP BX
	POP AX
		
RET 
DRAW_BALL ENDP

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;
;;;;;????????????PENDING???????????/;;;;;;

ERASE_BALL PROC NEAR
;input CX,DX-->coordinate of center of the ball
;output void,ball erased
;input CX,DX-->push CX,DX -->call(CX,DX)->pop DX,CX

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	; select pallete
    MOV AH,0Bh
	MOV BH,1
	MOV BL,1
	
	INT 10h   
	; writing pixel
	
	MOV AH,0Ch
	MOV AL, 0
	
	SUB CX,3	
	INT 10h
	
	DEC DX
	INT 10H
	
	DEC DX
	INC CX
	INT 10H
	
	DEC DX
	INC CX
	INT 10H
	
	INC CX
	INT 10H
	
	INC CX
	INT 10H
	
	INC CX
	INC DX
	INT 10H
	
	INC CX
	INC DX
	INT 10H
	
	INC DX
	INT 10H
	
	INC DX
	INT 10H
	
	DEC CX
	INC DX
	INT 10H
	
	DEC CX
	INC DX
	INT 10H
	
	DEC CX
	INT 10H
	
	DEC CX
	INT 10H
	
	DEC CX
	DEC DX
	INT 10H
	
	DEC CX
	DEC DX
	INT 10H
	
	POP DX
	POP CX
	POP BX
	POP AX
	
	RET	
	
ERASE_BALL ENDP

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;


DRAW_AIM PROC NEAR
;;DRAW_AIM draws a bulls eye at (CX,DX)
;input CX,DX-->coordinate of center of the ball
;output void,ball drawn
;input CX,DX-->push CX,DX -->call(CX,DX)->pop DX,CX

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	; select pallete
    MOV AH,0Bh
	MOV BH,1
	MOV BL,1
	
	INT 10h   
	; writing pixel
	
	MOV AH,0Ch
	MOV AL, 1 
	
	INT 10H
	
	;
	
	PUSH CX
	PUSH DX
	
	INT 10h
	DEC CX
	INT 10h
	DEC CX
	INT 10h
	DEC CX
	INT 10h
	
	POP DX
	POP CX 
	
	
	PUSH CX
	PUSH DX
	
    INT 10h
	INC CX
	INT 10h
	INC CX
	INT 10h
	INC CX
	INT 10h
	
	POP DX
	POP CX 
	
	PUSH CX
	PUSH DX
	
	INT 10h
	DEC DX
	INT 10h
	DEC DX
	INT 10h
	DEC DX
	INT 10h
	
	POP DX
	POP CX 
	
	PUSH CX
	PUSH DX
	
	INT 10h
	INC DX
	INT 10h
	INC DX
	INT 10h
	INC DX
	INT 10h
	
	POP DX
	POP CX 
	
	
	POP DX
	POP CX
	POP BX
	POP AX
	
	RET	
	
DRAW_AIM ENDP

;;;---------------------------------------------------------------------------------------------------;;;;;
;;;---------------------------------------------------------------------------------------------------;;;;;

ERASE_AIM PROC NEAR
;; ERASE_AIM PROCEDURE erases the AIM at (CX,DX)
;input CX,DX-->coordinate of center of the ball
;output void,ball erased
;input CX,DX-->push CX,DX -->call(CX,DX)->pop DX,CX

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	; select pallete
    MOV AH,0Bh
	MOV BH,1
	MOV BL,1
	
	INT 10h   
	; writing pixel
	
	MOV AH,0Ch
	MOV AL, 0
	
	INT 10H
	
	;
	
	PUSH CX
	PUSH DX
	
	INT 10h
	DEC CX
	INT 10h
	DEC CX
	INT 10h
	DEC CX
	INT 10h
	
	POP DX
	POP CX 
	
	
	PUSH CX
	PUSH DX
	
    INT 10h
	INC CX
	INT 10h
	INC CX
	INT 10h
	INC CX
	INT 10h
	
	POP DX
	POP CX 
	
	PUSH CX
	PUSH DX
	
	INT 10h
	DEC DX
	INT 10h
	DEC DX
	INT 10h
	DEC DX
	INT 10h
	
	POP DX
	POP CX 
	
	PUSH CX
	PUSH DX
	
	INT 10h
	INC DX
	INT 10h
	INC DX
	INT 10h
	INC DX
	INT 10h
	
	POP DX
	POP CX 
	
	
	POP DX
	POP CX
	POP BX
	POP AX
	
	RET	
	
ERASE_AIM ENDP
;;;---------------------------------------------------------------------------------------------------;;;;;

END
