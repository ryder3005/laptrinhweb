package vn.iotstar.service;

import vn.iotstar.model.User;

public  interface  UserService{
    User login(String email, String password);


    User get();
}
