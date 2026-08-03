package com.qkl.dao.impl;

import com.qkl.dao.InventoryDAO;
import com.qkl.entity.Inventory;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class InventoryDAOImpl implements InventoryDAO {

    @Override
    public List<Inventory> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        List<Inventory> list = em.createQuery("SELECT i FROM Inventory i", Inventory.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public Inventory findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        Inventory inventory = em.find(Inventory.class, id);
        em.close();
        return inventory;
    }

    @Override
    public void create(Inventory inventory) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(inventory);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void update(Inventory inventory) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(inventory);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        Inventory inventory = em.find(Inventory.class, id);
        if (inventory != null) {
            em.remove(inventory);
        }
        em.getTransaction().commit();
        em.close();
    }
}