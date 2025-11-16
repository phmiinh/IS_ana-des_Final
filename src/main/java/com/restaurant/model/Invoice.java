package com.restaurant.model;

import java.io.Serializable;
import java.sql.Date;

public class Invoice implements Serializable {
    private static final long serialVersionUID = 1L;
    private int invoiceID;
    private Date paymentDate;
    private String status;
    private int reservationID;
    private int saleStaffID;

    public Invoice() {
    }

    // Getters and Setters
    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getReservationID() {
        return reservationID;
    }

    public void setReservationID(int reservationID) {
        this.reservationID = reservationID;
    }

    public int getSaleStaffID() {
        return saleStaffID;
    }

    public void setSaleStaffID(int saleStaffID) {
        this.saleStaffID = saleStaffID;
    }
}

