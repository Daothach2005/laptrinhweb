-- Tạo cơ sở dữ liệu
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'bke_center')
BEGIN
    CREATE DATABASE bke_center;
END;
GO

USE bke_center;
GO

-- Tạo bảng users
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    user_name VARCHAR(25) NOT NULL,
    user_email VARCHAR(55) NOT NULL,
    user_pass VARCHAR(255) NOT NULL,
    updated_at DATETIME,
    created_at DATETIME
);
GO

-- Tạo bảng products
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price FLOAT NOT NULL, -- DOUBLE không được hỗ trợ trong SQL Server, dùng FLOAT thay thế
    product_description TEXT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME
);
GO

-- Tạo bảng orders
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME,
    CONSTRAINT FK_orders_users FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- Tạo bảng order_details
CREATE TABLE order_details (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME,
    CONSTRAINT FK_order_details_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT FK_order_details_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);
GO
Go

-- Chèn dữ liệu vào bảng users
INSERT INTO users (user_name, user_email, user_pass, created_at) VALUES
('minh', 'minh@gmail.com', 'password123', GETDATE()),
('an', 'an@gmail.com', 'password123', GETDATE()),
('mai', 'mai@yahoo.com', 'password123', GETDATE()),
('nam', 'nam@gmail.com', 'password123', GETDATE()),
('hoa', 'hoa@gmail.com', 'password123', GETDATE()),
('linh', 'linh@gmail.com', 'password123', GETDATE()),
('khanh', 'khanh@gmail.com', 'password123', GETDATE()),
('thai', 'thai@gmail.com', 'password123', GETDATE()),
('phuong', 'phuong@yahoo.com', 'password123', GETDATE()),
('trang', 'trang@gmail.com', 'password123', GETDATE());
GO

-- Chèn dữ liệu vào bảng products
INSERT INTO products (product_name, product_price, product_description, created_at) VALUES
('Samsung Galaxy S21', 15000000, 'Điện thoại Samsung', GETDATE()),
('iPhone 14', 20000000, 'Điện thoại Apple', GETDATE()),
('MacBook Pro', 35000000, 'Laptop Apple', GETDATE()),
('Samsung TV 55 inch', 12000000, 'TV Samsung', GETDATE()),
('Sony Headphones', 5000000, 'Tai nghe Sony', GETDATE());
GO

-- Chèn dữ liệu vào bảng orders
INSERT INTO orders (user_id, created_at) VALUES
(1, GETDATE()),
(1, GETDATE()),
(2, GETDATE()),
(3, GETDATE()),
(4, GETDATE()),
(5, GETDATE()),
(6, GETDATE());
GO

-- Chèn dữ liệu vào bảng order_details
INSERT INTO order_details (order_id, product_id, created_at) VALUES
(1, 1, GETDATE()),
(1, 2, GETDATE()),
(2, 3, GETDATE()),
(3, 1, GETDATE()),
(4, 2, GETDATE()),
(5, 4, GETDATE()),
(6, 5, GETDATE()),
(7, 1, GETDATE());
GO

GO

-- 1. Lấy danh sách người dùng theo thứ tự tên (A->Z)
SELECT * FROM users
ORDER BY user_name ASC; ---ASC sắp xếp theo thứ tự tăng dần ,desc sắp xếp theo thứ tưn giảm dần 
GO
GO
-- 2. Lấy 7 người dùng theo thứ tự tên (A->Z)
SELECT TOP 7 * FROM users
ORDER BY user_name ASC;
GO
GO
-- 3. Lấy danh sách người dùng có chữ 'a' trong tên, sắp xếp theo tên (A->Z)
SELECT * FROM users
WHERE user_name LIKE '%a%'
ORDER BY user_name ASC;
GO
GO
-- 4. Lấy danh sách người dùng có tên bắt đầu bằng chữ 'm'
SELECT * FROM users
WHERE user_name LIKE '%m%';
GO
GO

-- 5. Lấy danh sách người dùng có tên kết thúc bằng chữ 'i'
SELECT * FROM users
WHERE user_name LIKE '%i%';
GO
GO

-- 6. Lấy danh sách người dùng có email là Gmail
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com%';
GO
GO
-- 7. Lấy danh sách người dùng có email là Gmail và tên bắt đầu bằng chữ 'm'
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com%'
AND user_name LIKE 'm%';
GO
GO
-- 8. Lấy danh sách người dùng có email là Gmail, tên có chữ 'i', và tên dài hơn 5 ký tự
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com%'
AND user_name LIKE '%i%'
AND LEN(user_name) > 5;
GO
GO
-- 9. Lấy danh sách người dùng có chữ 'a' trong tên, tên dài từ 5 đến 9 ký tự, email là Gmail, và email có chữ 'i'
SELECT * FROM users
WHERE user_name LIKE '%a%'
AND LEN(user_name) BETWEEN 5 AND 9
AND user_email LIKE '%@gmail.com'
AND user_email LIKE '%i%';
