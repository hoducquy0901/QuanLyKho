package com.qkl.dao.impl;

import com.qkl.dao.ImportReceiptDAO;
import com.qkl.entity.ImportReceipt;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ImportReceiptDAOImpl implements ImportReceiptDAO {

    @Override
    public List<ImportReceipt> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        List<ImportReceipt> list = em.createQuery("SELECT r FROM ImportReceipt r", ImportReceipt.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public ImportReceipt findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        ImportReceipt receipt = em.find(ImportReceipt.class, id);
        em.close();
        return receipt;
    }

    @Override
    public void create(ImportReceipt receipt) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(receipt);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void update(ImportReceipt receipt) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(receipt);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        ImportReceipt receipt = em.find(ImportReceipt.class, id);
        if (receipt != null) {
            em.remove(receipt);
        }
        em.getTransaction().commit();
        em.close();
    }
}