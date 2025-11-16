package com.restaurant.dao;

import com.restaurant.model.Supplier;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Supplier operations
 */
public class SupplierDAO extends DAO {

    /**
     * Get all suppliers
     * @return List of all suppliers
     */
    public List<Supplier> getAllSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Supplier ORDER BY name";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierID(rs.getInt("supplierID"));
                supplier.setName(rs.getString("name"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setEmail(rs.getString("email"));
                supplier.setAddress(rs.getString("address"));
                suppliers.add(supplier);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in getAllSuppliers: " + e.getMessage());
            e.printStackTrace();
        }

        return suppliers;
    }

    /**
     * Get supplier by ID
     * @param supplierID
     * @return Supplier object or null if not found
     */
    public Supplier getSupplierByID(int supplierID) {
        Supplier supplier = null;
        String sql = "SELECT * FROM Supplier WHERE supplierID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, supplierID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                supplier = new Supplier();
                supplier.setSupplierID(rs.getInt("supplierID"));
                supplier.setName(rs.getString("name"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setEmail(rs.getString("email"));
                supplier.setAddress(rs.getString("address"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in getSupplierByID: " + e.getMessage());
            e.printStackTrace();
        }

        return supplier;
    }
}

