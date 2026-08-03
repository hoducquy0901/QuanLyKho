package com.qkl.dao;

import com.qkl.entity.Supplier;
import java.util.List;

public interface SupplierDAO {

    List<Supplier> findAll();

    Supplier findById(Integer id);

    void create(Supplier supplier);

    void update(Supplier supplier);

    void delete(Integer id);
}