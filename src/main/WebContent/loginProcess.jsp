<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.servlet.http.*, javax.servlet.*, java.util.*, java.io.*"%>
<%
// Prevent any HTML output that could break redirect
out.clear();
response.setContentType("text/plain");

System.out.println("=== LOGIN PROCESS STARTED ===");

String username = request.getParameter("username");
String password = request.getParameter("password");

System.out.println("Username: " + username);
System.out.println("Password: " + password);

// Simple authentication
if(username != null && password != null && !username.trim().isEmpty()) {
    System.out.println("Login SUCCESS - redirecting to profile");
    session.setAttribute("user", username);
    response.sendRedirect("profile.jsp");
    return; // Important: stop further execution
} else {
    System.out.println("Login FAILED - redirecting back to login");
    response.sendRedirect("login.jsp?error=1");
    return; // Important: stop further execution
}
%>