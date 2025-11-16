package com.restaurant.model;

import java.io.Serializable;

public class OrderCombo implements Serializable {
    private static final long serialVersionUID = 1L;
    private int orderComboID;
    private int quantity;
    private float price;
    private int orderID;
    private int comboID;

    public OrderCombo() {
    }

    // Getters and Setters
    public int getOrderComboID() {
        return orderComboID;
    }

    public void setOrderComboID(int orderComboID) {
        this.orderComboID = orderComboID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getComboID() {
        return comboID;
    }

    public void setComboID(int comboID) {
        this.comboID = comboID;
    }
}

