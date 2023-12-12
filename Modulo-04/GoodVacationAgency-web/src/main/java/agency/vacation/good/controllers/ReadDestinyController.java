package agency.vacation.good.controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import agency.vacation.good.daos.DestinyDao;

@WebServlet("/ReadDestinyController")
public class ReadDestinyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DestinyDao destinyDao = new DestinyDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		request.setAttribute("arrDestinys", this.destinyDao.getAllDestinys());
		
		RequestDispatcher rd = request.getRequestDispatcher("listDestinations.jsp");
		
		rd.forward(request, response);		
	}
}