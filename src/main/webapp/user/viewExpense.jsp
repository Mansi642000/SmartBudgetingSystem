<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="model.Expense" %>
<%@ page import="dao.ExpenseDao" %>
<%@ page import="util.DBConnection" %>
<%@ page import="model.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Expenses</title>
    <%@ include file="../components/all_css_js.jsp" %>
    <style>
        .card-sh {
            box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body class="bg-light">

    <!-- Navbar -->
    <%@ include file="../components/navbar.jsp" %>

    <!-- Session Check -->
    <c:if test="${empty sessionScope.user}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%
        User user = (User) session.getAttribute("user");
        List<Expense> expenses = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            expenses = ExpenseDao.getAllExpensesByUserId(conn, user.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("expenses", expenses);
    %>

    <div class="container pt-4 mt-4">
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <div class="card card-sh">
                    <div class="card-header text-center text-white" style="background-color: green;">
                        <h4>All Expenses</h4>
                        <c:if test="${not empty sessionScope.msg}">
                            <div class="alert alert-info mt-2">${sessionScope.msg}</div>
                            <c:remove var="msg" scope="session" />
                        </c:if>
                    </div>

                    <div class="card-body">
                        <c:if test="${not empty expenses}">
                            <table class="table table-bordered table-striped">
                                <thead class="table-success">
                                    <tr>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Date</th>
                                        <th>Price (₹)</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="ex" items="${expenses}">
                                        <tr>
                                            <td>${ex.title}</td>
                                            <td>${ex.description}</td>
                                            <td>${ex.date}</td>
                                            <td>${ex.price}</td>
                                            <td>
                                                <a href="editExpense.jsp?id=${ex.id}" class="btn btn-sm btn-primary me-1">Edit</a>
                                                <a href="${pageContext.request.contextPath}/deleteExpense?id=${ex.id}" class="btn btn-sm btn-danger"
                                                   onclick="return confirm('Are you sure you want to delete this expense?');">
                                                    Delete
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${empty expenses}">
                            <div class="text-center text-muted">No expenses found.</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
    