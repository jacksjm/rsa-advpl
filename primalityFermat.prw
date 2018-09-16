#include "Protheus.ch"
//-------------------------------------------------------------------
/*/{Protheus.doc} primalityFermat
Determina se um determinado n�mero (nNumTest) � primo
Utiliza-se do M�todo de Fermat, determinando um probabilidade
de que o n�mero � primo, atrav�s do quantitativo de descartes de
que o mesmo n�o � composto. Quanto maior o n�mero de tentativas (nNumTrial),
maior a chance do n�mero ser verdadeiramente primo.

@author  Jackson Machado
@since   16/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
User Function primalityFermat( nParamTest )

	Local lPrime := .T.
	Local nTrial
	// Numero de Tentativas
	Local nNumTrial := 20

	// Numero a ser testado
	Local nNumTest

	// Numero randomizado de 1 at� nNumTest - 1
	Local nNumRand

	// Determina um valor Padr�o como Primo a n�vel de teste
	Default nParamTest := 44721359

	//Atribui o valor para teste
	nNumTest := nParamTest

	For nTrial := 1 To nNumTrial
		// Gera um n�mero aleat�rio de  1 at� nNumTest - 1
		nNumRand := Randomize( 1, nNumTest )

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
Static Function testMod( nFactor, nPow, nNumMod )
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
Static Function MDC( nRandom, nTestNum )

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

