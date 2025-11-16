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

/* --- STAFF DATA --- */
INSERT INTO Staff (username, password, name, phone, email) VALUES
('manager', '123', 'Nguyen Van Anh', '0911111111', 'anh.nguyen@restaurant.com'),
('manager2', '123', 'Tran Thi Mai', '0911222333', 'mai.tran@restaurant.com'),
('warehouse', '123', 'Le Van Binh', '0922222222', 'binh.le@restaurant.com'),
('warehouse2', '123', 'Pham Thi Lan', '0922333444', 'lan.pham@restaurant.com'),
('sale', '123', 'Hoang Van Cuong', '0933333333', 'cuong.hoang@restaurant.com'),
('sale2', '123', 'Vo Thi Dung', '0933444555', 'dung.vo@restaurant.com');

INSERT INTO ManagementStaff (username) VALUES ('manager'), ('manager2');
INSERT INTO WarehouseStaff (username) VALUES ('warehouse'), ('warehouse2');
INSERT INTO SaleStaff (username) VALUES ('sale'), ('sale2');

/* --- DISH DATA (Extended) --- */
INSERT INTO Dish (name, description, price, managementStaffID) VALUES
('Pho Bo Dac Biet', 'Special beef pho with rare beef, brisket, tendon and tripe', 65000.0, 1),
('Com Rang Hai San', 'Seafood fried rice with shrimp, squid and vegetables', 80000.0, 1),
('Bun Cha Ha Noi', 'Traditional Hanoi grilled pork with vermicelli', 50000.0, 1),
('Banh Mi Thit Nuong', 'Grilled pork banh mi with pate and pickled vegetables', 35000.0, 1),
('Goi Cuon Tom Thit', 'Fresh spring rolls with shrimp and pork', 45000.0, 1),
('Bun Bo Hue', 'Spicy beef noodle soup from Hue', 60000.0, 2),
('Mi Xao Gion', 'Crispy fried noodles with mixed vegetables', 70000.0, 2),
('Canh Chua Ca', 'Sweet and sour fish soup', 85000.0, 2),
('Com Tam Suon Bi', 'Broken rice with grilled pork chop and shredded pork skin', 55000.0, 2),
('Hu Tieu Nam Vang', 'Phnom Penh style noodle soup', 58000.0, 1),
('Banh Xeo', 'Vietnamese crispy pancake with pork and shrimp', 48000.0, 2),
('Ca Kho To', 'Caramelized fish in clay pot', 95000.0, 1),
('Thit Kho Trung', 'Braised pork with eggs', 75000.0, 2),
('Ga Nuong Mat Ong', 'Honey grilled chicken', 120000.0, 1),
('Tom Rang Muoi', 'Salt and pepper shrimp', 150000.0, 2);

/* --- SUPPLIER DATA (Extended) --- */
INSERT INTO Supplier (name, phone, email, address) VALUES
('Da Lat Fresh Vegetables Co.', '02633888999', 'contact@dalatveggies.com', '123 Tran Hung Dao, Da Lat, Lam Dong'),
('Vissan Meat Products', '02835566777', 'sales@vissan.com.vn', '456 Nguyen Trai, District 5, Ho Chi Minh City'),
('Hai San Viet Seafood', '02363999888', 'info@haisanviet.vn', '789 Tran Phu, Nha Trang, Khanh Hoa'),
('Golden Rice Supply', '02433777666', 'order@goldenrice.com', '321 Le Duan, Dong Da, Hanoi'),
('Saigon Spices Trading', '02838555444', 'contact@saigonspices.vn', '654 Hai Ba Trung, District 1, Ho Chi Minh City'),
('Fresh Herbs Garden', '02633222111', 'sales@freshherbs.com', '987 Phan Dinh Phung, Da Lat, Lam Dong');

/* --- INGREDIENT DATA (Extended & Realistic) --- */
INSERT INTO Ingredient (name, stock, price) VALUES
-- Meat & Protein
('Beef (Thit Bo)', 150.0, 280000.0),
('Pork (Thit Heo)', 200.0, 180000.0),
('Chicken (Thit Ga)', 180.0, 120000.0),
('Shrimp (Tom)', 80.0, 350000.0),
('Squid (Muc)', 60.0, 220000.0),
('Fish (Ca)', 100.0, 150000.0),
('Eggs (Trung)', 500.0, 3500.0),

-- Vegetables
('Cabbage (Bap Cai)', 50.0, 25000.0),
('Carrot (Ca Rot)', 40.0, 18000.0),
('Tomato (Ca Chua)', 45.0, 22000.0),
('Lettuce (Xa Lach)', 30.0, 35000.0),
('Cucumber (Dua Leo)', 35.0, 15000.0),
('Bean Sprouts (Gia)', 25.0, 12000.0),
('Onion (Hanh Tay)', 60.0, 20000.0),
('Garlic (Toi)', 40.0, 80000.0),

