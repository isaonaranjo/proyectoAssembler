
.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!, {lr}	/* SP = R13 link register */
	mov r4,#0 @contador de palabras
	ldr r5,=palabras @palabras
	ldr r6, =letras

vuelta:
	ldr r0,=mensaje_adivina
	mov r1,r5 @palabra a mostrar
	bl printf
	@ lee la letra que le falta a la palabra 
	ldr r0, =formato
	ldr r1, =letra
	bl scanf
	@ compara si la letra corresponde a la palabra
	ldr r0, = letra 
	ldrb r0, [r0]
	@ r6 apunta a las letras
	ldrb r1, [r6]
	cmp r0, r1
	ldreq r0,=mensaje_igual
	ldrne r0,=mensaje_noigual
	bl puts
	bl getchar @borra el enter que se quedo en scanf
	add r5,#5 @se mueve 5 bytes en palabras, cuenta el NULL
	add r6,#1 @se mueve 1 byte en letras
	add r4,#1 @se suma 1 al contador de las palabras
	cmp r4,#6 @compara si llego a 6
	bne vuelta @si no ha llegado a 6 el contador, regresa 

	ldr r0,=enter
	bl puts

	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

.data
.align 2
palabras:
	.asciz "g_to","m_sa","pal_","t_na","pat_","ba_l"
letras:
	.byte 'a', 'i', 'a', 'i','o', 'u'
letra:
	.byte 0
formato: 
		.asciz "%c"
mensaje_adivina:
		.asciz "Adivine que letra le falta a la palabra %s: "
enter: 
		.asciz "\n"
mensaje_igual:
		.asciz "Correcto! \n"
mensaje_noigual:
		.asciz "Intentalo de nuevo! \n"

		
