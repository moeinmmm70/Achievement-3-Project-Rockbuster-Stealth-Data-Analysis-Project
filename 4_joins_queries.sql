-- Top 10 Countries by Customer Count
SELECT co.country, COUNT(c.customer_id) AS customer_count
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country
ORDER BY customer_count DESC
LIMIT 10;

-- Top 10 Cities Within the Top 10 Countries
SELECT ci.city, co.country, COUNT(c.customer_id) AS customer_count
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
GROUP BY ci.city, co.country
ORDER BY customer_count DESC
LIMIT 10;

-- Top 5 Customers (Highest Total Paid) in the Top 10 Cities
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
LIMIT 5;
