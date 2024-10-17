.cpu cortex-a53
.fpu neon-fp-armv8

.data 

cp: .asciz "\n\nCHECKPOINT\n\n"
d: .asciz "\n%d\n"
correct_w: .asciz "\n%d correct colors in the wrong location.\n"
correct_c: .asciz "%d correct colors in the correct location.\n"

.text
.align 2
.global find_correct_color
.type find_correct_color, %function

find_correct_color:

	push {fp, lr}
	add fp, sp, #4

	push {r0} @ &key, fp - 8
	push {r1} @ &guess, fp - 12

	push {r11, r12}

	ldr r6, [fp, #-8] @ r6 = &key
	ldr r6, [r6] @ r6 = key
	
	ldr r7, [fp, #-12] @ r7 = &guess
	ldr r7, [r7] @ r7 = guess

@ debug guess loading
	@ldr r0, =d
	@mov r1, r7
	@bl printf

	mov r8, #127 @ mask = r8 = 1111111

	mov r11, #0 @ counter for correct colors, wrong place
	mov r12, #0 @ counter for correct colors, correct place

	mov r9, #21 @ bit shift for key
	key_loop:
	
@ debug separate key_loops
	@ldr r0, =cp
	@bl printf

		cmp r9, #0
		blt end_key_loop

		mov r4, r6, LSR r9 @ locate specific term
		and r4, r4, r8 @ apply mask

	@ debug r9 decrementing
		@ldr r0, =d
		@mov r1, r4
		@bl printf

		sub r9, r9, #7 @ decrement bit shift
		
		mov r10, #21 @ bit shift for user_guess
		guess_loop:
			
			cmp r10, #0
			blt key_loop

			mov r5, r7, LSR r10 @ locate specific term
			and r5, r5, r8 @ apply mask

		@ debug r10 decrementing
			@ldr r0, =d
			@mov r1, r5
			@bl printf
	
			cmp r4, r5
			beq cmp_shift

			sub r10, r10, #7
			b guess_loop

		cmp_shift:

			@ldr r0, =d
			@mov r1, r9
			@bl printf

			@ldr r0, =d
			@mov r1, r10
			@bl printf

			cmp r9, r10
			addeq r12, r12, #1
			addne r11, r11, #1
			b key_loop
			

	end_key_loop:

		ldr r0, =correct_w
		mov r1, r11
		bl printf
		
		ldr r0, =correct_c
		mov r1, r12
		bl printf

	pop {r11, r12}
		
	sub sp, fp, #4
	pop {fp, pc}

	