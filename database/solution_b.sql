USE bke_center;
GO

-- 10. Liệt kê các hóa đơn của khách hàng: mã user, tên user, mã hóa đơn
SELECT u.user_id, u.user_name, o.order_id
FROM users u
JOIN orders o ON u.user_id = o.user_id;
GO

-- 11. Liệt kê số lượng hóa đơn của khách hàng: mã user, tên user, số đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS order_count
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;
GO

-- 12. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT o.order_id, COUNT(od.product_id) AS product_count
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;
GO

-- 13. Liệt kê thông tin mua hàng: mã user, tên user, mã đơn hàng, tên sản phẩm
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id;
GO

-- 14. Liệt kê 7 người dùng mua sản phẩm có tên 'Samsung' hoặc 'Apple'
SELECT DISTINCT TOP 7 u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%';
GO

-- 15. Liệt kê danh sách mua hàng: mã user, tên user, mã đơn hàng, tổng tiền
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_price
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id;
GO

-- 16. Liệt kê đơn hàng có tổng tiền nhỏ nhất của mỗi user
WITH RankedOrders AS (
    SELECT u.user_id, u.user_name, o.order_id, 
           SUM(p.product_price) AS total_price,
           COUNT(od.product_id) AS product_count,
           ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY SUM(p.product_price) ASC) AS rn
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
)
SELECT user_id, user_name, order_id, total_price, product_count
FROM RankedOrders
WHERE rn = 1;
GO

-- 17. (Giống câu 16, bỏ qua)

-- 18. Liệt kê đơn hàng có số sản phẩm nhiều nhất của mỗi user
WITH RankedOrders AS (
    SELECT u.user_id, u.user_name, o.order_id, 
           SUM(p.product_price) AS total_price,
           COUNT(od.product_id) AS product_count,
           ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY COUNT(od.product_id) DESC) AS rn
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
)
SELECT user_id, user_name, order_id, total_price, product_count
FROM RankedOrders
WHERE rn = 1;
GO
