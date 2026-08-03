package com.qkl.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "ImportReceiptDetail")
public class ImportReceiptDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DetailId")
    private Integer detailId;

    @ManyToOne
    @JoinColumn(name = "ReceiptId")
    private ImportReceipt receipt;

    @ManyToOne
    @JoinColumn(name = "ProductId")
    private Product product;

    @Column(name = "Quantity")
    private Integer quantity;

    @Column(name = "UnitPrice")
    private Double unitPrice;

    public ImportReceiptDetail() {
    }

    public ImportReceiptDetail(Integer detailId, ImportReceipt receipt,
                               Product product, Integer quantity,
                               Double unitPrice) {
        this.detailId = detailId;
        this.receipt = receipt;
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public Integer getDetailId() {
        return detailId;
    }

    public void setDetailId(Integer detailId) {
        this.detailId = detailId;
    }

    public ImportReceipt getReceipt() {
        return receipt;
    }

    public void setReceipt(ImportReceipt receipt) {
        this.receipt = receipt;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }
}