package com.restaurant.model;

import java.io.Serializable;

public class Table implements Serializable {
    private static final long serialVersionUID = 1L;
    private int tableID;
    private String type;
    private boolean available;

    public Table() {
    }

    // Getters and Setters
    public int getTableID() {
        return tableID;
    }

    public void setTableID(int tableID) {
        this.tableID = tableID;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }
}

