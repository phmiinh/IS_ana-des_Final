package com.restaurant.model;

import java.io.Serializable;

public class ImportedInvoiceDetail implements Serializable {
    private static final long serialVersionUID = 1L;
    private int importDetailID;
    private float quantity;
    private float price;
    private int importInvoiceID;
    private int ingredientID;

    // Additional fields for display
    private String ingredientName;

    public ImportedInvoiceDetail() {
    }

    // Getters and Setters
    public int getImportDetailID() {
        return importDetailID;
    }

    public void setImportDetailID(int importDetailID) {
        this.importDetailID = importDetailID;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getImportInvoiceID() {
        return importInvoiceID;
    }

    public void setImportInvoiceID(int importInvoiceID) {
        this.importInvoiceID = importInvoiceID;
    }

    public int getIngredientID() {
        return ingredientID;
    }

    public void setIngredientID(int ingredientID) {
        this.ingredientID = ingredientID;
    }

    public String getIngredientName() {
        return ingredientName;
    }

    public void setIngredientName(String ingredientName) {
        this.ingredientName = ingredientName;
    }
}

