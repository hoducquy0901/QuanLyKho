package com.qkl.dao.impl;

import com.qkl.dao.UserDAO;
import com.qkl.entity.User;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    @Override
    public List<User> findAll() {

        EntityManager em = JpaUtil.getEntityManager();

        String jpql = "SELECT u FROM User u";

        List<User> list = em.createQuery(jpql, User.class).getResultList();

        em.close();

        return list;
    }

    @Override
    public User findById(Integer id) {

        EntityManager em = JpaUtil.getEntityManager();

        User user = em.find(User.class, id);

        em.close();

        return user;
    }

    @Override
    public void create(User user) {

        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        em.persist(user);

        em.getTransaction().commit();

        em.close();
    }

    @Override
    public void update(User user) {

        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        em.merge(user);

        em.getTransaction().commit();

        em.close();
    }

    @Override
    public void delete(Integer id) {

        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        User user = em.find(User.class, id);

        if (user != null) {
            em.remove(user);
        }

        em.getTransaction().commit();

        em.close();
    }
    @Override
    public User login(String username, String password) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u " + "WHERE u.username = :username " + "AND u.password = :password";
            return em.createQuery(jpql, User.class)
                    .setParameter("username", username)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

}