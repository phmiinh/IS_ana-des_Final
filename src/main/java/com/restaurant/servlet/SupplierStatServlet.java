package com.restaurant.servlet;

import com.restaurant.dao.SupplierStatDAO;
import com.restaurant.model.SupplierStat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Servlet for Supplier Statistics
 */
@WebServlet(name = "SupplierStatServlet", urlPatterns = {"/SupplierStatServlet"})
public class SupplierStatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String startDateStr = request.getParameter("txtStartDate");
        String endDateStr = request.getParameter("txtEndDate");

        if (startDateStr != null && !startDateStr.isEmpty() && endDateStr != null && !endDateStr.isEmpty()) {
            try {
                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);

                SupplierStatDAO supplierStatDAO = new SupplierStatDAO();
                List<SupplierStat> stats = supplierStatDAO.getSupplierStat(startDate, endDate);
                supplierStatDAO.closeConnection();

                request.setAttribute("stats", stats);
                request.setAttribute("startDate", startDateStr);
                request.setAttribute("endDate", endDateStr);

            } catch (IllegalArgumentException e) {
                request.setAttribute("errorMessage", "Invalid date format. Please use yyyy-MM-dd.");
                e.printStackTrace();
            }
        }

        request.getRequestDispatcher("SupplierStatView.jsp").forward(request, response);
    }
}

