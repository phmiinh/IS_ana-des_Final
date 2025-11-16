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

    /**
     * Add a new imported invoice
     * @param invoice - ImportedInvoice object
     * @return the generated invoice ID, or -1 if failed
     */
    public int addImportedInvoice(ImportedInvoice invoice) {
        String sql = "INSERT INTO ImportedInvoice (importDate, totalPrice, supplierID, warehouseStaffID) VALUES (?, ?, ?, ?)";
        int generatedID = -1;

        try {
            PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setDate(1, invoice.getImportDate());
            ps.setFloat(2, invoice.getTotalPrice());
            ps.setInt(3, invoice.getSupplierID());
            ps.setInt(4, invoice.getWarehouseStaffID());

            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedID = rs.getInt(1);
                }
                rs.close();
            }

            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in addImportedInvoice: " + e.getMessage());
            e.printStackTrace();
        }

        return generatedID;
    }

    /**
     * Add invoice detail (ingredient)
     * @param detail - ImportedInvoiceDetail object
     * @return true if successful, false otherwise
     */
    public boolean addInvoiceDetail(ImportedInvoiceDetail detail) {
        String sql = "INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES (?, ?, ?, ?)";
        boolean success = false;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setFloat(1, detail.getQuantity());
            ps.setFloat(2, detail.getPrice());
            ps.setInt(3, detail.getImportInvoiceID());
            ps.setInt(4, detail.getIngredientID());

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in addInvoiceDetail: " + e.getMessage());
            e.printStackTrace();
        }

        return success;
    }
}

