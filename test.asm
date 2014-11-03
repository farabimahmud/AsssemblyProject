.MODEL SMALL
.STACK 100h
.DATA 
NEW_TIMER_VEC DW ?,?
OLD_TIMER_VEC DW ?,?
TIMER_FLAG DB 0
.CODE 

TIMER_TICK proc
	push ds
	push ax
	
	mov ax, seg TIMER_FLAG
	mov ds, ax
	mov TIMER_FLAG, 1
	
	pop ax
	pop ds
	
	iret
TIMER_TICK endp


SETUP_INT proc
; save old vector and set up new vector
; input: al = interrupt number
;	 di = address of buffer for old vector
;	 si = address of buffer containing new vector
; save old interrupt vector

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	mov ah, 35h	; get vector
	int 21h
	mov [di], bx	; save offset
	mov [di+2], es  ; save segment
; setup new vector
	mov dx, [si]	; dx has offset
	push ds		; save ds
	mov ds, [si+2]	; ds has the segment number
	mov ah, 25h	; set vector
	int 21h
	pop ds
	
	POP DX
	POP CX
	POP BX
	POP AX
	
	ret
SETUP_INT endp

MAIN PROC

	MOV NEW_TIMER_VEC, OFFSET TIMER_TICK 	;OFFSET
	MOV NEW_TIMER_VEC+2, CS 				;SEGMENT
	MOV AL, 1CH			; INTERRUPT TYPE
	LEA DI, OLD_TIMER_VEC
	LEA SI, NEW_TIMER_VEC
	CALL SETUP_INT
     
	CALL SET_DISPLAY
	CALL DRAW_BOUNDARY
	CALL DRAW_GOALPOST
	MOV AX, 200
	MOV BX, 300
	MOV CX, 140
	MOV DX, 100
	CALL DRAW_BALL
	CALL MOVE_BALL
	CALL READ_KEYBOARD

MAIN ENDP
 
INCLUDE DISPLAY.ASM
INCLUDE BALL.ASM

END MAIN



