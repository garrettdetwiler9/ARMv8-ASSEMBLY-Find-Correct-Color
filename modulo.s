@ Garrett Detwiler

.cpu cortex-a53
.fpu neon-fp-armv8

.data 

.text
.align 2
.global modulo
.type modulo, %function

modulo:

	push {fp, lr}
	add fp, sp, #4

	udiv r2, r0, r1 @ r2 = r0 / r1 (integer division)
	mul r2, r1, r2 @ r2 = r1 * r1 (r2 = r0 - remainder)
	sub r0, r0, r2 @ r0 = r0 - r2 (r0 = remainder)

	sub sp, fp, #4
	pop {fp, pc}