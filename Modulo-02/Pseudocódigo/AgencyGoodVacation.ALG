Algoritmo "AgencyGoodVacation"
// Programa Recode Pro 2023 - Atividade Pr�tica do M�dulo 2 (Pseudoc�digo);
// Professor   : Fl�vio Mota da Cruz;
// Descri��o   : Simula um sistema b�sico com menu
//             para uma empresa de ag�ncia de viagens;
// Autor(a)    : Rodrigo Alberto M. de Sousa
// Data in�cio do projeto  : 15/07/2023

//-------------------------------- PROCEDIMENTOS ------------------------------;
// #Impress�es:

procedimento printLogo(speed:inteiro)
inicio
   limpatela
   timer(speed)
   escreval("================================================================")
   escreval("   _____                       _")
   escreval("  / ____| Ag�ncia de Viagens  | |             Desenvolvido por:")
   escreval(" | |  __    ___     ___     __| |              Rodrigo Alberto")
   escreval(" | | |_ |  / _ \   / _ \   / _` |")
   escreval(" | |__| | | (_) | | (_) | | (_| |")
   escreval("  \_____|  \___/   \___/   \__,_|")

   escreval("__      __                       _     _")
   escreval("\ \    / /                      | |   (_)")
   escreval(" \ \  / /  __ _    ___    __ _  | |_   _    ___    ___")
   escreval("  \ \/ /  / _` |  / __|  / _` | | __| | |  / _ \  | '_ \")
   escreval("   \  /  | (_| | | (__  | (_| | | |_  | | | (_) | | | | |")
   escreval("    \/    \__,_|  \___|  \__,_|  \__| |_|  \___/  |_| |_|")
   escreval("")
   escreval("================================================================")
   escreval("")
   timer(0)
fimprocedimento

procedimento printAlerta(msgTop,msgBottom:caracter)
inicio
   escreval("--------------------------------------------------------------")
   escreval("")
   escreval("            ---- ", msgTop, " ----")
   escreval("")
   escreval("       - ", msgBottom, " -")
   timer(3500)
   timer(0)
fimprocedimento //Fim do procedimento printAlerta();

procedimento printHeader()
inicio
   limpatela
   escreval("=============== Ag�ncia de Viagens - GOOD VACATION =============")
   escreval("")
fimprocedimento //Fim do procedimento printHeader();

procedimento printMenuPrincipal()
var
   statusCadastro:logico
   menuOption:caractere
inicio
   printHeader()
   escreval("# - Cadastros: ------------------------")
   escreval("")
   escreval("     1 - Cadastro de clientes")
   escreval("     2 - Cadastro de destinos")
   escreval("")
   escreval("# - Consultas: ------------------------")
   escreval("")
   escreval("     3 - Consultar lista de clientes ativos")
   escreval("     4 - Consultar registro individual")
   escreval("     0 - Sair da aplica��o")
   escreval("")
   escreval("================================================================")
   escreval("")

   escreval("Escolha uma op��o ou pressione 0 - para sair...")
   escreva("-> ")
   leia(menuOption)

   escolha menuOption
   caso "0"
      printLogo(350)

   caso "1"
      se(indiceCliente <= MAX_CLIENTES) entao
         cadastrarCliente()
      senao
         printHeader()
         printAlerta("Cota m�xima de clientes atingida!", "Por favor, aguarde a libera��o de vagas")
         printMenuPrincipal()
      fimse

   caso "2"
      se(indiceDestino <= MAX_DESTINOS) entao
         cadastrarDestino()
      senao
         printHeader()
         printAlerta("Cota m�xima de destinos atingida!", "Por favor, aguarde a libera��o")
         printMenuPrincipal()
      fimse

   caso "3"
      printHeader()
      escreval("# - Lista de clientes ativos:")
      consultarClientes()
      escreva(" - Pressione a tecla 'enter' para voltar")
      leia(menuOption)
      printMenuPrincipal()

   caso "4"
      consultarClienteIndividual()
      escreva(" - Pressione a tecla 'enter' para voltar")
      leia(menuOption)
      printMenuPrincipal()

   outrocaso
      printMenuPrincipal()
   fimescolha
fimprocedimento //Fim do procedimento printMenuPrincipal();

procedimento printMenuEscolha(origem:caractere)
var
   option:caracter
inicio
   printHeader()
   escreval("Pressione 0 - para voltar ou 1 - para cadastrar um novo...")
   escreva("-> ")
   leia(option)

   se(option = "0") entao
      printMenuPrincipal()
   senao
      se(option = "1") entao
         se(origem = "cadastrarCliente") entao
            se(indiceCliente <= MAX_CLIENTES) entao
               cadastrarCliente()
            senao
               printAlerta("Cota m�xima de clientes atingida!", "Por favor, aguarde a libera��o de vagas")
               printMenuPrincipal()
            fimse
         senao
            se(origem = "cadastrarDestino") entao
               se(indiceDestino <= MAX_DESTINOS) entao
                  cadastrarDestino()
               senao
                  printAlerta("Cota m�xima de destinos atingida!", "Por favor, aguarde a libera��o")
                  printMenuPrincipal()
               fimse
            fimse
         fimse
      senao
         printMenuEscolha(origem)
      fimse
   fimse
fimprocedimento //Fim do procedimento printMenuEscolha()

// #Auxiliares:

procedimento associarDestino()
var
   opcao:caractere
inicio
   printHeader()
   escreva("- ", nomesClientes[(indiceCliente-1), 0])
   escreval(", deseja associar um dos destinos de viajens dispon�veis ao seu cadastro?")

   consultarDestinos()

   escreval("")
   escreval("Informe um nome entre os destinos acima ou digite ")
   escreval("0 - para sair sem associar...")
   escreval("-> ")
   escreva("   ")
   leia(opcao)

   se(opcao = "0") entao
      nomesClientes[(indiceCliente-1), 2] <- "[Sem destino associado]"
      printMenuEscolha("cadastrarCliente")
   senao
      se(valEscolhaDestino(opcao) = VERDADEIRO) entao
         nomesClientes[(indiceCliente-1), 2] <- opcao
         printAlerta("Destino associado com sucesso!", "--------------------------------------------")
         printMenuPrincipal()
      senao
         associarDestino()
      fimse
   fimse
fimprocedimento

// #Cadastros:

procedimento cadastrarCliente()
inicio
   printHeader()
   escreva("# - Cadastro de clientes:")
   escreval("                       [Cliente n� ", (indiceCliente+1), "]")
   escreval("")
   escreva("     - Informe seu primeiro nome: ")
   leia(nomesClientes[indiceCliente, 0])
   escreva("     - Informe seus sobrenomes: ")
   leia(nomesClientes[indiceCliente, 1])
   escreval("     - Informe sua data de nascimento")
   escreva("   -- Dia: ")
   leia(dadosClientes[indiceCliente, 0])
   escreva("   -- M�s: ")
   leia(dadosClientes[indiceCliente, 1])
   escreva("   -- Ano: ")
   leia(dadosClientes[indiceCliente, 2])

   se(valCampoVazio() = VERDADEIRO) entao
      se(valData() = VERDADEIRO) entao
         printAlerta("Cadastro conclu�do com sucesso!", "--------------------------------------------")


         indiceCliente <- indiceCliente + 1
         associarDestino()


      senao
         printAlerta("Erro! Data inv�lida!", "Por favor, verifique - [Cadastro invalidado]")
         cadastrarCliente()
      fimse
   senao
      printAlerta("Erro! Nem todos os campos foram preenchidos!", "Preencha os campos- [Cadastro invalidado]")
      cadastrarCliente()
   fimse
fimprocedimento //Fim do procedimento cadastrarCliente();

procedimento cadastrarDestino()
inicio
   printHeader()
   escreva("# - Cadastro de destinos:")
   escreval("")
   consultarDestinos()
   escreval("================================================================")
   escreva("Informe o nome do novo destino: ")
   leia(listaDestinos[indiceDestino])

   printAlerta("Destino cadastrado com sucesso!", "--------------------------------------------")
   indiceDestino <- indiceDestino + 1

   printMenuEscolha("cadastrarDestino")
fimprocedimento //Fim do procedimento cadastrarDestinos();

// #Consultas:

procedimento consultarDestinos()
var
   i:inteiro
inicio
   escreval("")

   para i de 0 ate MAX_DESTINOS faca
      escreval("  - ", listaDestinos[i])
   fimpara
fimprocedimento //Fim do procedimento consultarDestinos();

procedimento consultarClientes()
var
   i:inteiro
inicio
   escreval("")

   escreval("     Nomes completos:")
   escreval("----------------------------------------------------------------")

   se(nomesClientes[i, 0] = "") entao
      escreval("")
      escreval(" -- Sem clientes ativos no momento! --")
   senao
      para i de 0 ate MAX_CLIENTES faca
         escreval((i+1),"- ", nomesClientes[i, 0], " ", nomesClientes[i, 1])
      fimpara
   fimse

   escreval("")
fimprocedimento //Fim do procedimento consultarDestinos();

procedimento consultarClienteIndividual()
var
   nomeCliente:caractere
   i, contador:inteiro
inicio
   printHeader()
   escreval("# - Connsulta individual de clientes ativos:")
   escreval("")
   escreval("Informe exatamente o primeiro nome do cliente ou digite 0 - para")
   escreval("voltar...")
   escreva("-> ")
   leia(nomeCliente)

   se(nomeCliente <> "0") entao
      se(nomesClientes[i, 0] = "") entao
         printAlerta("N�o h� clientes ativos cadastrados!", "--------------------------------------------")
      senao
         se(nomeCliente = "") entao
            contador <-5
         senao
            para i de 0 ate MAX_CLIENTES faca
               se(nomeCliente = nomesClientes[i,0]) entao
                  escreval("")
                  escreval("Cliente n� ", (i+1), ": ", nomesClientes[i,0], " ", nomesClientes[i,1])
                  escreval("----------------------------------------------------------------")
                  escreval("Situa��o: Cadastrado(a)")
                  escreval("Data de nascimento: ", dadosClientes[i,0],"/", dadosClientes[i,1],"/", dadosClientes[i,2])
                  escreval("Destino programado: ", nomesClientes[i,2])
                  escreval("----------------------------------------------------------------")
                  interrompa
               senao
                  contador <- contador+1
               fimse
            fimpara
         fimse

         se((contador-1) = MAX_CLIENTES) entao
            printAlerta("Cliente n�o encontrado!", "--- Por favor, verifique o nome informado ---")
            consultarClienteIndividual()
         fimse
      fimse
   fimse

   escreval("")
fimprocedimento //Fim do procedimento consultarClienteIndividual();


//----------------------------------- FUN��ES ---------------------------------;
//#Valida��es de dados:

funcao valCampoVazio():logico
var
   i:inteiro
   statusValidacao:logico
inicio
   para i de 0 ate 1 faca
      se(nomesClientes[indiceCliente, i] = "") entao
         statusValidacao <- FALSO
         interrompa
      senao
         statusValidacao <- VERDADEIRO
      fimse
   fimpara

   retorne statusValidacao
fimfuncao //Fim da fun��o valCampoVazio();

funcao valData():logico
var
   dia, mes, ano:inteiro
inicio
   dia <- dadosClientes[indiceCliente,0])
   mes <- dadosClientes[indiceCliente,1])
   ano <- dadosClientes[indiceCliente,2])

   se((dia <= 31) e (dia > 0)) entao
      se((mes <= 12) e (mes > 0)) entao
         se((ano < ANO_ATUAL) e (ano >= ANO_LIMITE)) entao
            retorne VERDADEIRO
         senao
            retorne FALSO
         fimse
      senao
         retorne FALSO
      fimse
   senao
      retorne FALSO
   fimse
