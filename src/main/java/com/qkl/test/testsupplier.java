package com.qkl.test;

import com.qkl.dao.SupplierDAO;
import com.qkl.dao.impl.SupplierDAOImpl;
import com.qkl.entity.Supplier;

public class testsupplier {

    public static void main(String[] args) {
        SupplierDAO dao = new SupplierDAOImpl();
        for (Supplier supplier : dao.findAll()) {
            System.out.println(supplier.getSupplierName());
        }

    }
}