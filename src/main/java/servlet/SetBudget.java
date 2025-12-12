package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.*;
import java.sql.*;
import util.DBConnection;
import dao.BudgetDao;
@WebServlet(name = "setBudget", urlPatterns = { "/setBudget" })
public class SetBudget extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String month = request.getParameter("month");
        int year = Integer.parseInt(request.getParameter("year"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try (Connection conn = DBConnection.getConnection()) {
            Budget budget = new Budget();
            budget.setUserId(user.getId());
            budget.setMonth(month);
            budget.setYear(year);
            budget.setAmount(amount);

            boolean success = BudgetDao.setOrUpdateBudget(conn, budget);
            if (success) {
                session.setAttribute("msg", "Budget set successfully");
            } else {
                session.setAttribute("msg", "Failed to set budget");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Server error");
        }

        response.sendRedirect("user/setBudget.jsp");
	}
}
