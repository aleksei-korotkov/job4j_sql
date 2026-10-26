-- все пользователи и количество заказов:
SELECT
    u.id AS user_id,
    u.name AS user_name,
    COUNT(o.id) AS total_orders
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY u.id;

-- заказы, по которым не было платежа:
SELECT
    o.id AS order_id,
    o.status,
    o.created_at
FROM orders o
LEFT JOIN payments p ON p.order_id = o.id
WHERE p.id IS NULL;

-- Товары, которые встречались хотя бы в одном заказе:
SELECT
    p.id AS product_id,
    p.name AS product_name,
    COUNT(oi.id) AS times_in_order_items
FROM products p
JOIN order_items oi ON oi.product_id = p.id
GROUP BY p.id, p.name
ORDER BY times_in_order_items DESC;

-- Роли и количество пользователей:
SELECT
    r.code AS role_code,
    r.name AS role_name,
    COUNT(ur.user_id) AS users_count
FROM roles r
LEFT JOIN user_roles ur ON ur.role_id = r.id
GROUP BY r.id, r.code, r.name
ORDER BY r.code;

-- Пользователи, которым не назначена ни одна роль:
SELECT
    u.id AS user_id,
    u.name AS user_name
FROM users u
LEFT JOIN user_roles ur ON ur.user_id = u.id
WHERE ur.user_id IS NULL;

-- Все существующие пары «роль — пользователь»:
SELECT
    r.code AS role_code,
    ur.user_id
FROM roles r
JOIN user_roles ur ON r.id = ur.role_id;

-- Роли назначенные пользователям:
SELECT
    r.code AS role_code,
    u.id AS user_id,
    u.name AS user_name
FROM roles r
JOIN user_roles ur ON r.id = ur.role_id
JOIN users u ON u.id = ur.user_id;

-- Роли без пользователей: 
SELECT
    r.code AS role_code
FROM roles r
LEFT JOIN user_roles ur ON r.id = ur.role_id
WHERE ur.role_id IS NULL;

-- Все комбинации «роль × окружение»:
SELECT
    r.code AS role_code,
    e.code AS environment_code
FROM roles r
CROSS JOIN environments e
ORDER BY r.code, e.code;

-- Все категории с именем родительской категории:
SELECT
    c.id AS category_id,
    c.name AS category_name,
    parent.name AS parent_category_name
FROM categories c
LEFT JOIN categories parent ON parent.id = c.parent_id
ORDER BY c.id;
