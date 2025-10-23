package com.jobportal.beans;

public class JobSeeker {
    private int id;
    private int userId;
    private String fullName;
    private String phone;
    private String qualifications;
    private String experience;
    private String skills;
    private String resume;
    
    // Constructors
    public JobSeeker() {}
    
    public JobSeeker(int userId, String fullName) {
        this.userId = userId;
        this.fullName = fullName;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getQualifications() { return qualifications; }
    public void setQualifications(String qualifications) { this.qualifications = qualifications; }
    
    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }
    
    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }
    
    public String getResume() { return resume; }
    public void setResume(String resume) { this.resume = resume; }
}