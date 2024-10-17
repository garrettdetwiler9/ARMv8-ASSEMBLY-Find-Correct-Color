.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global gen_key
.type gen_key, %function

gen_key:

	push {fp, lr}
	add fp, sp, #4
	
	@ r0 = sp = address of the key
	push {r0} @ fp - 8
	push {r9, r10} @ save r9 and r10 just in case
	
	@ reset random seed
	mov r0, #0
	bl time @ time(0) retruns # sec since Jan 1, 1972
	bl srand

	mov r9, #0 @ counts 0, 7, 14, 21 bits
	mov r10, #0 @ r10 = i = 0
	
	begin_loop:
		
		cmp r10, #4
		bge end_loop

		@ generate random # from 0 - 5
		bl rand @ r0 = rand()
		mov r1, #6
		bl modulo @ r0 = rand() % 6
	
		@ red
		cmp r0, #0
		moveq r0, #117 @ r4 = r
		beq add_random
		@ blue
		cmp r0, #1
		moveq r0, #98 @ r4 = b
		beq add_random
		@ green
		cmp r0, #2
		moveq r0, #103 @ r4 = g
		beq add_random
		@ white
		cmp r0, #3
		moveq r0, #119 @ r4 = w
		beq add_random
		@ yellow
		cmp r0, #4
		moveq r0, #121 @ r4 = y
		beq add_random
		@ purple
		cmp r0, #5
		moveq r0, #112 @ r4 = p

		@ add random color to key

		add_random:

		ldr r1, [fp, #-8] @ r1 = &key
		
		mov r0, r0, LSL r9 @ r0 = r0 << r9 (# of bits)

		ldr r2, [r1] @ r2 = value stored at key

		orr r2, r2, r0 @ r2 = r2 | r0

		str r2, [r1] @ store r2 back into key

		add r9, r9, #7 @ increment r9 so we can shift the next number

		add r10, r10, #1

		b begin_loop

	end_loop:
	
	pop {r9, r10}
	
	sub sp, fp, #4
	pop {fp, pc}