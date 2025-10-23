<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.servlet.http.*"%>
<%
// Check if user is already logged in
String user = (String) session.getAttribute("user");
if(user != null) {
    response.sendRedirect("profile.jsp");
    return;
}

// Check for error messages
String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - JobSearchPortal</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #8B7355 0%, #A52A2A 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(139, 115, 85, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(139, 115, 85, 0.2);
        }

        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .logo i {
            font-size: 3rem;
            color: #8B7355;
        }

        .logo h1 {
            color: #5D4037;
            font-size: 2.2rem;
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .welcome-text {
            color: #6D4C41;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .subtitle {
            color: #8D6E63;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #5D4037;
            font-weight: 600;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .input-with-icon {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #8D6E63;
            font-size: 1.1rem;
        }

        input {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #D7CCC8;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: white;
            font-family: inherit;
        }

        input:focus {
            outline: none;
            border-color: #8B7355;
            box-shadow: 0 0 0 3px rgba(139, 115, 85, 0.1);
            transform: translateY(-2px);
        }

        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            color: white;
            padding: 16px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #7A6348, #8B4513);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(139, 115, 85, 0.4);
        }

        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
            color: #8D6E63;
            font-size: 0.9rem;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #D7CCC8;
        }

        .divider span {
            background: white;
            padding: 0 15px;
            position: relative;
        }

        .signup-section {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #D7CCC8;
        }

        .signup-text {
            color: #8D6E63;
            margin-bottom: 15px;
            font-size: 0.95rem;
        }

        .btn-signup {
            background: linear-gradient(135deg, #795548, #6D4C41);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .btn-signup:hover {
            background: linear-gradient(135deg, #6D4C41, #5D4037);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(121, 85, 72, 0.4);
            text-decoration: none;
            color: white;
        }

        .error-message {
            background: linear-gradient(135deg, #D84315, #BF360C);
            color: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
            display: <%= error != null ? "block" : "none" %>;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid #D7CCC8;
        }

        .feature {
            text-align: center;
            padding: 15px;
            background: rgba(139, 115, 85, 0.1);
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .feature:hover {
            background: rgba(139, 115, 85, 0.2);
            transform: translateY(-2px);
        }

        .feature i {
            font-size: 1.5rem;
            color: #8B7355;
            margin-bottom: 8px;
        }

        .feature-text {
            font-size: 0.8rem;
            color: #5D4037;
            font-weight: 500;
        }

        @media (max-width: 480px) {
            .login-card {
                padding: 30px 25px;
            }
            
            .features {
                grid-template-columns: 1fr;
            }
            
            .logo {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <!-- Logo Section -->
            <div class="logo-section">
                <div class="logo">
                    <i class="fas fa-briefcase"></i>
                    <h1>JobSearchPortal</h1>
                </div>
                <div class="welcome-text">Welcome Back!</div>
                <div class="subtitle">Sign in to your account to continue your job search</div>
            </div>

            <!-- Error Message -->
            <% if(error != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i>
                Invalid username or password. Please try again.
            </div>
            <% } %>

            <!-- Login Form -->
            <form action="loginProcess.jsp" method="post">
                <div class="form-group">
                    <label for="username">
                        <i class="fas fa-user"></i> Username
                    </label>
                    <div class="input-with-icon">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" id="username" name="username" required 
                               placeholder="Enter your username">
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" required 
                               placeholder="Enter your password">
                    </div>
                </div>

                <button type="submit" class="btn-login">
                    <i class="fas fa-sign-in-alt"></i> Sign In
                </button>
            </form>

            <!-- Features -->
            <div class="features">
                <div class="feature">
                    <i class="fas fa-search"></i>
                    <div class="feature-text">Smart Job Matching</div>
                </div>
                <div class="feature">
                    <i class="fas fa-briefcase"></i>
                    <div class="feature-text">40+ Job Categories</div>
                </div>
                <div class="feature">
                    <i class="fas fa-building"></i>
                    <div class="feature-text">Top Companies</div>
                </div>
                <div class="feature">
                    <i class="fas fa-rupee-sign"></i>
                    <div class="feature-text">Best Salaries</div>
                </div>
            </div>

            <!-- Sign Up Section -->
            <div class="signup-section">
                <div class="signup-text">Don't have an account?</div>
                <a href="signup.jsp" class="btn-signup">
                    <i class="fas fa-user-plus"></i> Create Account
                </a>
            </div>
        </div>
    </div>

    <script>
        // Add some interactive animations
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'translateY(-2px)';
                });
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'translateY(0)';
                });
            });

            // Add fade-in animation to card
            const card = document.querySelector('.login-card');
            card.style.animation = 'fadeInUp 0.6s ease-out forwards';
        });

        // Add CSS for fade-in animation
        const style = document.createElement('style');
        style.textContent = `
            .login-card {
                opacity: 0;
                transform: translateY(30px);
            }
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>