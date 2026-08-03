package com.qkl.dao;

import com.qkl.entity.ImportReceiptDetail;
import java.util.List;

public interface ImportReceiptDetailDAO {

    List<ImportReceiptDetail> findAll();

    ImportReceiptDetail findById(Integer id);

    void create(ImportReceiptDetail detail);

    void update(ImportReceiptDetail detail);

    void delete(Integer id);
}