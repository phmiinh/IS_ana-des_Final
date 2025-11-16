package com.restaurant.model;

import java.io.Serializable;
import java.sql.Date;

public class Membership implements Serializable {
    private static final long serialVersionUID = 1L;
    private int cardID;
    private String type;
    private int points;
    private Date startDate;
    private Date dueDate;
    private int customerID;

    public Membership() {
    }

    // Getters and Setters
    public int getCardID() {
        return cardID;
    }

    public void setCardID(int cardID) {
        this.cardID = cardID;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }
}

