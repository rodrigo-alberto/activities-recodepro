Algoritmo "AgencyGoodVacation"
// Programa Recode Pro 2023 - Atividade Prática do Módulo 2 (Pseudocódigo);
// Professor   : Flávio Mota da Cruz;
// Descrição   : Simula um sistema básico com menu
//             para uma empresa de agência de viagens;
// Autor(a)    : Rodrigo Alberto M. de Sousa
// Data início do projeto  : 15/07/2023

//-------------------------------- PROCEDIMENTOS ------------------------------;
// #Impressões:

procedimento printLogo(speed:inteiro)
inicio
   limpatela
   timer(speed)
   escreval("================================================================")
   escreval("   _____                       _")
   escreval("  / ____| Agência de Viagens  | |             Desenvolvido por:")
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
   timer(2000)
   timer(0)
fimprocedimento //Fim do procedimento printAlerta();

procedimento printHeader()
inicio
   limpatela
   escreval("=============== Agência de Viagens - GOOD VACATION =============")
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
   escreval("     0 - Sair da aplicação")
   escreval("")
   escreval("================================================================")
   escreval("")

   escreval("Escolha uma opção ou pressione 0 - para sair...")
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
         printAlerta("Cota máxima de clientes atingida!", "Por favor, aguarde a liberação de vagas")
         printMenuPrincipal()
      fimse

   caso "2"
      se(indiceDestino <= MAX_DESTINOS) entao
         cadastrarDestino()
      senao
         printHeader()
         printAlerta("Cota máxima de destinos atingida!", "Por favor, aguarde a liberação")
         printMenuPrincipal()
      fimse

   caso "3"
      escreval("3")

   caso "4"
      escreval("4")

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
               printAlerta("Cota máxima de clientes atingida!", "Por favor, aguarde a liberação de vagas")
               printMenuPrincipal()
            fimse
         senao
            se(origem = "cadastrarDestino") entao
               se(indiceDestino <= MAX_DESTINOS) entao
                  cadastrarDestino()
               senao
                  printAlerta("Cota máxima de destinos atingida!", "Por favor, aguarde a liberação")
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
   escreval(", deseja associar um dos destinos de viajens disponíveis ao seu cadastro?")

   consultarDestinos()

   escreval("")
   escreval("Informe um nome entre os destinos acima ou digite ")
   escreval("0 - para sair sem associar...")
   escreval("-> ")
   escreva("   ")
   leia(opcao)

   se(opcao = "0") entao
      printMenuEscolha("cadastrarCliente")
   senao
      se(valEscolhaDestino(opcao) = VERDADEIRO) entao
         nomesClientes[(indiceCliente-1), 2] <- opcao
         printAlerta("Destino associado com sucesso!", "")
         printMenuEscolha("cadastrarCliente")
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
   escreval("                       [Cliente nº ", (indiceCliente+1), "]")
   escreval("")
   escreva("     - Informe seu primeiro nome: ")
   leia(nomesClientes[indiceCliente, 0])
   escreva("     - Informe seus sobrenomes: ")
   leia(nomesClientes[indiceCliente, 1])
   escreval("     - Informe sua data de nascimento")
   escreva("   -- Dia: ")
   leia(dadosClientes[indiceCliente, 0])
   escreva("   -- Mês: ")
   leia(dadosClientes[indiceCliente, 1])
   escreva("   -- Ano: ")
   leia(dadosClientes[indiceCliente, 2])

   se(valCampoVazio() = VERDADEIRO) entao
      se(valData() = VERDADEIRO) entao
         printAlerta("Cadastro concluído com sucesso!", "")


         indiceCliente <- indiceCliente + 1
         associarDestino()


      senao
         printAlerta("Erro! Data inválida!", "Por favor, verifique - [Cadastro invalidado]")
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

//----------------------------------- FUNÇÕES ---------------------------------;
//#Validações de dados:

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
fimfuncao //Fim da função valCampoVazio();

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
fimfuncao //Fim da função valData();

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
fimfuncao  //Fim da função valEscolhaDestino();

//------------------------------ CÓDIGO PRINCIPAL -----------------------------;
//Obs.: Se houver modificações nas constantes, altere também as respectivas declaração dos vetores;
Var
   //Constantes:
   ANO_ATUAL, ANO_LIMITE, MAX_CLIENTES, MAX_DESTINOS:inteiro

   //Variáveis:
   startOption:caractere
   nomesClientes:vetor[0..4,0..2] de caractere
   dadosClientes:vetor[0..4,0..2] de inteiro
   listaDestinos:vetor[0..4] de caractere
   indiceCliente, indiceDestino:inteiro

Inicio
   ANO_ATUAL <- 2023
   ANO_LIMITE <- 1908 //Atualmente, a pessoa mais velha do mundo tem 115 anos;
   MAX_DESTINOS <- 4
   MAX_CLIENTES <- 4 //Nº máximo de clientes que o vetor suporta;
   indiceDestino <- 2 //"Salvador" e "Rio de Janeiro" formam uma lista prévia de destinos;
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