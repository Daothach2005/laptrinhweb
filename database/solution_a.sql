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
