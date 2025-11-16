# Restaurant Management System

Hệ thống quản lý nhà hàng được xây dựng bằng Java Web (JSP, Servlet, DAO) với MySQL.

## Công nghệ sử dụng

- **Backend**: Java Servlet, JSP
- **Database**: MySQL
- **Server**: Apache Tomcat 9.x
- **Build Tool**: Maven

## Cấu trúc project

```
src/main/
├── java/com/restaurant/
│   ├── model/          # Các class entity
│   ├── dao/            # Data Access Object
│   └── servlet/        # Controller
└── webapp/             # JSP views
    ├── css/
    └── *.jsp
```

Project tuân theo mô hình **MVC**:
- **Model**: Các class trong package `com.restaurant.model` và `com.restaurant.dao`
- **View**: Các file JSP trong `webapp`
- **Controller**: Các Servlet trong `com.restaurant.servlet`
