<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>MySQL Password Test</title>
    <style>
        body { font-family: Arial; margin: 40px; }
        .success { color: green; font-weight: bold; margin: 10px 0; }
        .error { color: red; margin: 5px 0; }
    </style>
</head>
<body>
    <h2> Testing MySQL Passwords</h2>
    
    <%
    String[] passwords = {"root@123", "root", "ROOT@123", "password", "1234", "admin"};
    
    for(String pwd : passwords) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", pwd);
    %>
            <div class="success"> SUCCESS! Password works: '<%= pwd %>'</div>
    <%
            conn.close();
            break;
        } catch (Exception e) {
    %>
            <div class="error"> FAILED: '<%= pwd %>' - <%= e.getMessage() %></div>
    <%
        }
    }
    %>
    
    <br>
    <a href="signup.jsp">← Back to Signup</a>
</body>
</html>