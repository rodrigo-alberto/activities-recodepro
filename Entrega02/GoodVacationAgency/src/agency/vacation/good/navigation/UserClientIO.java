package agency.vacation.good.navigation;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Scanner;
import javax.swing.JOptionPane;
import agency.vacation.good.daos.UserClientDao;
import agency.vacation.good.models.UserClient;
import agency.vacation.good.utils.AcessLevel;
import agency.vacation.good.utils.CrudMenu;
import agency.vacation.good.utils.SystemAlerts;

public class UserClientIO {
	private static UserClientDao userClientDao = new UserClientDao();
	private static UserClient userClient = new UserClient();
	private static int option;
	
	public static void printUserClientMenu(Scanner scan) {
		do {
			option = CrudMenu.printCrudMemnu(scan, "Menu - Usuário/Cliente", "");

			switch (option) {
				case 1:
					userClient = setUserClientData(scan, new UserClient());
					//Cria o usuário, com o nível de acesso já validado;
					userClientDao.createUserClient(userClient);
			
					break;
				case 2:
					scan.nextLine();
					System.out.print("\n - Usuários da aplicação:\n");
					printUserClientData(userClientDao.getAllUsers());
					
					break;
				case 3:
					ArrayList<UserClient> arrUser = new ArrayList<UserClient>();
					
					System.out.print("    - Informe o id do usuário que deseja atualizar: ");
					UserClient selectedUserClient = userClientDao.getUserbyid(scan.nextInt());
					
					if(selectedUserClient.getIdUser() != UserClient.NOTFOUND_IDUSER) {
						arrUser.add(selectedUserClient);
						printUserClientData(arrUser);
						System.out.println("\n      * Usuário encontrado! - Atualize seus dados: *\n");
						userClient = setUserClientData(scan, selectedUserClient);
						
						//Atualiza o usuário, com seus novos dados já preenchidos;
						userClientDao.updateUserClient(selectedUserClient.getIdUser(), userClient);	
					}else {
						System.out.println("\n      * Usuário não encontrado! *\n");
					}
					
					break;
				case 4:
					scan.nextLine();
					System.out.print("    - Informe o id do usuário que deseja deletar: ");
					selectedUserClient = userClientDao.getUserbyid(scan.nextInt());
					
					if(selectedUserClient.getIdUser() != UserClient.NOTFOUND_IDUSER) {
						if(JOptionPane.OK_OPTION == SystemAlerts.printAlertConfirm(SystemAlerts.RESTRICTION_EXCLUSION)) {
							//Deleta o usuário selecionado, bem como todos os seus Contatos e Pacotes de viagens;
							userClientDao.deleteUserClient(selectedUserClient.getIdUser());
						}
						
					}else {
						System.out.println("\n      * Usuário não encontrado! *\n");
					}
					
					break;
				default:
					SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_OPTION);
				}
		} while (option != 5);
	}
	
	private static UserClient setUserClientData(Scanner scan, UserClient selectedUserClient) {
		int codAcessLevel;
		Boolean isFilled = false;
		scan.nextLine();
		
		System.out.print("\n - Informe o primeiro nome do usuário: ");
		selectedUserClient.setName(scan.next());
		System.out.print(" - Informe a senha do usuário: ");
		selectedUserClient.setPassword(scan.next());
		System.out.print(" - Informe o caminho (referência) da imagem de perfil do usuário: "); //Simulação de upload da imagem de perfil;
		selectedUserClient.setProfilePicture(scan.next());
		
		//Breve validação do nível de acesso do usuário a ser cadastrado;
		do {
			System.out.print(" - Informe o nível de acesso do usuário (1 p/ Administrativo || 2 p/ Comum): ");
			codAcessLevel = scan.nextInt();
			
			if(AcessLevel.ADMIN_ACESS.getCod() == codAcessLevel) {			
				if(JOptionPane.OK_OPTION == SystemAlerts.printAlertConfirm(SystemAlerts.RESTRICTION_ADM_ALERT)) {
					System.out.print("    - Informe o id de um usuário(ADM): ");
					UserClient admUserClient = userClientDao.getUserbyid(scan.nextInt());
					
					if(admUserClient.getIdUser() != UserClient.NOTFOUND_IDUSER && admUserClient.getAcessLevel() == AcessLevel.ADMIN_ACESS) {
						selectedUserClient.setAcessLevel(codAcessLevel);
						isFilled = true;									
					}else {
						System.out.println("\n      * Usuário(ADM) não encontrado! *");
					}
				}
			}else {
				if(AcessLevel.COMMON_ACCESS.getCod() == codAcessLevel) {
					selectedUserClient.setAcessLevel(codAcessLevel);
					isFilled = true;
				}else {
					SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_OPTION);
				}
			}
		} while (!isFilled);
		
		if(selectedUserClient.isClient()) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			scan.nextLine();

			try {
				System.out.print(" - Data de nascimento (dd/mm/yyyy): ");
				selectedUserClient.setDateBirth(LocalDate.parse(scan.next(), formatter));				
			} catch (DateTimeParseException e) {
				SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_FORMAT);	
			}

			System.out.print(" - CPF (com pontuação): ");
			selectedUserClient.setCpf(scan.next());
			System.out.print(" - Sexo (M p/ Masculino ou F p/ Feminino): ");
			selectedUserClient.setSex(scan.next());
		}
		
		return selectedUserClient;
	}
	
	private static void printUserClientData(ArrayList<UserClient> arr) {
		for (int i = 0; i < arr.size(); i++) {
			System.out.println("\n * Usuário["+arr.get(i).getIdUser()+"]");
			System.out.println("  - Nome: "+arr.get(i).getName());
			System.out.println("  - Senha: "+arr.get(i).getPassword());
			System.out.println("  - Caminho da imagem de perfil: "+arr.get(i).getProfilePicture());
			System.out.println("  - Nível de acesso: "+arr.get(i).getAcessLevel());
			System.out.println("  - É cliente? ["+arr.get(i).isClient()+"]");
			
			//Mostra os dados específicos do cliente, se o usuário for considerado um;
			if(arr.get(i).isClient()) {
				System.out.println("  - Data de nascimento: "+arr.get(i).getDateBirth());
				System.out.println("  - CPF: "+arr.get(i).getCpf());
				System.out.println("  - Sexo: "+arr.get(i).getSex());
			}
		}
	}
}