#include "Protheus.ch"
//-------------------------------------------------------------------
/*/{Protheus.doc} totiente
Determina a Função Totiente de Euler
Utilizada para determina o valor de N = P * Q para geração da
Criptografia RSA, com isso, aplica-se o conceito de que para todo
número primo, os números naturais co-primos destes são ele mesmo menos 1.
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
	//Determina o tamanho mínimo dos números
	Local nTamNumbers := 2
	//Determina os valores de limite inicial e final da geração dos números aleatórios
	Local nLimLeft    := Val( PadR( "1" , nTamNumbers , "0" ) )
	Local nLimRight   := Val( Replicate( "2" , nTamNumbers ) )

	Local nP
	Local nQ
	Local nPhiP
	Local nPhiQ

	Local aValues := {}

	//Define que retorna a estrutura completa
	Default lPrivate := .F.

	//Executa o Random para buscar os números entre o limite
	nP := Randomize( nLimLeft , nLimRight + 1 ) //Sortei um número entre o limite
	nQ := Randomize( nLimLeft , nLimRight + 1 ) //Sortei um número entre o limite

	//Adiciona os valores no array de retorno
	aAdd( aValues, nP )
	aAdd( aValues, nQ )
	//Percorre os valores randomizados de nP até que sejam primos
	For nCnt := 1 To Len( aValues )
		While !u_PriFerm( aValues[ nCnt ] )//Determina a primalidade do número
			//Caso valor ultrapasse o limite da sequencia, volta ao início da sequencia
			If aValues[ nCnt ] < nLimRight
				// Caso seja divisor de 2 sabe-se que é par, logo busca
				// o próximo número ímpar em sequencia
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