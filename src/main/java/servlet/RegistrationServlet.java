package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import dao.UserDao;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		 User u = new User();
	        u.setName(request.getParameter("name"));
	        u.setEmail(request.getParameter("email"));
	        u.setPassword(request.getParameter("password"));

	        if (UserDao.registerUser(u)) {
	            response.sendRedirect("login.jsp");
	        } else {
	            response.getWriter().print("Registration Failed");
	        }
	
	 if (UserDao.isUserExists(u.getEmail())) {
	    response.getWriter().print("User already exists with this email.");
	 } else if (UserDao.registerUser(u)) {
	    response.sendRedirect("login.jsp");
	 } else {
	    response.getWriter().print("Registration Failed");
	 }
	}
}