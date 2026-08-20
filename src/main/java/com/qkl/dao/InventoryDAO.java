package com.qkl.dao;

import com.qkl.entity.Inventory;
import java.util.List;

public interface InventoryDAO {

    List<Inventory> findAll();

    Inventory findById(Integer id);

    void create(Inventory inventory);

    void update(Inventory inventory);

    void delete(Integer id);


}