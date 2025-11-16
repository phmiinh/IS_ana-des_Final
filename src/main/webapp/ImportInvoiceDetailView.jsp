<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Import Invoice Details - Restaurant Management System</title>
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
                <h1>Invoice Details</h1>
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
                        <h2>Invoice ${invoiceID}</h2>
                    </div>
                    
                    <!-- Breadcrumb -->
                    <div style="margin-bottom: 20px; text-align: center;">
                        <a href="javascript:history.back()" style="color: #3498db; text-decoration: none;">← Back to Invoice List</a>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty details}">
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Ingredient</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="detail" items="${details}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>${detail.ingredientName}</td>
                                                <td><c:out value="${String.format('%,.2f', detail.quantity)}"/>kg</td>
                                                <td><c:out value="${String.format('%,.0f', detail.price)}"/>$</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr class="total-row">
                                            <td colspan="3" style="text-align: right; font-weight: bold;">Total price</td>
                                            <td style="font-weight: bold;">
                                                <c:set var="totalPrice" value="0"/>
                                                <c:forEach var="detail" items="${details}">
                                                    <c:set var="totalPrice" value="${totalPrice + (detail.quantity * detail.price)}"/>
                                                </c:forEach>
                                                <c:out value="${String.format('%,.0f', totalPrice)}"/>$
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align: center; color: #777; padding: 20px;">
                                No details available for this invoice.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>