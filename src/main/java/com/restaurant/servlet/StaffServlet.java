package com.restaurant.servlet;

import com.restaurant.dao.StaffDAO;
import com.restaurant.model.Staff;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for Staff operations (Login, Logout)
 */
@WebServlet(name = "StaffServlet", urlPatterns = {"/StaffServlet"})
public class StaffServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("LoginView.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        }
    }

    /**
     * Handle login request
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        StaffDAO staffDAO = new StaffDAO();
        Staff staff = staffDAO.checkLogin(username, password);
        staffDAO.closeConnection();

        if (staff != null) {
            // Login successful
            HttpSession session = request.getSession();
            session.setAttribute("staff", staff);
            response.sendRedirect("ManagementHomeView.jsp");
        } else {
            // Login failed
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("LoginView.jsp").forward(request, response);
        }
    }

    /**
     * Handle register request
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form parameters
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String role = request.getParameter("role");

            // Validate inputs
            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Please fill in all required fields!");
                request.getRequestDispatcher("RegisterView.jsp").forward(request, response);
                return;
            }

            StaffDAO staffDAO = new StaffDAO();

            // Check if username already exists
            if (staffDAO.isUsernameExists(username)) {
                staffDAO.closeConnection();
                request.setAttribute("errorMessage", "Username already exists!");
                request.getRequestDispatcher("RegisterView.jsp").forward(request, response);
                return;
            }

            // Create Staff object
            Staff staff = new Staff();
            staff.setUsername(username);
            staff.setPassword(password);
            staff.setName(name);
            staff.setPhone(phone);
            staff.setEmail(email);

            // Register the staff
            boolean success = staffDAO.registerStaff(staff, role);
            staffDAO.closeConnection();

            if (success) {
                // Registration successful
                request.setAttribute("successMessage", "Registration successful! Please login.");
                request.getRequestDispatcher("LoginView.jsp").forward(request, response);
            } else {
                // Registration failed
                request.setAttribute("errorMessage", "Registration failed! Please try again.");
                request.getRequestDispatcher("RegisterView.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("RegisterView.jsp").forward(request, response);
        }
    }
}

