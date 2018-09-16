Main Function primalityFermat()

	Local lPrime := .T.
	Local nTrial
	// Numero de Tentativas
	Local nNumTrial := 20
	// Numero a ser testado
	Local nNumTest := 44721359
	// Numero randomizado de 1 at� nNumTest - 1
	Local nNumRand

	For nTrial := 1 To nNumTrial
		// Gera um n�mero aleat�rio de  1 at� nNumTest - 1
		nNumRand := 19724148//Randomize( 1, nNumTest )

		// Avalia se o numero possui outro m�ximo denominador comum
		// que n�o 1, caso tenha n�o � primo
		If MDC( nNumRand, nNumTest ) != 1
			lPrime := .F.
			Exit
		EndIf

		// Avalia pelo Teste de Fermat se o n�mero � composto
		If testMod( nNumRand, (nNumTest - 1), nNumTest ) != 1
			lPrime := .F.
			Exit
		EndIf
	Next nTrial

	Return lPrime
//-------------------------------------------------------------------
/*/{Protheus.doc} testMod
Determina o resultado do m�dulo de acordo com o Fator e a Pot�ncia
@author  Jackson Machado
@since   16/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
Function testMod( nFactor, nPow, nNumMod )
	Local nMod := 1

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
	Return nMod
//-------------------------------------------------------------------
/*/{Protheus.doc} MDC
Retorna o Maximo Divisor Comum

@author  Jackson Machado
@since   16/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
Function MDC( nRandom, nTestNum )

	Local nTmpMod
	Local nMDC    := nRandom

	// Faz o teste at� zerar o n�mero do divisor
	While nTestNum != 0
		//Salva o resto da divis�o do n�mero randomico pelo numero testado
		nTmpMod  := nMDC % nTestNum
		// Salva como m�ximo divisor comum o n�mero testado
		// e como novo divisor o resto da divis�o atual
		nMDC     := nTestNum
		nTestNum := nTmpMod
	EndDo

	Return nMDC

