package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBConnection;
import java.sql.*;
import dao.ExpenseDao;
import java.io.IOException;


@WebServlet("/deleteExpense")
public class DeleteExpense extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session=request.getSession();
		try {
			int id=Integer.parseInt(request.getParameter("id"));
			Connection conn=DBConnection.getConnection();
			boolean success=ExpenseDao.deleteExpenseById(conn,id);
			if(success) {
				session.setAttribute("msg", "Expense deleted successfully!");
			}else {
				session.setAttribute("msg", "Failed to delete expense");
			}		
		}catch(Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect("user/viewExpense.jsp");
	}
}
