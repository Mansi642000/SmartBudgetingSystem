<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ include file="../components/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <title>Smart Budgeting Dashboard</title>
  <%@include file="../components/all_css_js.jsp" %>
  <style>
    .dashboard-card {
        box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
        transition: 0.3s;
        max-width: 500px;
        margin: 0 auto;
    }
    .dashboard-card:hover {
        transform: scale(1.02);
    }
    .dashboard-container {
        margin-top: 40px;
    }
    .dashboard-row {
        margin-bottom: 25px;
    }
    .btn-full {
        width: 100%;
    }

  .dashboard-card .card-title {
    color: #000;
    font-weight: 600;
    font-size: 18px;
    margin-bottom: 10px;
  }
        
  </style>
</head>
<body class="bg-dark text-white">
  <div class="container dashboard-container">
    
    <div class="row dashboard-row">
      <div class="col-12">
        <div class="card dashboard-card text-center p-4">
          <h5 class="card-title"><i class="fa-solid fa-plus-circle"></i> Add Expense</h5>
          <a href="addExpense.jsp" class="btn btn-success mt-2 btn-full">Add Now</a>
        </div>
      </div>
    </div>

    <div class="row dashboard-row">
      <div class="col-12">
        <div class="card dashboard-card text-center p-4">
          <h5 class="card-title"><i class="fa-solid fa-pen-to-square"></i> Edit Expense</h5>
          <a href="viewExpense.jsp" class="btn btn-warning mt-2 btn-full">Manage</a>
        </div>
      </div>
    </div>

    <div class="row dashboard-row">
      <div class="col-12">
        <div class="card dashboard-card text-center p-4">
          <h5 class="card-title"><i class="fa-solid fa-coins"></i> Set Monthly Budget</h5>
          <a href="setBudget.jsp" class="btn btn-primary mt-2 btn-full">Set Budget</a>
        </div>
      </div>
    </div>

    <div class="row dashboard-row">
      <div class="col-12">
        <div class="card dashboard-card text-center p-4">
          <h5 class="card-title"><i class="fa-solid fa-chart-line"></i> View Report</h5>
          <a href="viewReport.jsp" class="btn btn-info mt-2 btn-full">View</a>
        </div>
      </div>
    </div>

    <div class="row dashboard-row">
      <div class="col-12">
        <div class="card dashboard-card text-center p-4">
          <h5 class="card-title"><i class="fa-solid fa-robot"></i> Predict Next Month's Expense</h5>
          <form action="<%=request.getContextPath()%>/predictExpense" method="post">
            <button type="submit" class="btn btn-dark mt-2 btn-full">Predict</button>
          </form>
        </div>
      </div>
    </div>

  </div>
</body>
</html>
