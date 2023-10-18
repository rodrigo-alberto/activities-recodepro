package agency.vacation.good.models;

public class TravelPackage {
	private final Trip trip;
	private final UserClient userCliente;
	
	public TravelPackage(Trip trip, UserClient userCliente) {
		this.trip = trip;
		this.userCliente = userCliente;
	}

	public Trip getTrip() {
		return trip;
	}

	public UserClient getUserCliente() {
		return userCliente;
	}
}