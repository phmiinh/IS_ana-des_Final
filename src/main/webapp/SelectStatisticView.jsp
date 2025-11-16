<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Statistics - Restaurant Management System</title>
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
                <li><a href="DishServlet?action=search">Dish Management</a></li>
                <li><a href="SelectStatisticView.jsp" class="active">View Statistics</a></li>
                <li><a href="StaffServlet?action=logout">Logout</a></li>
            </ul>
        </nav>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="header">
                <h1>Select Statistics</h1>
                <div class="user-info">
                    <span>Hello, <strong>${sessionScope.staff.name}</strong></span>
                    <span>|</span>
                    <a href="StaffServlet?action=logout">Logout</a>
                </div>
            </div>
            
            <!-- Content -->
            <div class="content">
                <div class="page-title-centered">
                    <h2>Select Statistic Report</h2>
                </div>
                
                <div class="statistic-grid">
                    <a href="SupplierStatServlet?action=view" class="statistic-card">
                        <div class="statistic-icon">📊</div>
                        <h3>Supplier Statistics</h3>
                        <p>View supplier statistics by imported quantity and time period</p>
                    </a>
                    
                    <a href="#" class="statistic-card disabled">
                        <div class="statistic-icon">👥</div>
                        <h3>Customer Statistics</h3>
                        <p>View customer statistics and membership information</p>
                    </a>
                    
                    <a href="#" class="statistic-card disabled">
                        <div class="statistic-icon">🍽️</div>
                        <h3>Dish Statistics</h3>
                        <p>View dish popularity and sales statistics</p>
                    </a>
                    
                    <a href="#" class="statistic-card disabled">
                        <div class="statistic-icon">🥗</div>
                        <h3>Ingredient Statistics</h3>
                        <p>View ingredient usage and inventory statistics</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>