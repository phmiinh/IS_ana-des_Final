package com.restaurant.model;

import java.io.Serializable;

public class OrderDish implements Serializable {
    private static final long serialVersionUID = 1L;
    private int orderDishID;
    private int quantity;
    private float price;
    private int orderID;
    private int dishID;

    public OrderDish() {
    }

    // Getters and Setters
    public int getOrderDishID() {
        return orderDishID;
    }

    public void setOrderDishID(int orderDishID) {
        this.orderDishID = orderDishID;
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

    public int getDishID() {
        return dishID;
    }

    public void setDishID(int dishID) {
        this.dishID = dishID;
    }
}

