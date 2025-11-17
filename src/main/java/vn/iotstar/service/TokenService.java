package vn.iotstar.service;

import java.time.LocalDateTime;

import vn.iotstar.model.Token;

public interface TokenService {
    void saveResetToken(String email, String token, LocalDateTime expiryDate);
    Token getResetTokenByEmail(String email);
    boolean deleteResetTokenByEmail(String email);
}
