.cpu cortex-a53
.fpu neon-fp-armv8

.data

out: .asciz "\nUser guess after bit manipulation: \n"
strint: .asciz "Step %d: %d\n"

.text
.align 2
.global print_string_int
.type print_string_int, %function

print_string_int:

	push {fp, lr}
	add fp, sp, #4

	@ r0 = string
	push {r0}
	push {r10}

	ldr r0, =out
	bl printf

	mov r10, #0

	begin_print:
		
		cmp r10, #4
		bge end_print_string

		ldr r2, [fp, #-8]
		ldr r2, [r2, r10]
		add r1, r10, #1
		ldr r0, =strint
		bl printf

		add r10, r10, #1
		b begin_print
	
	end_print_string:

	sub sp, fp, #4
	pop {fp, pc}