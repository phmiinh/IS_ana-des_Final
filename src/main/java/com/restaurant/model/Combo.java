package com.restaurant.model;

import java.io.Serializable;

public class Combo implements Serializable {
    private static final long serialVersionUID = 1L;
    private int comboID;
    private String name;
    private float price;
    private String description;

    public Combo() {
    }

    // Getters and Setters
    public int getComboID() {
        return comboID;
    }

    public void setComboID(int comboID) {
        this.comboID = comboID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

