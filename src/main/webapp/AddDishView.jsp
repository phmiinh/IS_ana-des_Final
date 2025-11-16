<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Dish - Restaurant Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Check if user is logged in -->
    <c:if test="${empty sessionScope.staff}">
        <c:redirect url="LoginView.jsp"/>
    </c:if>
    
    <div class="layout">
        <!-- Sidebar Navigation -->
        <nav class="sidebar">
            <div class="sidebar-header">
                <h2><a href="ManagementHomeView.jsp" style="color: inherit; text-decoration: none;">Restaurant</a></h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="ManagementHomeView.jsp">Home</a></li>
                <li><a href="DishServlet?action=search" class="active">Dish Management</a></li>
                <li><a href="SelectStatisticView.jsp">View Statistics</a></li>
                <li><a href="StaffServlet?action=logout">Logout</a></li>
            </ul>
        </nav>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="header">
                <h1>Add New Dish</h1>
                <div class="user-info">
                    <span>Hello, <strong>${sessionScope.staff.name}</strong></span>
                    <span>|</span>
                    <a href="StaffServlet?action=logout">Logout</a>
                </div>
            </div>
            
            <!-- Content -->
            <div class="content">
                <div class="card">
                    <div class="page-title-centered">
                        <h2>Add New Dish</h2>
                    </div>
                    
                    <!-- Display Messages -->
                    <c:if test="${not empty message}">
                        <div class="message message-success">
                            ${message}
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty error}">
                        <div class="message message-error">
                            ${error}
                        </div>
                    </c:if>
                    
                    <!-- Add Dish Form -->
                    <div class="edit-form-container">
                        <form action="DishServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            
                            <table class="edit-table">
                                <tr>
                                    <td class="label-cell">Dish Name <span style="color: red;">*</span></td>
                                    <td class="input-cell">
                                        <input type="text" name="name" class="edit-input" 
                                               placeholder="Enter dish name" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Price (VND) <span style="color: red;">*</span></td>
                                    <td class="input-cell">
                                        <input type="number" name="price" class="edit-input" 
                                               placeholder="Enter price" step="1000" min="0" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Description</td>
                                    <td class="input-cell">
                                        <textarea name="description" class="edit-input" 
                                                  placeholder="Enter dish description" rows="4"></textarea>
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="button-group-centered">
                                <button type="submit" class="btn btn-success">Save Dish</button>
                                <a href="DishServlet?action=search" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

