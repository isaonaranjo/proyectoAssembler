@ Maria Isabel Ortiz Naranjo
@ Carnet: 18176
@ Douglas de Leon
@ Carnet: 18037

.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!, {lr}	/* SP = R13 link register */

ingreso:
    mov r8,#5 @Contador buenas
    mov r7,#3 @Contador malas

    @ASCII Art
    ldr r0,=nave
    bl puts

    ldr r0, =mensaje_bienvenida
    bl puts
	ldr r0, =mensaje_ingreso
    bl puts 
	@ Lectura de los datos 
	ldr r0, =formatoC
	ldr r1, =opcion 
	bl scanf
	
    ldr r1, =opcion
    ldrb r1, [r1]

	cmp r1, #'S'
    beq inicio
	@ Comparacion
    cmp r1, #'N'
    beq fin 

inicio:	 
	mov r4,#7 @contador de palabras

	@4.	Mostrar las palabras 
	ldr r5,=palabras @palabras a mostrar
	mov r4,#1
juego:
	ldr r0,=adivina
	mov r1,r4 @contador
	mov r2,r5 @palabra a mostrar
	bl printf
	add r5,#5 @se mueve 5 bytes en palabras, cuenta el NULL
	add r4,#1 @se suma 1 al contador de las palabras
	cmp r4,#6 @compara si llego a 6
	bne juego @ si no ha llegado a 6 el contador, regresa 

@ 5. preguntar por numero de palabra y letra que faltantes
	ldr r0,=pedir
	bl puts
	ldr r0, =formatoS
	@ Se lee la cadena con formatoS
	ldr r1, =cadena
	bl scanf
	@ compara si la letra corresponde a la palabra
	ldr r0, = cadena 
	ldrb r10, [r0] @ cargo el numero de la palabra ingresada (en ascii)
	ldrb r11, [r0,#1] @ cargo la letra ingresada en r11
	@ convierto el numero en ascii a valor 
	@ se resta 30 en hexadecimal para la conversion 
	sub r10, #0x30
	@ se le resta uno porque muestra la posicion a partir de 1
	sub r10, #1 
	@ traemos la letra en esa posicion 
	ldr r3, =letras
	ldrb r9, [r3,r10] @ cargo la letra 
	mov r1,r9
	cmp r9, r11 @ comparo las letras (ingresada con la guardada)
	beq correcto @ tira el mensaje de correcto si son iguales 
	@ incorrecto 
	ldr r0, =mensaje_noigual
	bl puts

    subs r7,r7,#1
    bne inicio
    ldr r0,=perdedor
    bl puts
    b fin



correcto:
	ldr r0, =mensaje_igual
	bl puts
	mov r0,r10 @posicion de la palabra en el arreglo palabras
	bl borrarPalabra

    subs r8,r8,#1
    bne inicio
    ldr r0,=ganador
    bl puts
    b fin

fin: 
    ldr r0, =mensaje_final
    bl puts
    /* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

@ subrutinas 

borrarPalabra:
	push {lr}
	@ multiplico la posicion por 5, porque cada palabra tiene 5 bytes
	mov r1, #5
	mul r0, r0, r1
	ldr r1, =palabras
	add r1, r0 @ se suma la posicion donde esta la palabra a borrar
	@ inicio del ciclo 
	mov r2, #4 @ contador
	mov r3, #' ' @ espacio en blanco
borrar:
	strb r3, [r1],#1 @ se borra la palabra correcta 
	subs r2, #1 
	bne borrar
	pop {pc}




.data
.align 2

formatoN:
    .asciz "%d"
ganador:
    .asciz "GANASTE!"

perdedor:
    .asciz "LO SIENTO... PERDISTE..."
mensaje_bienvenida:
        .asciz "Bienvenido. Debes destruir las palabras completándolas.  Selecciona el orden de la palabra seguido de sus caracteres faltantes: 1ER. \n"
mensaje_ingreso:
		.asciz "Listo para jugar?(S/N): "
opcion:
		.byte 0
mensaje_final:
		.asciz "Se salio del juego.\n"
formatoC:
		.asciz "%c"
palabras:
		.asciz "g_to","m_sa","pal_","t_na","pat_","ba_l"
letras:
		.byte 'a', 'i', 'a', 'i','o', 'u'
formatoS: 
		.asciz "%s"
mensaje_adivina:
		.asciz "%s: "
enter: 
		.asciz "\n"
mensaje_igual:
		.asciz "Correcto! \n"
mensaje_noigual:
		.asciz "Intentalo de nuevo! \n"
adivina: 
		.asciz "(%d) %s "
blanco: 
		.asciz " "
pedir:	
		.asciz "\nIngrese numero de la palabra y letra que falta: "
cadena:
		.asciz "  "
nave:
		.asciz "oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo\nooooooooooooooooooooooooooooooooooooool::loooooooooooooooooooooooooooooooooooooo\noooooooooooooooooooooooooooooooooooooo:'':oooooooooooooooooooooooooooooooooooooo\noooooooooooooooooooooooooooooooooooool::;:looooooooooooooooooooooooooooooooooooo\noooooooooooooooooooooooooooooooooooooc;,,,cooooooooooooooooooooooooooooooooooooo\nooooooooooooooooooooooooooooooooooooo;.''.;ooooooooooooooooooooooooooooooooooooo\nooooooooooooooooooooooooooooooooooool;,,,',loooooooooooooooooooooooooooooooooooo\noooooooooooooooooooooooooooooooooooo:,;;,,'coooooooooooooooooooooooooooooooooooo\noooooooooooooooooooooooooooooooooooo:,:;,'':oooooooooooooooooooooooooooooooooooo\nooooooooooooooooooooooooooooollooool,;;....'loooollooooooooooooooooooooooooooooo\nooooooooooooooooooooooooooooc;,:oooc,;;'....coooc,,coooooooooooooooooooooooooooo\noooooooooooooooooooooooooooo;'.'lol;,;cc,...;ool,..,oooooooooooooooooooooooooooo\noooooooooooooooooooooooooooo;'.'::;;:;;;'...',::,..,oooooooooooooooooooooooooooo\noooooooooooooooooooooooooooo;...,;;:;,'...',,'.'...,oooooooooooooooooooooooooooo\noooooooooooooooooooooooooool,.',;::;,..,,...,,,,'..,looooooooooooooooooooooooooo\nooooooooooooooooooooooooooc;,'';;;;,. .;,. ..,;;,'.',coooooooooooooooooooooooooo\noooooooooooooooooooooool:;,;;,,;;;;'..';;'..',;;;',,'',:cooooooooooooooooooooooo\noooooooooooooooooooool:,,,,,'''',,;;'',;;,'';;,,'''',,,'';cooooooooooooooooooooo\nooooooooooooooooooooc,,;;;;:'..'cll:'.,,;,.':llc'..':;;;,',coooooooooooooooooooo\nooooooooooooooooooooolloooool::cooc''',,,''''cooc::looooollooooooooooooooooooooo\nooooooooooooooooooooooooooooooooooololllollllooooooooooooooooooooooooooooooooooo\noooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
