
.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!, {lr}	/* SP = R13 link register */
	
	@limpiar la pantalla de 80 columnas x 25 filas
	mov r4,#0x7D0 @ es 2000 en decimal 80x25
ciclo:
	ldr r0,=formato
	ldr r1,=blanco
	ldr r1,[r1]
	bl printf
	subs r4,#1
	bne ciclo

	mov r4,#1 @contador de palabras
	ldr r5,=palabras @palabras
vuelta:
	ldr r0,=adivina
	mov r1,r4 @contador
	mov r2,r5 @palabra a mostrar
	bl printf
	bl tiempo @un retardo de tiempo
	add r5,#5 @se mueve 5 bytes, cuenta el NULL
	add r4,#1
	cmp r4,#5
	bne vuelta

	ldr r0,=enter
	bl puts

	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

@subrutina tiempo
tiempo:
	mov r0,#0xFF0000
otra:
	subs r0,#1
	bne otra
	mov pc,lr

.data
.align 2
palabras:
	.asciz "g_to","m_sa","pal_","t_na","pat_","ba_l"
letras:
	.asciz "a", "i", "a", "i","o", "u"

formato: 
	.asciz "%c"
adivina: 
	.asciz "(%d) %s "
blanco: 
	.asciz " "
enter: 
	.asciz "\n"