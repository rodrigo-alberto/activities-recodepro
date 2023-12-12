package agency.vacation.good.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
import agency.vacation.good.daos.DestinyDao;
import agency.vacation.good.utils.SystemAlerts;

@WebServlet("/DeleteDestinyController")
public class DeleteDestinyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DestinyDao detinyDao = new DestinyDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (JOptionPane.OK_OPTION == SystemAlerts.printAlertConfirm(SystemAlerts.CONFIRM_EXCLUSION)) {
			this.detinyDao.deleteDestiny(Integer.parseInt(request.getParameter("idDestiny")));			
		}

		response.sendRedirect("ReadDestinyController");
	}
}