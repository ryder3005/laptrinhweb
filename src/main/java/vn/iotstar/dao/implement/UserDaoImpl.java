package vn.iotstar.dao.implement;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDaoImpl implements UserDao {
    public Connection conn=null;
    public PreparedStatement ps=null;
    public ResultSet rs=null;

    @Override
    public User get(String username) {
        String sql="select * from users where email=?";
        try {
            conn= DBConnection.getDBConnection();
            ps=conn.prepareStatement(sql);
            ps.setString(1, username);
            rs=ps.executeQuery();
            if(rs.next()){
                User user=new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("userName"));
                user.setFullName(rs.getString("fullName"));
                user.setPassWord(rs.getString("passWord"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleid(rs.getInt("roleid"));
                user.setPhone(rs.getString("phone"));
                user.setCreatedDate((Date) new java.sql.Date(rs.getTimestamp("createdDate").getTime()));
                return user;
            }

        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
