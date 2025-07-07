-- Average Amount Paid by Top 5 Customers
-- Outer Query (Calculate Average Amount Paid)
SELECT AVG(total_paid) AS average
FROM (
SELECT
c.customer_id,
c.first_name,
c.last_name,
co.country,
ci.city,
SUM(p.amount) AS total_paid
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE ci.city IN (
SELECT ci.city
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country IN (
SELECT co.country
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country
ORDER BY COUNT(c.customer_id) DESC
LIMIT 10
)
GROUP BY ci.city
ORDER BY COUNT(c.customer_id) DESC
LIMIT 10
)
GROUP BY c.customer_id, c.first_name, c.last_name, co.country, ci.city
ORDER BY total_paid DESC
LIMIT 5

-- Top 5 Customers per Country
-- Outer Query (All Customers by Country)
SELECT
co.country,
COUNT(DISTINCT c.customer_id) AS all_customer_count,
COUNT(DISTINCT top_5.customer_id) AS top_customer_count
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
LEFT JOIN (
SELECT
c.customer_id,
co.country
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id WHERE ci.city IN (
SELECT ci.city
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country IN (
SELECT co.country
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country
ORDER BY COUNT(c.customer_id) DESC
LIMIT 10
)
GROUP BY ci.city
ORDER BY COUNT(c.customer_id) DESC
LIMIT 10
)
GROUP BY c.customer_id, co.country
ORDER BY SUM(p.amount) DESC
LIMIT 5
) AS top_5 ON co.country = top_5.country
GROUP BY co.country
ORDER BY top_customer_count DESC;
) AS total_amount_paid;
