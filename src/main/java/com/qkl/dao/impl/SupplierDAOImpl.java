package com.qkl.dao.impl;

import com.qkl.dao.SupplierDAO;
import com.qkl.entity.Supplier;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class SupplierDAOImpl implements SupplierDAO {

    @Override
    public List<Supplier> findAll() {

        EntityManager em = JpaUtil.getEntityManager();

        String jpql = "SELECT s FROM Supplier s";

        List<Supplier> list = em.createQuery(jpql, Supplier.class).getResultList();

        em.close();

        return list;
    }

    @Override
    public Supplier findById(Integer id) {

        EntityManager em = JpaUtil.getEntityManager();

        Supplier supplier = em.find(Supplier.class, id);

        em.close();

        return supplier;
    }

    @Override
    public void create(Supplier supplier) {

        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        em.persist(supplier);

        em.getTransaction().commit();

        em.close();
    }

    @Override
    public void update(Supplier supplier) {

        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        em.merge(supplier);

        em.getTransaction().commit();

        em.close();
    }

    @Override
    public void delete(Integer id) {

        EntityManager em = JpaUtil.getEntityManager();

        em.getTransaction().begin();

        Supplier supplier = em.find(Supplier.class, id);

        if (supplier != null) {
            em.remove(supplier);
        }

        em.getTransaction().commit();

        em.close();
    }
}