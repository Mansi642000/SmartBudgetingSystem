<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../components/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prediction Chart</title>
    <%@include file="../components/all_css_js.jsp" %>
</head>
<body class="bg-dark text-white">
    <div class="container mt-5 text-center">
        <h3>Predicted Monthly Expense Chart</h3>

        <%
            String imagePath = "images/prediction.png";
            java.io.File chartFile = new java.io.File(application.getRealPath("/") + imagePath);
            if (chartFile.exists()) {
        %>
            <img 
                src="<%= request.getContextPath() %>/images/prediction.png?t=<%= System.currentTimeMillis() %>"
                alt="Prediction Chart" 
                class="img-fluid mt-3"
                style="max-width: 80%; height: auto;">
        <%
            } else {
        %>
            <p class="text-danger">Prediction chart not found. Please click the Predict button again.</p>
        <%
            }
        %>

        <%
            String month = (String) session.getAttribute("predictedMonth");
            String expense = (String) session.getAttribute("predictedExpense");

            if (month != null && expense != null) {
        %>
            <h4 class="text-success mt-4">
                Predicted expense for <%= month %> is ₹<%= expense %>
            </h4>
        <%
            }
        %>

        <a href="dashboard.jsp" class="btn btn-secondary mt-4">Back to Dashboard</a>
    </div>
</body>
</html>
