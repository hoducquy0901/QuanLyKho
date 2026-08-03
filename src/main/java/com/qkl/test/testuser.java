package com.qkl.test;

import com.qkl.dao.UserDAO;
import com.qkl.dao.impl.UserDAOImpl;
import com.qkl.entity.User;

public class testuser {
    public static void main(String[] args) {
        UserDAO dao = new UserDAOImpl();
        for (User user : dao.findAll()) {
            System.out.println(user.getUsersId());
        }

    }

}