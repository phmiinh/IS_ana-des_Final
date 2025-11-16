<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Import Invoice List - Restaurant Management System</title>
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
                <h1>Imported Invoices</h1>
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
                        <h2>Imported Invoice by ${supplierName}</h2>
                    </div>

                    <!-- Breadcrumb -->
                    <div style="margin-bottom: 20px; text-align: center;">
                        <a href="SupplierStatView.jsp" style="color: #3498db; text-decoration: none;">← Back to Supplier Statistics</a>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty invoices}">
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Import Date</th>
                                            <th>Total Price</th>
                                            <th>Supplier</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="invoice" items="${invoices}">
                                            <tr>
                                                <td>
                                                    <a href="ImportedInvoiceServlet?action=detail&invoiceID=${invoice.importInvoiceID}">
                                                        ${invoice.importInvoiceID}
                                                    </a>
                                                </td>
                                                <td>${invoice.importDate}</td>
                                                <td><c:out value="${String.format('%,.0f', invoice.totalPrice)}"/>$</td>
                                                <td>${supplierName}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align: center; color: #777; padding: 20px;">
                                No invoices found.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>