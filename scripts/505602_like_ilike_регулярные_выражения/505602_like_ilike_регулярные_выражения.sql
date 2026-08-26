CREATE TABLE vacancies
(
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title       TEXT        NOT NULL,
    company     TEXT        NOT NULL,
    description TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

SELECT id, name, email
FROM users
WHERE email LIKE '%mail%';

SELECT id, name, price
FROM products
WHERE name ILIKE '%air%';

SELECT id, name, price
FROM products
WHERE name ILIKE 'i%';

SELECT id, name, price
FROM products
WHERE name ILIKE '%pro';

SELECT id, name, email
FROM users
WHERE email ILIKE 'A%'
   OR email ILIKE 'I%';

SELECT id, title, company, description
FROM vacancies
WHERE title ~* '(java|go|postgres)'
   OR description ~* '(java|go|postgres)';

SELECT id, name, price
FROM products
WHERE name ~* '^iPhone [0-9]+';
