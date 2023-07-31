Algoritmo "AgencyGoodVacation"
// Programa Recode Pro 2023 - Atividade Prática do Módulo 2 (Pseudocódigo);
// Professor   : ;
// Descrição   : Simula um menu básico para uma empresa de agência de viagens;
// Autor(a)    : Rodrigo Alberto M. de Sousa
// Data atual  : 15/07/2023
//---------------------------------------------------------------------------;

// Procedimentos ------------------------------;

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
fimprocedimento

procedimento printAlerta(msg:caracter)
inicio
   escreval("-------------------------------------------------")
   escreval("")
   timer(3500)
   escreval("     ----- ", msg, " -----")
   timer(0)
fimprocedimento

procedimento printHeader()
inicio
   limpatela
   escreval("=============== Agência de Viagens - GOOD VACATION =============")
   escreval("")
fimprocedimento

procedimento printMenu()
var
   menuOption, i:inteiro
inicio
   printHeader()
   escreval("# - Cadastros: ------------------------")
   escreval("")
   escreval("     1 - Cadastro de clientes")
   escreval("     2 - Cadstro de destino")
   escreval("")
   escreval("# - Consultas: ------------------------")
   escreval("")
   escreval("     3 - Consultar clientes ativos")
   escreval("     4 - Consultar lista de destinos")
   escreval("     5 - Consultar registro individual")
   escreval("")
   escreval("================================================================")
   escreval("")

   escreval("Escolha uma opção ou pressione 0 - para sair...")
   escreva("-> ")
   leia(menuOption)

   escolha menuOption
   caso 0
      printLogo(400)
      //fimalgoritmo
   caso 1
      se(numCliente <=4) entao
         se(cadastrarCliente(numCliente) = VERDADEIRO) entao
            printAlerta("Cadastro concluído com sucesso!")
            numCliente <- numCliente + 1
            printMenu()
         senao
            printAlerta("Cota máxima de clientes atingida!")
            numCliente <- 4 //Ou colocar constantes aqui
            printMenu()
         fimse
      senao
         escreval("nnnnn cadastrou")
      fimse
   caso 3
      escreval("3")
   outrocaso
      escreval("outro caso")
   fimescolha
fimprocedimento

// Funções ------------------------------;

funcao valCampoVazio(): logico
inicio

   retorne VERDADEIRO
fimfuncao

funcao valData(numCliente:inteiro): logico
var
   data, mes, ano:inteiro
inicio

   //data <- int(clientes[numCliente,2])
   //mes <- int(clientes[numCliente,3])
   //ano <- int(clientes[numCliente,4])

   se((clientes[numCliente,2] <= "31") e (clientes[numCliente,2] > "0")) entao
      escreval("dia valido")
      se((clientes[numCliente,3] <="12") e (clientes[numCliente,3] > "0")) entao
         escreval("mes valido")
         se((clientes[numCliente,4] < "2023") e (clientes[numCliente,4] >= "1908")) entao //Atualmente, a pessoa mais velha do mundo tem 115 anos;
            escreval("ano valido")
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
fimfuncao

funcao cadastrarCliente(numCliente:inteiro):logico
var
   statusCadastro:logico

inicio
   limpatela
   printHeader()

   escreval("Cadastro de clientes:")
   escreval("")
   escreva("     - Informe seu primeiro nome: ")
   leia(clientes[numCliente, 0])
   escreva("     - Informe seus sobrenomes: ")
   leia(clientes[numCliente, 1])
   escreval("     - Informe sua data de nascimento")
   escreva("   -- Dia: ")
   leia(clientes[numCliente, 2])
   escreva("   -- Mês: ")
   leia(clientes[numCliente, 3])
   escreva("   -- Ano: ")
   leia(clientes[numCliente, 4])

   se(valCampoVazio() = VERDADEIRO) entao
      escreval("vazio verdade")
      se(valData(numCliente) = VERDADEIRO) entao
         escreval("data verdade")
         statusCadastro <- VERDADEIRO
      senao
         printAlerta("Erro! Data inválida! - [Cadastro invalidado]")
         //erro aqui?
         statusCadastro <- cadastrarCliente(numCliente)
      fimse
   senao
      printAlerta("Erro! Nem todos os campos foram preenchidos! - [Cadastro invalidado]")
      statusCadastro <- cadastrarCliente()
   fimse

   retorne statusCadastro
fimfuncao



// Código principal ------------------------------;

Var
   startOption:caractere
   clientes:vetor[0..4,0..4] de caracter
   numCliente:inteiro

Inicio
   printLogo(0)
   numCliente <- 0

   repita
      escreval("Pressione 1 - para continuar ou 0 - para sair...")
      escreva("-> ")
      leia(startOption)
      limpatela

      se(startOption = "1") entao
         printMenu()
      senao
         se(startOption = "0") entao
            printLogo(400)
            //fimalgoritmo
         senao
            printLogo(0)
         fimse
      fimse
   ate startOption = "1"
Fimalgoritmo