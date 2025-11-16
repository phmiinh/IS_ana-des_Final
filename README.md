# Restaurant Management System - Information System Analysis & Design

## [object Object] Overview

This project is a comprehensive **Restaurant Management System** developed as part of the **Information System Analysis and Design** course. The system implements a multi-user platform that serves different stakeholders including Management Staff, Warehouse Staff, Sale Staff, and Customers.

### 🎯 System Objectives

The Restaurant Management System enables:
- **Management Staff**: View statistics (dishes, ingredients, customers, suppliers), manage dish information, create combo menus
- **Warehouse Staff**: Import materials from suppliers, manage supplier information
- **Sale Staff**: Receive customers, take orders, process payments, create membership cards, confirm reservations and online orders
- **Customers**: Search, book tables, and order food online

---

## 🔍 Implemented Modules

This implementation focuses on **two core modules** as specified in the course requirements:

### Module 1: Dish Information Management
**Actor**: Management Staff

**Flow**:
1. Select menu to manage dish information
2. Select function to edit dish information
3. Search for dishes by name
4. Select dish from search results
5. Enter/update dish information
6. Save changes to database

### Module 2: Supplier Statistics
**Actor**: Management Staff

**Flow**:
1. Select menu to view statistical reports
2. Select supplier statistics by imported quantity
3. Select start and end time for statistics
4. View supplier statistics
5. Select a supplier to view details
6. View list of imported invoices
7. Select an invoice to view details
8. View detailed invoice information (including ingredients)

---

## 🏗️ System Architecture

### Technology Stack
- **Backend**: Java Servlet, JSP (J2EE)
- **Frontend**: HTML5, CSS3, JavaScript
- **Database**: MySQL
- **Server**: Apache Tomcat 9.x
- **Architecture Pattern**: MVC (Model-View-Controller)

### Project Structure
```
IS_ana-des_Final/
├── src/main/
│   ├── java/com/restaurant/
│   │   ├── model/          # Entity classes (Question 2)
│   │   │   ├── Dish.java
│   │   │   ├── Supplier.java
│   │   │   ├── ImportedInvoice.java
│   │   │   ├── ImportedInvoiceDetail.java
│   │   │   ├── Ingredient.java
│   │   │   └── Staff.java
│   │   ├── dao/            # Data Access Objects (Question 4)
│   │   │   ├── DAO.java
│   │   │   ├── DishDAO.java
│   │   │   ├── SupplierDAO.java
│   │   │   └── ImportedInvoiceDAO.java
│   │   └── servlet/        # Controllers (Question 3)
│   │       ├── DishServlet.java
│   │       ├── SupplierStatServlet.java
│   │       └── ImportedInvoiceServlet.java
│   └── webapp/             # Views (JSP files)
│       ├── DishSearchView.jsp
│       ├── EditDishView.jsp
│       ├── SupplierStatView.jsp
│       ├── ListImportInvoiceView.jsp
│       └── ImportInvoiceDetailView.jsp
├── database.sql            # Database schema (Question 4.a)
└── README.md
```

---

## 📊 Course Requirements Implementation

### Question 1: Use Case & Scenarios ✅
- **Use Case Diagram**: Identifies actors (Management Staff) and use cases for both modules
- **Scenarios**: Documented standard and alternative flows for:
  - Edit Dish Information
  - View Supplier Statistics

### Question 2: Entity Classes & Class Diagram ✅
**Extracted Entity Classes**:
- `Dish` (dishID, name, price, description, category, image)
- `Supplier` (supplierID, name, phone, email, address)
- `ImportedInvoice` (importInvoiceID, importDate, totalPrice, supplierID, warehouseStaffID)
- `ImportedInvoiceDetail` (importDetailID, quantity, price, importInvoiceID, ingredientID)
- `Ingredient` (ingredientID, name, unit, quantity, supplierID)
- `Staff` (staffID, username, password, name, phone, email, role)

**Entity Class Diagram**: Shows relationships and multiplicities between entities

