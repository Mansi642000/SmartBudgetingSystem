<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
	<%@include file="components/all_css_js.jsp"%>
	<style type="text/css">
            .card-sh{
                box-shadow: 0 0 6px 0 rgba(0,0,0,0.3);
            }
        </style>
</head>
<body class="bg-light">
	<%@include file="components/navbar.jsp"%>
	<div class="container p-5">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card card-sh">
                        <div class="card-body">
                            <p class="text-center fs-5">Register Page</p>
                             <form action="RegistrationServlet" method="post">
                                <div class="mb-3">
                                    <label>Enter Full Name</label>
                                    <input type="text" name="name" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label>Email</label>
                                    <input type="email" name="email" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label>Password</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                               <button class="btn btn-primary col-md-12">Register</button>
                               <div class="text-center mt-2">
                                    Already have an account? <a href="login.jsp" class="text-decoration-none">Login</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>   
</body>
</html>