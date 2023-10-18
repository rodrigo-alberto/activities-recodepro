package agency.vacation.good.navigation;

import java.util.InputMismatchException;
import java.util.Scanner;

import agency.vacation.good.utils.SystemAlerts;

public class MainIO {
	public static void printMainMenu() {
		Scanner scan = new Scanner(System.in);
		int option = 0;

		do {
			try {
				System.out.print("--------------------------------------------");
				System.out.println("\n# MENU PRINCIPAL # - Entidades manipuláveis:");
				System.out.print("--------------------------------------------\n");
				System.out.println(" 1 - Usuario-cliente;\n 2 - Destino;\n 3 - Viagem;\n 4 - Contato;\n 5 - Pacote da viagem;\n 6 - Sair da aplicação;");
				System.out.println("---------------------------------------------");
				System.out.print(" - Escolha uma opção: ");
				option = scan.nextInt();
				
				switch (option) {
					case 1:
						UserClientIO.printUserClientMenu(scan);
						break;
					case 2:
						DestinyIO.printDestinyMenu(scan);
						break;
					case 3:
						TripIO.printTripMenu(scan);
						break;
					case 4:
						ContactIO.printUserContactMenu(scan);
						break;
					case 5:
						SystemAlerts.printAlertMessage(SystemAlerts.RESTRICTION_OPERATING);
						break;
					default:
						SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_OPTION);
				}
			
			} catch (InputMismatchException e) {
				SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_OPTION);
				scan.nextLine();
			}
		
		} while (option != 6);
		
		scan.close();
		System.out.println("\n\n * APLICAÇÃO ENCERRADA *");
	}
}