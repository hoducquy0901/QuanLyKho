package com.qkl.dao;

import com.qkl.entity.ImportReceipt;
import java.util.List;

public interface ImportReceiptDAO {

    List<ImportReceipt> findAll();

    ImportReceipt findById(Integer id);

    void create(ImportReceipt receipt);

    void update(ImportReceipt receipt);

    void delete(Integer id);
}