### Question 3: Communication & Design Class Diagrams ✅
- **Communication Diagrams**: Illustrate object interactions and message passing for:
  - Edit Dish Information scenario
  - View Supplier Statistics scenario (drill-down navigation)
- **Detail Design Class Diagrams**: Include:
  - Boundary classes (Views)
  - Control classes (Servlets)
  - Entity classes (Models)
  - Methods with parameters and return types

### Question 4: Database & Java Implementation ✅
- **Database Design**: 
  - Normalized relational schema (3NF)
  - Primary keys, foreign keys, and constraints
  - See `database.sql` for complete schema
- **Java Code**:
  - Entity classes with getters/setters
  - DAO classes with CRUD operations
  - Servlet controllers with request handling
  - Comprehensive inline documentation

### Question 5: Package & Deployment Diagrams ✅
- **Package Diagram**: Organized into logical packages:
  - `com.restaurant.model` - Entity classes
  - `com.restaurant.dao` - Data access layer
  - `com.restaurant.servlet` - Controller layer
  - `webapp` - Presentation layer
- **Deployment Diagram**: Three-tier architecture:
  - Client Tier (Web Browser)
  - Application Tier (Tomcat Server with Servlets/JSP)
  - Data Tier (MySQL Database Server)

---

## 🚀 Getting Started

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat 9.x
- MySQL Server 5.7+
- Maven (optional, for dependency management)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd IS_ana-des_Final
   ```

2. **Setup Database**
   ```bash
   mysql -u root -p
   source database.sql
   ```

3. **Configure Database Connection**
   
   Edit `src/main/java/com/restaurant/dao/DAO.java`:
   ```java
   private static final String DB_URL = "jdbc:mysql://localhost:3306/RestaurantDB";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "your_password";
   ```

4. **Deploy to Tomcat**
   
   **Option 1: Using IntelliJ IDEA**
   - Import project
   - Configure Tomcat server (see `INTELLIJ_RUN_CONFIG_SAMPLE.xml`)
   - Run configuration

   **Option 2: Manual Deployment**
   ```bash
   # Build WAR file
   mvn clean package
   
   # Copy to Tomcat
   cp target/RestaurantManagement.war $TOMCAT_HOME/webapps/
   
   # Start Tomcat
   $TOMCAT_HOME/bin/startup.sh
   ```

5. **Access the Application**
   ```
   http://localhost:8080/RestaurantManagement/LoginView.jsp
   ```

### Default Login Credentials

| Role | Username | Password |
|------|----------|----------|
| Management Staff | admin | admin123 |
| Warehouse Staff | warehouse1 | warehouse123 |
| Sale Staff | sale1 | sale123 |

---

## 📖 User Guide

### Module 1: Edit Dish Information

1. Login as **Management Staff**
2. Navigate to **Home** → **Dish Management**
3. Enter dish name in search box and click **Search**
4. Click **Edit** button on the desired dish
5. Modify dish information (name, price, description, category)
6. Click **Save** to update the database

### Module 2: View Supplier Statistics

1. Login as **Management Staff**
2. Navigate to **Home** → **View Statistics**
3. Click on **Supplier Statistics**
4. Select **Start Date** and **End Date** for the report period
5. Click **View Statistics** to see supplier list with import quantities
6. Click on a **Supplier Name** to view their invoices
7. Click **👁️ View Details** button to see invoice details
8. View complete invoice information including:
   - Invoice ID and date
   - List of ingredients with quantities and prices
   - Total invoice amount

---

## 🗄️ Database Schema

### Key Tables

**Dish**
- Primary Key: `dishID`
- Attributes: name, price, description, category, image

**Supplier**
- Primary Key: `supplierID`
- Attributes: name, phone, email, address

**ImportedInvoice**
- Primary Key: `importInvoiceID`
- Foreign Keys: `supplierID`, `warehouseStaffID`
- Attributes: importDate, totalPrice

**ImportedInvoiceDetail**
- Primary Key: `importDetailID`
- Foreign Keys: `importInvoiceID`, `ingredientID`
- Attributes: quantity, price

**Ingredient**
- Primary Key: `ingredientID`
- Foreign Key: `supplierID`
- Attributes: name, unit, quantity

**Staff**
- Primary Key: `staffID`
- Attributes: username, password, name, phone, email, role

---

## [object Object] Patterns Used

### MVC Pattern
- **Model**: Entity classes and DAO classes
- **View**: JSP files for presentation
- **Controller**: Servlet classes for request handling

### DAO Pattern
- Separates data access logic from business logic
- Provides abstraction layer for database operations
- Implements CRUD operations for each entity

### Front Controller Pattern
- Servlets act as front controllers
- Handle routing based on action parameters
- Centralized request processing

---

## 🔒 Security Features

- **Authentication**: Session-based login system
- **Authorization**: Role-based access control (Management, Warehouse, Sale Staff)
- **Session Management**: Automatic redirect to login if session expired
- **SQL Injection Prevention**: PreparedStatement usage in all DAO classes
- **Password Security**: (Note: In production, implement password hashing)

---

## 📝 Key Features Implemented

### Dish Management Module
✅ Search dishes by name  
✅ View dish details  
✅ Edit dish information  
✅ Delete dishes  
✅ Add new dishes  
✅ Image upload support  
✅ Category management  

### Supplier Statistics Module
✅ Date range filtering  
✅ Supplier ranking by import quantity  
✅ Drill-down navigation (Supplier → Invoices → Details)  
✅ Invoice detail view with ingredient list  
✅ Total price calculation  
✅ Add new imported invoices  
✅ Dynamic ingredient selection  

---

## 🧪 Testing

### Test Scenarios

**Module 1: Edit Dish Information**
1. Search for existing dish ✅
2. Edit dish with valid data ✅
3. Edit dish with invalid data (validation) ✅
4. Save changes successfully ✅

**Module 2: Supplier Statistics**
1. View statistics with date range ✅
2. Navigate to supplier invoices ✅
3. View invoice details ✅
4. Verify ingredient list display ✅
5. Check total price calculation ✅

---

## 📚 Documentation

### Code Documentation
- All classes include JavaDoc comments
- Methods documented with parameters and return types
- Inline comments for complex logic

### Database Documentation
- ER diagram available
- Table relationships documented
- Sample data included in `database.sql`

---

## [object Object]

### Common Issues

**Issue**: Database connection error  
**Solution**: Check MySQL service is running and credentials in `DAO.java` are correct

**Issue**: 404 Error when accessing pages  
**Solution**: Verify Tomcat deployment and context path

**Issue**: Session timeout  
**Solution**: Increase session timeout in `web.xml` or re-login

**Issue**: Images not displaying  
**Solution**: Check image paths and ensure images are in `webapp/images/` directory

---

## [object Object] Team

- **Course**: Information System Analysis and Design
- **Institution**: [Your University Name]
- **Semester**: [Semester/Year]
- **Instructor**: [Instructor Name]

---

## 📄 License

This project is developed for educational purposes as part of the Information System Analysis and Design course.

---

## 📞 Contact & Support

For questions or issues related to this project:
- Email: [your-email@university.edu]
- Course Forum: [link-to-forum]

---

## 🎓 Academic Integrity

This project represents original work completed for the Information System Analysis and Design course. All external resources and references have been properly cited.

---

## 📅 Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2025-11 | Initial implementation of two modules |
| 1.1 | 2025-11 | UI improvements and bug fixes |
| 1.2 | 2025-11 | Added invoice detail view with ingredients |

---

## 🔮 Future Enhancements

- Customer module implementation
- Online ordering system
- Table reservation system
- Payment gateway integration
- Real-time inventory management
- Advanced reporting and analytics
- Mobile responsive design
- RESTful API development

---

**Note**: This README provides comprehensive documentation for the implemented modules. For detailed UML diagrams, design documents, and analysis artifacts, please refer to the accompanying project documentation.
