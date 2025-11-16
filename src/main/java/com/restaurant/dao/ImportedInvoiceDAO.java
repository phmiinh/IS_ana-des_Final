package com.restaurant.dao;

import com.restaurant.model.ImportedInvoice;
import com.restaurant.model.ImportedInvoiceDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for ImportedInvoice operations
 */
public class ImportedInvoiceDAO extends DAO {

    /**
     * Get list of imported invoices for a specific supplier
     * @param supplierID
     * @return List of ImportedInvoice objects
     */
    public List<ImportedInvoice> getListImportInvoice(int supplierID) {
        List<ImportedInvoice> invoices = new ArrayList<>();
        String sql = "SELECT ii.*, s.name as supplierName " +
                     "FROM ImportedInvoice ii " +
                     "JOIN Supplier s ON ii.supplierID = s.supplierID " +
                     "WHERE ii.supplierID = ? ORDER BY ii.importDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, supplierID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ImportedInvoice invoice = new ImportedInvoice();
                invoice.setImportInvoiceID(rs.getInt("importInvoiceID"));
                invoice.setImportDate(rs.getDate("importDate"));
                invoice.setTotalPrice(rs.getFloat("totalPrice"));
                invoice.setSupplierID(rs.getInt("supplierID"));
                invoice.setWarehouseStaffID(rs.getInt("warehouseStaffID"));
                invoice.setSupplierName(rs.getString("supplierName"));
                invoices.add(invoice);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in getListImportInvoice: " + e.getMessage());
            e.printStackTrace();
        }

        return invoices;
    }

    /**
     * Get list of ingredients for a specific imported invoice
     * @param invoiceID
     * @return List of ImportedInvoiceDetail objects
     */
    public List<ImportedInvoiceDetail> getListIngredients(int invoiceID) {
        List<ImportedInvoiceDetail> details = new ArrayList<>();
        String sql = "SELECT iid.*, i.name as ingredientName " +
                     "FROM ImportedInvoiceDetail iid " +
                     "JOIN Ingredient i ON iid.ingredientID = i.ingredientID " +
                     "WHERE iid.importInvoiceID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, invoiceID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ImportedInvoiceDetail detail = new ImportedInvoiceDetail();
                detail.setImportDetailID(rs.getInt("importDetailID"));
                detail.setQuantity(rs.getFloat("quantity"));
                detail.setPrice(rs.getFloat("price"));
                detail.setImportInvoiceID(rs.getInt("importInvoiceID"));
                detail.setIngredientID(rs.getInt("ingredientID"));
                detail.setIngredientName(rs.getString("ingredientName"));
                details.add(detail);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in getListIngredients: " + e.getMessage());
            e.printStackTrace();
        }

        return details;
    }
}

