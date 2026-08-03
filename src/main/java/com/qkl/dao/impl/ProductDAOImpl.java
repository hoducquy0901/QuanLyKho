package com.qkl.dao.impl;

import com.qkl.dao.ProductDAO;
import com.qkl.entity.Product;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        List<Product> list = em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public Product findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        Product product = em.find(Product.class, id);
        em.close();
        return product;
    }

    @Override
    public void create(Product product) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(product);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void update(Product product) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(product);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        Product product = em.find(Product.class, id);
        if (product != null) {
            em.remove(product);
        }
        em.getTransaction().commit();
        em.close();
    }
}