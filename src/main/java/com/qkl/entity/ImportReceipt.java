package com.qkl.entity;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "ImportReceipt")
public class ImportReceipt {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ReceiptId")
    private Integer receiptId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ImportDate")
    private Date importDate;

    @ManyToOne
    @JoinColumn(name = "SupplierId")
    private Supplier supplier;

    @ManyToOne
    @JoinColumn(name = "UsersId")
    private User user;

    @Column(name = "TotalAmount")
    private Double totalAmount;

    @OneToMany(mappedBy = "receipt")
    private List<ImportReceiptDetail> receiptDetails;

    public ImportReceipt() {
    }

    public ImportReceipt(Integer receiptId, Date importDate, Supplier supplier,
                         User user, Double totalAmount) {
        this.receiptId = receiptId;
        this.importDate = importDate;
        this.supplier = supplier;
        this.user = user;
        this.totalAmount = totalAmount;
    }

    public Integer getReceiptId() {
        return receiptId;
    }

    public void setReceiptId(Integer receiptId) {
        this.receiptId = receiptId;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<ImportReceiptDetail> getReceiptDetails() {
        return receiptDetails;
    }

    public void setReceiptDetails(List<ImportReceiptDetail> receiptDetails) {
        this.receiptDetails = receiptDetails;
    }

}