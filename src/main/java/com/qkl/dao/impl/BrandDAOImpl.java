package com.qkl.dao.impl;

import com.qkl.dao.BrandDAO;
import com.qkl.entity.Brand;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class BrandDAOImpl implements BrandDAO {

    @Override
    public List<Brand> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        List<Brand> list = em.createQuery("SELECT b FROM Brand b", Brand.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public Brand findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        Brand brand = em.find(Brand.class, id);
        em.close();
        return brand;
    }

    @Override
    public void create(Brand brand) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(brand);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void update(Brand brand) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(brand);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        Brand brand = em.find(Brand.class, id);
        if (brand != null) {
            em.remove(brand);
        }
        em.getTransaction().commit();
        em.close();
    }
}