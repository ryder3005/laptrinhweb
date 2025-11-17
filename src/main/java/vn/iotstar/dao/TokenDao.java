package vn.iotstar.dao;

import java.time.LocalDateTime;

import vn.iotstar.model.Token;

public interface  TokenDao {

    boolean insertToken(String email, String token, LocalDateTime  expiryDate);
    Token getTokenByEmail(String email);
    boolean deleteTokenByEmail(String email);
}
