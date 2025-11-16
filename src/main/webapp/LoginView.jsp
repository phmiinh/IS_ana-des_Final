<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Restaurant Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <h1>Login</h1>
            
            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="message message-error">
                    ${errorMessage}
                </div>
            </c:if>
            
            <!-- Success Message -->
            <c:if test="${not empty successMessage}">
                <div class="message message-success">
                    ${successMessage}
                </div>
            </c:if>
            
            <!-- Login Form -->
            <form action="StaffServlet" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required autofocus>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Login</button>
            </form>
            
            <div style="margin-top: 20px; text-align: center;">
                <p style="color: #666;">Don't have an account? <a href="RegisterView.jsp" style="color: #3498db; text-decoration: none; font-weight: bold;">Register now</a></p>
            </div>
        </div>
    </div>
</body>
</html>