fimfuncao //Fim da fun��o valData();

funcao valEscolhaDestino(opcao:caractere):logico
var
   statusValidacao:logico
   i:inteiro
inicio

   se(opcao <> "") entao
      para i de 0 ate MAX_DESTINOS faca
         se(opcao = listaDestinos[i]) entao
            statusValidacao <- VERDADEIRO
            interrompa
         senao
            statusValidacao <- FALSO
         fimse
      fimpara
   senao
      statusValidacao <- FALSO
   fimse

   retorne statusValidacao
fimfuncao  //Fim da fun��o valEscolhaDestino();

//------------------------------ C�DIGO PRINCIPAL -----------------------------;
//Obs.: Se houver modifica��es nas constantes, altere tamb�m as respectivas declara��o dos vetores;
Var
   //Constantes:
   ANO_ATUAL, ANO_LIMITE, MAX_CLIENTES, MAX_DESTINOS:inteiro

   //Vari�veis:
   startOption:caractere
   nomesClientes:vetor[0..4,0..2] de caractere
   dadosClientes:vetor[0..4,0..2] de inteiro
   listaDestinos:vetor[0..4] de caractere
   indiceCliente, indiceDestino:inteiro

Inicio
   ANO_ATUAL <- 2023
   ANO_LIMITE <- 1908 //Atualmente, a pessoa mais velha do mundo tem 115 anos;
   MAX_DESTINOS <- 4
   MAX_CLIENTES <- 4 //N� m�ximo de clientes que o vetor suporta;
   indiceDestino <- 2 //"Salvador" e "Rio de Janeiro" formam uma lista pr�via de destinos;
   listaDestinos[0] <- "Salvador"
   listaDestinos[1] <- "Rio de Janeiro"

   printLogo(0)

   repita
      escreval("Pressione 1 - para continuar ou 0 - para sair...")
      escreva("-> ")
      leia(startOption)
      limpatela

      se(startOption = "1") entao
         printMenuPrincipal()
         interrompa
      senao
         se(startOption = "0") entao
            printLogo(350)
         senao
            printLogo(0)
         fimse
      fimse
   ate startOption = "0"
Fimalgoritmo