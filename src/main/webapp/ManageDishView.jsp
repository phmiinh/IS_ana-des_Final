<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dish Management - Restaurant Management System</title>
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
                <h1>Manage Dishes</h1>
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
                        <h2>Manage Dishes</h2>
                    </div>
                    
                    <!-- Search Form -->
                    <div class="search-section">
                        <form action="DishServlet" method="get" class="search-form-centered">
                            <input type="hidden" name="action" value="search">
                            <input type="text" id="inSearchName" name="inSearchName" 
                                   value="${searchName}" placeholder="Enter dish name..." class="search-input">
                            <button type="submit" class="btn btn-primary search-btn">Search</button>
                        </form>
                    </div>
                    
                    <!-- Dishes Table -->
                    <c:choose>
                        <c:when test="${not empty dishes}">
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Describe</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="dish" items="${dishes}">
                                            <tr>
                                                <td>${dish.dishID}</td>
                                                <td>${dish.name}</td>
                                                <td><c:out value="${String.format('%,.0f', dish.price)}"/></td>
                                                <td>${dish.description}</td>
                                                <td>
                                                    <a href="DishServlet?action=load_edit&id=${dish.dishID}" 
                                                       class="btn-action">Edit</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align: center; color: #777; padding: 20px;">
                                No dishes found.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>