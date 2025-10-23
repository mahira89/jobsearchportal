<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.servlet.http.*"%>
<%
String user = (String) session.getAttribute("user");
if(user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Preferences - JobSearchPortal</title>
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
            padding: 20px;
        }

        .preferences-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 255, 255, 0.95);
            padding: 20px 30px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(139, 115, 85, 0.2);
            backdrop-filter: blur(10px);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo i {
            font-size: 2rem;
            color: #8B7355;
        }

        .logo h1 {
            color: #5D4037;
            font-size: 1.8rem;
        }

        .nav-links a {
            color: #8B7355;
            text-decoration: none;
            margin-left: 20px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            color: #A52A2A;
            transform: translateY(-2px);
        }

        .preferences-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(139, 115, 85, 0.2);
            backdrop-filter: blur(10px);
        }

        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .form-header h2 {
            color: #5D4037;
            font-size: 2.2rem;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .form-header p {
            color: #8D6E63;
            font-size: 1.1rem;
        }

        .info-section {
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(139, 115, 85, 0.3);
        }

        .info-section h3 {
            margin-bottom: 10px;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
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

        .required::after {
            content: " *";
            color: #D84315;
        }

        select, input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #D7CCC8;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: white;
            font-family: inherit;
        }

        select:focus, input:focus {
            outline: none;
            border-color: #8B7355;
            box-shadow: 0 0 0 3px rgba(139, 115, 85, 0.1);
            transform: translateY(-2px);
        }

        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 10px;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            background: rgba(139, 115, 85, 0.1);
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .checkbox-item:hover {
            background: rgba(139, 115, 85, 0.2);
            transform: translateY(-2px);
        }

        .checkbox-item input {
            width: auto;
            transform: scale(1.2);
        }

        .checkbox-item label {
            margin: 0;
            font-weight: 500;
            color: #5D4037;
            cursor: pointer;
        }

        .sector-icon {
            color: #8B7355;
            font-size: 1.2rem;
            width: 20px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid #D7CCC8;
        }

        .btn-primary {
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            color: white;
            padding: 16px 40px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #7A6348, #8B4513);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(139, 115, 85, 0.4);
        }

        .btn-secondary {
            background: rgba(139, 115, 85, 0.1);
            color: #8B7355;
            padding: 16px 30px;
            border: 2px solid #8B7355;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: #8B7355;
            color: white;
            transform: translateY(-2px);
        }

        .benefits {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
            padding: 25px;
            background: rgba(139, 115, 85, 0.05);
            border-radius: 15px;
        }

        .benefit {
            text-align: center;
            padding: 20px;
        }

        .benefit-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 1.5rem;
            color: white;
        }

        .benefit h4 {
            color: #5D4037;
            margin-bottom: 8px;
            font-size: 1.1rem;
        }

        .benefit p {
            color: #8D6E63;
            font-size: 0.9rem;
            line-height: 1.4;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .checkbox-group {
                grid-template-columns: 1fr;
            }
            
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="preferences-container">
        <!-- Header -->
        <div class="header">
            <div class="logo">
                <i class="fas fa-briefcase"></i>
                <h1>JobSearchPortal</h1>
            </div>
            <div class="nav-links">
                <a href="profile.jsp"><i class="fas fa-user"></i> Profile</a>
                <a href="jobs.jsp"><i class="fas fa-briefcase"></i> Browse Jobs</a>
                <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <!-- Preferences Form -->
        <div class="preferences-card">
            <div class="form-header">
                <h2>Tell Us Your Preferences</h2>
                <p>Help us find the perfect jobs matching your profile and interests</p>
            </div>

            <div class="info-section">
                <h3><i class="fas fa-lightbulb"></i> Smart Job Matching</h3>
                <p>Setting your preferences helps us recommend jobs that are the best fit for your skills, experience, and career goals. We'll show you the most relevant opportunities from our database of 40+ job categories.</p>
            </div>

            <form action="jobs.jsp" method="get">
                <div class="form-grid">
                    <!-- Qualification -->
                    <div class="form-group">
                        <label for="qualification" class="required">
                            <i class="fas fa-graduation-cap"></i> Highest Qualification
                        </label>
                        <select id="qualification" name="qualification" required>
                            <option value="">Select your qualification</option>
                            <option value="btech">B.Tech / B.E. (Engineering)</option>
                            <option value="mtech">M.Tech / M.E. (Engineering)</option>
                            <option value="bca">BCA (Computer Applications)</option>
                            <option value="mca">MCA (Computer Applications)</option>
                            <option value="bsc">B.Sc (Science)</option>
                            <option value="msc">M.Sc (Science)</option>
                            <option value="bcom">B.Com (Commerce)</option>
                            <option value="mcom">M.Com (Commerce)</option>
                            <option value="bba">BBA (Business Administration)</option>
                            <option value="mba">MBA (Business Administration)</option>
                            <option value="ba">B.A. (Arts)</option>
                            <option value="ma">M.A. (Arts)</option>
                            <option value="phd">Ph.D (Doctorate)</option>
                            <option value="diploma">Diploma</option>
                            <option value="other">Other</option>
                        </select>
                    </div>

                    <!-- Experience -->
                    <div class="form-group">
                        <label for="experience" class="required">
                            <i class="fas fa-briefcase"></i> Years of Experience
                        </label>
                        <select id="experience" name="experience" required>
                            <option value="">Select experience</option>
                            <option value="fresher">Fresher (0 years)</option>
                            <option value="1-2">1-2 years</option>
                            <option value="2-4">2-4 years</option>
                            <option value="4-6">4-6 years</option>
                            <option value="6-10">6-10 years</option>
                            <option value="10+">10+ years</option>
                        </select>
                    </div>

                    <!-- Expected Salary -->
                    <div class="form-group">
                        <label for="salary" class="required">
                            <i class="fas fa-rupee-sign"></i> Expected Salary (₹ per year)
                        </label>
                        <select id="salary" name="salary" required>
                            <option value="">Select expected salary</option>
                            <option value="0-3">0-3 Lakhs</option>
                            <option value="3-6">3-6 Lakhs</option>
                            <option value="6-10">6-10 Lakhs</option>
                            <option value="10-15">10-15 Lakhs</option>
                            <option value="15-25">15-25 Lakhs</option>
                            <option value="25+">25+ Lakhs</option>
                        </select>
                    </div>

                    <!-- Preferred Location -->
                    <div class="form-group">
                        <label for="location">
                            <i class="fas fa-map-marker-alt"></i> Preferred Location
                        </label>
                        <select id="location" name="location">
                            <option value="any">🌍 Any Location</option>
                            <option value="bangalore">📍 Bangalore</option>
                            <option value="hyderabad">📍 Hyderabad</option>
                            <option value="pune">📍 Pune</option>
                            <option value="mumbai">📍 Mumbai</option>
                            <option value="delhi">📍 Delhi/NCR</option>
                            <option value="chennai">📍 Chennai</option>
                            <option value="kolkata">📍 Kolkata</option>
                            <option value="ahmedabad">📍 Ahmedabad</option>
                            <option value="remote">🏠 Work From Home</option>
                        </select>
                    </div>
                </div>

                <!-- Job Sectors -->
                <div class="form-group full-width">
                    <label class="required">
                        <i class="fas fa-industry"></i> Preferred Job Sectors
                    </label>
                    <p style="color: #8D6E63; margin-bottom: 15px; font-size: 0.9rem;">
                        Select the sectors you're interested in (choose multiple):
                    </p>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="it" name="sectors" value="it">
                            <i class="fas fa-laptop-code sector-icon"></i>
                            <label for="it">IT & Software</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="finance" name="sectors" value="finance">
                            <i class="fas fa-chart-line sector-icon"></i>
                            <label for="finance">Finance & Banking</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="marketing" name="sectors" value="marketing">
                            <i class="fas fa-bullhorn sector-icon"></i>
                            <label for="marketing">Marketing</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="sales" name="sectors" value="sales">
                            <i class="fas fa-handshake sector-icon"></i>
                            <label for="sales">Sales</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="healthcare" name="sectors" value="healthcare">
                            <i class="fas fa-heartbeat sector-icon"></i>
                            <label for="healthcare">Healthcare</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="engineering" name="sectors" value="engineering">
                            <i class="fas fa-cogs sector-icon"></i>
                            <label for="engineering">Engineering</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="hr" name="sectors" value="hr">
                            <i class="fas fa-users sector-icon"></i>
                            <label for="hr">HR & Recruitment</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="customer" name="sectors" value="customer">
                            <i class="fas fa-headset sector-icon"></i>
                            <label for="customer">Customer Service</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="education" name="sectors" value="education">
                            <i class="fas fa-graduation-cap sector-icon"></i>
                            <label for="education">Education & Training</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="retail" name="sectors" value="retail">
                            <i class="fas fa-shopping-bag sector-icon"></i>
                            <label for="retail">Retail</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="manufacturing" name="sectors" value="manufacturing">
                            <i class="fas fa-industry sector-icon"></i>
                            <label for="manufacturing">Manufacturing</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="media" name="sectors" value="media">
                            <i class="fas fa-film sector-icon"></i>
                            <label for="media">Media & Entertainment</label>
                        </div>
                    </div>
                </div>

                <!-- Skills -->
                <div class="form-group full-width">
                    <label for="skills">
                        <i class="fas fa-tools"></i> Key Skills
                    </label>
                    <input type="text" id="skills" name="skills" 
                           placeholder="Enter your key skills separated by commas (e.g., Java, Marketing, Sales, Management)">
                </div>

                <div class="benefits">
                    <div class="benefit">
                        <div class="benefit-icon">
                            <i class="fas fa-bullseye"></i>
                        </div>
                        <h4>Personalized Matches</h4>
                        <p>Get job recommendations tailored to your specific profile and preferences</p>
                    </div>
                    <div class="benefit">
                        <div class="benefit-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h4>Save Time</h4>
                        <p>Focus on relevant opportunities instead of searching through hundreds of jobs</p>
                    </div>
                    <div class="benefit">
                        <div class="benefit-icon">
                            <i class="fas fa-bell"></i>
                        </div>
                        <h4>Smart Alerts</h4>
                        <p>Receive notifications when new jobs match your criteria</p>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="profile.jsp" class="btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Profile
                    </a>
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-search"></i> Find Matching Jobs
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const qualification = document.getElementById('qualification').value;
            const experience = document.getElementById('experience').value;
            const salary = document.getElementById('salary').value;
            const sectors = document.querySelectorAll('input[name="sectors"]:checked');
            
            if(!qualification || !experience || !salary) {
                alert('Please fill all required fields (Qualification, Experience, and Salary)');
                e.preventDefault();
                return;
            }
            
            if(sectors.length === 0) {
                alert('Please select at least one job sector');
                e.preventDefault();
                return;
            }
        });

        // Add interactive animations
        document.addEventListener('DOMContentLoaded', function() {
            const selects = document.querySelectorAll('select');
            const inputs = document.querySelectorAll('input[type="text"]');
            
            selects.forEach(select => {
                select.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'translateY(-2px)';
                });
                select.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'translateY(0)';
                });
            });
            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'translateY(-2px)';
                });
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'translateY(0)';
                });
            });
        });
    </script>
</body>
</html>