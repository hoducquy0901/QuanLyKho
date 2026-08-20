package com.qkl.dao.impl;

import com.qkl.dao.CategoryDAO;
import com.qkl.entity.Category;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public List<Category> findAll() {
        EntityManager em = JpaUtil.getEntityManager();

        List<Category> list = em.createQuery("SELECT c FROM Category c", Category.class).getResultList();

        em.close();

        return list;
    }

    @Override
    public Category findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();

        Category category = em.find(Category.class, id);

        em.close();

        return category;
    }

    @Override
    public void create(Category category) {
        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        em.persist(category);

        em.getTransaction().commit();

        em.close();
    }

    @Override
    public void update(Category category) {
        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        em.merge(category);

        em.getTransaction().commit();

        em.close();
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        Category category = em.find(Category.class, id);

        if (category != null) {
            em.remove(category);
        }

        em.getTransaction().commit();

        em.close();
    }

    @Override
    public boolean hasProducts(Integer categoryId) {

        EntityManager em = JpaUtil.getEntityManager();

        Long count = em.createQuery("SELECT COUNT(p) FROM Product p " + "WHERE p.category.categoryId = :categoryId", Long.class).setParameter("categoryId", categoryId).getSingleResult();

        em.close();

        return count > 0;
    }
}