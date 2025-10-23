<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.servlet.http.*, java.util.*, java.io.*"%>
<%
String user = (String) session.getAttribute("user");
if(user == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Get user preferences from session
String qualification = (String) session.getAttribute("qualification");
String experience = (String) session.getAttribute("experience");
String[] sectors = (String[]) session.getAttribute("sectors");
String location = (String) session.getAttribute("location");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - JobSearchPortal</title>
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

        .profile-container {
            max-width: 1200px;
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

        .user-menu {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-info {
            text-align: right;
        }

        .user-name {
            font-weight: 600;
            color: #5D4037;
            font-size: 1.1rem;
        }

        .user-role {
            color: #8D6E63;
            font-size: 0.9rem;
        }

        .logout-btn {
            background: linear-gradient(135deg, #D84315, #BF360C);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(216, 67, 21, 0.4);
        }

        .welcome-section {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(139, 115, 85, 0.2);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, #8B7355, #A52A2A);
        }

        .welcome-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
            color: white;
        }

        .welcome-section h2 {
            color: #5D4037;
            font-size: 2.2rem;
            margin-bottom: 10px;
        }

        .welcome-section p {
            color: #8D6E63;
            font-size: 1.1rem;
            margin-bottom: 20px;
        }

        .highlight {
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
        }

        .main-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(139, 115, 85, 0.2);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(139, 115, 85, 0.3);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #D7CCC8;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .card-header h3 {
            color: #5D4037;
            font-size: 1.4rem;
            margin: 0;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-bottom: 25px;
        }

        .stat-item {
            background: linear-gradient(135deg, #A1887F, #8D6E63);
            color: white;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(141, 110, 99, 0.4);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .preference-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 15px 0;
            padding: 15px;
            background: rgba(139, 115, 85, 0.1);
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .preference-item:hover {
            background: rgba(139, 115, 85, 0.2);
            transform: translateX(5px);
        }

        .preference-item i {
            color: #8B7355;
            width: 20px;
        }

        .preference-value {
            color: #5D4037;
            font-weight: 500;
        }

        .no-preference {
            color: #8D6E63;
            font-style: italic;
            text-align: center;
            padding: 20px;
        }

        .action-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-top: 20px;
        }

        .action-card {
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            color: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(139, 115, 85, 0.3);
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(139, 115, 85, 0.4);
            text-decoration: none;
            color: white;
        }

        .action-card.secondary {
            background: linear-gradient(135deg, #795548, #6D4C41);
            box-shadow: 0 5px 15px rgba(121, 85, 72, 0.3);
        }

        .action-card.secondary:hover {
            box-shadow: 0 10px 25px rgba(121, 85, 72, 0.4);
        }

        .action-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .action-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .action-description {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .quick-actions {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(139, 115, 85, 0.2);
            backdrop-filter: blur(10px);
            margin-bottom: 30px;
        }

        .quick-actions h3 {
            color: #5D4037;
            margin-bottom: 20px;
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .quick-btn {
            background: rgba(139, 115, 85, 0.1);
            color: #8B7355;
            padding: 15px;
            border: 2px solid rgba(139, 115, 85, 0.2);
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            justify-content: center;
        }

        .quick-btn:hover {
            background: #8B7355;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(139, 115, 85, 0.3);
        }

        .recent-activity {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(139, 115, 85, 0.2);
            backdrop-filter: blur(10px);
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            margin: 10px 0;
            background: rgba(139, 115, 85, 0.05);
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .activity-item:hover {
            background: rgba(139, 115, 85, 0.1);
            transform: translateX(5px);
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1rem;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: #5D4037;
            margin-bottom: 5px;
        }

        .activity-description {
            color: #8D6E63;
            font-size: 0.9rem;
        }

        .activity-time {
            color: #A1887F;
            font-size: 0.8rem;
        }

        @media (max-width: 768px) {
            .main-content {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .action-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                grid-template-columns: 1fr;
            }
            
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .user-menu {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <!-- Header -->
        <div class="header">
            <div class="logo">
                <i class="fas fa-briefcase"></i>
                <h1>JobSearchPortal</h1>
            </div>
            <div class="user-menu">
                <div class="user-info">
                    <div class="user-name"><%= user %></div>
                    <div class="user-role">Job Seeker</div>
                </div>
                <a href="logout.jsp" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-icon">
                <i class="fas fa-user-check"></i>
            </div>
            <h2>Welcome back, <span class="highlight"><%= user %>!</span> 👋</h2>
            <p>Ready to discover your next career opportunity? Let's find the perfect match for you!</p>
        </div>

        <!-- Main Content Grid -->
        <div class="main-content">
            <!-- Profile Stats Card -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3>Profile Overview</h3>
                </div>
                
                <div class="stats-grid">
                    <div class="stat-item">
                        <div class="stat-number">40+</div>
                        <div class="stat-label">Jobs Available</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">12</div>
                        <div class="stat-label">Job Categories</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">100%</div>
                        <div class="stat-label">Profile Complete</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">5</div>
                        <div class="stat-label">Perfect Matches</div>
                    </div>
                </div>

                <!-- Action Grid -->
                <div class="action-grid">
                    <a href="jobPreferences.jsp" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-bullseye"></i>
                        </div>
                        <div class="action-title">Smart Job Match</div>
                        <div class="action-description">Find jobs matching your profile</div>
                    </a>
                    
                    <a href="jobs.jsp" class="action-card secondary">
                        <div class="action-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <div class="action-title">Browse All Jobs</div>
                        <div class="action-description">Explore all opportunities</div>
                    </a>
                </div>
            </div>

            <!-- Job Preferences Card -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-sliders-h"></i>
                    </div>
                    <h3>Your Job Preferences</h3>
                </div>
                
                <% if(qualification != null || experience != null || sectors != null || location != null) { %>
                    <% if(qualification != null) { %>
                    <div class="preference-item">
                        <i class="fas fa-graduation-cap"></i>
                        <div class="preference-value"><strong>Qualification:</strong> <%= getQualificationText(qualification) %></div>
                    </div>
                    <% } %>
                    
                    <% if(experience != null) { %>
                    <div class="preference-item">
                        <i class="fas fa-briefcase"></i>
                        <div class="preference-value"><strong>Experience:</strong> <%= getExperienceText(experience) %></div>
                    </div>
                    <% } %>
                    
                    <% if(location != null && !location.equals("any")) { %>
                    <div class="preference-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <div class="preference-value"><strong>Location:</strong> <%= getLocationText(location) %></div>
                    </div>
                    <% } %>
                    
                    <% if(sectors != null && sectors.length > 0) { %>
                    <div class="preference-item">
                        <i class="fas fa-industry"></i>
                        <div class="preference-value"><strong>Sectors:</strong> <%= String.join(", ", sectors) %></div>
                    </div>
                    <% } %>
                <% } else { %>
                    <div class="no-preference">
                        <i class="fas fa-sliders-h" style="font-size: 2rem; margin-bottom: 10px; color: #A1887F;"></i>
                        <p>No preferences set yet</p>
                        <p style="font-size: 0.9rem; margin-top: 5px;">Set your preferences to get personalized job recommendations</p>
                    </div>
                <% } %>
                
                <div style="margin-top: 25px; text-align: center;">
                    <a href="jobPreferences.jsp" class="quick-btn" style="display: inline-flex; width: auto; padding: 12px 25px;">
                        <i class="fas fa-edit"></i> 
                        <%= (qualification != null || experience != null) ? "Update Preferences" : "Set Preferences" %>
                    </a>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
            <div class="action-buttons">
                <a href="jobPreferences.jsp" class="quick-btn">
                    <i class="fas fa-user-cog"></i> Update Preferences
                </a>
                <a href="jobs.jsp" class="quick-btn">
                    <i class="fas fa-search"></i> Browse Jobs
                </a>
                <a href="#" class="quick-btn">
                    <i class="fas fa-bookmark"></i> Saved Jobs
                </a>
                <a href="#" class="quick-btn">
                    <i class="fas fa-bell"></i> Job Alerts
                </a>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="recent-activity">
            <div class="card-header">
                <div class="card-icon">
                    <i class="fas fa-history"></i>
                </div>
                <h3>Recent Activity</h3>
            </div>
            
            <div class="activity-item">
                <div class="activity-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-title">Profile Created</div>
                    <div class="activity-description">Welcome to JobSearchPortal! Your journey begins here.</div>
                </div>
                <div class="activity-time">Just now</div>
            </div>
            
            <% if(qualification != null || experience != null) { %>
            <div class="activity-item">
                <div class="activity-icon">
                    <i class="fas fa-sliders-h"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-title">Preferences Updated</div>
                    <div class="activity-description">Your job preferences have been set for better matching.</div>
                </div>
                <div class="activity-time">Recently</div>
            </div>
            <% } %>
            
            <div class="activity-item">
                <div class="activity-icon">
                    <i class="fas fa-search"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-title">Ready to Explore</div>
                    <div class="activity-description">Start browsing jobs that match your profile and preferences.</div>
                </div>
                <div class="activity-time">Today</div>
            </div>
        </div>
    </div>

    <script>
        // Add some interactive animations
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
                card.classList.add('fade-in');
            });
        });

        // Add CSS for fade-in animation
        const style = document.createElement('style');
        style.textContent = `
            .fade-in {
                animation: fadeInUp 0.6s ease-out forwards;
                opacity: 0;
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

<%!
// Helper methods for display
public String getQualificationText(String qual) {
    Map<String, String> qualMap = new HashMap<>();
    qualMap.put("btech", "B.Tech/B.E.");
    qualMap.put("mtech", "M.Tech/M.E.");
    qualMap.put("bca", "BCA");
    qualMap.put("mca", "MCA");
    qualMap.put("bsc", "B.Sc");
    qualMap.put("msc", "M.Sc");
    qualMap.put("bba", "BBA");
    qualMap.put("mba", "MBA");
    qualMap.put("ba", "B.A.");
    qualMap.put("ma", "M.A.");
    qualMap.put("phd", "Ph.D");
    qualMap.put("diploma", "Diploma");
    qualMap.put("other", "Other");
    return qualMap.getOrDefault(qual, qual);
}

public String getExperienceText(String exp) {
    Map<String, String> expMap = new HashMap<>();
    expMap.put("fresher", "Fresher (0 years)");
    expMap.put("1-2", "1-2 years");
    expMap.put("2-4", "2-4 years");
    expMap.put("4-6", "4-6 years");
    expMap.put("6-10", "6-10 years");
    expMap.put("10+", "10+ years");
    return expMap.getOrDefault(exp, exp);
}

public String getLocationText(String loc) {
    Map<String, String> locMap = new HashMap<>();
    locMap.put("bangalore", "Bangalore");
    locMap.put("hyderabad", "Hyderabad");
    locMap.put("pune", "Pune");
    locMap.put("mumbai", "Mumbai");
    locMap.put("delhi", "Delhi/NCR");
    locMap.put("chennai", "Chennai");
    locMap.put("kolkata", "Kolkata");
    locMap.put("ahmedabad", "Ahmedabad");
    locMap.put("remote", "Work From Home");
    locMap.put("any", "Any Location");
    return locMap.getOrDefault(loc, loc);
}
%>