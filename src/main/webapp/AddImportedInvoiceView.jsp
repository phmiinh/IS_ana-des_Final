<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Imported Invoice - Restaurant Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .ingredient-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr auto;
            gap: 10px;
            align-items: center;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 4px;
        }
        .ingredient-row select,
        .ingredient-row input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .remove-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .remove-btn:hover {
            background-color: #c0392b;
        }
        .add-ingredient-btn {
            margin-top: 10px;
        }
        .total-section {
            margin-top: 20px;
            padding: 15px;
            background-color: #34495e;
            color: white;
            border-radius: 4px;
            text-align: right;
        }
        .total-section h3 {
            margin: 0;
            font-size: 20px;
        }
    </style>
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
                <h1>Add Imported Invoice</h1>
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
                        <h2>Add New Imported Invoice</h2>
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
                    
                    <!-- Add Invoice Form -->
                    <form action="ImportedInvoiceServlet" method="post" id="invoiceForm">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="edit-form-container">
                            <table class="edit-table">
                                <tr>
                                    <td class="label-cell">Import Date <span style="color: red;">*</span></td>
                                    <td class="input-cell">
                                        <input type="date" name="importDate" class="edit-input" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Supplier <span style="color: red;">*</span></td>
                                    <td class="input-cell">
                                        <select name="supplierID" class="edit-input" required>
                                            <option value="">-- Select Supplier --</option>
                                            <c:forEach var="supplier" items="${suppliers}">
                                                <option value="${supplier.supplierID}">${supplier.name}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            
                            <h3 style="margin-top: 30px; margin-bottom: 15px; color: #2c3e50;">Invoice Details</h3>
                            
                            <div id="ingredientsContainer">
                                <!-- Initial ingredient row -->
                                <div class="ingredient-row">
                                    <select name="ingredientID[]" class="ingredient-select" required onchange="updatePrice(this)">
                                        <option value="">-- Select Ingredient --</option>
                                        <c:forEach var="ingredient" items="${ingredients}">
                                            <option value="${ingredient.ingredientID}" data-price="${ingredient.price}">
                                                ${ingredient.name} (${String.format('%,.0f', ingredient.price)} VND/unit)
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <input type="number" name="quantity[]" placeholder="Quantity" step="0.01" min="0.01" required class="quantity-input" oninput="calculateRowTotal(this)">
                                    <input type="number" name="price[]" placeholder="Unit Price" step="1000" min="0" required class="price-input" readonly>
                                    <input type="text" class="row-total" placeholder="Subtotal" readonly>
                                    <button type="button" class="remove-btn" onclick="removeIngredient(this)">✕</button>
                                </div>
                            </div>
                            
                            <button type="button" class="btn btn-primary add-ingredient-btn" onclick="addIngredient()">
                                ➕ Add Ingredient
                            </button>
                            
                            <div class="total-section">
                                <h3>Total: <span id="totalPrice">0</span> VND</h3>
                                <input type="hidden" name="totalPrice" id="totalPriceInput" value="0">
                            </div>
                            
                            <div class="button-group-centered">
                                <button type="submit" class="btn btn-success">Save Invoice</button>
                                <a href="SupplierStatView.jsp" class="btn btn-secondary">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function addIngredient() {
            const container = document.getElementById('ingredientsContainer');
            const newRow = container.children[0].cloneNode(true);
            
            // Reset values
            newRow.querySelectorAll('input, select').forEach(input => {
                if (input.type === 'text' || input.type === 'number') {
                    input.value = '';
                } else if (input.tagName === 'SELECT') {
                    input.selectedIndex = 0;
                }
            });
            
            container.appendChild(newRow);
        }
        
        function removeIngredient(button) {
            const container = document.getElementById('ingredientsContainer');
            if (container.children.length > 1) {
                button.parentElement.remove();
                calculateTotal();
            } else {
                alert('At least one ingredient is required!');
            }
        }
        
        function updatePrice(select) {
            const row = select.parentElement;
            const priceInput = row.querySelector('.price-input');
            const selectedOption = select.options[select.selectedIndex];
            const price = selectedOption.getAttribute('data-price') || 0;
            priceInput.value = price;
            calculateRowTotal(priceInput);
        }
        
        function calculateRowTotal(input) {
            const row = input.parentElement;
            const quantity = parseFloat(row.querySelector('.quantity-input').value) || 0;
            const price = parseFloat(row.querySelector('.price-input').value) || 0;
            const rowTotal = quantity * price;
            row.querySelector('.row-total').value = rowTotal.toLocaleString('vi-VN') + ' VND';
            calculateTotal();
        }
        
        function calculateTotal() {
            let total = 0;
            document.querySelectorAll('.ingredient-row').forEach(row => {
                const quantity = parseFloat(row.querySelector('.quantity-input').value) || 0;
                const price = parseFloat(row.querySelector('.price-input').value) || 0;
                total += quantity * price;
            });
            document.getElementById('totalPrice').textContent = total.toLocaleString('vi-VN');
            document.getElementById('totalPriceInput').value = total;
        }
        
        // Validate form before submission
        document.getElementById('invoiceForm').addEventListener('submit', function(e) {
            const rows = document.querySelectorAll('.ingredient-row');
            let valid = true;
            
            rows.forEach(row => {
                const ingredientSelect = row.querySelector('.ingredient-select');
                const quantity = row.querySelector('.quantity-input');
                
                if (!ingredientSelect.value || !quantity.value || parseFloat(quantity.value) <= 0) {
                    valid = false;
                }
            });
            
            if (!valid) {
                e.preventDefault();
                alert('Please fill in all ingredient details with valid quantities!');
            }
        });
    </script>
</body>
</html>

