<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.servlet.http.*, java.util.*"%>
<%
String user = (String) session.getAttribute("user");
if(user == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Get user preferences from request parameters
String qualification = request.getParameter("qualification");
String experience = request.getParameter("experience");
String salary = request.getParameter("salary");
String[] sectors = request.getParameterValues("sectors");
String location = request.getParameter("location");
String skills = request.getParameter("skills");

// Store in session for future use
if(qualification != null) session.setAttribute("qualification", qualification);
if(experience != null) session.setAttribute("experience", experience);
if(sectors != null) session.setAttribute("sectors", sectors);
if(location != null) session.setAttribute("location", location);

// If no preferences selected, redirect to preferences page
if(qualification == null && experience == null) {
    response.sendRedirect("jobPreferences.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Recommended Jobs For You</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #8B7355 0%, #A52A2A 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(139, 115, 85, 0.2);
            backdrop-filter: blur(10px);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #eee;
        }
        .header h1 {
            color: #5D4037;
            font-size: 2.2rem;
        }
        .nav-links a {
            color: #8B7355;
            text-decoration: none;
            margin-left: 20px;
            font-weight: 600;
        }
        .nav-links a:hover {
            color: #A52A2A;
            text-decoration: underline;
        }
        .preference-summary {
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin: 25px 0;
            box-shadow: 0 5px 15px rgba(139, 115, 85, 0.3);
        }
        .preference-summary h3 {
            margin-bottom: 15px;
            font-size: 1.3rem;
        }
        .preference-item {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 15px;
            border-radius: 20px;
            margin: 5px 10px 5px 0;
            font-size: 0.9rem;
        }
        .change-pref {
            display: inline-block;
            background: white;
            color: #8B7355;
            padding: 8px 20px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 600;
            margin-top: 15px;
            transition: all 0.3s ease;
        }
        .change-pref:hover {
            background: #8B7355;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(139, 115, 85, 0.3);
        }
        .job { 
            border: 1px solid #e0e0e0; 
            padding: 25px; 
            margin: 20px 0; 
            border-radius: 15px;
            background: white;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            position: relative;
        }
        .job:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            border-color: #8B7355;
        }
        .job h3 { 
            color: #5D4037; 
            margin-top: 0; 
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .match-badge { 
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            color: white; 
            padding: 4px 12px; 
            border-radius: 15px; 
            font-size: 0.8rem; 
            font-weight: 600;
        }
        .salary { 
            color: #27ae60; 
            font-weight: bold; 
            font-size: 1.1rem;
        }
        .location { 
            color: #7f8c8d; 
        }
        .job-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 15px 0;
        }
        .job-detail-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .job-detail-item i {
            color: #8B7355;
            width: 20px;
        }
        .no-jobs {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        .no-jobs i {
            font-size: 4rem;
            color: #bdc3c7;
            margin-bottom: 20px;
        }
        .apply-note {
            background: linear-gradient(135deg, #ffeaa7, #fdcb6e);
            color: #2d3436;
            padding: 15px;
            border-radius: 10px;
            margin: 15px 0;
            border-left: 4px solid #e17055;
        }
        .apply-note i {
            color: #e17055;
            margin-right: 10px;
        }
        .website-link {
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 10px;
            transition: all 0.3s ease;
        }
        .website-link:hover {
            background: linear-gradient(135deg, #7A6348, #8B4513);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(139, 115, 85, 0.4);
        }
        .sector-badge {
            background: linear-gradient(135deg, #8B7355, #A52A2A);
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-left: 10px;
        }
        .job-count {
            background: #8B7355;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            margin-left: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
    <h1>🎯 Recommended Jobs For You <span class="job-count" id="jobCount"></span></h1>
    <div class="nav-links">
        <a href="profile.jsp"><i class="fas fa-user"></i> Profile</a>
        <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div> 
        <div class="preference-summary">
            <h3><i class="fas fa-filter"></i> Your Job Preferences</h3>
            <% if(qualification != null) { %>
                <span class="preference-item"><i class="fas fa-graduation-cap"></i> <%= getQualificationText(qualification) %></span>
            <% } %>
            <% if(experience != null) { %>
                <span class="preference-item"><i class="fas fa-briefcase"></i> <%= getExperienceText(experience) %></span>
            <% } %>
            <% if(salary != null) { %>
                <span class="preference-item"><i class="fas fa-rupee-sign"></i> <%= getSalaryText(salary) %></span>
            <% } %>
            <% if(location != null && !location.equals("any")) { %>
                <span class="preference-item"><i class="fas fa-map-marker-alt"></i> <%= getLocationText(location) %></span>
            <% } %>
            <% if(sectors != null && sectors.length > 0) { %>
                <span class="preference-item"><i class="fas fa-industry"></i> <%= String.join(", ", sectors) %> Sector</span>
            <% } %>
            <br>
            <a href="jobPreferences.jsp" class="change-pref"><i class="fas fa-edit"></i> Change Preferences</a>
        </div>

        <div class="job-listings">
            <%
            // Get all jobs and filter them
            List<Map<String, String>> allJobs = getAllJobs();
            List<Map<String, String>> matchingJobs = new ArrayList<>();
            int totalMatches = 0;
            
            for(Map<String, String> job : allJobs) {
                if(isJobMatching(job, qualification, experience, salary, sectors, location, skills)) {
                    matchingJobs.add(job);
                    totalMatches++;
                }
            }
            
            if(totalMatches > 0) {
            %>
                <div style="margin-bottom: 20px; color: #5D4037;">
                    <h3><i class="fas fa-chart-line"></i> Found <%= totalMatches %> matching jobs for you</h3>
                </div>
                
                <div class="apply-note">
                    <i class="fas fa-info-circle"></i>
                    <strong>Note:</strong> This is a job search portal. To apply for any position, please visit the company's official website using the link provided below each job listing.
                </div>
            <%
                // Group jobs by sector for better organization
                Map<String, List<Map<String, String>>> jobsBySector = new HashMap<>();
                for(Map<String, String> job : matchingJobs) {
                    String sector = job.get("sector");
                    jobsBySector.computeIfAbsent(sector, k -> new ArrayList<>()).add(job);
                }
                
                // Display jobs by sector
                for(Map.Entry<String, List<Map<String, String>>> entry : jobsBySector.entrySet()) {
                    String sector = entry.getKey();
                    List<Map<String, String>> sectorJobs = entry.getValue();
            %>
                <div style="margin: 30px 0 20px 0; padding-bottom: 10px; border-bottom: 2px solid #8B7355;">
                    <h2 style="color: #5D4037; display: flex; align-items: center; gap: 10px;">
                        <i class="<%= getSectorIcon(sector) %>"></i>
                        <%= getSectorDisplayName(sector) %>
                        <span class="sector-badge"><%= sectorJobs.size() %> jobs</span>
                    </h2>
                </div>
                
                <%
                for(Map<String, String> job : sectorJobs) {
                %>
                <div class="job">
                    <h3>
                        <%= job.get("title") %> 
                        <span class="match-badge"><i class="fas fa-star"></i> PERFECT MATCH</span>
                    </h3>
                    <p style="font-size: 1.1rem; color: #34495e; margin-bottom: 10px;">
                        <i class="fas fa-building"></i> <strong><%= job.get("company") %></strong>
                    </p>
                    
                    <div class="job-details">
                        <div class="job-detail-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span class="location"><%= job.get("location") %></span>
                        </div>
                        <div class="job-detail-item">
                            <i class="fas fa-rupee-sign"></i>
                            <span class="salary"><%= job.get("salary") %></span>
                        </div>
                        <div class="job-detail-item">
                            <i class="fas fa-briefcase"></i>
                            <span><%= job.get("experience") %></span>
                        </div>
                        <div class="job-detail-item">
                            <i class="fas fa-industry"></i>
                            <span><%= getSectorDisplayName(job.get("sector")) %></span>
                        </div>
                    </div>
                    
                    <p style="margin: 15px 0;"><strong><i class="fas fa-tools"></i> Skills:</strong> <%= job.get("skills") %></p>
                    
                    <!-- Application Instructions -->
                    <div style="background: #f8f9fa; padding: 15px; border-radius: 10px; margin: 15px 0;">
                        <p style="margin: 0; color: #2c3e50; font-weight: 600;">
                            <i class="fas fa-external-link-alt"></i> How to Apply:
                        </p>
                        <p style="margin: 5px 0 0 0; color: #7f8c8d;">
                            Visit the company's career page to submit your application directly.
                        </p>
                    </div>
                    
                    <!-- Company Website Link -->
                    <a href="<%= job.get("website") %>" target="_blank" class="website-link">
                        <i class="fas fa-external-link-alt"></i> Apply on <%= job.get("company") %> Website
                    </a>
                </div>
                <%
                }
                }
            } else {
            %>
                <div class="no-jobs">
                    <i class="fas fa-search"></i>
                    <h2>No jobs match your current preferences</h2>
                    <p style="margin: 15px 0;">Try adjusting your criteria to see more opportunities</p>
                    <a href="jobPreferences.jsp" class="website-link" style="text-decoration: none;">
                        <i class="fas fa-sliders-h"></i> Adjust Preferences
                    </a>
                </div>
            <%
            }
            %>
        </div>
    </div>

    <script>
        // Update job count
        document.getElementById('jobCount').textContent = '<%= totalMatches %> Jobs';
    </script>
</body>
</html>

<%!
// Method to get all available jobs with company websites - COMPREHENSIVE LIST
public List<Map<String, String>> getAllJobs() {
    List<Map<String, String>> jobs = new ArrayList<>();
    
    // ========== IT & SOFTWARE JOBS ==========
    jobs.add(createJob("IT001", "Software Developer", "Infosys", "Bangalore, Karnataka", 
        "₹8,00,000 - ₹12,00,000", "2-4 years", "Java, Spring Boot, Microservices", "it", 
        "https://www.infosys.com/careers.html"));
    jobs.add(createJob("IT002", "Full Stack Developer", "TCS", "Hyderabad, Telangana", 
        "₹6,00,000 - ₹10,00,000", "1-3 years", "JavaScript, React, Node.js, MongoDB", "it", 
        "https://www.tcs.com/careers"));
    jobs.add(createJob("IT003", "Data Scientist", "Wipro", "Pune, Maharashtra", 
        "₹12,00,000 - ₹18,00,000", "3-5 years", "Python, Machine Learning, SQL", "it", 
        "https://careers.wipro.com/"));
    jobs.add(createJob("IT004", "Cloud Engineer", "Amazon India", "Bangalore, Karnataka", 
        "₹15,00,000 - ₹25,00,000", "3-6 years", "AWS, Azure, DevOps, Kubernetes", "it", 
        "https://www.amazon.jobs/"));
    jobs.add(createJob("IT005", "Mobile App Developer", "Flipkart", "Bangalore, Karnataka", 
        "₹9,00,000 - ₹14,00,000", "2-4 years", "Android, iOS, Kotlin, Swift", "it", 
        "https://www.flipkartcareers.com/"));
    jobs.add(createJob("IT006", "DevOps Engineer", "Microsoft India", "Hyderabad, Telangana", 
        "₹14,00,000 - ₹22,00,000", "3-5 years", "Docker, Jenkins, CI/CD, Linux", "it", 
        "https://careers.microsoft.com/"));
    jobs.add(createJob("IT007", "UI/UX Designer", "Adobe", "Noida, Uttar Pradesh", 
        "₹8,00,000 - ₹12,00,000", "2-4 years", "Figma, Sketch, Adobe XD, Prototyping", "it", 
        "https://www.adobe.com/careers.html"));
    jobs.add(createJob("IT008", "QA Engineer", "Cognizant", "Chennai, Tamil Nadu", 
        "₹5,00,000 - ₹8,00,000", "1-3 years", "Selenium, Testing, Automation", "it", 
        "https://www.cognizant.com/careers"));
    jobs.add(createJob("IT009", "System Administrator", "HCL Technologies", "Noida, Uttar Pradesh", 
        "₹4,00,000 - ₹7,00,000", "1-3 years", "Windows Server, Linux, Networking", "it", 
        "https://www.hcltech.com/careers"));
    jobs.add(createJob("IT010", "IT Support Specialist", "Tech Mahindra", "Pune, Maharashtra", 
        "₹3,00,000 - ₹5,00,000", "0-2 years", "Technical Support, Troubleshooting", "it", 
        "https://www.techmahindra.com/careers/"));
    
    // ========== FINANCE & BANKING JOBS ==========
    jobs.add(createJob("FB001", "Financial Analyst", "ICICI Bank", "Mumbai, Maharashtra", 
        "₹6,00,000 - ₹9,00,000", "2-4 years", "Financial Modeling, Excel, Accounting", "finance", 
        "https://www.icicicareers.com/"));
    jobs.add(createJob("FB002", "Investment Banker", "Goldman Sachs", "Bangalore, Karnataka", 
        "₹20,00,000 - ₹35,00,000", "4-7 years", "M&A, Capital Markets, Financial Analysis", "finance", 
        "https://www.goldmansachs.com/careers/"));
    jobs.add(createJob("FB003", "Bank Teller", "State Bank of India", "Delhi", 
        "₹3,00,000 - ₹4,50,000", "0-1 years", "Customer Service, Cash Handling", "finance", 
        "https://www.sbi.co.in/careers"));
    jobs.add(createJob("FB004", "Risk Analyst", "JP Morgan Chase", "Mumbai, Maharashtra", 
        "₹8,00,000 - ₹12,00,000", "2-4 years", "Risk Management, Compliance, Analytics", "finance", 
        "https://careers.jpmorgan.com/"));
    jobs.add(createJob("FB005", "Wealth Manager", "HDFC Bank", "Delhi", 
        "₹7,00,000 - ₹11,00,000", "3-5 years", "Investment Advisory, Client Management", "finance", 
        "https://www.hdfcbank.com/personal/careers"));
    
    // ========== MARKETING & SALES JOBS ==========
    jobs.add(createJob("MS001", "Digital Marketing Manager", "Hindustan Unilever", "Mumbai, Maharashtra", 
        "₹7,00,000 - ₹10,00,000", "3-5 years", "SEO, Social Media, Google Analytics", "marketing", 
        "https://www.unilever.com/careers/"));
    jobs.add(createJob("MS002", "Sales Executive", "Reliance Retail", "Chennai, Tamil Nadu", 
        "₹4,00,000 - ₹6,00,000 + Incentives", "1-2 years", "Communication, Negotiation, CRM", "sales", 
        "https://careers.ril.com/"));
    jobs.add(createJob("MS003", "Content Marketing Specialist", "Byju's", "Bangalore, Karnataka", 
        "₹5,00,000 - ₹8,00,000", "1-3 years", "Content Writing, SEO, Social Media", "marketing", 
        "https://byjus.com/careers/"));
    jobs.add(createJob("MS004", "Business Development Manager", "Ola Cabs", "Bangalore, Karnataka", 
        "₹8,00,000 - ₹12,00,000 + Commission", "3-5 years", "B2B Sales, Partnerships", "sales", 
        "https://www.olacabs.com/careers"));
    jobs.add(createJob("MS005", "Social Media Manager", "Nykaa", "Mumbai, Maharashtra", 
        "₹6,00,000 - ₹9,00,000", "2-4 years", "Instagram, Facebook, Content Strategy", "marketing", 
        "https://www.nykaa.com/careers"));
    
    // ========== HEALTHCARE JOBS ==========
    jobs.add(createJob("HC001", "Medical Representative", "Sun Pharma", "Ahmedabad, Gujarat", 
        "₹4,00,000 - ₹6,00,000", "1-3 years", "Pharma Knowledge, Sales, Communication", "healthcare", 
        "https://www.sunpharma.com/careers"));
    jobs.add(createJob("HC002", "Staff Nurse", "Apollo Hospitals", "Delhi", 
        "₹3,00,000 - ₹5,00,000", "1-2 years", "Patient Care, Nursing, Medical Knowledge", "healthcare", 
        "https://www.apollohospitals.com/careers/"));
    jobs.add(createJob("HC003", "Medical Coder", "Max Healthcare", "Delhi", 
        "₹3,50,000 - ₹5,50,000", "1-2 years", "Medical Coding, ICD-10, Healthcare", "healthcare", 
        "https://www.maxhealthcare.in/careers"));
    jobs.add(createJob("HC004", "Pharmacist", "Fortis Healthcare", "Mumbai, Maharashtra", 
        "₹3,00,000 - ₹4,50,000", "1-2 years", "Pharmacy, Medicine, Customer Service", "healthcare", 
        "https://www.fortishealthcare.com/careers"));
    
    // ========== ENGINEERING JOBS ==========
    jobs.add(createJob("EN001", "Mechanical Engineer", "Tata Motors", "Jamshedpur, Jharkhand", 
        "₹5,00,000 - ₹8,00,000", "2-4 years", "AutoCAD, SolidWorks, Manufacturing", "engineering", 
        "https://www.tatamotors.com/careers/"));
    jobs.add(createJob("EN002", "Civil Engineer", "L&T Construction", "Mumbai, Maharashtra", 
        "₹4,50,000 - ₹7,00,000", "2-5 years", "AutoCAD, Project Management, Construction", "engineering", 
        "https://www.larsentoubro.com/corporate/careers/"));
    jobs.add(createJob("EN003", "Electrical Engineer", "Siemens India", "Pune, Maharashtra", 
        "₹6,00,000 - ₹9,00,000", "2-4 years", "Electrical Systems, PLC, Automation", "engineering", 
        "https://new.siemens.com/global/en/company/jobs.html"));
    jobs.add(createJob("EN004", "Chemical Engineer", "Reliance Industries", "Jamnagar, Gujarat", 
        "₹7,00,000 - ₹10,00,000", "3-5 years", "Process Engineering, Chemical Processes", "engineering", 
        "https://careers.ril.com/"));
    
    // ========== HR & RECRUITMENT JOBS ==========
    jobs.add(createJob("HR001", "HR Recruiter", "Tech Mahindra", "Noida, Uttar Pradesh", 
        "₹4,00,000 - ₹6,00,000", "1-3 years", "Recruitment, Interviewing, HRMS", "hr", 
        "https://www.techmahindra.com/careers/"));
    jobs.add(createJob("HR002", "HR Manager", "Infosys", "Bangalore, Karnataka", 
        "₹8,00,000 - ₹12,00,000", "4-6 years", "Employee Relations, HR Policies", "hr", 
        "https://www.infosys.com/careers.html"));
    
    // ========== CUSTOMER SERVICE JOBS ==========
    jobs.add(createJob("CS001", "Customer Support Executive", "Amazon India", "Work From Home", 
        "₹2,50,000 - ₹4,00,000", "Freshers can apply", "Communication, Customer Service, English", "customer", 
        "https://www.amazon.jobs/"));
    jobs.add(createJob("CS002", "Call Center Representative", "Concentrix", "Gurgaon, Haryana", 
        "₹2,20,000 - ₹3,50,000", "0-1 years", "Call Handling, Customer Support", "customer", 
        "https://www.concentrix.com/careers/"));
    
    // ========== EDUCATION & TRAINING JOBS ==========
    jobs.add(createJob("ED001", "School Teacher", "Delhi Public School", "Delhi", 
        "₹4,00,000 - ₹6,00,000", "1-3 years", "Teaching, Lesson Planning, Student Management", "education", 
        "https://www.dps.edu/careers"));
    jobs.add(createJob("ED002", "Professor", "IIT Delhi", "Delhi", 
        "₹12,00,000 - ₹18,00,000", "5+ years", "Research, Teaching, Publications", "education", 
        "https://home.iitd.ac.in/jobs.php"));
    
    // ========== RETAIL JOBS ==========
    jobs.add(createJob("RT001", "Store Manager", "Big Bazaar", "Mumbai, Maharashtra", 
        "₹5,00,000 - ₹7,00,000", "3-5 years", "Retail Management, Inventory, Team Handling", "retail", 
        "https://careers.futuregroup.in/"));
    jobs.add(createJob("RT002", "Sales Associate", "Shoppers Stop", "Bangalore, Karnataka", 
        "₹2,50,000 - ₹3,50,000", "0-1 years", "Customer Service, Sales, Product Knowledge", "retail", 
        "https://www.shoppersstop.com/careers"));
    
    // ========== HOSPITALITY JOBS ==========
    jobs.add(createJob("HO001", "Hotel Manager", "Taj Hotels", "Mumbai, Maharashtra", 
        "₹8,00,000 - ₹12,00,000", "4-6 years", "Hotel Operations, Guest Services", "hospitality", 
        "https://careers.tajhotels.com/"));
    jobs.add(createJob("HO002", "Chef", "Oberoi Hotels", "Delhi", 
        "₹6,00,000 - ₹9,00,000", "3-5 years", "Culinary Skills, Menu Planning", "hospitality", 
        "https://www.oberoihotels.com/careers/"));
    
    // ========== MANUFACTURING JOBS ==========
    jobs.add(createJob("MF001", "Production Supervisor", "Maruti Suzuki", "Gurgaon, Haryana", 
        "₹5,00,000 - ₹7,00,000", "2-4 years", "Production Planning, Quality Control", "manufacturing", 
        "https://www.marutisuzuki.com/careers"));
    jobs.add(createJob("MF002", "Quality Assurance Manager", "Asian Paints", "Mumbai, Maharashtra", 
        "₹7,00,000 - ₹10,00,000", "4-6 years", "Quality Control, Six Sigma, ISO", "manufacturing", 
        "https://www.asianpaints.com/careers"));
    
    // ========== MEDIA & ENTERTAINMENT JOBS ==========
    jobs.add(createJob("ME001", "Video Editor", "TVF", "Mumbai, Maharashtra", 
        "₹4,00,000 - ₹6,00,000", "1-3 years", "Premiere Pro, After Effects, Video Editing", "media", 
        "https://tvfplay.com/careers"));
    jobs.add(createJob("ME002", "Journalist", "Times of India", "Delhi", 
        "₹5,00,000 - ₹8,00,000", "2-4 years", "Writing, Reporting, News Gathering", "media", 
        "https://timesofindia.indiatimes.com/careers"));
    
    return jobs;
}

// Helper method to create job map with website
public Map<String, String> createJob(String id, String title, String company, String location, 
                                   String salary, String experience, String skills, String sector, String website) {
    Map<String, String> job = new HashMap<>();
    job.put("id", id);
    job.put("title", title);
    job.put("company", company);
    job.put("location", location);
    job.put("salary", salary);
    job.put("experience", experience);
    job.put("skills", skills);
    job.put("sector", sector);
    job.put("website", website);
    return job;
}

// Method to check if job matches user preferences
public boolean isJobMatching(Map<String, String> job, String qualification, String experience, 
                           String salary, String[] sectors, String location, String skills) {
    boolean matches = true;
    
    // Location filter
    if(location != null && !location.equals("any")) {
        if(location.equals("remote")) {
            matches = job.get("location").toLowerCase().contains("work from home") || 
                     job.get("location").toLowerCase().contains("remote");
        } else {
            matches = job.get("location").toLowerCase().contains(location.toLowerCase());
        }
    }
    
    // Sector filter
    if(sectors != null && sectors.length > 0) {
        boolean sectorMatch = false;
        for(String sector : sectors) {
            if(job.get("sector").equalsIgnoreCase(sector)) {
                sectorMatch = true;
                break;
            }
        }
        matches = matches && sectorMatch;
    }
    
    return matches;
}

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

public String getSalaryText(String sal) {
    Map<String, String> salMap = new HashMap<>();
    salMap.put("0-3", "0-3 Lakhs");
    salMap.put("3-6", "3-6 Lakhs");
    salMap.put("6-10", "6-10 Lakhs");
    salMap.put("10-15", "10-15 Lakhs");
    salMap.put("15-25", "15-25 Lakhs");
    salMap.put("25+", "25+ Lakhs");
    return salMap.getOrDefault(sal, sal);
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

public String getSectorIcon(String sector) {
    Map<String, String> iconMap = new HashMap<>();
    iconMap.put("it", "fas fa-laptop-code");
    iconMap.put("finance", "fas fa-chart-line");
    iconMap.put("marketing", "fas fa-bullhorn");
    iconMap.put("sales", "fas fa-handshake");
    iconMap.put("healthcare", "fas fa-heartbeat");
    iconMap.put("engineering", "fas fa-cogs");
    iconMap.put("hr", "fas fa-users");
    iconMap.put("customer", "fas fa-headset");
    iconMap.put("education", "fas fa-graduation-cap");
    iconMap.put("retail", "fas fa-shopping-bag");
    iconMap.put("hospitality", "fas fa-hotel");
    iconMap.put("manufacturing", "fas fa-industry");
    iconMap.put("media", "fas fa-film");
    return iconMap.getOrDefault(sector, "fas fa-briefcase");
}

public String getSectorDisplayName(String sector) {
    Map<String, String> nameMap = new HashMap<>();
    nameMap.put("it", "IT & Software");
    nameMap.put("finance", "Finance & Banking");
    nameMap.put("marketing", "Marketing");
    nameMap.put("sales", "Sales");
    nameMap.put("healthcare", "Healthcare");
    nameMap.put("engineering", "Engineering");
    nameMap.put("hr", "HR & Recruitment");
    nameMap.put("customer", "Customer Service");
    nameMap.put("education", "Education & Training");
    nameMap.put("retail", "Retail");
    nameMap.put("hospitality", "Hospitality");
    nameMap.put("manufacturing", "Manufacturing");
    nameMap.put("media", "Media & Entertainment");
    return nameMap.getOrDefault(sector, sector);
}
%>