-- Herbs & Spices
('Cilantro (Rau Mui)', 15.0, 30000.0),
('Mint (Rau Hung)', 12.0, 28000.0),
('Basil (Rau Que)', 10.0, 32000.0),
('Lemongrass (Sa)', 20.0, 25000.0),
('Ginger (Gung)', 30.0, 45000.0),
('Chili (Ot)', 18.0, 55000.0),
('Black Pepper (Tieu Den)', 25.0, 180000.0),
('Salt (Muoi)', 100.0, 8000.0),
('Sugar (Duong)', 120.0, 18000.0),
('Fish Sauce (Nuoc Mam)', 80.0, 35000.0),
('Soy Sauce (Nuoc Tuong)', 70.0, 28000.0),

-- Noodles & Rice
('Rice Noodles (Banh Pho)', 100.0, 45000.0),
('Vermicelli (Bun)', 90.0, 42000.0),
('Rice (Gao)', 300.0, 22000.0),
('Egg Noodles (Mi Trung)', 80.0, 38000.0),

-- Oils & Condiments
('Cooking Oil (Dau An)', 150.0, 45000.0),
('Sesame Oil (Dau Me)', 40.0, 85000.0),
('Oyster Sauce (Dau Hao)', 50.0, 42000.0),
('Hoisin Sauce (Tuong Den)', 45.0, 38000.0);

/* --- IMPORTED INVOICE DATA (Extended & Realistic) --- */
INSERT INTO ImportedInvoice (importDate, totalPrice, supplierID, warehouseStaffID) VALUES
-- October 2025
('2025-10-15', 5250000.0, 2, 1),  -- Vissan Meat
('2025-10-16', 1850000.0, 1, 2),  -- Da Lat Vegetables
('2025-10-18', 3420000.0, 3, 1),  -- Hai San Viet Seafood
('2025-10-20', 2180000.0, 4, 2),  -- Golden Rice
('2025-10-22', 1650000.0, 5, 1),  -- Saigon Spices
('2025-10-25', 980000.0, 6, 2),   -- Fresh Herbs

-- November 2025
('2025-11-01', 6800000.0, 2, 1),  -- Vissan Meat
('2025-11-03', 2250000.0, 1, 2),  -- Da Lat Vegetables
('2025-11-05', 4150000.0, 3, 1),  -- Hai San Viet Seafood
('2025-11-07', 2850000.0, 4, 2),  -- Golden Rice
('2025-11-09', 1980000.0, 5, 1),  -- Saigon Spices
('2025-11-11', 1320000.0, 6, 2),  -- Fresh Herbs
('2025-11-13', 5450000.0, 2, 1),  -- Vissan Meat
('2025-11-15', 1750000.0, 1, 2);  -- Da Lat Vegetables

/* --- IMPORTED INVOICE DETAIL DATA (Comprehensive) --- */

-- Invoice 1 (2025-10-15) - Vissan Meat Products
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(15.0, 280000.0, 1, 1),   -- Beef 15kg
(20.0, 180000.0, 1, 2),   -- Pork 20kg
(10.0, 120000.0, 1, 3);   -- Chicken 10kg

-- Invoice 2 (2025-10-16) - Da Lat Vegetables
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(30.0, 25000.0, 2, 8),    -- Cabbage 30kg
(25.0, 18000.0, 2, 9),    -- Carrot 25kg
(20.0, 22000.0, 2, 10),   -- Tomato 20kg
(15.0, 35000.0, 2, 11),   -- Lettuce 15kg
(20.0, 15000.0, 2, 12),   -- Cucumber 20kg
(10.0, 12000.0, 2, 13);   -- Bean Sprouts 10kg

-- Invoice 3 (2025-10-18) - Hai San Viet Seafood
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(8.0, 350000.0, 3, 4),    -- Shrimp 8kg
(6.0, 220000.0, 3, 5),    -- Squid 6kg
(10.0, 150000.0, 3, 6);   -- Fish 10kg

-- Invoice 4 (2025-10-20) - Golden Rice Supply
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(50.0, 22000.0, 4, 30),   -- Rice 50kg
(20.0, 45000.0, 4, 28),   -- Rice Noodles 20kg
(15.0, 42000.0, 4, 29),   -- Vermicelli 15kg
(10.0, 38000.0, 4, 31);   -- Egg Noodles 10kg

