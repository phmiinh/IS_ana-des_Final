<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Restaurant Management System</title>
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
                <h2>Restaurant</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="ManagementHomeView.jsp" class="active">Home</a></li>
                <li><a href="DishServlet?action=search">Dish Management</a></li>
                <li><a href="SelectStatisticView.jsp">View Statistics</a></li>
                <li><a href="StaffServlet?action=logout">Logout</a></li>
            </ul>
        </nav>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="header">
                <h1>Home</h1>
                <div class="user-info">
                    <span>Hello, <strong>${sessionScope.staff.name}</strong></span>
                    <span>|</span>
                    <a href="StaffServlet?action=logout">Logout</a>
                </div>
            </div>
            
            <!-- Content -->
            <div class="content">
                <div class="card">
                    <h2 class="card-title">Welcome to the Restaurant Management System</h2>
                    <p style="margin-bottom: 20px;">Your role: <strong style="color: #3498db; text-transform: uppercase;">${sessionScope.staff.role}</strong></p>
                    
                    <div class="dashboard-cards">
                        <div class="dashboard-card">
                            <h3>Dish Management</h3>
                            <p style="margin: 15px 0;">Add, edit, and delete dish information</p>
                            <a href="DishServlet?action=search" class="btn btn-primary">Access</a>
                        </div>
                        
                        <div class="dashboard-card">
                            <h3>Supplier Statistics</h3>
                            <p style="margin: 15px 0;">View reports and statistics</p>
                            <a href="SelectStatisticView.jsp" class="btn btn-primary">Access</a>
                        </div>
                        
                        <div class="dashboard-card">
                            <h3>Inventory Management</h3>
                            <p style="margin: 15px 0;">Manage ingredients and imports</p>
                            <a href="#" class="btn btn-secondary">Coming Soon</a>
                        </div>
                    </div>
                </div>
                
                <div class="card">
                    <h3 class="card-title">User Information</h3>
                    <table>
                        <tr>
                            <td style="font-weight: 600; width: 200px;">Username:</td>
                            <td>${sessionScope.staff.username}</td>
                        </tr>
                        <tr>
                            <td style="font-weight: 600;">Full Name:</td>
                            <td>${sessionScope.staff.name}</td>
                        </tr>
                        <tr>
                            <td style="font-weight: 600;">Phone Number:</td>
                            <td>${sessionScope.staff.phone}</td>
                        </tr>
                        <tr>
                            <td style="font-weight: 600;">Email:</td>
                            <td>${sessionScope.staff.email}</td>
                        </tr>
                        <tr>
                            <td style="font-weight: 600;">Role:</td>
                            <td style="text-transform: uppercase; color: #3498db; font-weight: 600;">${sessionScope.staff.role}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>