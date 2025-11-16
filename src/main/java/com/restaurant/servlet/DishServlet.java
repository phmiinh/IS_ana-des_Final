package com.restaurant.servlet;

import com.restaurant.dao.DishDAO;
import com.restaurant.model.Dish;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for Dish operations
 */
@WebServlet(name = "DishServlet", urlPatterns = {"/DishServlet"})
public class DishServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("search".equals(action)) {
            handleSearch(request, response);
        } else if ("load_edit".equals(action)) {
            handleLoadEdit(request, response);
        } else {
            // Default: load all dishes
            handleSearch(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            handleUpdate(request, response);
        }
    }

    /**
     * Handle search dishes by name
     */
    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchName = request.getParameter("inSearchName");
        if (searchName == null) {
            searchName = "";
        }

        DishDAO dishDAO = new DishDAO();
        List<Dish> dishes = dishDAO.searchDishByName(searchName);
        dishDAO.closeConnection();

        request.setAttribute("dishes", dishes);
        request.setAttribute("searchName", searchName);
        request.getRequestDispatcher("ManageDishView.jsp").forward(request, response);
    }

    /**
     * Handle load dish for editing
     */
    private void handleLoadEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int dishID = Integer.parseInt(idParam);
                DishDAO dishDAO = new DishDAO();
                Dish dish = dishDAO.getDishByID(dishID);
                dishDAO.closeConnection();

                if (dish != null) {
                    request.setAttribute("dish", dish);
                    request.getRequestDispatcher("EditDishView.jsp").forward(request, response);
                } else {
                    response.sendRedirect("DishServlet?action=search");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("DishServlet?action=search");
            }
        } else {
            response.sendRedirect("DishServlet?action=search");
        }
    }

    /**
     * Handle update dish
     */
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int dishID = Integer.parseInt(request.getParameter("dishID"));
            String name = request.getParameter("txtName");
            String description = request.getParameter("txtDescription");
            float price = Float.parseFloat(request.getParameter("txtPrice"));

            Dish dish = new Dish();
            dish.setDishID(dishID);
            dish.setName(name);
            dish.setDescription(description);
            dish.setPrice(price);

            DishDAO dishDAO = new DishDAO();
            boolean success = dishDAO.updateDish(dish);
            
            if (success) {
                // Reload the updated dish
                Dish updatedDish = dishDAO.getDishByID(dishID);
                dishDAO.closeConnection();
                
                request.setAttribute("dish", updatedDish);
                request.setAttribute("message", "Cập nhật món ăn thành công!");
                request.getRequestDispatcher("EditDishView.jsp").forward(request, response);
            } else {
                dishDAO.closeConnection();
                request.setAttribute("errorMessage", "Cập nhật món ăn thất bại!");
                request.getRequestDispatcher("EditDishView.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("EditDishView.jsp").forward(request, response);
        }
    }
}

