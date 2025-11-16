package com.restaurant.model;

public class ManagementStaff extends Staff {
    private static final long serialVersionUID = 1L;
    private int managementStaffID;

    public ManagementStaff() {
        super();
    }

    public int getManagementStaffID() {
        return managementStaffID;
    }

    public void setManagementStaffID(int managementStaffID) {
        this.managementStaffID = managementStaffID;
    }
}

