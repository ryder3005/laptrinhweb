package vn.iotstar.service.implement;

import vn.iotstar.dao.TokenDao;
import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.implement.TokenDaoimpl;
import vn.iotstar.dao.implement.UserDaoImpl;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;

public class UserServiceImpl implements UserService {
    UserDao userDao=new UserDaoImpl();
    TokenDao tokenDao=new TokenDaoimpl();
    User user=null;

    @Override
    public User login(String email, String password) {
        User user= userDao.get(email);
        if (user!=null && password.equals(user.getPassWord())){
            this.user=user;
            return user;
        }
        return null;
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public boolean register(String username, String password, String email, String
            fullname, String phone ) {
        if (userDao.checkExistUsername(username)){
            return false;
        }
        long milis=System.currentTimeMillis();
        java.sql.Date date=new java.sql.Date(milis);
        userDao.insert(new User(email, username, fullname,password,null,5,phone,date));

        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);

    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);

    }

    @Override
    public User get() {
        return this.user;
    }
    @Override
    public boolean changePassword(String email, String newPassword) {
        return userDao.changePassword(email, newPassword);
    }
    @Override
    public boolean saveResetToken(String email, String token) {
        return false;
    }
    @Override
    public boolean sendResetPasswordEmail(String email, String resetLink) {
        String subject = "Đặt lại mật khẩu";
        String content = "Nhấp vào liên kết sau để đặt lại mật khẩu của bạn: " + resetLink;

        return false;
    }
}
