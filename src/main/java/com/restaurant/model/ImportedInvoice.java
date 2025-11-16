package com.restaurant.model;

import java.io.Serializable;
import java.sql.Date;

public class ImportedInvoice implements Serializable {
    private static final long serialVersionUID = 1L;
    private int importInvoiceID;
    private Date importDate;
    private float totalPrice;
    private int supplierID;
    private int warehouseStaffID;
    
    // Additional fields for display purposes
    private String supplierName;

    public ImportedInvoice() {
    }

    // Getters and Setters
    public int getImportInvoiceID() {
        return importInvoiceID;
    }

    public void setImportInvoiceID(int importInvoiceID) {
        this.importInvoiceID = importInvoiceID;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public int getWarehouseStaffID() {
        return warehouseStaffID;
    }

    public void setWarehouseStaffID(int warehouseStaffID) {
        this.warehouseStaffID = warehouseStaffID;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}

