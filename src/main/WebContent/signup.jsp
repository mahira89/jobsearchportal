<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.servlet.http.*, javax.servlet.*, java.util.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up - Job Portal</title>
    <style>
        /* Mocha Color Theme */
        :root {
            --mocha-dark: #8B7355;
            --mocha-medium: #A78B6F;
            --mocha-light: #C4A484;
            --mocha-cream: #F5E6D3;
            --mocha-brown: #6F4E37;
        }
        
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, var(--mocha-cream) 0%, var(--mocha-light) 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(111, 78, 55, 0.2);
            width: 100%;
            max-width: 400px;
        }
        
        h1 {
            color: var(--mocha-brown);
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
        }
        
        .error { 
            color: #d32f2f;
            background: #ffebee; 
            padding: 12px;
            border: 1px solid #f44336;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .success { 
            color: #388e3c;
            background: #e8f5e9; 
            padding: 12px;
            border: 1px solid #4caf50;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        input { 
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        
        input:focus {
            outline: none;
            border-color: var(--mocha-medium);
            box-shadow: 0 0 0 3px rgba(167, 139, 111, 0.1);
        }
        
        button { 
            width: 100%;
            padding: 14px;
            background: var(--mocha-brown);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        button:hover {
            background: var(--mocha-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(111, 78, 55, 0.3);
        }
        
        .login-link {
            text-align: center;
            margin-top: 25px;
            color: var(--mocha-medium);
        }
        
        .login-link a {
            color: var(--mocha-brown);
            text-decoration: none;
            font-weight: 600;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .brand {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .brand span {
            color: var(--mocha-brown);
            font-size: 24px;
            font-weight: bold;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="brand">
            <span>☕ JobPortal</span>
        </div>
        
        <h1>Create Account</h1>
        
        <%-- Error and Success Messages --%>
        <%
        String error = request.getParameter("error");
        String message = request.getParameter("message");
        
        if (error != null) {
        %>
            <div class="error">
                <strong>⚠️</strong> <%= error %>
            </div>
        <%
        }
        
        if (message != null) {
        %>
            <div class="success">
                <strong>✅</strong> <%= message %>
            </div>
        <%
        }
        %>
        
        <form action="signupProcess.jsp" method="post">
            <div class="form-group">
                <input type="text" name="fullname" placeholder="Full Name" required>
            </div>
            
            <div class="form-group">
                <input type="email" name="email" placeholder="Email Address" required>
            </div>
            
            <div class="form-group">
                <input type="text" name="username" placeholder="Username" required>
            </div>
            
            <div class="form-group">
                <input type="password" name="password" placeholder="Password" required>
            </div>
            
            <button type="submit">Sign Up</button>
        </form>
        
        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>
</body>
</html>