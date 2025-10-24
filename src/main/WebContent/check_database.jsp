<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Database Setup</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 40px; 
            background: #f5f5f5;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 800px;
        }
        .success { 
            color: #2ecc71; 
            background: #e8f8ef;
            padding: 15px;
            border: 1px solid #2ecc71;
            border-radius: 5px;
            margin: 10px 0;
        }
        .error { 
            color: #e74c3c; 
            background: #fdeaea;
            padding: 15px;
            border: 1px solid #e74c3c;
            border-radius: 5px;
            margin: 10px 0;
        }
        .info { 
            color: #3498db; 
            background: #e8f4fc;
            padding: 15px;
            border: 1px solid #3498db;
            border-radius: 5px;
            margin: 10px 0;
        }
        .button {
            display: inline-block;
            padding: 12px 24px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin: 10px 5px;
        }
        .button:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔧 Database Setup Check</h1>
        <%
        Connection conn = null;
        Statement stmt = null;
        
        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Connect to MySQL server (without specifying database)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/", "root", "ROOT@123");
            out.println("<div class='success'>✅ Connected to MySQL server successfully!</div>");
            
            stmt = conn.createStatement();
            
            // Check if database exists
            ResultSet rs = stmt.executeQuery("SHOW DATABASES LIKE 'jobportal'");
            
            if(rs.next()) {
                out.println("<div class='success'>✅ Database 'jobportal' exists</div>");
                
                // Switch to jobportal database
                stmt.execute("USE jobportal");
                
                // Check if users table exists
                rs = stmt.executeQuery("SHOW TABLES LIKE 'users'");
                if(rs.next()) {
                    out.println("<div class='success'>✅ Table 'users' exists</div>");
                    
                    // Show table structure
                    out.println("<div class='info'><strong>Table Structure:</strong><br>");
                    ResultSet columns = conn.getMetaData().getColumns(null, null, "users", null);
                    while(columns.next()) {
                        out.println("• " + columns.getString("COLUMN_NAME") + " - " + columns.getString("TYPE_NAME") + "<br>");
                    }
                    out.println("</div>");
                    
                } else {
                    out.println("<div class='error'>❌ Table 'users' does NOT exist</div>");
                    out.println("<div class='info'>Creating 'users' table...</div>");
                    
                    // Create the users table
                    String createTableSQL = "CREATE TABLE users (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY, " +
                        "fullname VARCHAR(100) NOT NULL, " +
                        "email VARCHAR(100) UNIQUE NOT NULL, " +
                        "username VARCHAR(50) UNIQUE NOT NULL, " +
                        "password VARCHAR(255) NOT NULL, " +
                        "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")";
                    
                    stmt.executeUpdate(createTableSQL);
                    out.println("<div class='success'>✅ Table 'users' created successfully!</div>");
                }
                
            } else {
                out.println("<div class='error'>❌ Database 'jobportal' does NOT exist</div>");
                out.println("<div class='info'>Creating database and table...</div>");
                
                // Create database
                stmt.executeUpdate("CREATE DATABASE jobportal");
                out.println("<div class='success'>✅ Database 'jobportal' created successfully!</div>");
                
                // Use the new database
                stmt.execute("USE jobportal");
                
                // Create users table
                String createTableSQL = "CREATE TABLE users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "fullname VARCHAR(100) NOT NULL, " +
                    "email VARCHAR(100) UNIQUE NOT NULL, " +
                    "username VARCHAR(50) UNIQUE NOT NULL, " +
                    "password VARCHAR(255) NOT NULL, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                ")";
                
                stmt.executeUpdate(createTableSQL);
                out.println("<div class='success'>✅ Table 'users' created successfully!</div>");
            }
            
            // Test insert
            out.println("<div class='info'>Testing database operations...</div>");
            try {
                String testInsert = "INSERT INTO users (fullname, email, username, password) VALUES (?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(testInsert);
                pstmt.setString(1, "Test User");
                pstmt.setString(2, "test@example.com");
                pstmt.setString(3, "testuser");
                pstmt.setString(4, "testpass");
                pstmt.executeUpdate();
                out.println("<div class='success'>✅ Test data inserted successfully!</div>");
                
                // Clean up test data
                stmt.execute("DELETE FROM users WHERE username = 'testuser'");
                out.println("<div class='info'>Test data cleaned up</div>");
                
            } catch (SQLException e) {
                out.println("<div class='error'>❌ Test insert failed: " + e.getMessage() + "</div>");
            }
            
        } catch (ClassNotFoundException e) {
            out.println("<div class='error'>❌ MySQL JDBC Driver not found: " + e.getMessage() + "</div>");
        } catch (SQLException e) {
            out.println("<div class='error'>❌ Database error: " + e.getMessage() + "</div>");
        } catch (Exception e) {
            out.println("<div class='error'>❌ Unexpected error: " + e.getMessage() + "</div>");
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<div class='error'>Error closing resources: " + e.getMessage() + "</div>");
            }
        }
        %>
        
        <br>
        <div style="margin-top: 20px;">
            <a href="signup.jsp" class="button">🚀 Test Signup Now</a>
            <a href="login.jsp" class="button">🔐 Go to Login</a>
        </div>
    </div>
</body>
</html>