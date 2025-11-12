package vn.iotstar.service.implement;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.implement.UserDaoImpl;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;

public class UserServiceImpl implements UserService {
    UserDao userDao=new UserDaoImpl();
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
    public User get() {
        return this.user;
    }
}
