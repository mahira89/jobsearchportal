<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
// Database connection parameters
String DB_URL = "jdbc:mysql://localhost:3306/jobportal";
String DB_USER = "root";
String DB_PASSWORD = "ROOT@123";

// Get form data
String fullname = request.getParameter("fullname");
String email = request.getParameter("email");
String username = request.getParameter("username");
String password = request.getParameter("password");

// Debug output
System.out.println("=== ☕ SIGNUP PROCESS STARTED ===");
System.out.println("Fullname: " + fullname);
System.out.println("Email: " + email);
System.out.println("Username: " + username);

// Validate form data
if (fullname == null || fullname.trim().isEmpty() ||
    email == null || email.trim().isEmpty() ||
    username == null || username.trim().isEmpty() ||
    password == null || password.trim().isEmpty()) {
    
    System.out.println("❌ Form validation failed - missing fields");
    response.sendRedirect("signup.jsp?error=Please+fill+all+required+fields");
    return;
}

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    // Load JDBC driver
    System.out.println("📦 Loading JDBC Driver...");
    Class.forName("com.mysql.cj.jdbc.Driver");
    
    // Create connection
    System.out.println("🔗 Connecting to database...");
    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    System.out.println("✅ Database connected successfully!");
    
    // Check if user already exists
    System.out.println("🔍 Checking if user exists...");
    String checkSQL = "SELECT id FROM users WHERE username = ? OR email = ?";
    pstmt = conn.prepareStatement(checkSQL);
    pstmt.setString(1, username);
    pstmt.setString(2, email);
    rs = pstmt.executeQuery();
    
    if (rs.next()) {
        System.out.println("❌ User already exists in database");
        response.sendRedirect("signup.jsp?error=Username+or+Email+already+exists");
        return;
    }
    
    // Close previous statement
    pstmt.close();
    
    // Insert new user
    System.out.println("👤 Creating new user...");
    String insertSQL = "INSERT INTO users (fullname, email, username, password) VALUES (?, ?, ?, ?)";
    pstmt = conn.prepareStatement(insertSQL);
    pstmt.setString(1, fullname.trim());
    pstmt.setString(2, email.trim());
    pstmt.setString(3, username.trim());
    pstmt.setString(4, password.trim()); // In production, hash this password!
    
    int rows = pstmt.executeUpdate();
    System.out.println("📊 Rows affected: " + rows);
    
    if (rows > 0) {
        System.out.println("✅ User created successfully! Redirecting to login...");
        response.sendRedirect("login.jsp?message=Account+created+successfully!+Please+login.");
    } else {
        System.out.println("❌ Registration failed - no rows affected");
        response.sendRedirect("signup.jsp?error=Registration+failed+please+try+again");
    }
    
} catch (ClassNotFoundException e) {
    System.out.println("❌ JDBC Driver not found: " + e.getMessage());
    response.sendRedirect("signup.jsp?error=Database+driver+not+found");
} catch (SQLException e) {
    System.out.println("❌ Database error: " + e.getMessage());
    System.out.println("SQL State: " + e.getSQLState());
    System.out.println("Error Code: " + e.getErrorCode());
    
    // More specific error messages
    String errorMsg = "Database+error";
    if (e.getMessage().contains("Access denied")) {
        errorMsg = "Database+access+denied+check+credentials";
    } else if (e.getMessage().contains("Unknown database")) {
        errorMsg = "Database+not+found+create+database+first";
    } else if (e.getMessage().contains("Table") && e.getMessage().contains("doesn't exist")) {
        errorMsg = "Users+table+not+found+create+table+first";
    }
    
    response.sendRedirect("signup.jsp?error=" + errorMsg);
} catch (Exception e) {
    System.out.println("❌ Unexpected error: " + e.getMessage());
    e.printStackTrace();
    response.sendRedirect("signup.jsp?error=Unexpected+error+please+try+again");
} finally {
    // Close resources properly
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
        System.out.println("🔒 Database resources closed");
    } catch (SQLException e) {
        System.out.println("⚠️ Error closing resources: " + e.getMessage());
    }
    System.out.println("=== ☕ SIGNUP PROCESS COMPLETED ===\n");
}
%>