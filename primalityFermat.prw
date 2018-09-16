#include "Protheus.ch"
//-------------------------------------------------------------------
/*/{Protheus.doc} PriFerm
Determina se um determinado n�mero (nNumTest) � primo (Primality Fermat)
Utiliza-se do M�todo de Fermat, determinando um probabilidade
de que o n�mero � primo, atrav�s do quantitativo de descartes de
que o mesmo n�o � composto. Quanto maior o n�mero de tentativas (nNumTrial),
maior a chance do n�mero ser verdadeiramente primo.

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
		If u_MDC( nNumRand, nNumTest ) != 1
			lPrime := .F.
			Exit
		EndIf

		// Avalia pelo Teste de Fermat se o n�mero � composto
		If u_testMod( nNumRand, (nNumTest - 1), nNumTest ) != 1
			lPrime := .F.
			Exit
		EndIf
	Next nTrial

	Return lPrime


