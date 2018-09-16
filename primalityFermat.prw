#include "Protheus.ch"
//-------------------------------------------------------------------
/*/{Protheus.doc} PriFerm
Determina se um determinado número (nNumTest) é primo (Primality Fermat)
Utiliza-se do Método de Fermat, determinando um probabilidade
de que o número é primo, através do quantitativo de descartes de
que o mesmo não é composto. Quanto maior o número de tentativas (nNumTrial),
maior a chance do número ser verdadeiramente primo.

@author  Jackson Machado
@since   16/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
User Function PriFerm( nParamTest )

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
		If u_MDC( nNumRand, nNumTest ) != 1
			lPrime := .F.
			Exit
		EndIf

		// Avalia pelo Teste de Fermat se o número é composto
		If u_testMod( nNumRand, (nNumTest - 1), nNumTest ) != 1
			lPrime := .F.
			Exit
		EndIf
	Next nTrial

	Return lPrime


