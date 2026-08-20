package com.qkl.dao;

import com.qkl.entity.Category;
import java.util.List;

public interface CategoryDAO {

    List<Category> findAll();

    Category findById(Integer id);

    void create(Category category);

    void update(Category category);

    void delete(Integer id);

    boolean hasProducts(Integer categoryId);
}