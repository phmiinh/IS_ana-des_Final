package com.restaurant.dao;

import com.restaurant.model.Staff;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO for Staff operations
 */
public class StaffDAO extends DAO {

    /**
     * Check login credentials and return Staff object with role
     * @param username
     * @param password
     * @return Staff object if credentials are valid, null otherwise
     */
    public Staff checkLogin(String username, String password) {
        Staff staff = null;
        String sql = "SELECT s.username, s.password, s.name, s.phone, s.email, " +
                     "CASE " +
                     "  WHEN ms.username IS NOT NULL THEN 'manager' " +
                     "  WHEN ws.username IS NOT NULL THEN 'warehouse' " +
                     "  WHEN ss.username IS NOT NULL THEN 'sale' " +
                     "  ELSE 'unknown' " +
                     "END AS role " +
                     "FROM Staff s " +
                     "LEFT JOIN ManagementStaff ms ON s.username = ms.username " +
                     "LEFT JOIN WarehouseStaff ws ON s.username = ws.username " +
                     "LEFT JOIN SaleStaff ss ON s.username = ss.username " +
                     "WHERE s.username = ? AND s.password = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                staff = new Staff();
                staff.setUsername(rs.getString("username"));
                staff.setPassword(rs.getString("password"));
                staff.setName(rs.getString("name"));
                staff.setPhone(rs.getString("phone"));
                staff.setEmail(rs.getString("email"));
                staff.setRole(rs.getString("role"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in checkLogin: " + e.getMessage());
            e.printStackTrace();
        }

        return staff;
    }
}

