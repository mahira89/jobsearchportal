<%@ page import="java.sql.*" %>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/", "ROOT", "ROOT@123");
    
    // Create database if not exists
    Statement stmt = conn.createStatement();
    stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS jobportal");
    stmt.executeUpdate("USE jobportal");
    
    // Create users table
    String createTableSQL = "CREATE TABLE IF NOT EXISTS users (" +
        "id INT AUTO_INCREMENT PRIMARY KEY, " +
        "fullname VARCHAR(100) NOT NULL, " +
        "email VARCHAR(100) UNIQUE NOT NULL, " +
        "username VARCHAR(50) UNIQUE NOT NULL, " +
        "password VARCHAR(255) NOT NULL, " +
        "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
        ")";
    stmt.executeUpdate(createTableSQL);
    
    out.println("<h3> Database Setup Complete!</h3>");
    out.println("<p>Database 'jobportal' and table 'users' created successfully.</p>");
    
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("<h3> Database Setup Failed</h3>");
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
%>