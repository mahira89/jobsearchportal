package com.jobportal.beans;

import java.util.Date;

public class User {
    private int id;
    private String email;
    private String password;
    private String userType;
    private Date createdAt;
    
    // Constructors
    public User() {}
    
    public User(String email, String password, String userType) {
        this.email = email;
        this.password = password;
        this.userType = userType;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}