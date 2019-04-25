@ Maria Isabel Ortiz Naranjo
@ Carnet: 18176
@ Douglas de Leon
@ Carnet: 18037

.text
.align 2
.global main
.type main,%function

main: 
    stmfd sp!, {lr} 
	mov r4,#1 @contador de palabras
	ldr r5,=palabras @palabras
	ldr r6, =letras

ingreso:
    @ASCII Art
    ldr r0,=dibujo
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
    beq juego
	
	@ Comparacion
    cmp r1, #'N'
    beq fin 

juego:
	bl getchar @ borra el enter que se quedo en scanf
	ldr r0,=adivina
	mov r1,r4 @contador
	mov r2,r5 @palabra a mostrar
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
	bl getchar @ borra el enter que se quedo en scanf
	add r5,#5 @se mueve 5 bytes en palabras, cuenta el NULL
	add r6,#1 @se mueve 1 byte en letras
	add r4,#1 @se suma 1 al contador de las palabras
	cmp r4,#6 @compara si llego a 6
	bne juego @ si no ha llegado a 6 el contador, regresa 

	ldr r0,=enter
	bl puts


	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
	
fin: 
    ldr r0, =mensaje_final
    bl puts
    /* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

.data
.align 2  
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
formato: 
		.asciz "%c"
mensaje_adivina:
		.asciz "%s: "
enter: 
		.asciz "\n"
mensaje_igual:
		.asciz "Correcto! \n"
mensaje_noigual:
		.asciz "Intentalo de nuevo! \n"
letra:
	.byte 0
adivina: 
	.asciz "(%d) %s "

dibujo:
    .asciz "....................                          .. . . .           .\n..... ..............               .           .   . .           .         .\n..... .  ................ . .. ... ..... ......... . .         ... . .. .... . .\n.....    .   .. ..   .  .        . .\n.....                   .          . =MMNNMM.. .       . .. ..   ..        .  .\n.....                .             .NM.    ~M            .. ..             .\n.           . .   . ........... . M, .....M ..................................\n..  . .  .  ............... ,M8 ..+MZ..  .. ............... .. ...  ....\n.  . .  .      .    .. .   . .MMM= ... ................................\n.                 .. ... ...... . .  OIM .... ................................\n.  .................. O~M..... ................................\n.     .     .  .  .. ........ . . ..:M7MMMMM$~:. .............................\n.  .  ............            ZMMMZ ...    .. ..?MMM7. .....\n....................      . ZMM+ +MMM.       .. ... . .$MM, .. .. .     .      .\n... . . ........... . ..$MM...? +MM.           .Z:..   . $MM.                 .\n.....   ..  . .  .    .NM . ... ..MM     ..   . .$M....~OOO .MM.. .     .      .\n...... . ........... MM... $8+    M8.  .MMI, IM  ....MM....M  :M  . .. ... ..  .\n.......... .......MM. ~M,   .M?.   ...M.    ..M   .N..  .. M  .MD.     .    . .\n................ ,M,. $=.    . M.  . .M ..... .M~ ..M  ....?M... MM  .. ........\n.     ..  . . OM . .M.      .M.     M      .+M.    MM?.?MM..  ..MM.\n.....   .....  MM ... M:. ..  M=.   . .MMMOMMMZ      ...,..   .. IMMMMM ..     .\n. ..........M=. .  . NM$ZMMM.  .    .        .   . .. ~OMMMMMM+..    MM.     .\n.    . .. .M .   .    .   ...       .. . :7MMMMMMMMMZ~ ..... .      .MMM.    .\n....     .. M.           ,,IMMMMMMMMMMMNZ=..        .    ..... .  ~MMM7.\n.... . . MMD$.                 .    .   .  .        . .  .. .IMMMM= M,...\n.   .MM     .  .            .               .   ... =MMMMM?...DM?MD   .      .\n.  8MM~   ........ .  .    .. .          .?DMMMMMM7, . :MM.   ZMMMI   .      .\n.    . MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM$:    . ....... ::  :. $M+MM...........\n.      .+MMMMMMI+,,.          .       ..    .  . .. ... .  OIMMZM~N.. .  . . .\n. ......  IM$+7??,.. + .   .. .       . .  ..     . .. ...ZMM~M:MM.   .  .  ..\n.. .. ..  ...$MN:. ...~ .  .. .        .    .     . ...=MMMMM?+NO     .  . . .\n.            MMM,IMMM7   . .. .             . ... ~OMMM? .  DM+ ..    .      .\n.  . ...  . . MM,7MMMO,MMMMNM$::      .,:$$MMMMMMI    ...... .. . ......... ..\n.     ..  . . ..OMMMZI$M ......:~I7$$$M7??7OMM8IZO............................\n..              ..   ...               OMMDD8MMMM?.. ........ .. .     .\n.  ...............                    ..   .  .  .. .  ..... .. ..  . . .... .\n.         . .  .   .  .     .         .         . . ........... .    .      ..\n....    ..  ...  .   .                  ............................ .. ... ....\n.     ..    .  .      .     .         ............................... ........"
