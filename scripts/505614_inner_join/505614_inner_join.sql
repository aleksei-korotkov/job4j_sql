SELECT o.id AS order_id,
       o.status,
       u.email
FROM   orders AS o
INNER JOIN users AS u ON u.id = o.user_id
ORDER BY o.id;

SELECT oi.id AS order_item_id,
       oi.order_id,
       p.name,
       oi.quantity
FROM   order_items AS oi
INNER JOIN products AS p ON p.id = oi.product_id
WHERE  oi.quantity > 1;

SELECT oi.order_id,
       p.name,
       oi.quantity,
       oi.unit_price
FROM   order_items AS oi
INNER JOIN products AS p ON p.id = oi.product_id
INNER JOIN orders AS o ON o.id = oi.order_id
WHERE  o.user_id = 1;

SELECT o.id AS order_id,
       o.status,
       u.name AS user_name
FROM   orders AS o
INNER JOIN users AS u ON u.id = o.user_id
WHERE  o.status = 'NEW';

SELECT oi.id AS order_item_id,
       p.name,
       oi.quantity,
       (oi.quantity * oi.unit_price) AS line_total
FROM   order_items AS oi
INNER JOIN products AS p ON p.id = oi.product_id;
