<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Dish - Restaurant Management System</title>
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
                <h1>Edit Dish Information</h1>
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
                        <h2>Edit dish information</h2>
                    </div>
                    
                    <!-- Success Message -->
                    <c:if test="${not empty message}">
                        <div class="message message-success">
                            ${message}
                        </div>
                    </c:if>
                    
                    <!-- Error Message -->
                    <c:if test="${not empty errorMessage}">
                        <div class="message message-error">
                            ${errorMessage}
                        </div>
                    </c:if>
                    
                    <!-- Edit Form -->
                    <form action="DishServlet" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="dishID" value="${dish.dishID}">
                        
                        <div class="edit-form-container">
                            <table class="edit-table">
                                <tr>
                                    <td class="label-cell">ID</td>
                                    <td class="input-cell">${dish.dishID}</td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Name</td>
                                    <td class="input-cell">
                                        <input type="text" name="txtName" value="${dish.name}" required class="edit-input">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Price</td>
                                    <td class="input-cell">
                                        <input type="number" name="txtPrice" value="${dish.price}" 
                                               step="1000" min="0" required class="edit-input">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Describe</td>
                                    <td class="input-cell">
                                        <input type="text" name="txtDescription" value="${dish.description}" class="edit-input">
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="button-group-centered">
                                <button type="submit" class="btn btn-success">Save</button>
                                <a href="DishServlet?action=search" class="btn btn-danger">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>