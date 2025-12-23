-- Total Revenue
SELECT SUM(payment_value) AS total_revenue
FROM payments;

-- Top Cities by Revenue
SELECT c.customer_city, SUM(p.payment_value) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_city
ORDER BY total_revenue DESC
LIMIT 5;

-- AOV by City
SELECT c.customer_city,
       SUM(p.payment_value) * 1.0 / COUNT(DISTINCT o.order_id) AS aov
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_city;

-- Revenue by Payment Type
SELECT payment_type, SUM(payment_value) AS total_revenue
FROM payments
GROUP BY payment_type;

-- Repeat Customers by City
SELECT t.customer_city, COUNT(*) AS repeat_customers
FROM (
  SELECT c.customer_id, c.customer_city, COUNT(o.order_id) AS orders_count
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, c.customer_city
  HAVING COUNT(o.order_id) >= 2
) t
GROUP BY t.customer_city
ORDER BY repeat_customers DESC;
