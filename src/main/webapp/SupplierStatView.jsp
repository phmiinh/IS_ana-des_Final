<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Statistics - Restaurant Management System</title>
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
                <h1>Supplier Statistics</h1>
                <div class="user-info">
                    <span>Hello, <strong>${sessionScope.staff.name}</strong></span>
                    <span>|</span>
                    <a href="StaffServlet?action=logout">Logout</a>
                </div>
            </div>
            
            <!-- Content -->
            <div class="content">
                <div class="card">
                    <!-- Error Message -->
                    <c:if test="${not empty errorMessage}">
                        <div class="message message-error">
                            ${errorMessage}
                        </div>
                    </c:if>
                    
                    <!-- Filter Section -->
                    <div class="filter-section">
                        <form action="SupplierStatServlet" method="get" class="filter-form">
                            <div class="filter-header">
                                <span class="filter-label">Filter</span>
                            </div>
                            <div class="filter-content">
                                <div class="filter-row">
                                    <label>Imported Quantity</label>
                                </div>
                                <div class="filter-dates">
                                    <div class="date-group">
                                        <label>Start</label>
                                        <input type="date" name="txtStartDate" value="${startDate}" required>
                                    </div>
                                    <div class="date-group">
                                        <label>End</label>
                                        <input type="date" name="txtEndDate" value="${endDate}" required>
                                    </div>
                                </div>
                                <div class="filter-actions">
                                    <button type="submit" class="btn btn-primary">View</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Results Section -->
                    <c:if test="${not empty stats}">
                        <div class="result-section">
                            <div class="result-header">
                                <span class="result-label">Result</span>
                            </div>
                            
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Total Imported Quantity</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="stat" items="${stats}">
                                            <tr>
                                                <td>${stat.supplierID}</td>
                                                <td>
                                                    <a href="ImportedInvoiceServlet?action=list&supplierID=${stat.supplierID}">
                                                        ${stat.supplierName}
                                                    </a>
                                                </td>
                                                <td><c:out value="${String.format('%,.2f', stat.totalQuantity)}"/>kg</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${empty stats && not empty startDate}">
                        <div class="result-section">
                            <p style="text-align: center; color: #777; padding: 20px;">
                                No data available for this time period.
                            </p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>