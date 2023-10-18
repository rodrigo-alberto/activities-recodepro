package agency.vacation.good.navigation;

import java.util.ArrayList;
import java.util.Scanner;
import agency.vacation.good.daos.DestinyDao;
import agency.vacation.good.daos.UserClientDao;
import agency.vacation.good.models.Destiny;
import agency.vacation.good.models.UserClient;
import agency.vacation.good.utils.AcessLevel;
import agency.vacation.good.utils.CrudMenu;
import agency.vacation.good.utils.SystemAlerts;

public class DestinyIO {
	private static DestinyDao destinyDao = new DestinyDao();
	private static Destiny destiny;
	private static UserClientDao userClientDao = new UserClientDao();
	
	public static void printDestinyMenu(Scanner scan) {
		int option;
		
		do {
			option = CrudMenu.printCrudMemnu(scan, "Menu - Destino", "");

			switch (option) {
				case 1:
					System.out.println("\n * Para criar um novo destino é preciso ter uma conta de usuário(ADM)\n");
					System.out.print("    - Informe o id do usuário(ADM) para criar um novo contato: ");
					UserClient admUserClient = userClientDao.getUserbyid(scan.nextInt());
					
					if(admUserClient.getIdUser() != UserClient.NOTFOUND_IDUSER && admUserClient.getAcessLevel() == AcessLevel.ADMIN_ACESS) {
						Destiny destinyFilled = getDestinyData(scan, new Destiny());
						
						destinyDao.createDestiny(destinyFilled);								
					}else {
						System.out.println("\n      * Usuário(ADM) não encontrado! *");
					}

				case 2:
					ArrayList<Destiny> arrDestinyFilled = destinyDao.getAllDestinys();
						
					printDestinyData(arrDestinyFilled);
					break;
				case 3:
					ArrayList<Destiny> arrDestiny = new ArrayList<Destiny>();
					
					System.out.print("    - Informe o id do destino que deseja atualizar: ");
					destiny = destinyDao.getDestinyById(scan.nextInt());
					
					if(destiny.getIdDestiny() != Destiny.NOTFOUND_IDDESTINY) {
						arrDestiny.add(destiny);
						printDestinyData(arrDestiny);
						System.out.println("\n      * Destino encontrado! - Atualize os seus dados: *\n");
						destiny = getDestinyData(scan, destiny);
						
						//Atualiza o destino, com seus novos dados já preenchidos;
						destinyDao.updateDestiny(destiny.getIdDestiny(), destiny);	
					}else {
						System.out.println("\n      * Destino não encontrado! *\n");
					}

					break;
				case 4: //Adicionar restrição "AcessLevel.ADMIN_ACESS";
					scan.nextLine();
					System.out.print("\n    - Informe o id do destino que deseja deletar: ");
					destiny = destinyDao.getDestinyById(scan.nextInt());

					if(destiny.getIdDestiny() != Destiny.NOTFOUND_IDDESTINY) {
						destinyDao.deleteDestiny(destiny.getIdDestiny());
					}else {
						System.out.println("\n      * Destino não encontrado! *\n");
					}
					
					break;
				default:
					SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_OPTION);
				}
		} while (option != 5);
	}
	
	private static Destiny getDestinyData(Scanner scan, Destiny destiny) {
		scan.nextLine();
		
		System.out.print("\n - Informe o nome do destino: ");
		destiny.setName(scan.nextLine());
		System.out.print(" - Informe o caminho (referência) da imagem do destino: ");
		destiny.setImages(scan.nextLine());
		System.out.print(" - Informe o nome da cidade do destino: ");
		destiny.setCity(scan.nextLine());
		
		return destiny;
	}
	
	private static void printDestinyData(ArrayList<Destiny> arr) {
		if(arr.size() != 0) {
			for (int i = 0; i < arr.size(); i++) {
				System.out.println("\n * Destino["+arr.get(i).getIdDestiny()+"]");
				System.out.println("  - Nome: "+arr.get(i).getName());
				System.out.println("  - Caminho (referência) da imagem: "+arr.get(i).getImages());
				System.out.println("  - Cidade do destino: "+arr.get(i).getCity());
			}			
		}else {
			System.out.println("\n      * Não há destinos cadastrados no sistema\n"); //O que na teoria nunca deveria acontecer =);
		}
	}
	
}
