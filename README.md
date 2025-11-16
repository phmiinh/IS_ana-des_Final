# Hệ thống Quản lý Nhà hàng (Restaurant Management System)

## Mô tả
Ứng dụng Web Java (JSP, Servlet, DAO) hoàn chỉnh cho quản lý nhà hàng, sử dụng cơ sở dữ liệu MySQL.

## Công nghệ sử dụng
- **Backend**: Java Servlet, JSP
- **Database**: MySQL 8.0+
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9.0+
- **Architecture**: MVC (Model-View-Controller)

## Cấu trúc Dự án
```
restaurant-management/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/restaurant/
│       │       ├── model/          # POJOs (19 classes)
│       │       ├── dao/            # Data Access Objects
│       │       └── servlet/        # Controllers
│       └── webapp/
│           ├── css/
│           │   └── style.css       # Professional CSS
│           ├── WEB-INF/
│           │   └── web.xml         # Web configuration
│           └── *.jsp               # View pages (8 files)
├── database.sql                    # Database schema & sample data
├── pom.xml                         # Maven configuration
└── README.md                       # This file
```

## Hướng dẫn Cài đặt

### 1. Yêu cầu Hệ thống
- JDK 11 hoặc cao hơn
- Apache Tomcat 9.0+
- MySQL 8.0+
- Maven 3.6+

### 2. Cài đặt Cơ sở Dữ liệu

1. Mở MySQL Workbench hoặc MySQL Command Line
2. Chạy file `database.sql`:
   ```sql
   source /path/to/database.sql
   ```
   Hoặc copy nội dung file và execute trong MySQL Workbench

3. Kiểm tra database đã được tạo:
   ```sql
   USE restaurant_db;
   SHOW TABLES;
   ```

### 3. Cấu hình Kết nối Database

Mở file `src/main/java/com/restaurant/dao/DAO.java` và cập nhật thông tin kết nối:

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant_db";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_password_here";
```

### 4. Build Dự án

```bash
# Di chuyển vào thư mục dự án
cd restaurant-management

# Build với Maven
mvn clean package
```

File WAR sẽ được tạo tại: `target/restaurant-management.war`

### 5. Deploy lên Tomcat

**Cách 1: Sử dụng Tomcat Manager**
1. Copy file `restaurant-management.war` vào thư mục `webapps` của Tomcat
2. Khởi động Tomcat
3. Truy cập: `http://localhost:8080/restaurant-management`

**Cách 2: Sử dụng IDE (Eclipse/IntelliJ)**
1. Import project as Maven project
2. Configure Tomcat server trong IDE
3. Run project trên Tomcat server

## Tài khoản Đăng nhập Mẫu

| Username  | Password | Vai trò           |
|-----------|----------|-------------------|
| manager   | 123      | Management Staff  |
| warehouse | 123      | Warehouse Staff   |
| sale      | 123      | Sale Staff        |

## Chức năng Chính

### Module 1: Quản lý Món ăn
- ✅ Tìm kiếm món ăn theo tên
- ✅ Xem danh sách món ăn
- ✅ Sửa thông tin món ăn (tên, mô tả, giá)
- ✅ Hiển thị thông báo sau khi cập nhật thành công

### Module 2: Thống kê Nhà cung cấp
- ✅ Xem thống kê nhà cung cấp theo khoảng thời gian
- ✅ Drill-down Level 1: Xem danh sách hóa đơn nhập của nhà cung cấp
- ✅ Drill-down Level 2: Xem chi tiết nguyên liệu trong hóa đơn

### Tính năng Khác
- ✅ Đăng nhập với xác thực vai trò
- ✅ Session management
- ✅ Giao diện hiện đại, responsive
- ✅ Sidebar navigation với trạng thái active
- ✅ Professional UI/UX design

## Cấu trúc Database

Hệ thống sử dụng **19 bảng** với mô hình kế thừa "Table Per Subclass":

### Nhóm Actor & Customer
- Staff (cha)
- ManagementStaff, WarehouseStaff, SaleStaff (con - kế thừa)
- Customer
- Membership

### Nhóm Giao dịch & Bán hàng
- Table
- Reservation
- Invoice
- Order

### Nhóm Menu & Junction Tables
- Dish
- Combo
- OrderDish
- OrderCombo
- DishCombo

### Nhóm Kho & Nhập hàng
- Supplier
- Ingredient
- ImportedInvoice
- ImportedInvoiceDetail

## Kiến trúc MVC

### Model (com.restaurant.model)
19 POJO classes đại diện cho các entity trong database

### DAO (com.restaurant.dao)
- `DAO.java` - Base class với database connection
- `StaffDAO.java` - Xử lý đăng nhập
- `DishDAO.java` - CRUD operations cho món ăn
- `SupplierStatDAO.java` - Thống kê nhà cung cấp
- `ImportedInvoiceDAO.java` - Quản lý hóa đơn nhập

### Controller (com.restaurant.servlet)
- `StaffServlet.java` - Login/Logout
- `DishServlet.java` - Quản lý món ăn
- `SupplierStatServlet.java` - Thống kê
- `ImportedInvoiceServlet.java` - Drill-down hóa đơn

### View (JSP)
8 trang JSP với giao diện chuyên nghiệp:
- LoginView.jsp
- ManagementHomeView.jsp
- ManageDishView.jsp
- EditDishView.jsp
- SelectStatisticView.jsp
- SupplierStatView.jsp
- ListImportInvoiceView.jsp
- ImportInvoiceDetailView.jsp

## Giao diện UI/UX

### Đặc điểm
- ✅ Bố cục 2 cột: Sidebar + Main Content
- ✅ Sidebar navigation cố định với trạng thái active
- ✅ Header/Taskbar hiển thị tên người dùng
- ✅ Font chuyên nghiệp (Inter, Roboto)
- ✅ Bảng màu nhất quán (xanh dương chính)
- ✅ Khoảng cách hợp lý, dễ đọc
- ✅ Tables với hover effects
- ✅ Forms được định dạng đẹp mắt
- ✅ Responsive design

## Xử lý Lỗi

Ứng dụng có xử lý lỗi cho:
- Đăng nhập thất bại
- Dữ liệu không hợp lệ
- Kết nối database lỗi
- Session timeout

## Bảo mật

- Session-based authentication
- Password validation
- SQL injection prevention (PreparedStatement)
- XSS protection (JSTL escaping)

## Troubleshooting

### Lỗi kết nối Database
```
Error: Communications link failure
```
**Giải pháp**: Kiểm tra MySQL service đang chạy và thông tin kết nối trong `DAO.java`

### Lỗi 404 Not Found
**Giải pháp**: Đảm bảo context path đúng: `/restaurant-management`

### Lỗi Encoding (Tiếng Việt hiển thị sai)
**Giải pháp**: Đã được xử lý trong `web.xml` với UTF-8 filter

## Tác giả
Developed by Professional Full-Stack J2EE Developer

## License
Educational Purpose - Restaurant Management System
