;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;KEYS.ASM IS A LIBRARY TO IMPLEMENT KEYBOARD ROUTINES
;;;;;;;;;;;;;;;;;;


;;;;;PUBLIC FUNCTIONS;;;;;;;;;;;

PUBLIC READ_KEY,DOS_EXIT,SET_TM,FIX_AIM
PUBLIC FIXED_COL,FIXED_ROW
;;;;;;;;;;EXTERN FUNCTIONS;;;;;;;;

EXTRN DRAW_AIM:NEAR,ERASE_AIM:NEAR
;;;CODES;;;;;;;;;
.MODEL SMALL
.STACK 100h
.DATA

FIXED_COL DW ?
FIXED_ROW DW ?
.CODE


;;;;

;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;;;;READ_KEY is just a void procedure to take input from keyboard

READ_KEY PROC NEAR
	MOV AH,0
	INT 16h
	RET
READ_KEY ENDP

;;;;----------------------------------------------------------------------------------------------------;;;;


;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;;;;;;SET_TM is a void function to set text mode

SET_TM PROC NEAR
	
	MOV AX,3
	INT 10h
	RET

SET_TM ENDP

;;;;----------------------------------------------------------------------------------------------------;;;;


;;;;----------------------------------------------------------------------------------------------------;;;;

;;;;;;;;DOS_EXIT is a void procedure to return to DOS

DOS_EXIT PROC NEAR
	
	MOV AH,4CH
	INT 21h
	
	RET

DOS_EXIT ENDP

;;;;----------------------------------------------------------------------------------------------------;;;;
;;;;----------------------------------------------------------------------------------------------------;;;;

FIX_AIM PROC NEAR
;;FIX_AIM PROCEDURE fixes aim at (AX,BX)
;input (CX,DX)-->bulls eye
;output (AX,BX)-->final aim
; no push ,no pop
labels:
 CALL DRAW_AIM
 
 
 MOV AH,0
 INT 16h
 CMP AH,48h
 JE UP
 CMP AH,4Dh
 JE RIGHT
 CMP AH,50h
 JE DOWN
 CMP AH,4Bh
 JE LEFT 
 CMP AH,1Ch
 JE FIX
 
 UP: 
 CMP DX,24
 JE labels
 CALL ERASE_AIM
 DEC DX
 JMP labels 
 
 RIGHT:
 CMP CX,226
 JE labels
 CALL ERASE_AIM
 INC CX
 JMP labels 
 
 DOWN:
 CMP DX,76
 JE labels
 CALL ERASE_AIM
 INC DX
 JMP labels 
 
 LEFT:
 CMP CX,94
 JE labels
 CALL ERASE_AIM
 DEC CX
 JMP labels
 
 FIX:
 CALL DRAW_AIM
 
 MOV AX,CX
 MOV BX,DX
 
 MOV FIXED_COL,AX
 MOV FIXED_ROW,BX
 ret 

 FIX_AIM  ENDP	

;;;---------------------------------------------------------------------------------------------------;;;;;





END
