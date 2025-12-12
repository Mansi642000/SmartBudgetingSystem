<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    session.invalidate(); // Ends the session
    response.sendRedirect(request.getContextPath() + "/index.jsp"); // Redirect to index or login page
%>
    