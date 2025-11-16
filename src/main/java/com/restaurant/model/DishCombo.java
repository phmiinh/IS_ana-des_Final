package com.restaurant.model;

import java.io.Serializable;

public class DishCombo implements Serializable {
    private static final long serialVersionUID = 1L;
    private int dishComboID;
    private int quantity;
    private int dishID;
    private int comboID;

    public DishCombo() {
    }

    // Getters and Setters
    public int getDishComboID() {
        return dishComboID;
    }

    public void setDishComboID(int dishComboID) {
        this.dishComboID = dishComboID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getDishID() {
        return dishID;
    }

    public void setDishID(int dishID) {
        this.dishID = dishID;
    }

    public int getComboID() {
        return comboID;
    }

    public void setComboID(int comboID) {
        this.comboID = comboID;
    }
}

