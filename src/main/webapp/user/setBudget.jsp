<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Budget" %>
<%@ page import="model.User" %>
<%@ page import="dao.BudgetDao" %>
<%@ page import="util.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Set Monthly Budget</title>
    <%@ include file="../components/all_css_js.jsp" %>
</head>
<body>
<%@ include file="../components/navbar.jsp" %>

<%
    User user = (User) session.getAttribute("user");
    java.time.LocalDate today = java.time.LocalDate.now();
    String currentMonth = today.getMonth().toString().substring(0,1) + today.getMonth().toString().substring(1).toLowerCase();
    int currentYear = today.getYear();
    Budget currentBudget = null;

    try (Connection conn = DBConnection.getConnection()) {
        currentBudget = BudgetDao.getCurrentMonthBudget(conn, user.getId(), currentMonth, currentYear);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-header bg-success text-white text-center">
                    <h4>Set Monthly Budget</h4>
                </div>
                <div class="card-body">

                    <% if (currentBudget != null) { %>
                        <div class="alert alert-info">
                            Current Budget for <%= currentBudget.getMonth() %> <%= currentBudget.getYear() %>: ₹<%= currentBudget.getAmount() %>
                        </div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/setBudget" method="post">
                        <label>Month:</label>
                        <select name="month" class="form-control" required>
                            <option>--Select--</option><option>January</option> <option>February</option> <option>March</option>
                            <option>April</option> <option>May</option> <option>June</option>
                            <option>July</option> <option>August</option> <option>September</option>
                            <option>October</option> <option>November</option> <option>December</option>
                        </select>

                        <label>Year:</label>
                        <input type="number" name="year" class="form-control" value="<%= currentYear %>" required />

                        <label>Budget Amount (₹):</label>
                        <input type="number" name="amount" class="form-control" step="0.01" min="0" required />

                        <button type="submit" class="btn btn-success mt-3 w-100">Set Budget</button>
                    </form>

                    <c:if test="${not empty sessionScope.msg}">
                        <div class="alert alert-success mt-3">${sessionScope.msg}</div>
                        <c:remove var="msg" scope="session"/>
                    </c:if>
   				</div>
  			 </div>
 		 </div>
  	 </div>  
  </div>
 </body>
  </html>               
