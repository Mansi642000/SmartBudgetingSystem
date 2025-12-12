<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Expense</title>
    <%@include file="../components/all_css_js.jsp"%>
    <style type="text/css">
        .card-sh {
            box-shadow: 0 0 6px 0 rgba(0,0,0,0.3);
        }
    </style>
</head>
<body class="bg-light">

    <!-- Redirect to login if user is not logged in -->
    <c:if test="${empty sessionScope.user}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%@include file="../components/navbar.jsp"%>

    <div class="container pt-4 mt-4">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card card-sh">
                    <div class="card-header text-center" style="background-color: #009933; color: #ffffff">
                        <h4 class="mb-0">Add Expense</h4>
                        <c:if test="${not empty sessionScope.msg}">
                            <div class="alert alert-success mt-2 mb-0">${sessionScope.msg}</div>
                            <c:remove var="msg" scope="session"/>
                        </c:if>
                    </div>
                    <div class="card-body">
                        <form action="../saveExpense" method="post">
                            <div class="mb-3">
                                <label for="title" class="form-label">Title</label>
                                <input type="text" name="title" id="title" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="date" class="form-label">Date</label>
                                <input type="date" name="date" id="date" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <input type="text" name="description" id="description" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">Price</label>
                                <input type="number" name="price" id="price" class="form-control" min="0" step="0.01" required>
                            </div>
                            <button type="submit" class="btn btn-success w-100">Add</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
