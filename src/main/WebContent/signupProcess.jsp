<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.servlet.http.*, javax.servlet.*, java.util.*, java.io.*"%>
<%
// Your signup processing logic here
String fullname = request.getParameter("fullname");
String email = request.getParameter("email");
String username = request.getParameter("username");
String password = request.getParameter("password");

// Add your user registration logic
// response.sendRedirect("login.jsp");
%>