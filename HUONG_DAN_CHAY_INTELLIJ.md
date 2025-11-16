# HƯỚNG DẪN CHẠY DỰ ÁN BẰNG INTELLIJ IDEA

## Bước 1: Import Project vào IntelliJ

1. Mở IntelliJ IDEA
2. Chọn **File → Open**
3. Chọn thư mục chứa file `pom.xml`
4. IntelliJ sẽ tự động nhận diện đây là Maven project
5. Đợi IntelliJ download dependencies (có thể mất vài phút)

## Bước 2: Cấu hình Tomcat Server

### 2.1. Download Tomcat (nếu chưa có)
- Tải Apache Tomcat 9.0: https://tomcat.apache.org/download-90.cgi
- Giải nén vào thư mục (ví dụ: `C:\apache-tomcat-9.0.xx`)

### 2.2. Thêm Tomcat vào IntelliJ

1. Vào **Run → Edit Configurations...**
2. Click dấu **+** (Add New Configuration)
3. Chọn **Tomcat Server → Local**
4. Đặt tên: `Tomcat 9 - Restaurant`
5. Click **Configure...** bên cạnh Application server
6. Chọn thư mục Tomcat đã giải nén
7. Click **OK**

### 2.3. Deploy Application

1. Trong cửa sổ Configuration, chọn tab **Deployment**
2. Click dấu **+** → **Artifact...**
3. Chọn **restaurant-management:war exploded**
4. Trong **Application context**, đổi thành: `/restaurant-management`
5. Click **Apply** → **OK**

## Bước 3: Cấu hình Database

1. Mở MySQL Workbench
2. Chạy file `database.sql` để tạo database
3. Mở file: `src/main/java/com/restaurant/dao/DAO.java`
4. Cập nhật thông tin kết nối:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant_management";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = ""; 
```

## Bước 4: Build và Run

1. Click vào **Maven** tab (bên phải IntelliJ)
2. Expand **Lifecycle**
3. Double-click **clean** → đợi hoàn thành
4. Double-click **package** → đợi hoàn thành
5. Click nút **Run** (▶️) hoặc **Shift + F10**
6. Tomcat sẽ khởi động và tự động mở browser

## Bước 5: Truy cập Application

- URL: `http://localhost:8080/restaurant-management`
- Trang đăng nhập sẽ hiển thị
- Dùng tài khoản: `manager` / `123`

## Troubleshooting

### Lỗi: Can't find catalina.jar
**Nguyên nhân**: IntelliJ không tìm thấy Tomcat hoặc cấu hình sai đường dẫn

**Giải pháp**:

**Cách 1: Cấu hình lại Tomcat từ đầu**
1. **Run → Edit Configurations...**
2. Chọn configuration Tomcat hiện tại → Click dấu **-** (Remove) để xóa
3. Click dấu **+** → **Tomcat Server → Local**
4. Đặt tên: `Tomcat 9 - Restaurant`
5. Click **Configure...** bên cạnh **Application server**
6. **QUAN TRỌNG**: Chọn đúng thư mục gốc của Tomcat (thư mục chứa các folder: `bin`, `lib`, `webapps`, `conf`)
   - ✅ Đúng: `C:\apache-tomcat-9.0.xx\` (thư mục gốc)
   - ❌ Sai: `C:\apache-tomcat-9.0.xx\bin\` (thư mục con)
7. IntelliJ sẽ tự động detect và hiển thị: **Tomcat 9.0.xx**
8. Click **OK**
9. Tab **Deployment** → Click **+** → **Artifact** → Chọn `restaurant-management:war exploded`
10. **Application context**: `/restaurant-management`
11. Click **Apply** → **OK**

**Cách 2: Download Tomcat đúng cách**
1. Truy cập: https://tomcat.apache.org/download-90.cgi
2. Trong mục **Binary Distributions → Core**:
   - Windows: Tải **32-bit/64-bit Windows Service Installer (pgp, sha512)** hoặc **64-bit Windows zip (pgp, sha512)**
   - Khuyến nghị: Tải file **ZIP** để dễ cấu hình
3. Giải nén vào thư mục (ví dụ: `C:\apache-tomcat-9.0.84\`)
4. Kiểm tra cấu trúc thư mục:
   ```
   C:\apache-tomcat-9.0.84\
   ├── bin\
   │   ├── catalina.bat
   │   ├── startup.bat
   │   └── shutdown.bat
   ├── lib\
   │   ├── catalina.jar  ← File này phải có!
   │   ├── servlet-api.jar
   │   └── ...
   ├── webapps\
   ├── conf\
   ├── logs\
   └── temp\
   ```
5. Quay lại IntelliJ và cấu hình lại theo **Cách 1**

**Cách 3: Kiểm tra file catalina.jar**
1. Mở thư mục Tomcat của bạn
2. Vào thư mục `lib\`
3. Kiểm tra xem có file `catalina.jar` không
4. Nếu không có → Tomcat bị lỗi, cần download lại
5. Nếu có → Quay lại IntelliJ và cấu hình lại đường dẫn

**Cách 4: Sử dụng Tomcat Embedded (Không cần cài Tomcat)**
1. Thêm plugin vào `pom.xml`:
   ```xml
   <build>
       <finalName>restaurant-management</finalName>
       <plugins>
           <plugin>
               <groupId>org.apache.tomcat.maven</groupId>
               <artifactId>tomcat7-maven-plugin</artifactId>
               <version>2.2</version>
               <configuration>
                   <path>/restaurant-management</path>
                   <port>8080</port>
               </configuration>
           </plugin>
       </plugins>
   </build>
   ```
2. Chạy bằng Maven command:
   - Mở Terminal trong IntelliJ
   - Chạy: `mvn tomcat7:run`
3. Truy cập: `http://localhost:8080/restaurant-management`

### Lỗi: Port 8080 already in use
**Giải pháp**: 
- Đổi port trong Tomcat configuration (Run → Edit Configurations → HTTP port: 8081)
- Hoặc tắt ứng dụng đang chiếm port 8080

### Lỗi: Cannot connect to database
**Giải pháp**:
- Kiểm tra MySQL service đang chạy
- Kiểm tra username/password trong `DAO.java`
- Kiểm tra database `restaurant_db` đã được tạo

### Lỗi: 404 Not Found
**Giải pháp**:
- Kiểm tra Application context phải là `/restaurant-management`
- Kiểm tra artifact đã được deploy

### Lỗi: Class not found
**Giải pháo**:
- Maven → Reimport
- File → Invalidate Caches / Restart

## Hot Reload (Tự động reload khi sửa code)

1. Run → Edit Configurations
2. Chọn Tomcat configuration
3. Tab **Server**
4. Trong **On 'Update' action**: chọn **Update classes and resources**
5. Trong **On frame deactivation**: chọn **Update classes and resources**
6. Bây giờ khi sửa code, chỉ cần **Ctrl + F10** để reload

## Debug Mode

1. Click nút **Debug** (🐛) thay vì Run
2. Đặt breakpoint bằng cách click vào lề trái của dòng code
3. Khi chạy đến breakpoint, IntelliJ sẽ dừng lại để bạn kiểm tra

---

**Lưu ý**: Ứng dụng Web J2EE không có file `Main.java`. Entry point là Servlet Container (Tomcat).

