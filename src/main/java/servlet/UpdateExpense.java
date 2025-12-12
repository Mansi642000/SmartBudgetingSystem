package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

import dao.ExpenseDao;
import util.DBConnection;
import model.Expense;
import model.User;

@WebServlet("/updateExpense")
public class UpdateExpense extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String date = request.getParameter("date");
		String description = request.getParameter("description");
		String priceStr = request.getParameter("price");

		double price = 0.0;
		try {
			price = Double.parseDouble(priceStr);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			request.getSession().setAttribute("msg", "Invalid price format");
			response.sendRedirect("user/viewExpense.jsp");
			return;
		}

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
		    session.setAttribute("msg", "Session expired. Please login again.");
		    response.sendRedirect("login.jsp");
		    return;
		}


		Expense ex = new Expense();
		ex.setId(id);
		ex.setTitle(title);
		ex.setDate(date);
		ex.setDescription(description);
		ex.setPrice(price);
		ex.setUserId(user.getId()); // ✅ Extract user ID from User object

		try (Connection conn = DBConnection.getConnection()) {
			boolean success = ExpenseDao.updateExpense(conn, ex);

			if (success) {
				session.setAttribute("msg", "Expense updated successfully");
			} else {
				session.setAttribute("msg", "Failed to update expense");
			}
			response.sendRedirect("user/viewExpense.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("msg", "Server error");
			response.sendRedirect("user/viewExpense.jsp");
		}
	}
}
