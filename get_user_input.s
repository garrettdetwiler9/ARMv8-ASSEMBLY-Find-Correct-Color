.cpu cortex-a53
.fpu neon-fp-armv8

.data

uinp: .asciz "%s"
instr: .asciz "\nEnter guess: "
output: .asciz "\nPacked 32-bit value: %d\n"
d: .asciz "\n%d\n"

.align 4

user_guess: .word 0

.text
.align 2
.global get_user_input
.type get_user_input, %function

get_user_input:

	push {fp, lr}
	add fp, sp, #4

	@ r0 = address to string
	@push {r0}

	@ prompt user to guess
	ldr r0, =instr
	bl printf

	@ scanf("%s", addr of string)
	ldr r0, =uinp
	ldr r1, =user_guess
	bl scanf

	mov r10, #0 @ letter incrementer
	mov r9, #0 @ bit shift incrementer
	mov r7, #0
	ldr r4, =user_guess

begin_loop:
	
	cmp r10, #4
	bge end_loop

	ldrb r6, [r4, r10] @ r6 = user_guess[r10]

	@ldr r0, =d
	@mov r1, r6
	@bl printf

	and r6, r6, #127
	lsl r6, r6, r9
	
	orr r7, r7, r6 @ r7 = r7 | r6

	@ldr r0, =d
	@mov r1, r7
	@bl printf

	add r10, r10, #1
	add r9, r9, #7

	b begin_loop

end_loop:

	ldr r0, =output
	mov r1, r7
	bl printf

	mov r0, r7

	sub sp, fp, #4
	pop {fp, pc}