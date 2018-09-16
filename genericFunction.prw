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
User Function testMod( nFactor, nPow, nNumMod )
	Local nMod  := 1

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

	// Caso seja negativo, corrige para o valor positivo
	// pois o AdvPL não trata o módulo negativo
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

	// Faz o calculo até zerar o número do divisor
	// Para tanto, realiza as divisões pelos restos
	While nTestNum != 0
		//Salva o resto da divisão do número randomico pelo numero testado
		nTmpMod  := nMDC % nTestNum
		// Salva como máximo divisor comum o número testado
		// e como novo divisor o resto da divisão atual
		nMDC     := nTestNum
		nTestNum := nTmpMod
	EndDo

	Return nMDC