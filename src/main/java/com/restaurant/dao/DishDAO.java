package com.restaurant.dao;

import com.restaurant.model.Dish;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Dish operations
 */
public class DishDAO extends DAO {

    /**
     * Search dishes by name
     * @param name - search keyword (can be partial)
     * @return List of dishes matching the search criteria
     */
    public List<Dish> searchDishByName(String name) {
        List<Dish> dishes = new ArrayList<>();
        String sql = "SELECT * FROM Dish WHERE name LIKE ? ORDER BY dishID";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Dish dish = new Dish();
                dish.setDishID(rs.getInt("dishID"));
                dish.setName(rs.getString("name"));
                dish.setDescription(rs.getString("description"));
                dish.setPrice(rs.getFloat("price"));
                dish.setManagementStaffID(rs.getInt("managementStaffID"));
                dishes.add(dish);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in searchDishByName: " + e.getMessage());
            e.printStackTrace();
        }

        return dishes;
    }

    /**
     * Get a dish by ID
     * @param dishID
     * @return Dish object or null if not found
     */
    public Dish getDishByID(int dishID) {
        Dish dish = null;
        String sql = "SELECT * FROM Dish WHERE dishID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, dishID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                dish = new Dish();
                dish.setDishID(rs.getInt("dishID"));
                dish.setName(rs.getString("name"));
                dish.setDescription(rs.getString("description"));
                dish.setPrice(rs.getFloat("price"));
                dish.setManagementStaffID(rs.getInt("managementStaffID"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in getDishByID: " + e.getMessage());
            e.printStackTrace();
        }

        return dish;
    }

    /**
     * Update a dish
     * @param dish - Dish object with updated information
     * @return true if update successful, false otherwise
     */
    public boolean updateDish(Dish dish) {
        String sql = "UPDATE Dish SET name = ?, description = ?, price = ? WHERE dishID = ?";
        boolean success = false;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, dish.getName());
            ps.setString(2, dish.getDescription());
            ps.setFloat(3, dish.getPrice());
            ps.setInt(4, dish.getDishID());

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in updateDish: " + e.getMessage());
            e.printStackTrace();
        }

        return success;
    }

    /**
     * Add a new dish
     * @param dish - Dish object with new dish information
     * @return true if add successful, false otherwise
     */
    public boolean addDish(Dish dish) {
        String sql = "INSERT INTO Dish (name, description, price, managementStaffID) VALUES (?, ?, ?, ?)";
        boolean success = false;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, dish.getName());
            ps.setString(2, dish.getDescription());
            ps.setFloat(3, dish.getPrice());
            ps.setInt(4, dish.getManagementStaffID());

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in addDish: " + e.getMessage());
            e.printStackTrace();
        }

        return success;
    }
}

