package agency.vacation.good.navigation;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Scanner;
import agency.vacation.good.daos.ContactDao;
import agency.vacation.good.daos.UserClientDao;
import agency.vacation.good.models.Contact;
import agency.vacation.good.models.UserClient;
import agency.vacation.good.utils.CrudMenu;
import agency.vacation.good.utils.SystemAlerts;

public class ContactIO {
	private static ContactDao contactDao = new ContactDao();
	private static UserClientDao userClientDao = new UserClientDao();
	private static UserClient selectedUserClient;
	private static int option;
	
	public static void printUserContactMenu(Scanner scan) {
		do {
			option = CrudMenu.printCrudMemnu(scan, "Menu - Contato", "");

			switch (option) {
				case 1:
					System.out.println("\n * Para realizar um contato, é preciso ter uma conta de usuário prévia.\n");
					System.out.print("    - Informe o id do usuário para criar um novo contato: ");
					selectedUserClient = userClientDao.getUserbyid(scan.nextInt());
					
					if(selectedUserClient.getIdUser() != UserClient.NOTFOUND_IDUSER) {
						Contact contactFilled = getContactData(scan, selectedUserClient);
						
						contactDao.createContact(contactFilled); //Cria o contato, com um usuário existente associado;
					}else {
						System.out.println("\n      * Usuário não encontrado! *\n");
					}
							
					break;
				case 2:
					System.out.print("    - Informe o id do usuário que deseja visualizar seus contatos: ");
					selectedUserClient = userClientDao.getUserbyid(scan.nextInt());
					
					if(selectedUserClient.getIdUser() != UserClient.NOTFOUND_IDUSER) {
						ArrayList<Contact> arrContactsFilled = contactDao.getAllContactsByidUser(selectedUserClient.getIdUser());
						
						printContactData(arrContactsFilled);
					}else {
						System.out.println("\n      * Usuário não encontrado! *\n");
					}
					
					break;
				case 3:
					SystemAlerts.printAlertMessage(SystemAlerts.RESTRICTION_OPERATING);

					break;
				case 4:
					SystemAlerts.printAlertMessage(SystemAlerts.RESTRICTION_OPERATING);
					
					break;
				default:
					SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_OPTION);
				}
		} while (option != 5);
	}
	
	private static Contact getContactData(Scanner scan, UserClient selectedUserClient) {
		Contact contact = new Contact(selectedUserClient);
		scan.nextLine();
		
		System.out.print("\n - Informe seu e-mail: ");
		contact.setEmail(scan.next());
		System.out.print(" - Informe o assunto da mensagem: ");
		scan.nextLine();
		contact.setSubject(scan.nextLine());
		System.out.print(" - Descreva sua mensagem: ");
		contact.setMessage(scan.nextLine());
		contact.setMessageTime(LocalDateTime.now());
		
		return contact;
	}
	
	private static void printContactData(ArrayList<Contact> arr) {
		if(arr.size() != 0) {
			for (int i = 0; i < arr.size(); i++) {
				System.out.println("\n * Usuário["+arr.get(i).getUserClient().getIdUser()+"] - "+arr.get(i).getUserClient().getName());
				System.out.println("  - Horário da mensagem: ["+arr.get(i).getMessageTime()+"]");
				System.out.println("  - Email: "+arr.get(i).getEmail());
				System.out.println("  - Assunto: "+arr.get(i).getSubject());
				System.out.println("  - Mensagem: "+arr.get(i).getMessage());
			}			
		}else {
			System.out.println("\n      * Usuário sem contatos a ele associados\n");
		}
	}
}
