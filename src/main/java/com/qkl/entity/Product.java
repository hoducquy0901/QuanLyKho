package com.qkl.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductId")
    private Integer productId;

    @Column(name = "ProductName")
    private String productName;

    @ManyToOne
    @JoinColumn(name = "BrandId")
    private Brand brand;

    @ManyToOne
    @JoinColumn(name = "CategoryId")
    private Category category;

    @Column(name = "Unit")
    private String unit;

    @Column(name = "ImportPrice")
    private Double importPrice;

    @Column(name = "SellingPrice")
    private Double sellingPrice;

    @Column(name = "Description")
    private String description;

    @OneToOne(mappedBy = "product")
    private Inventory inventory;

    @OneToMany(mappedBy = "product")
    private List<ImportReceiptDetail> receiptDetails;

    public Product() {
    }

    public Product(Integer productId, String productName, Brand brand,
                   Category category, String unit,
                   Double importPrice, Double sellingPrice,
                   String description) {
        this.productId = productId;
        this.productName = productName;
        this.brand = brand;
        this.category = category;
        this.unit = unit;
        this.importPrice = importPrice;
        this.sellingPrice = sellingPrice;
        this.description = description;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Double getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(Double importPrice) {
        this.importPrice = importPrice;
    }

    public Double getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(Double sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Inventory getInventory() {
        return inventory;
    }

    public void setInventory(Inventory inventory) {
        this.inventory = inventory;
    }

    public List<ImportReceiptDetail> getReceiptDetails() {
        return receiptDetails;
    }

    public void setReceiptDetails(List<ImportReceiptDetail> receiptDetails) {
        this.receiptDetails = receiptDetails;
    }


}