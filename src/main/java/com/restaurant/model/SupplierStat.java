package com.restaurant.model;

import java.io.Serializable;

public class SupplierStat implements Serializable {
    private static final long serialVersionUID = 1L;
    private int supplierID;
    private String supplierName;
    private float totalQuantity;

    public SupplierStat() {
    }

    // Getters and Setters
    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public float getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(float totalQuantity) {
        this.totalQuantity = totalQuantity;
    }
}

