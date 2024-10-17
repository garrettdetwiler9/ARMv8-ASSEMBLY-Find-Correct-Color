.cpu cortex-a53
.fpu neon-fp-armv8

.data 

intro: .asciz "\nKey values: \n"
outp: .asciz "%d\n"
ret: .asciz "\b"

.text 
.align 2
.global print_key
.type print_key, %function

print_key:

	push {fp, lr}
	add fp, sp, #4
	
	@ r0 = address of key
	push {r0} @ fp - 8
	push {r8, r9, r10}

	ldr r0, =intro
	bl printf

	ldr r9, [fp, #-8] @ r9 = sp
	ldr r9, [r9] @ r9 = value at sp

	@ create mask 1111111
	mov r8, #127

	mov r10, #21 @ use r10 to shift # of bits by 

	begin_loop:
		
		cmp r10, #0
		blt end_loop

		mov r0, r9, LSR r10 @ shift r9 by number of bits to the right
		and r0, r0, r8 @ mask out all bits except the first 7 bits

		mov r1, r0
		ldr r0, =outp
		bl printf

		sub r10, r10, #7

		b begin_loop

	end_loop:
		
		pop {r8-r10}

	sub sp, fp, #4
	pop {fp, pc}