SET_DISPLAY PROC


;set Graphics 320*200 4 colour

 MOV AX,04H
 INT 10H;


;draw green background

    MOV AH,0Bh
	MOV BH,0
	MOV BL,0010b ;set pixel as green
	INT 10H
	
	; mov DX,10 ;starting row
	
	; DRAW_ROW:
	
	   ; MOV CX,0 ;starting column
	   ; DRAW_COLUMN:
		; INT 10h
		; INC CX
		; CMP CX,320
	   ; JLE DRAW_COLUMN
	   ; INC DX
	   ; CMP DX,190
	   ; JLE DRAW_ROW
	       
	   
		RET

SET_DISPLAY ENDP 


DRAW_BOUNDARY PROC
    
	;select pallete
    MOV AH,0Bh
	MOV BH,1
	MOV BL,1
	
	INT 10h
    
	
	;writing pixel
	
	MOV AH,0Ch
	MOV AL,3
	;
	
	MOV DX,80
	MOV CX,10
	
	draw_row1:
	INT 10h
	INC CX
	CMP CX,310
	
	JLE draw_row1
	
	
	MOV DX,190
    MOV CX,10
	
    draw_row2:
	INT 10h
	INC CX
	CMP CX,310
	
	JLE draw_row2	
	

	MOV DX,80
	MOV CX,10
	
	draw_column1:
	INT 10h
	INC DX
	CMP DX,190
	
	JLE draw_column1
	
	
	MOV DX,80
    MOV CX,310
	
    draw_column2:
	INT 10h
	INC DX
	CMP DX,190
	
	JLE draw_column2	
	

	
	
	RET	
     
DRAW_BOUNDARY ENDP


DRAW_GOALPOST PROC
	
	; select pallete
    MOV AH,0Bh
	MOV BH,1
	MOV BL,1
	
	INT 10h
    
	
	; writing pixel
	
	MOV AH,0Ch
	MOV AL,3
	
	
	
	MOV DX,20
	MOV CX,90
	
	draw_row1GP:
	INT 10h
	INC CX
	CMP CX,230
	
	JLE draw_row1GP
	
	
	MOV DX,20
	MOV CX,90
	
	draw_columnGP1:
	INT 10h
	INC DX
	CMP DX,80
	
	JLE draw_columnGP1
	
	
	MOV DX,20
    MOV CX,230
	
    draw_columnGP2:
	INT 10h
	INC DX
	CMP DX,80
	
	JLE draw_columnGP2	
	

	
	RET

DRAW_GOALPOST ENDP

READ_KEYBOARD PROC

    ;read keyboard
	MOV AH,0
	INT 16h
	
	;set to text mode
	
	MOV AX,3
	INT 10h
	
	;return to dos
	MOV AH,4CH
	INT 21h
	
	RET
READ_KEYBOARD ENDP	
	
	
	