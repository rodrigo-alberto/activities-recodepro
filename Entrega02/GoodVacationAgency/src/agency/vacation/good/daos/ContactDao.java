package agency.vacation.good.daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import agency.vacation.good.connection.ConnectionBd;
import agency.vacation.good.models.Contact;
import agency.vacation.good.models.UserClient;
import agency.vacation.good.utils.SystemAlerts;

/* Segundo a regra de negócio ATUAL da Good Vacation Agency, após enviado, um Contato (formulário enviado pelo front-end) 
 * não pode ser atualizado ou excluído por um usuário/Cliente. Posteriormente essa função será associada a usuários(ADM) */

public class ContactDao {
	public boolean createContact(Contact contact) {
		String sql = "INSERT INTO contact (email, `subject`, message, messageTime, fk_userClient_idUser) "
				+ "values(?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pst = ConnectionBd.getConnection().prepareStatement(sql);
			pst.setString(1, contact.getEmail());
			pst.setString(2, contact.getSubject());
			pst.setString(3, contact.getMessage());	
			pst.setTimestamp(4, Timestamp.valueOf(contact.getMessageTime()));
			pst.setInt(5, contact.getUserClient().getIdUser());
			pst.execute();
			pst.close();		
		} catch (SQLException e) {
			SystemAlerts.printAlertMessage(SystemAlerts.REGISTRY_ERROR);
			SystemAlerts.printAlertException(e);
			return false;
		}
		
		SystemAlerts.printAlertMessage(SystemAlerts.REGISTRY_SUCCESS);
		return true;
	}
	
	public ArrayList<Contact> getAllContactsByidUser(int idUser) {
		ArrayList<Contact> arrContacts = new ArrayList<Contact>();
		String sql = "SELECT * "
				+ "FROM contact as c INNER JOIN userClient as u "
				+ "ON c.fk_userClient_idUser = u.idUser "
				+ "WHERE c.fk_userClient_idUser = ? ";
		
		try {
			PreparedStatement pst = ConnectionBd.getConnection().prepareStatement(sql);
			ResultSet rs;
			
			pst.setInt(1, idUser);
			rs = pst.executeQuery();
			
			while (rs.next()) {
				UserClient contactUser = new UserClient();

				contactUser.setIdUser(rs.getInt("idUser"));
				contactUser.setName(rs.getString("name"));
				contactUser.setPassword(rs.getString("password"));
				contactUser.setClient(rs.getBoolean("isClient"));
				contactUser.setProfilePicture(rs.getString("profilePicture"));
				contactUser.setAcessLevel(rs.getString("acessLevel"));
				contactUser.setDateBirth(LocalDate.parse(rs.getDate("dateBirth").toString()));
				contactUser.setCpf(rs.getString("cpf"));
				contactUser.setSex(rs.getString("sex"));

				Contact contact = new Contact(contactUser);
				
				contact.setIdContact(rs.getInt("idContact"));
				contact.setEmail(rs.getString("email"));
				contact.setSubject(rs.getString("subject"));
				contact.setMessage(rs.getString("message"));
				contact.setMessageTime(rs.getTimestamp("messageTime").toLocalDateTime());
				arrContacts.add(contact);
			}
			pst.close();
			rs.close();
		
		} catch (SQLException e) {
			System.out.println(e);
			SystemAlerts.printAlertMessage(SystemAlerts.QUERY_ERROR);
			SystemAlerts.printAlertException(e);
		}
		
		return arrContacts;
	}
}