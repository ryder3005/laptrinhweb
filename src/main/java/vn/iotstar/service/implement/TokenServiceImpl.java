package vn.iotstar.service.implement;

import java.time.LocalDateTime;

import vn.iotstar.dao.TokenDao;
import vn.iotstar.dao.implement.TokenDaoimpl;
import vn.iotstar.model.Token;
import vn.iotstar.service.TokenService;

public class TokenServiceImpl implements TokenService {
    TokenDao tokendao=new TokenDaoimpl();
    @Override
    public void saveResetToken(String email, String token, LocalDateTime expiryDate) {
        tokendao.insertToken(email, token, expiryDate);
    }
    @Override
    public Token getResetTokenByEmail(String email) {
        return tokendao.getTokenByEmail(email);
    }
    @Override
    public boolean deleteResetTokenByEmail(String email) {
        return tokendao.deleteTokenByEmail(email);
    }
    

}
