package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.*;
import model.User;
import model.Expense;
import dao.ExpenseDao;
import util.DBConnection;
import java.sql.*;


@WebServlet("/saveExpense")
public class saveExpense extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
       // Expense.setUserId(user.getId());

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String title = request.getParameter("title");
            String date = request.getParameter("date");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));

            Expense expense = new Expense();
            expense.setTitle(title);
            expense.setDate(date);
            expense.setDescription(description);
            expense.setPrice(price);
            expense.setUserId(user.getId());
            
            Connection conn = DBConnection.getConnection();
            boolean status = ExpenseDao.saveExpense(conn, expense);

            if (status) {
                session.setAttribute("msg", "Expense added successfully!.");
            } else {
                session.setAttribute("msg", "Failed to add expense.");
            }

            response.sendRedirect("user/addExpense.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Something went wrong.");
            response.sendRedirect("user/addExpense.jsp");
        }

	}
}
