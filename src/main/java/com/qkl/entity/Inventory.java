package com.qkl.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Inventory")
public class Inventory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "InventoryId")
    private Integer inventoryId;

    @OneToOne
    @JoinColumn(name = "ProductId")
    private Product product;

    @Column(name = "Quantity")
    private Integer quantity;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "LastUpdated")
    private Date lastUpdated;

    public Inventory() {
    }

    public Inventory(Integer inventoryId, Product product,
                     Integer quantity, Date lastUpdated) {
        this.inventoryId = inventoryId;
        this.product = product;
        this.quantity = quantity;
        this.lastUpdated = lastUpdated;
    }

    public Integer getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(Integer inventoryId) {
        this.inventoryId = inventoryId;
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

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }


}