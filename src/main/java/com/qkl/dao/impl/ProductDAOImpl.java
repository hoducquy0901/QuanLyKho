package com.qkl.dao.impl;

import com.qkl.dao.ProductDAO;
import com.qkl.entity.Inventory;
import com.qkl.entity.Product;
import com.qkl.utils.JpaUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> findAll() {
        EntityManager em = JpaUtil.getEntityManager();

        List<Product> list = em.createQuery(
                "SELECT DISTINCT p " + "FROM Product p " + "JOIN FETCH p.brand " + "JOIN FETCH p.category " + "LEFT JOIN FETCH p.inventory", Product.class
        ).getResultList();

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

        try {

            em.getTransaction().begin();

            Product product = em.find(Product.class, id);

            if (product != null) {

                // Kiểm tra sản phẩm đã từng xuất hiện
                // trong phiếu nhập hay chưa
                Long count = em.createQuery(
                                "SELECT COUNT(d) " +
                                        "FROM ImportReceiptDetail d " +
                                        "WHERE d.product.productId = :productId",
                                Long.class
                        )
                        .setParameter("productId", id)
                        .getSingleResult();

                // Nếu đã có lịch sử nhập hàng
                // thì không cho xóa
                if (count > 0) {

                    em.getTransaction().rollback();

                    throw new IllegalStateException(
                            "Không thể xóa sản phẩm vì sản phẩm đã có trong phiếu nhập!"
                    );
                }

                // Nếu chưa có phiếu nhập thì xóa Inventory trước
                Inventory inventory = em.createQuery(
                                "SELECT i " +
                                        "FROM Inventory i " +
                                        "WHERE i.product.productId = :productId",
                                Inventory.class
                        )
                        .setParameter("productId", id)
                        .getResultStream()
                        .findFirst()
                        .orElse(null);

                if (inventory != null) {
                    em.remove(inventory);
                }

                // Cuối cùng xóa Product
                em.remove(product);
            }

            em.getTransaction().commit();

        } catch (Exception e) {

            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            throw e;

        } finally {

            em.close();
        }
    }
}