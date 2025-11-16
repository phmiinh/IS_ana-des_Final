package com.restaurant.dao;

import com.restaurant.model.SupplierStat;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Supplier Statistics
 */
public class SupplierStatDAO extends DAO {

    /**
     * Get supplier statistics within a date range
     * @param startDate
     * @param endDate
     * @return List of SupplierStat objects
     */
    public List<SupplierStat> getSupplierStat(Date startDate, Date endDate) {
        List<SupplierStat> stats = new ArrayList<>();
        String sql = "SELECT s.supplierID, s.name, SUM(iid.quantity) AS totalQuantity " +
                     "FROM Supplier s " +
                     "JOIN ImportedInvoice ii ON s.supplierID = ii.supplierID " +
                     "JOIN ImportedInvoiceDetail iid ON ii.importInvoiceID = iid.importInvoiceID " +
                     "WHERE ii.importDate BETWEEN ? AND ? " +
                     "GROUP BY s.supplierID, s.name " +
                     "ORDER BY totalQuantity DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SupplierStat stat = new SupplierStat();
                stat.setSupplierID(rs.getInt("supplierID"));
                stat.setSupplierName(rs.getString("name"));
                stat.setTotalQuantity(rs.getFloat("totalQuantity"));
                stats.add(stat);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in getSupplierStat: " + e.getMessage());
            e.printStackTrace();
        }

        return stats;
    }
}

