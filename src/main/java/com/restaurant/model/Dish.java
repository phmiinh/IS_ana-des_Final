package com.restaurant.model;

import java.io.Serializable;

public class Dish implements Serializable {
    private static final long serialVersionUID = 1L;
    private int dishID;
    private String name;
    private String description;
    private float price;
    private int managementStaffID;

    public Dish() {
    }

    // Getters and Setters
    public int getDishID() {
        return dishID;
    }

    public void setDishID(int dishID) {
        this.dishID = dishID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getManagementStaffID() {
        return managementStaffID;
    }

    public void setManagementStaffID(int managementStaffID) {
        this.managementStaffID = managementStaffID;
    }
}

