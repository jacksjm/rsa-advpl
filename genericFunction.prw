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
			nMod := u_MOD( ( nMod * nFactor ), nNumMod )
			nPow := nPow--
		EndIf
		// Divide o expoente por 2 e salva o valor
		nPow    := nPow/2
		// Multiplica o fator em 2 e
		// salva como novo fator o resto da divisão
		// para utilizar no novo módulo
		nFactor := u_MOD( ( nFactor * nFactor ) , nNumMod )
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
	// Faz o calculo até zerar o número do divisor
	// Para tanto, realiza as divisões pelos restos
	While nTestNum != 0
		//Salva o resto da divisão do número randomico pelo numero testado
		nTmpMod  := u_MOD( nMDC, nTestNum )
		// Salva como máximo divisor comum o número testado
		// e como novo divisor o resto da divisão atual
		nMDC     := nTestNum
		nTestNum := nTmpMod
	EndDo

	Return nMDC
//-------------------------------------------------------------------
/*/{Protheus.doc} MDCExt
Retorna o valor de X no Algoritmo de Euclides Estendido
Onde A x X + B x Y = MDC(A,B), sendo :
	- A o valor da chave pública E
	- B o valor de Phi(N)

@author  Jackson Machado
@since   17/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
User Function MDCExt( nX, nY )

	// Estrutura de Variáveis
	// nValueX * nX + nValueY * nY = nX
	// nRest1 * nValueX + nRest2 * nY = nY
	Local nValueX   := 1
	Local nValueY   := 0
	Local nRest1    := 0
	Local nRest2    := 1
	Local nNewRest1 := 0
	Local nNewRest2 := 0
	Local nTmpRes


	/* Estrutura de Exemplo
	(1) 13/640 = 0 com resto 13
	(2) 640/13 = 49 com resto 3
	(3) 13/3 = 4 com resto 1

	------------------
	X / Y = C com R
	X = C * Y + R
	Isola-se o R
	R = X - ( C * Y ) ou R = ( 1 * X ) - ( C * Y )
	(1) 13 = ( 1 * 13 ) - ( 0 * 640 )
	(2) 3 = ( 1 * 640 ) - ( 49 * 13 )
	(2) 3 = ( 1 * 640 ) - ( 49 * ( ( 1 * 13 ) - ( 0 * 640 ) ) )
	(2) 3 = ( 1 * 640 ) - ( 49 * 13 ) - ( 0 * 640 )
	(2) 3 = ( 1 * 640 ) - ( 49 * 13 )
	(3) 1 = ( 1 * 13 ) - ( 4 * 3 )
	(3) 1 = ( 1 * 13 ) - ( 4 * ( 1 * 640 ) - ( 49 * 13 ) )
	(3) 1 = ( 1 * 13 ) - ( 4 * 640 ) - ( 196 * 13 )
	(3) 1 = ( 197 * 13 ) - ( 4 * 640 )
	*/
	While nY != 0
		nTmpRes := u_MOD( nX, nY ) // 13 // 3 // 1 // 0
		nQuot   := Int(nX/nY) // 0 // 49 // 4 // 3
		nX := nY // 640 // 13 // 3 // 1
		nY := nTmpRes // 13 // 3 // 1 // 0
		nNewRest1 := nValueX - nQuot * nRest1 // 1 // -49 // 197 // -640
		nNewRest2 := nValueY - nQuot * nRest2 // 0 // 1 // -4 // 13
		nValueX := nRest1 // 0 // 1 // -49 // 197
		nValueY := nRest2 // 1 // 0 // 1 // -4
		nRest1  := nNewRest1 // 1 //-49 // 197 // -640
		nRest2  := nNewRest2 // 0 // 1 // -4 // 13
	EndDo

	Return nValueX

//-------------------------------------------------------------------
/*/{Protheus.doc} MOD
Retorna o Mod da divisão
Necessário pois o Protheus não trata corretamente Mod negativo

@author  Jackson Machado
@since   17/09/2018
@version 1.0
/*/
//-------------------------------------------------------------------
User Function MOD( nA, nB )
	Local nRest := Round( nA % nB , 0 )

	// Se o resto for negativo e o dividendo for positivo, ou se o resto
	// for positivo e o dividendo negativo, é necessário ajustar
	If ( nRest < 0 .And. nB > 0 ) .Or. ;
		( nRest > 0 .And. nB < 0 )
		nRest := nB + nRest
	EndIf

	Return nRest