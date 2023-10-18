package agency.vacation.good.navigation;

import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Scanner;
import agency.vacation.good.daos.DestinyDao;
import agency.vacation.good.daos.TripDao;
import agency.vacation.good.daos.UserClientDao;
import agency.vacation.good.models.Destiny;
import agency.vacation.good.models.Trip;
import agency.vacation.good.models.UserClient;
import agency.vacation.good.utils.AcessLevel;
import agency.vacation.good.utils.CrudMenu;
import agency.vacation.good.utils.SystemAlerts;

public class TripIO {
	private static TripDao tripDao = new TripDao();
	private static Trip trip;
	private static final UserClientDao userClientDao = new UserClientDao();
	private static final DestinyDao destinyDao = new DestinyDao();
	
	public static void printTripMenu(Scanner scan) {
		int option;
		
		do {
			option = CrudMenu.printCrudMemnu(scan, "Menu - Viagem", "");

			switch (option) {
				case 1:
					System.out.println("\n * Para criar uma nova viagem é preciso ter uma conta de usuário(ADM)\n");
					System.out.print("    - Informe o id do usuário(ADM) para criar uma nova viagem: ");
					UserClient admUserClient = userClientDao.getUserbyid(scan.nextInt());
					
					if(admUserClient.getIdUser() != UserClient.NOTFOUND_IDUSER && admUserClient.getAcessLevel() == AcessLevel.ADMIN_ACESS) {
						System.out.print("    - Informe o id do destino para esta viagem: ");
						Destiny destiny = destinyDao.getDestinyById(scan.nextInt());
						
						if(destiny.getIdDestiny() != Destiny.NOTFOUND_IDDESTINY) {
							Trip tripFilled = getTripData(scan, destiny);
														
							tripDao.createTrip(tripFilled);								
						}else {
							System.out.println("\n      * Destino não encontrado! *\n");
						}
						
						
					}else {
						System.out.println("\n      * Usuário(ADM) não encontrado! *");
					}

				case 2:
					ArrayList<Trip> arrTripFilled = tripDao.getAllTrips();
						
					printTripData(arrTripFilled);
					break;
				case 3:
					ArrayList<Trip> arrTrip = new ArrayList<Trip>();
					
					System.out.print("    - Informe o id da viagem que deseja atualizar: ");
					trip = tripDao.getTripById(scan.nextInt());
					
					if(trip.getIdTrip() != Trip.NOTFOUND_IDTRIP) {
						arrTrip.add(trip);
						printTripData(arrTrip);
						System.out.println("\n      * Viagem encontrada! - Atualize os seus dados: *\n");
						trip = getTripData(scan, trip.getDestiny());
						
						tripDao.updateTrip(trip.getIdTrip(), trip);	
					}else {
						System.out.println("\n      * Destino não encontrado! *\n");
					}

					break;
				case 4: //Adicionar restrição "AcessLevel.ADMIN_ACESS";
					scan.nextLine();
					System.out.print("\n    - Informe o id da viagem que deseja deletar: ");
					trip = tripDao.getTripById(scan.nextInt());

					if(trip.getIdTrip() != Trip.NOTFOUND_IDTRIP) {
						tripDao.deleteTrip(trip.getIdTrip());
					}else {
						System.out.println("\n      * Destino não encontrado! *\n");
					}
					
					break;
				default:
					SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_OPTION);
				}
		} while (option != 5);
	}
	
	private static Trip getTripData(Scanner scan, Destiny destiny) {
		Trip trip = new Trip(destiny);
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
		scan.nextLine();
		
		try {
			System.out.print("\n - Informe o horário de partida da viagem (dd/MM/yyyy HH:mm:ss): ");
//			trip.setDepartureDate(LocalDateTime.parse(scan.nextLine(), formatter));
			trip.setDepartureDate(LocalDateTime.now());
			System.out.print("\n - Informe o horário de chegada da viagem (dd/MM/yyyy HH:mm:ss): \n");
//			trip.setDepartureDate(LocalDateTime.parse(scan.nextLine(), formatter));	
			trip.setArrivalDate(LocalDateTime.now());	
		} catch (DateTimeParseException e) {
			SystemAlerts.printToConsole(SystemAlerts.RESTRICTION_FORMAT);	
		}
		
		System.out.print(" - Informe o preço para esta viagem: ");
		trip.setTravelPrice(scan.nextDouble());
		System.out.print(" - Esta viagem está na promoção? (true ou false): ");
		trip.setPromotion(scan.nextBoolean());

		return trip;
	}
	
	private static void printTripData(ArrayList<Trip> arr) {
		if(arr.size() != 0) {
			for (int i = 0; i < arr.size(); i++) {
				System.out.println("\n * Viagem ["+arr.get(i).getIdTrip()+"]");
				System.out.println("  - Destino da viagem: "+arr.get(i).getDestiny().getName());
				System.out.println("  - Data de partida da viagem: "+arr.get(i).getDepartureDate());
				System.out.println("  - Data de chegada da viagem: "+arr.get(i).getArrivalDate());
				System.out.println("  - Preço desta viagem: "+arr.get(i).getTravelPrice());
				System.out.println("  - Esta viagem está na promoção?: "+arr.get(i).isPromotion());
			}			
		}else {
			System.out.println("\n      * Não há viagens cadastrados no sistema\n");
		}
	}
}
