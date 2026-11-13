-- Кузова, которые не используются ни в одной машине: 

SELECT cb.id, cb.name AS body_name
FROM car_bodies cb
LEFT JOIN cars c ON cb.id = c.body_id
WHERE c.body_id IS NULL;

-- Двигатели, которые не используются ни в одной машине:

SELECT ce.id, ce.name AS engine_name
FROM car_engines ce
LEFT JOIN cars c ON ce.id = c.engine_id
WHERE c.engine_id IS NULL;

-- Коробки передач, которые не используются ни в одной машине:

SELECT ct.id, ct.name AS transmission_name
FROM car_transmissions ct
LEFT JOIN cars c ON ct.id = c.transmission_id
WHERE c.transmission_id IS NULL;

-- Список всех машин и название кузова, если оно указано:

SELECT c.id, c.name AS car_name, cb.name AS body_name
FROM cars c
LEFT JOIN car_bodies cb ON c.body_id = cb.id;

-- Машины, у которых одновременно указаны кузов, двигатель и коробка передач:

SELECT
    c.id,
    c.name AS car_name,
    cb.name AS body_name,
    ce.name AS engine_name,
    ct.name AS transmission_name
FROM cars c
INNER JOIN car_bodies cb ON c.body_id = cb.id
INNER JOIN car_engines ce ON c.engine_id = ce.id
INNER JOIN car_transmissions ct ON c.transmission_id = ct.id;

-- Машины, у которых есть двигатель, но нет кузова:

SELECT
    c.id,
    c.name AS car_name,
    NULL AS body_name,
    ce.name AS engine_name
FROM cars c
JOIN car_engines ce ON c.engine_id = ce.id
WHERE c.body_id IS NULL;

-- Все кузова и машины, которые их используют:

SELECT
    cb.id AS body_id,
    cb.name AS body_name,
    c.id AS car_id,
    c.name AS car_name
FROM car_bodies cb
LEFT JOIN cars c ON cb.id = c.body_id;

-- Неиспользуемые двигатели:

SELECT e.id, e.name AS engine_name
FROM car_engines e
LEFT JOIN cars c ON c.engine_id = e.id
WHERE c.id IS NULL
ORDER BY e.id;

-- Машины с автоматической коробкой, со всеми деталями:

SELECT c.id,
       c.name           AS car_name,
       b.name           AS body_name,
       e.name           AS engine_name,
       t.name           AS transmission_name
FROM cars c
JOIN car_transmissions t ON t.id = c.transmission_id
LEFT JOIN car_bodies b   ON b.id = c.body_id
LEFT JOIN car_engines e  ON e.id = c.engine_id
WHERE t.name ILIKE 'automatic%'
ORDER BY c.id;

-- Машины без хотя бы одной детали:

SELECT c.id,
       c.name AS car_name,
       b.name AS body_name,
       e.name AS engine_name,
       t.name AS transmission_name
FROM cars c
LEFT JOIN car_bodies b   ON b.id = c.body_id
LEFT JOIN car_engines e  ON e.id = c.engine_id
LEFT JOIN car_transmissions t ON t.id = c.transmission_id
WHERE c.body_id IS NULL
   OR c.engine_id IS NULL
   OR c.transmission_id IS NULL
ORDER BY c.id;

-- Все машины с двигателем, коробка — необязательно:

SELECT c.id,
       c.name AS car_name,
       e.name AS engine_name,
       t.name AS transmission_name
FROM cars c
JOIN car_engines e ON e.id = c.engine_id
LEFT JOIN car_transmissions t ON t.id = c.transmission_id
ORDER BY c.id;

-- Все неиспользуемые детали в едином формате:

SELECT 'body'  AS detail_type,
        b.id   AS detail_id,
        b.name AS detail_name
FROM car_bodies b
LEFT JOIN cars c ON c.body_id = b.id
WHERE c.id IS NULL

UNION ALL

SELECT 'engine',
        e.id,
        e.name
FROM car_engines e
LEFT JOIN cars c ON c.engine_id = e.id
WHERE c.id IS NULL

UNION ALL

SELECT 'transmission',
       t.id,
       t.name
FROM car_transmissions t
LEFT JOIN cars c ON c.transmission_id = t.id
WHERE c.id IS NULL

ORDER BY detail_type, detail_id;

--  Машины с кузовами sedan, hatchback, suv:

SELECT c.id,
       c.name AS car_name,
       b.name AS body_name,
       e.name AS engine_name,
       t.name AS transmission_name
FROM cars c
JOIN car_bodies b ON b.id = c.body_id
LEFT JOIN car_engines e ON e.id = c.engine_id
LEFT JOIN car_transmissions t ON t.id = c.transmission_id
WHERE b.name IN ('sedan', 'hatchback', 'suv')
ORDER BY c.id;
