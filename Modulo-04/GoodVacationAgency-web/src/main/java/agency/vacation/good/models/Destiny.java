package agency.vacation.good.models;

import java.util.Base64;

public class Destiny {
	public static final Destiny NOT_FOUND_DESTINY = null;
	
	private int idDestiny;
	private String name;
	private byte[] image;
	private String imageBase64;	
	private String city;
	
	public Destiny() {
	}

	public int getIdDestiny() {
		return idDestiny;
	}

	public void setIdDestiny(int idDestiny) {
		this.idDestiny = idDestiny;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}
	
	public String getImageBase64() {
		return imageBase64;
	}
	
	public void setImageBase64(byte[] imagemByte) {
//	    if (imageBase64 == null) {
	        this.imageBase64 = Base64.getEncoder().encodeToString(imagemByte);
//	    }
	}
}