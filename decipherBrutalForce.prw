User Function brutDeci()

	Local nMsg
	Local nValueN // Valor para a chave pública N
	Local nValueE // Valor para a chave pública E
	Local nValueD      := 0 // Valor para a chave privada D
	Local lLoc         := .F.
	Local cValPow //Valor que receberá a potência dos números grandes
	Local oObj //Utilizado como objeto para Inteiros Grantes (TMathIntegerStr)

    Local cMsgToCipher := "Oi"
	Local cMsgTpDeciph := ""
	Local cLogMsg      := ""
	Local aValues      := u_totiente()
	Local aLetMsg      := {}

	// Determina os valores de limite inicial e final da geração dos números aleatórios
	Local nLimLeft    := 1
	Local nLimRight   := aValues[ 4 ] //Valor de ?(N)

	// Determina valor de N
	nValueN := aValues[ 3 ]

	// Calcula o valor de E para que o valor não seja menor que 1 e maior que o valor de ?(N)
	conout( "===== Determinando valor de E =====")
	nValueE := Randomize( nLimLeft , nLimRight + 1 ) // Sortei um número entre o limite
	While !lLoc
		While !u_PriFerm( nValueE )// Determina a primalidade do número
			// Caso valor ultrapasse o limite da sequencia, volta ao início da sequencia
			If nValueE < nLimRight
				// Caso seja divisor de 2 sabe-se que é par, logo busca
				// o próximo número ímpar em sequencia
				If nValueE % 2 == 0
					nValueE++
				Else
					nValueE += 2
				EndIf
			Else
				nValueE := nLimLeft
			EndIf
		EndDo
		// Determina se ?(N) e o número possem o máximo denominador comum de 1
		If u_MDC( nLimRight , nValueE ) == 1
			lLoc := .T.
		Else
			// Caso o Máximo denominador comum não seja 1, pula para o próximo número
			nValueE++
		EndIf
	EndDo
	conout( "===== Valor de E: " + cValToChar( nValueE ) + " =====")
	conout( "===== Criptografando Mensagem =====")
	// Cipher da Mensagem
	For nMsg := 1 To Len( cMsgToCipher )
		nASCII  := ASC( SubStr( cMsgToCipher , nMsg , 1 ) )
		oObj    := TMathIntegerStr():New()
		cValPow := oObj:Pow( cValToChar( nASCII ) , cValToChar( nValueE ) )

		aAdd( aLetMsg , oObj:Mod( cValPow , cValToChar( nValueN ) ) )
		cLogMsg += If( !Empty( cLogMsg ) , "," , "" ) + aLetMsg[ nMsg ]
	Next nMsg
	conout( "===== Cipher: " + cLogMsg + " =====")

	// ----------- Simula a não existência do valor de Phi(N)  -----------
	// Fatorar valor de nValueN com Euclides Estendido
	// TODO

	conout( "===== Decriptografando Mensagem =====")
	//Decipher da Mensagem
	For nMsg := 1 To Len( aLetMsg )
		oObj    := TMathIntegerStr():New()
		cValPow := oObj:Pow( cValToChar( aLetMsg[ nMsg ] ) , cValToChar( nValueD ) )
		cMsgTpDeciph += Chr( Val( oObj:Mod( cValPow , cValToChar( nValueN ) ) ) )
	Next nMsg
	conout( "===== Decipher: " + cMsgTpDeciph + " =====")
	Return