<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Restaurant Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .register-card {
            max-width: 500px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        @media (max-width: 600px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card register-card">
            <h1>Register Account</h1>
            
            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="message message-error">
                    ${errorMessage}
                </div>
            </c:if>
            
            <!-- Register Form -->
            <form action="StaffServlet" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="register">
                
                <div class="form-group">
                    <label for="username">Username <span style="color: red;">*</span></label>
                    <input type="text" id="username" name="username" required autofocus 
                           pattern="[a-zA-Z0-9_]{3,20}" 
                           title="Username must be 3-20 characters, containing only letters, numbers and underscores">
                </div>
                
                <div class="form-group">
                    <label for="password">Password <span style="color: red;">*</span></label>
                    <input type="password" id="password" name="password" required 
                           minlength="3" 
                           title="Password must be at least 3 characters">
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password <span style="color: red;">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <div class="form-group">
                    <label for="name">Full Name <span style="color: red;">*</span></label>
                    <input type="text" id="name" name="name" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number <span style="color: red;">*</span></label>
                        <input type="tel" id="phone" name="phone" required 
                               pattern="[0-9]{10,11}" 
                               title="Phone number must be 10-11 digits">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email <span style="color: red;">*</span></label>
                        <input type="email" id="email" name="email" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="role">Role <span style="color: red;">*</span></label>
                    <select id="role" name="role" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;">
                        <option value="">-- Select Role --</option>
                        <option value="manager">Management Staff</option>
                        <option value="warehouse">Warehouse Staff</option>
                        <option value="sale">Sale Staff</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary">Register</button>
            </form>
            
            <div style="margin-top: 20px; text-align: center;">
                <p style="color: #666;">Already have an account? <a href="LoginView.jsp" style="color: #3498db; text-decoration: none; font-weight: bold;">Login now</a></p>
            </div>
        </div>
    </div>
    
    <script>
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Password confirmation does not match!');
                return false;
            }
            
            const role = document.getElementById('role').value;
            if (!role) {
                alert('Please select a role!');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>
