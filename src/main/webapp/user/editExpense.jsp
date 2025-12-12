<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page import="model.Expense" %>
<%@ page import="dao.ExpenseDao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Expense</title>
    <%@include file="../components/all_css_js.jsp" %>
    <style>
        .card-sh {
            box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body class="bg-light">

<!-- Redirect if not logged in -->
<c:if test="${empty sessionScope.user}">
    <c:redirect url="../login.jsp"/>
</c:if>

<%@include file="../components/navbar.jsp" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = DBConnection.getConnection();
    Expense ex = ExpenseDao.getExpenseById(conn, id);
%>

<div class="container pt-4 mt-4">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card card-sh">
                <div class="card-header text-center" style="background-color: #009933; color: white;">
                    <h4>Edit Expense</h4>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/updateExpense" method="post">
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" id="title" name="title" class="form-control" value="<%= ex.getTitle() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="date" class="form-label">Date</label>
                            <input type="date" id="date" name="date" class="form-control" value="<%= ex.getDate() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <input type="text" id="description" name="description" class="form-control" value="<%= ex.getDescription() %>">
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" id="price" name="price" class="form-control" value="<%= ex.getPrice() %>" min="0" step="0.01" required>
                        </div>

                        <input type="hidden" name="id" value="<%= ex.getId() %>">

                        <button type="submit" class="btn btn-success w-100">Update Expense</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
    