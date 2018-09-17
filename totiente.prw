#include "Protheus.ch"
//-------------------------------------------------------------------
/*/{Protheus.doc} totiente
Determina a Fun��o Totiente de Euler
Utilizada para determina o valor de N = P * Q para gera��o da
Criptografia RSA, com isso, aplica-se o conceito de que para todo
n�mero primo, os n�meros naturais co-primos destes s�o ele mesmo menos 1.
Com isso, tem-se que ?(N) ou Phi(N) = (P - 1) * (Q - 1).

@return  Array, Valores dispostos como:
				[1] Valor de P
				[2] Valor de Q
				[3] Valor de N
				[4] Valor de ?(N)

@author  Jackson Machado
@since   16/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
User Function totiente( lPrivate )

	Local nCnt
	//Determina o tamanho m�nimo dos n�meros
	Local nTamNumbers := 2
	//Determina os valores de limite inicial e final da gera��o dos n�meros aleat�rios
	Local nLimLeft    := Val( PadR( "1" , nTamNumbers , "0" ) )
	Local nLimRight   := Val( Replicate( "2" , nTamNumbers ) )

	Local nP
	Local nQ
	Local nPhiP
	Local nPhiQ

	Local aValues := {}

	//Define que retorna a estrutura completa
	Default lPrivate := .F.

	//Executa o Random para buscar os n�meros entre o limite
	nP := Randomize( nLimLeft , nLimRight + 1 ) //Sortei um n�mero entre o limite
	nQ := Randomize( nLimLeft , nLimRight + 1 ) //Sortei um n�mero entre o limite

	//Adiciona os valores no array de retorno
	aAdd( aValues, nP )
	aAdd( aValues, nQ )
	//Percorre os valores randomizados de nP at� que sejam primos
	For nCnt := 1 To Len( aValues )
		While !u_PriFerm( aValues[ nCnt ] )//Determina a primalidade do n�mero
			//Caso valor ultrapasse o limite da sequencia, volta ao in�cio da sequencia
			If aValues[ nCnt ] < nLimRight
				// Caso seja divisor de 2 sabe-se que � par, logo busca
				// o pr�ximo n�mero �mpar em sequencia
				If aValues[ nCnt ] % 2 == 0
					aValues[ nCnt ]++
				Else
					aValues[ nCnt ] += 2
				EndIf
			Else
				aValues[ nCnt ] := nLimLeft
			EndIf
		EndDo
	Next nCnt

	//Salva os valores para calcular o ?(N)
	nPhiP := aValues[ 1 ] - 1
	nPhiQ := aValues[ 2 ] - 1

	If !lPrivate
		//Adiciona os valores no array de retorno
		aAdd( aValues, nP * nQ )
		aAdd( aValues, nPhiP * nPhiQ )
	Else
		//Caso seja a estrutura privada, retorna apenas N
		aAdd( aValues, nP * nQ )
	EndIf

	Return aValues