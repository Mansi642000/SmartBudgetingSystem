<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.DBConnection" %>
<%@ page isELIgnored="false" %>
<%@ include file="../components/all_css_js.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<%
    User user = (User) session.getAttribute("user");

    java.time.LocalDate today = java.time.LocalDate.now();
    String currentMonth = today.getMonth().getDisplayName(java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH);
    int currentYear = today.getYear();

    // Get selected month/year or default to current
    String selectedMonth = request.getParameter("month") != null ? request.getParameter("month") : today.getMonth().getDisplayName(java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH);
    int selectedYear = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : currentYear;

    Budget currentBudget = null;
    List<Expense> expenseList = new ArrayList<>();
    double totalExpense = 0;
    Expense highestExpense = null;

    try (Connection conn = DBConnection.getConnection()) {
        currentBudget = BudgetDao.getCurrentMonthBudget(conn, user.getId(), selectedMonth, selectedYear);
        expenseList = ExpenseDao.getExpensesByMonth(conn, user.getId(), selectedMonth, selectedYear);
        
        for (Expense exp : expenseList) {
            totalExpense += exp.getPrice();
            if (highestExpense == null || exp.getPrice() > highestExpense.getPrice()) {
                highestExpense = exp;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    double remaining = currentBudget != null ? currentBudget.getAmount() - totalExpense : 0;
%>

<div class="container mt-4">
    <form method="get" class="mb-3 text-center">
        <label for="month">Month:</label>
        <select name="month" id="month" required>
            <% 
                String[] months = {"January", "February", "March", "April", "May", "June", 
                                   "July", "August", "September", "October", "November", "December"};
                for(String m : months) { 
            %>
                <option value="<%= m %>" <%= m.equals(selectedMonth) ? "selected" : "" %>><%= m %></option>
            <% } %>
        </select>

        <label for="year">Year:</label>
        <input type="number" name="year" id="year" value="<%= selectedYear %>" required style="width: 100px;">

        <button type="submit" class="btn btn-sm btn-primary">View</button>
    </form>

    <h3 class="text-center mb-4">Monthly Budget Report - <%= selectedMonth %> <%= selectedYear %></h3>

    <% if (currentBudget != null) { %>
        <div class="alert alert-info">Budget Set: ₹<%= currentBudget.getAmount() %></div>
        <div class="alert alert-warning">Total Expenses: ₹<%= totalExpense %></div>
        <div class="alert alert-success">Remaining Budget: ₹<%= remaining %></div>
    <% } else { %>
        <div class="alert alert-danger">No budget set for this month.</div>
    <% } %>

    <% if (!expenseList.isEmpty()) { %>
        <h5>Expenses This Month:</h5>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Amount (₹)</th>
                </tr>
            </thead>
            <tbody>
                <% for (Expense e : expenseList) { %>
                    <tr>
                        <td><%= e.getTitle() %></td>
                        <td><%= e.getDescription() %></td>
                        <td><%= e.getDate() %></td>
                        <td><%= e.getPrice() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <% if (highestExpense != null) { %>
            <div class="alert alert-primary">
                <strong>Highest Expense:</strong> <%= highestExpense.getTitle() %> - ₹<%= highestExpense.getPrice() %>
            </div>
        <% } %>
    <% } else if (currentBudget != null) { %>
        <p>No expenses added yet for this month.</p>
    <% } %>
</div>
