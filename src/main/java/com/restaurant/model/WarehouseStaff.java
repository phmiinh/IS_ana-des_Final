package com.restaurant.model;

public class WarehouseStaff extends Staff {
    private static final long serialVersionUID = 1L;
    private int warehouseStaffID;

    public WarehouseStaff() {
        super();
    }

    public int getWarehouseStaffID() {
        return warehouseStaffID;
    }

    public void setWarehouseStaffID(int warehouseStaffID) {
        this.warehouseStaffID = warehouseStaffID;
    }
}