-- Invoice 5 (2025-10-22) - Saigon Spices Trading
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(10.0, 80000.0, 5, 15),   -- Garlic 10kg
(5.0, 45000.0, 5, 20),    -- Ginger 5kg
(3.0, 55000.0, 5, 21),    -- Chili 3kg
(2.0, 180000.0, 5, 22),   -- Black Pepper 2kg
(15.0, 35000.0, 5, 25),   -- Fish Sauce 15L
(10.0, 28000.0, 5, 26);   -- Soy Sauce 10L

-- Invoice 6 (2025-10-25) - Fresh Herbs Garden
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(8.0, 30000.0, 6, 16),    -- Cilantro 8kg
(7.0, 28000.0, 6, 17),    -- Mint 7kg
(6.0, 32000.0, 6, 18),    -- Basil 6kg
(10.0, 25000.0, 6, 19);   -- Lemongrass 10kg

-- Invoice 7 (2025-11-01) - Vissan Meat Products
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(20.0, 280000.0, 7, 1),   -- Beef 20kg
(25.0, 180000.0, 7, 2),   -- Pork 25kg
(15.0, 120000.0, 7, 3),   -- Chicken 15kg
(100.0, 3500.0, 7, 7);    -- Eggs 100 pieces

-- Invoice 8 (2025-11-03) - Da Lat Vegetables
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(35.0, 25000.0, 8, 8),    -- Cabbage 35kg
(30.0, 18000.0, 8, 9),    -- Carrot 30kg
(25.0, 22000.0, 8, 10),   -- Tomato 25kg
(20.0, 35000.0, 8, 11),   -- Lettuce 20kg
(15.0, 20000.0, 8, 14);   -- Onion 15kg

-- Invoice 9 (2025-11-05) - Hai San Viet Seafood
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(10.0, 350000.0, 9, 4),   -- Shrimp 10kg
(8.0, 220000.0, 9, 5),    -- Squid 8kg
(12.0, 150000.0, 9, 6);   -- Fish 12kg

-- Invoice 10 (2025-11-07) - Golden Rice Supply
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(60.0, 22000.0, 10, 30),  -- Rice 60kg
(25.0, 45000.0, 10, 28),  -- Rice Noodles 25kg
(20.0, 42000.0, 10, 29),  -- Vermicelli 20kg
(15.0, 38000.0, 10, 31);  -- Egg Noodles 15kg

-- Invoice 11 (2025-11-09) - Saigon Spices Trading
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(12.0, 80000.0, 11, 15),  -- Garlic 12kg
(20.0, 8000.0, 11, 23),   -- Salt 20kg
(15.0, 18000.0, 11, 24),  -- Sugar 15kg
(10.0, 45000.0, 11, 32),  -- Cooking Oil 10L
(5.0, 85000.0, 11, 33);   -- Sesame Oil 5L

-- Invoice 12 (2025-11-11) - Fresh Herbs Garden
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(10.0, 30000.0, 12, 16),  -- Cilantro 10kg
(9.0, 28000.0, 12, 17),   -- Mint 9kg
(8.0, 32000.0, 12, 18),   -- Basil 8kg
(12.0, 25000.0, 12, 19);  -- Lemongrass 12kg

-- Invoice 13 (2025-11-13) - Vissan Meat Products
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(18.0, 280000.0, 13, 1),  -- Beef 18kg
(22.0, 180000.0, 13, 2),  -- Pork 22kg
(12.0, 120000.0, 13, 3);  -- Chicken 12kg

-- Invoice 14 (2025-11-15) - Da Lat Vegetables
INSERT INTO ImportedInvoiceDetail (quantity, price, importInvoiceID, ingredientID) VALUES
(28.0, 25000.0, 14, 8),   -- Cabbage 28kg
(22.0, 18000.0, 14, 9),   -- Carrot 22kg
(18.0, 22000.0, 14, 10),  -- Tomato 18kg
(15.0, 15000.0, 14, 12),  -- Cucumber 15kg
(12.0, 12000.0, 14, 13);  -- Bean Sprouts 12kg

/* --- CUSTOMER DATA (Optional - for future use) --- */
INSERT INTO Customer (name, phone, email) VALUES
('Nguyen Thi Hoa', '0901234567', 'hoa.nguyen@email.com'),
('Tran Van Khanh', '0912345678', 'khanh.tran@email.com'),
('Le Thi Lan', '0923456789', 'lan.le@email.com'),
('Pham Van Minh', '0934567890', 'minh.pham@email.com'),
('Vo Thi Nga', '0945678901', 'nga.vo@email.com');

/* --- TABLE DATA (Optional - for future use) --- */
INSERT INTO `Table` (type, available) VALUES
('Small (2 seats)', true),
('Small (2 seats)', true),
('Medium (4 seats)', true),
('Medium (4 seats)', true),
('Large (6 seats)', true),
('Large (6 seats)', false),
('VIP (8 seats)', true),
('VIP (10 seats)', true);
