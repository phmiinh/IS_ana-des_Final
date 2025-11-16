CREATE DATABASE IF NOT EXISTS restaurant_management;
USE restaurant_management;

CREATE TABLE Staff (
    username VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Customer (
    customerID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Membership (
    cardID INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50),
    points INT DEFAULT 0,
    startDate DATE,
    dueDate DATE,
    customerID INT UNIQUE,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE ManagementStaff (
    managementStaffID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    FOREIGN KEY (username) REFERENCES Staff(username)
);

CREATE TABLE WarehouseStaff (
    warehouseStaffID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    FOREIGN KEY (username) REFERENCES Staff(username)
);

CREATE TABLE SaleStaff (
    saleStaffID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    FOREIGN KEY (username) REFERENCES Staff(username)
);

CREATE TABLE `Table` (
    tableID INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50),
    available BOOLEAN DEFAULT true
);

CREATE TABLE Reservation (
    reservationID INT PRIMARY KEY AUTO_INCREMENT,
    reservationTime DATETIME NOT NULL,
    status VARCHAR(50),
    customerID INT,
    tableID INT,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    FOREIGN KEY (tableID) REFERENCES `Table`(tableID)
);

CREATE TABLE Invoice (
    invoiceID INT PRIMARY KEY AUTO_INCREMENT,
    paymentDate DATE,
    status VARCHAR(50),
    reservationID INT,
    saleStaffID INT,
    FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID),
    FOREIGN KEY (saleStaffID) REFERENCES SaleStaff(saleStaffID)
);

CREATE TABLE `Order` (
    orderID INT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    price FLOAT,
    reservationID INT,
    invoiceID INT,
    FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID),
    FOREIGN KEY (invoiceID) REFERENCES Invoice(invoiceID)
);

CREATE TABLE Dish (
    dishID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1000),
    price FLOAT,
    managementStaffID INT,
    FOREIGN KEY (managementStaffID) REFERENCES ManagementStaff(managementStaffID)
);

CREATE TABLE Combo (
    comboID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price FLOAT,
    description VARCHAR(1000)
);

CREATE TABLE OrderDish (
    orderDishID INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT,
    price FLOAT,
    orderID INT,
    dishID INT,
    FOREIGN KEY (orderID) REFERENCES `Order`(orderID),
    FOREIGN KEY (dishID) REFERENCES Dish(dishID)
);

CREATE TABLE OrderCombo (
    orderComboID INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT,
    price FLOAT,
    orderID INT,
    comboID INT,
    FOREIGN KEY (orderID) REFERENCES `Order`(orderID),
    FOREIGN KEY (comboID) REFERENCES Combo(comboID)
);

CREATE TABLE DishCombo (
    dishComboID INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT,
    dishID INT,
    comboID INT,
    FOREIGN KEY (dishID) REFERENCES Dish(dishID),
    FOREIGN KEY (comboID) REFERENCES Combo(comboID)
);

CREATE TABLE Supplier (
    supplierID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    email VARCHAR(255),
    address VARCHAR(500)
);

CREATE TABLE Ingredient (
    ingredientID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    stock FLOAT,
    price FLOAT
);

CREATE TABLE ImportedInvoice (
    importInvoiceID INT PRIMARY KEY AUTO_INCREMENT,
    importDate DATE,
    totalPrice FLOAT,
    supplierID INT,
    warehouseStaffID INT,
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID),
    FOREIGN KEY (warehouseStaffID) REFERENCES WarehouseStaff(warehouseStaffID)
);

CREATE TABLE ImportedInvoiceDetail (
    importDetailID INT PRIMARY KEY AUTO_INCREMENT,
    quantity FLOAT,
    price FLOAT,
    importInvoiceID INT,
    ingredientID INT,
    FOREIGN KEY (importInvoiceID) REFERENCES ImportedInvoice(importInvoiceID),
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID)
);
