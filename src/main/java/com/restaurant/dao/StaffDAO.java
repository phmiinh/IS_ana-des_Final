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

    /**
     * Check if username already exists
     * @param username
     * @return true if username exists, false otherwise
     */
    public boolean isUsernameExists(String username) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) as count FROM Staff WHERE username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                exists = rs.getInt("count") > 0;
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in isUsernameExists: " + e.getMessage());
            e.printStackTrace();
        }

        return exists;
    }

    /**
     * Register a new staff member
     * @param staff - Staff object with user details
     * @param role - Role of the staff (manager, warehouse, sale)
     * @return true if registration successful, false otherwise
     */
    public boolean registerStaff(Staff staff, String role) {
        // First, insert into Staff table
        String insertStaffSql = "INSERT INTO Staff (username, password, name, phone, email) VALUES (?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(insertStaffSql);
            ps.setString(1, staff.getUsername());
            ps.setString(2, staff.getPassword());
            ps.setString(3, staff.getName());
            ps.setString(4, staff.getPhone());
            ps.setString(5, staff.getEmail());

            int rowsAffected = ps.executeUpdate();
            ps.close();

            if (rowsAffected > 0) {
                // Insert into role-specific table
                String roleTableSql = "";
                switch (role.toLowerCase()) {
                    case "manager":
                        roleTableSql = "INSERT INTO ManagementStaff (username) VALUES (?)";
                        break;
                    case "warehouse":
                        roleTableSql = "INSERT INTO WarehouseStaff (username) VALUES (?)";
                        break;
                    case "sale":
                        roleTableSql = "INSERT INTO SaleStaff (username) VALUES (?)";
                        break;
                    default:
                        return false;
                }

                PreparedStatement rolePs = connection.prepareStatement(roleTableSql);
                rolePs.setString(1, staff.getUsername());
                int roleRowsAffected = rolePs.executeUpdate();
                rolePs.close();

                return roleRowsAffected > 0;
            }

            return false;
        } catch (SQLException e) {
            System.err.println("Error in registerStaff: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}

