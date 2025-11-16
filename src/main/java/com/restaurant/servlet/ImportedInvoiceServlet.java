package com.restaurant.servlet;

import com.restaurant.dao.ImportedInvoiceDAO;
import com.restaurant.model.ImportedInvoice;
import com.restaurant.model.ImportedInvoiceDetail;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
}

