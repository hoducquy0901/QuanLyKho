package com.qkl.test;

import com.qkl.dao.UserDAO;
import com.qkl.dao.impl.UserDAOImpl;
import com.qkl.entity.User;

public class TestLogin {

    public static void main(String[] args) {

        UserDAO dao = new UserDAOImpl();
        User user = dao.login("admin", "quy123");
        if (user != null) {
            System.out.println("Đăng nhập thành công");
            System.out.println(user.getFullName());
        } else {
            System.out.println("Sai tài khoản");
        }

    }

}