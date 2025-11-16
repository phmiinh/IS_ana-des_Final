package com.restaurant.model;

public class SaleStaff extends Staff {
    private static final long serialVersionUID = 1L;
    private int saleStaffID;

    public SaleStaff() {
        super();
    }

    public int getSaleStaffID() {
        return saleStaffID;
    }

    public void setSaleStaffID(int saleStaffID) {
        this.saleStaffID = saleStaffID;
    }
}

