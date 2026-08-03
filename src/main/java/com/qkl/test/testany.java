package com.qkl.test;

import com.qkl.dao.ProductDAO;
import com.qkl.dao.SupplierDAO;
import com.qkl.dao.impl.ProductDAOImpl;
import com.qkl.dao.impl.SupplierDAOImpl;
import com.qkl.entity.Product;
import com.qkl.entity.Supplier;

public class testany {
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAOImpl();
        for(Product p : dao.findAll()){
            System.out.println(p.getProductName() + " - " + p.getBrand().getBrandName()
            );
        }
    }
}
