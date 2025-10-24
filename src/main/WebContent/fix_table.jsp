<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fix Users Table</title>
    <style>
        body { font-family: Arial; margin: 40px; background: #f0f8ff; }
        .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .success { color: green; background: #e8f8ef; padding: 15px; border: 1px solid green; border-radius: 5px; margin: 10px 0; }
        .error { color: red; background: #fdeaea; padding: 15px; border: 1px solid red; border-radius: 5px; margin: 10px 0; }
        .info { color: blue; background: #e8f4fc; padding: 15px; border: 1px solid blue; border-radius: 5px; margin: 10px 0; }
        .button { display: inline-block; padding: 12px 24px; background: #007bff; color: white; text-decoration: none; border-radius: 5px; margin: 10px 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔧 Fix Users Table Structure</h1>
        
        <%
        Connection conn = null;
        Statement stmt = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal", "root", "ROOT@123");
            stmt = conn.createStatement();
            
            out.println("<div class='success'>✅ Connected to database</div>");
            
            // First, disable foreign key checks
            stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 0");
            out.println("<div class='info'>🔓 Foreign key checks disabled</div>");
            
            // Check what tables depend on users table
            out.println("<div class='info'>Checking dependent tables...</div>");
            
            // Store dependent tables in a list first
            java.util.List<String> dependentTables = new java.util.ArrayList<>();
            ResultSet fkRs = stmt.executeQuery(
                "SELECT TABLE_NAME " +
                "FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE " +
                "WHERE REFERENCED_TABLE_NAME = 'users' AND REFERENCED_TABLE_SCHEMA = 'jobportal'"
            );
            
            while(fkRs.next()) {
                String tableName = fkRs.getString("TABLE_NAME");
                dependentTables.add(tableName);
                out.println("<div class='info'>Found dependent table: " + tableName + "</div>");
            }
            fkRs.close();
            
            if (!dependentTables.isEmpty()) {
                out.println("<div class='info'>Dropping dependent tables first...</div>");
                // Drop tables that reference users
                for(String tableName : dependentTables) {
                    try {
                        stmt.executeUpdate("DROP TABLE IF EXISTS " + tableName);
                        out.println("<div class='success'>✅ Dropped table: " + tableName + "</div>");
                    } catch (Exception e) {
                        out.println("<div class='error'>❌ Failed to drop " + tableName + ": " + e.getMessage() + "</div>");
                    }
                }
            }
            
            // Now drop the users table
            stmt.executeUpdate("DROP TABLE IF EXISTS users");
            out.println("<div class='success'>✅ Users table dropped</div>");
            
            // Re-enable foreign key checks
            stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 1");
            out.println("<div class='info'>🔒 Foreign key checks re-enabled</div>");
            
            // Create new table with correct structure
            String createTableSQL = "CREATE TABLE users (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "fullname VARCHAR(100) NOT NULL, " +
                "email VARCHAR(100) UNIQUE NOT NULL, " +
                "username VARCHAR(50) UNIQUE NOT NULL, " +
                "password VARCHAR(255) NOT NULL, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
            ")";
            
            stmt.executeUpdate(createTableSQL);
            out.println("<div class='success'>✅ New users table created with correct structure!</div>");
            
            // Show the new structure
            out.println("<h3>New Table Structure:</h3>");
            ResultSet rs = stmt.executeQuery("DESCRIBE users");
            out.println("<table border='1' style='border-collapse: collapse; width: 100%;'>");
            out.println("<tr><th>Field</th><th>Type</th><th>Null</th><th>Key</th></tr>");
            while(rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("Field") + "</td>");
                out.println("<td>" + rs.getString("Type") + "</td>");
                out.println("<td>" + rs.getString("Null") + "</td>");
                out.println("<td>" + rs.getString("Key") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            rs.close();
            
            // Test insert
            out.println("<div style='margin-top: 20px;'>");
            String testSQL = "INSERT INTO users (fullname, email, username, password) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(testSQL);
            pstmt.setString(1, "John Doe");
            pstmt.setString(2, "john@example.com");
            pstmt.setString(3, "johndoe");
            pstmt.setString(4, "password123");
            pstmt.executeUpdate();
            out.println("<div class='success'>✅ Test data inserted successfully!</div>");
            pstmt.close();
            out.println("</div>");
            
        } catch (Exception e) {
            out.println("<div class='error'>❌ Error: " + e.getMessage() + "</div>");
            e.printStackTrace();
            // Make sure to re-enable foreign key checks even if error occurs
            try {
                if (stmt != null) stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 1");
            } catch (Exception e2) {}
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<div class='error'>Error closing: " + e.getMessage() + "</div>");
            }
        }
        %>
        
        <br>
        <div style="margin-top: 20px;">
            <a href="signup.jsp" class="button">🚀 Test Signup Now</a>
            <a href="check_database.jsp" class="button">📊 Check Database</a>
        </div>
    </div>
</body>
</html>