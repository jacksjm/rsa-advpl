//-------------------------------------------------------------------
/*/{Protheus.doc} testMod
Determina o resultado do m�dulo de acordo com o Fator e a Pot�ncia
Aplica-se o Teorema do Quociente-Resto:
	- Onde, A = B * Q + R, sendo 0 <= R < B
e a Multiplica��o Modular:
	- Onde, (A * B) mod C = (A mod C * B mod C) mod C
Com isso, elimina-se os m�ltiplos de C e considera-se os Restos para
as demais m�ltiplica��es

@author  Jackson Machado
@since   16/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
User Function testMod( nFactor, nPow, nNumMod )
	Local nMod  := 1

	//Realiza a opera��o at� pot�ncia ser encerrada
	While nPow > 0
		// Caso n�o seja divisor de dois,
		// multiplica o resto salvo pelo fator e
		// salva o resto da divis�o
		If nPow % 2 == 1
			nMod := Round( ( nMod * nFactor ) % nNumMod, 0 )
			nPow := nPow--
		EndIf
		// Divide o expoente por 2 e salva o valor
		nPow    := nPow/2
		// Multiplica o fator em 2 e
		// salva como novo fator o resto da divis�o
		// para utilizar no novo m�dulo
		nFactor := Round( ( nFactor * nFactor ) % nNumMod, 0 )
	EndDo

	// Caso seja negativo, corrige para o valor positivo
	// pois o AdvPL n�o trata o m�dulo negativo
	If nMod < 0
		//Adiciona o resto para completar o ciclo negativo
		nMod := nNumMod + nMod
	EndIf

	Return nMod
//-------------------------------------------------------------------
/*/{Protheus.doc} MDC
Retorna o Maximo Divisor Comum aplicando o Algoritmo de Euclides

@author  Jackson Machado
@since   16/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
User Function MDC( nRandom, nTestNum )

	Local nTmpMod
	Local nMDC    := nRandom
	/* Estrutura de exemplo

		(1) nMDC = 32 e nTestNum = 76
			nTmpMod = 32 -> Resto
			nMDC = 76
			nTestNum = 32

		(2) nMDC = 76 e nTestNum = 32
			nTmpMod = 12 -> Resto
			nMDC = 32
			nTestNum = 12

		(3) nMDC = 32 e nTestNum = 12
			nTmpMod = 8 -> Resto
			nMDC = 12
			nTestNum = 8

		(4) nMDC = 12 e nTestNum = 8
			nTmpMod = 4 -> Resto
			nMDC = 8
			nTestNum = 4

		(5) nMDC = 8 e nTestNum = 4
			nTmpMod = 0 -> Resto
			nMDC = 4
			nTestNum = 0
	*/
	// Faz o calculo at� zerar o n�mero do divisor
	// Para tanto, realiza as divis�es pelos restos
	While nTestNum != 0
		//Salva o resto da divis�o do n�mero randomico pelo numero testado
		nTmpMod  := nMDC % nTestNum
		// Salva como m�ximo divisor comum o n�mero testado
		// e como novo divisor o resto da divis�o atual
		nMDC     := nTestNum
		nTestNum := nTmpMod
	EndDo

	Return nMDC