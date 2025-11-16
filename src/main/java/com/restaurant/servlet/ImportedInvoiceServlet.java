package com.restaurant.servlet;

import com.restaurant.dao.ImportedInvoiceDAO;
import com.restaurant.dao.SupplierDAO;
import com.restaurant.dao.IngredientDAO;
import com.restaurant.model.ImportedInvoice;
import com.restaurant.model.ImportedInvoiceDetail;
import com.restaurant.model.Supplier;
import com.restaurant.model.Ingredient;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Servlet for Imported Invoice operations (Drill-down)
 */
@WebServlet(name = "ImportedInvoiceServlet", urlPatterns = {"/ImportedInvoiceServlet"})
public class ImportedInvoiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("list".equals(action)) {
            handleListInvoices(request, response);
        } else if ("detail".equals(action)) {
            handleInvoiceDetail(request, response);
        } else if ("load_add".equals(action)) {
            handleLoadAdd(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(request, response);
        }
    }

    /**
     * Handle listing invoices for a supplier
     */
    private void handleListInvoices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));
            ImportedInvoiceDAO dao = new ImportedInvoiceDAO();
            List<ImportedInvoice> invoices = dao.getListImportInvoice(supplierID);
            dao.closeConnection();

            if (!invoices.isEmpty()) {
                request.setAttribute("supplierName", invoices.get(0).getSupplierName());
            }
            request.setAttribute("invoices", invoices);
            request.getRequestDispatcher("ListImportInvoiceView.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            // Redirect to a safe page if supplierID is invalid
            response.sendRedirect("SelectStatisticView.jsp");
        }
    }

    /**
     * Handle showing details of an invoice
     */
    private void handleInvoiceDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int invoiceID = Integer.parseInt(request.getParameter("invoiceID"));
            ImportedInvoiceDAO dao = new ImportedInvoiceDAO();
            List<ImportedInvoiceDetail> details = dao.getListIngredients(invoiceID);
            dao.closeConnection();

            request.setAttribute("details", details);
            request.setAttribute("invoiceID", invoiceID);
            request.getRequestDispatcher("ImportInvoiceDetailView.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            // Redirect to a safe page if invoiceID is invalid
            response.sendRedirect("SelectStatisticView.jsp");
        }
    }

    /**
     * Handle load add invoice form
     */
    private void handleLoadAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Load suppliers and ingredients for the form
        SupplierDAO supplierDAO = new SupplierDAO();
        List<Supplier> suppliers = supplierDAO.getAllSuppliers();
        supplierDAO.closeConnection();

        IngredientDAO ingredientDAO = new IngredientDAO();
        List<Ingredient> ingredients = ingredientDAO.getAllIngredients();
        ingredientDAO.closeConnection();

        request.setAttribute("suppliers", suppliers);
        request.setAttribute("ingredients", ingredients);
        request.getRequestDispatcher("AddImportedInvoiceView.jsp").forward(request, response);
    }

    /**
     * Handle add new imported invoice
     */
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Parse invoice data
            String importDateStr = request.getParameter("importDate");
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));
            float totalPrice = Float.parseFloat(request.getParameter("totalPrice"));

            // Get warehouse staff ID from session (default to 1 if not available)
            int warehouseStaffID = 1;

            // Create invoice object
            ImportedInvoice invoice = new ImportedInvoice();
            invoice.setImportDate(Date.valueOf(importDateStr));
            invoice.setTotalPrice(totalPrice);
            invoice.setSupplierID(supplierID);
            invoice.setWarehouseStaffID(warehouseStaffID);

            // Add invoice to database
            ImportedInvoiceDAO dao = new ImportedInvoiceDAO();
            int invoiceID = dao.addImportedInvoice(invoice);

            if (invoiceID > 0) {
                // Parse ingredient details
                String[] ingredientIDs = request.getParameterValues("ingredientID[]");
                String[] quantities = request.getParameterValues("quantity[]");
                String[] prices = request.getParameterValues("price[]");

                boolean allDetailsAdded = true;

                // Add each ingredient detail
                for (int i = 0; i < ingredientIDs.length; i++) {
                    ImportedInvoiceDetail detail = new ImportedInvoiceDetail();
                    detail.setImportInvoiceID(invoiceID);
                    detail.setIngredientID(Integer.parseInt(ingredientIDs[i]));
                    detail.setQuantity(Float.parseFloat(quantities[i]));
                    detail.setPrice(Float.parseFloat(prices[i]));

                    if (!dao.addInvoiceDetail(detail)) {
                        allDetailsAdded = false;
                        break;
                    }
                }

                dao.closeConnection();

                if (allDetailsAdded) {
                    // Redirect to supplier statistics page
                    response.sendRedirect("SupplierStatView.jsp");
                } else {
                    request.setAttribute("error", "Failed to add some invoice details!");
                    handleLoadAdd(request, response);
                }
            } else {
                dao.closeConnection();
                request.setAttribute("error", "Failed to add invoice!");
                handleLoadAdd(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            handleLoadAdd(request, response);
        }
    }
}

