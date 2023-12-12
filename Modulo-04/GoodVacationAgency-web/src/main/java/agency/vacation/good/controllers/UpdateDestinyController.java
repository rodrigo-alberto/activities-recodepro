package agency.vacation.good.controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import agency.vacation.good.daos.DestinyDao;
import agency.vacation.good.models.Destiny;

@WebServlet("/UpdateDestinyController")
@MultipartConfig(maxFileSize = 16177216)
public class UpdateDestinyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DestinyDao destinyDao = new DestinyDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Destiny selectedDestiny = this.destinyDao.getDestinyById(Integer.parseInt(request.getParameter("idDestiny")));

		request.setAttribute("selectedDestiny", selectedDestiny);
		
		RequestDispatcher rd = request.getRequestDispatcher("updateDestiny.jsp");
		rd.forward(request, response);		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Destiny destiny = new Destiny();
		Part part = request.getPart("image");
		
		destiny.setIdDestiny(Integer.parseInt(request.getParameter("idDestiny")));
		destiny.setName(request.getParameter("nameDestiny"));
		destiny.setCity(request.getParameter("city"));
		
		this.destinyDao.updateDestiny(destiny.getIdDestiny(), destiny, part);
		response.sendRedirect("ReadDestinyController");
	}
}