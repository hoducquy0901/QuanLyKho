package com.qkl.dao;

import com.qkl.entity.User;
import java.util.List;

public interface UserDAO {

    List<User> findAll();

    User findById(Integer id);

    void create(User user);

    void update(User user);

    void delete(Integer id);

    User login(String username, String password);
}