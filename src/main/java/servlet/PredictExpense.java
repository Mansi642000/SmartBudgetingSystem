package servlet;

import jakarta.servlet.ServletException;
import java.io.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/predictExpense")
public class PredictExpense extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			ProcessBuilder pb = new ProcessBuilder(
				"C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python312\\python.exe",
				"C:\\Users\\hp\\Downloads\\SmartBudgetPython\\predictexpense.py"
			);
			pb.redirectErrorStream(true);
			Process process = pb.start();

			BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String predictedValue = null;
			String line;
			while ((line = reader.readLine()) != null) {
				System.out.println("PYTHON: " + line);
				predictedValue = line; 
			}

			int exitCode = process.waitFor();
			if (exitCode == 0) {
				System.out.println(" Python script executed successfully.");
			} else {
				System.out.println(" Python script failed with code: " + exitCode);
			}

			// Store prediction in session
			if (predictedValue != null) {
				String[] parts = predictedValue.split(",");
				if (parts.length == 2) {
					request.getSession().setAttribute("predictedMonth", parts[0]);
					request.getSession().setAttribute("predictedExpense", parts[1]);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		response.sendRedirect(request.getContextPath() + "/user/predictexpense.jsp");
	}
}
