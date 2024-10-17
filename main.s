.cpu cortex-a53
.fpu neon-fp-armv8

.data

out: .asciz "%d\n"
strout: .asciz "%s\n"

.text
.align 2
.global main
.type main, %function

main:

	push {fp, lr}
	add fp, sp, #4
	@ allocate memory for user input string
	mov r0, #80
	bl malloc
	push {r0} @ fp - 8

	@ get_user_input(r0)
	bl get_user_input
	
	mov r1, r0
	@ print_string_int(string)
	ldr r0, [fp, #-8]
	bl print_string_int

	@ gen_key(sp)
	sub sp, sp, #4 @ fp - 12

	mov r0, sp

	@ initialize 0 into sp
	mov r1, #0
	str r1, [r0]

	bl gen_key

	@ print_key(sp)
	sub r0, fp, #-12
	mov r0, sp
	bl print_key

	sub r0, fp, #-12
	mov r0, sp
	ldr r1, [fp, #-8]
	bl find_correct_color
	
	add sp, sp, #4
	sub sp, fp, #4
	pop {fp, pc}