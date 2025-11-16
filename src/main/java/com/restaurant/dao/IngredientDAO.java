package com.restaurant.dao;

import com.restaurant.model.Ingredient;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Ingredient operations
 */
public class IngredientDAO extends DAO {

    /**
     * Get all ingredients
     * @return List of all ingredients
     */
    public List<Ingredient> getAllIngredients() {
        List<Ingredient> ingredients = new ArrayList<>();
        String sql = "SELECT * FROM Ingredient ORDER BY name";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ingredient ingredient = new Ingredient();
                ingredient.setIngredientID(rs.getInt("ingredientID"));
                ingredient.setName(rs.getString("name"));
                ingredient.setStock(rs.getFloat("stock"));
                ingredient.setPrice(rs.getFloat("price"));
                ingredients.add(ingredient);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error in getAllIngredients: " + e.getMessage());
            e.printStackTrace();
        }

        return ingredients;
    }
}

