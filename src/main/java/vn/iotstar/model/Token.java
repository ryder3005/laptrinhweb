package vn.iotstar.model;

import java.time.LocalDateTime;

public class Token {
    private String token;
    private String email;
    private boolean used;
    private LocalDateTime expiryTime;
    public String getToken() {
        return token;
    }
    public boolean isUsed() {
        return used;
    }
    public void setUsed(boolean used) {
        this.used = used;
    }
    public void setToken(String token) {
        this.token = token;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public LocalDateTime getExpiryTime() {
        return expiryTime;
    }
    public void setExpiryTime(LocalDateTime expiryTime) {
        this.expiryTime = expiryTime;
    }
    public Token(String token, String email, LocalDateTime expiryTime) {
        this.token = token;
        this.email = email;
        this.expiryTime = expiryTime;
    }

}
