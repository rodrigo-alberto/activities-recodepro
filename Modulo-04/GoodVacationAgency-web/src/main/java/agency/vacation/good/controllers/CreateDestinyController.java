package agency.vacation.good.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import agency.vacation.good.daos.DestinyDao;
import agency.vacation.good.models.Destiny;

@WebServlet("/CreateDestinyController")
@MultipartConfig(maxFileSize = 16177216)
public class CreateDestinyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DestinyDao destinyDao = new DestinyDao();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Destiny destiny = new Destiny();
		Part part = request.getPart("image");

		destiny.setName(request.getParameter("nameDestiny"));
		destiny.setCity(request.getParameter("city"));
		
		this.destinyDao.createDestiny(destiny, part);
		response.sendRedirect("ReadDestinyController");
	}
}