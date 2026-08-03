package com.qkl.dao;

import com.qkl.entity.Product;
import java.util.List;

public interface ProductDAO {

    List<Product> findAll();

    Product findById(Integer id);

    void create(Product product);

    void update(Product product);

    void delete(Integer id);
}