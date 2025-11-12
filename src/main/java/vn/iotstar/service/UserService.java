package vn.iotstar.service;

import vn.iotstar.model.User;

public  interface  UserService{
    User login(String email, String password);

    void insert(User user);
    boolean register(String email, String password,String username,String fullname,String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String password);
    boolean checkExistPhone(String phone);
    User get();
}
