package com.jobportal.beans;

import java.util.Date;

public class Job {
    private int id;
    private String title;
    private String description;
    private String company;
    private String location;
    private String salary;
    private String jobType;
    private String requiredSkills;
    private String requiredQualifications;
    private String requiredExperience;
    private Date postedDate;
    private Date expiryDate;
    private int employerId;
    
    // Constructors
    public Job() {}
    
    public Job(String title, String description, String company, String location) {
        this.title = title;
        this.description = description;
        this.company = company;
        this.location = location;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public String getSalary() { return salary; }
    public void setSalary(String salary) { this.salary = salary; }
    
    public String getJobType() { return jobType; }
    public void setJobType(String jobType) { this.jobType = jobType; }
    
    public String getRequiredSkills() { return requiredSkills; }
    public void setRequiredSkills(String requiredSkills) { this.requiredSkills = requiredSkills; }
    
    public String getRequiredQualifications() { return requiredQualifications; }
    public void setRequiredQualifications(String requiredQualifications) { this.requiredQualifications = requiredQualifications; }
    
    public String getRequiredExperience() { return requiredExperience; }
    public void setRequiredExperience(String requiredExperience) { this.requiredExperience = requiredExperience; }
    
    public Date getPostedDate() { return postedDate; }
    public void setPostedDate(Date postedDate) { this.postedDate = postedDate; }
    
    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }
    
    public int getEmployerId() { return employerId; }
    public void setEmployerId(int employerId) { this.employerId = employerId; }
}