.text
.align 2
.global impresionPalabras

impresionPalabras:
	@Uso de registros
	palabras .req r0
	contador .req r4
	contadorPalabras .req r5

	mov contador,#0
	mov contadorPalabras, #6

	ciclo:
		@Cargar valor de palabra.
		ldr r6,[palabras]

		@Apuntar a siguiente.
		add palabras, #4

		@Compara si la palabra está vacía
		cmp r6,#"    "
		addne contador,contador, #1
		ldreq r6, [palabras]
		bne imprimir
	
		@Recorre hasta la última palabra.
		subs contador, #1
		cmp contadorPalabras,#0
		bne ciclo

	imprimir:
		push{lr}
		ldr r0,=formato
		ldr r1, contador
		ldr r2,	[r6]
		bl printf
		pop{lr}


	.unreq palabras
	.unreq contador
	.unreq contadorPalabras

	@Salida de subrutina
	mov pc,lr

verificacionEntrada:

	@Uso de registros
	palabras .req r0
	letras .req r1
	ingreso .req r2
	contador .req r4
	contadorPalabras .req r5

	mov contador,#0

	ciclo:
		@Cargar valores de palabra y letra
		ldr r6,[palabras]
		ldr r7,[letras]

		@Apuntar a siguiente.
		add palabras, #4
		add letras, #4

		@Compara si la palabra está vacía
		cmp r6,"    "
		addne contador,contador, #1
		cmp 
		



	.unreq palabras
	.unreq letras
	.unreq ingreso

	@Salida de subrutina
	mov pc,lr

.data
.align 2

	formato: 
		.asciz "%d) %s.  "
