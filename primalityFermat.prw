#include "Protheus.ch"
//-------------------------------------------------------------------
/*/{Protheus.doc} primalityFermat
Determina se um determinado número (nNumTest) é primo
Utiliza-se do Método de Fermat, determinando um probabilidade
de que o número é primo, através do quantitativo de descartes de
que o mesmo não é composto. Quanto maior o número de tentativas (nNumTrial),
maior a chance do número ser verdadeiramente primo.

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

	// Numero randomizado de 1 até nNumTest - 1
	Local nNumRand

	// Determina um valor Padrão como Primo a nível de teste
	Default nParamTest := 44721359

	//Atribui o valor para teste
	nNumTest := nParamTest

	For nTrial := 1 To nNumTrial
		// Gera um número aleatório de  1 até nNumTest - 1
		nNumRand := Randomize( 1, nNumTest )

		// Avalia se o numero possui outro máximo denominador comum
		// que não 1, caso tenha não é primo
		If MDC( nNumRand, nNumTest ) != 1
			lPrime := .F.
			Exit
		EndIf

		// Avalia pelo Teste de Fermat se o número é composto
		If testMod( nNumRand, (nNumTest - 1), nNumTest ) != 1
			lPrime := .F.
			Exit
		EndIf
	Next nTrial

	Return lPrime
//-------------------------------------------------------------------
/*/{Protheus.doc} testMod
Determina o resultado do módulo de acordo com o Fator e a Potência
Aplica-se o Teorema do Quociente-Resto:
	- Onde, A = B * Q + R, sendo 0 <= R < B
e a Multiplicação Modular:
	- Onde, (A * B) mod C = (A mod C * B mod C) mod C
Com isso, elimina-se os múltiplos de C e considera-se os Restos para
as demais múltiplicações

@author  Jackson Machado
@since   16/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function testMod( nFactor, nPow, nNumMod )
	Local nMod := 1

	//Realiza a operação até potência ser encerrada
	While nPow > 0
		// Caso não seja divisor de dois,
		// multiplica o resto salvo pelo fator e
		// salva o resto da divisão
		If nPow % 2 == 1
			nMod := Round( ( nMod * nFactor ) % nNumMod, 0 )
			nPow := nPow--
		EndIf
		// Divide o expoente por 2 e salva o valor
		nPow    := nPow/2
		// Multiplica o fator em 2 e
		// salva como novo fator o resto da divisão
		// para utilizar no novo módulo
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

	// Faz o teste até zerar o número do divisor
	While nTestNum != 0
		//Salva o resto da divisão do número randomico pelo numero testado
		nTmpMod  := nMDC % nTestNum
		// Salva como máximo divisor comum o número testado
		// e como novo divisor o resto da divisão atual
		nMDC     := nTestNum
		nTestNum := nTmpMod
	EndDo

	Return nMDC

