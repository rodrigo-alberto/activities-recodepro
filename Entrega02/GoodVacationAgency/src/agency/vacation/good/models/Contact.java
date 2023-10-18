package agency.vacation.good.models;

import java.time.LocalDateTime;

public class Contact {
	private int idContact;
	private String email;
	private String subject;
	private String message;
	private LocalDateTime messageTime;
	private UserClient userClient;

	public Contact(UserClient userClient) {
		this.userClient = userClient;
	}

	public int getIdContact() {
		return idContact;
	}

	public void setIdContact(int idContact) {
		this.idContact = idContact;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public LocalDateTime getMessageTime() {
		return messageTime;
	}

	public void setMessageTime(LocalDateTime messageTime) {
		this.messageTime = messageTime;
	}

	public UserClient getUserClient() {
		return userClient;
	}

	public void setUserClient(UserClient userClient) {
		this.userClient = userClient;
	}
}