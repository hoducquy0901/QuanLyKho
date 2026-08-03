package com.qkl.dao;

import com.qkl.entity.Brand;
import java.util.List;

public interface BrandDAO {

    List<Brand> findAll();

    Brand findById(Integer id);

    void create(Brand brand);

    void update(Brand brand);

    void delete(Integer id);
}