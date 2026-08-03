package com.qkl.dao.impl;

import com.qkl.dao.ImportReceiptDetailDAO;
import com.qkl.entity.ImportReceiptDetail;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ImportReceiptDetailDAOImpl implements ImportReceiptDetailDAO {

    @Override
    public List<ImportReceiptDetail> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        List<ImportReceiptDetail> list = em.createQuery("SELECT d FROM ImportReceiptDetail d", ImportReceiptDetail.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public ImportReceiptDetail findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        ImportReceiptDetail detail = em.find(ImportReceiptDetail.class, id);
        em.close();
        return detail;
    }

    @Override
    public void create(ImportReceiptDetail detail) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(detail);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void update(ImportReceiptDetail detail) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(detail);
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        em.getTransaction().begin();
        ImportReceiptDetail detail = em.find(ImportReceiptDetail.class, id);
        if (detail != null) {
            em.remove(detail);
        }
        em.getTransaction().commit();
        em.close();
    }
}