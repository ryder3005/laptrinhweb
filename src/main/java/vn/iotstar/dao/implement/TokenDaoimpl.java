package vn.iotstar.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.model.Token;
public class TokenDaoimpl implements vn.iotstar.dao.TokenDao {
    public Connection conn=null;
    public PreparedStatement ps=null;
    public ResultSet rs=null;

    @Override
    public boolean insertToken(String email, String token, LocalDateTime expiryDate) {
        String query="INSERT INTO tokens (email, token, expiryTime, used) VALUES (?, ?, ?, ?)";
        try {
            conn=DBConnection.getDBConnection();
            ps=conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, token);
            ps.setObject(3, expiryDate);
            ps.setBoolean(4, false);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    @Override
    public Token getTokenByEmail(String email) {
        String query="SELECT * FROM tokens WHERE email = ?";
        try {
            conn=DBConnection.getDBConnection();
            ps=conn.prepareStatement(query);
            ps.setString(1, email);
            rs=ps.executeQuery();
            if (rs.next()) {
                String token=rs.getString("token");
                LocalDateTime expiryTime=rs.getObject("expiryTime", LocalDateTime.class);
                boolean used=rs.getBoolean("used");
                Token resetToken=new Token(token, email, expiryTime);
                resetToken.setUsed(used);
                return resetToken;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    @Override
    public boolean deleteTokenByEmail(String email) {
        String query = "DELETE FROM tokens WHERE email = ?";

        try (Connection conn = DBConnection.getDBConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace(); // log lỗi
            return false;
        }
    }
    

}
