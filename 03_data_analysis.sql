-- 1. Top 3 customers based on orders
SELECT
c.first_name,
c.last_name,
SUM(o.total_amount) AS total_order_amount
FROM Customers AS c
JOIN Orders AS o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_order_amount DESC
LIMIT 3;

-- 2. Average order value for each customer
SELECT
c.first_name,
c.last_name,
AVG(o.total_amount) AS average_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 3. Employees with >4 resolved support tickets
SELECT
e.first_name,
e.last_name,
COUNT(s.ticket_id)
FROM Employees e
JOIN SupportTickets s ON e.employee_id = s.employee_id
WHERE s.status = 'resolved'
GROUP BY e.employee_id
HAVING COUNT(s.ticket_id) > 4
;

-- 4. Produk yang belum pernah dipesan
SELECT
products.product_name
FROM products
LEFT JOIN OrderDetails od ON od.product_id = products.product_id
WHERE od.order_id IS NULL;

-- 5. Total revenue
SELECT
SUM(quantity * unit_price)
FROM OrderDetails;

-- 6. Harga rata-rata tiap kategori produk
WITH cte_avg_price AS (
SELECT category, AVG(price) AS rerata
FROM products
GROUP BY category
)
SELECT * FROM cte_avg_price rerata ;

-- 7. Pelanggan yang pernah order melebihi 1000

SELECT customer_id,total_amount
FROM Orders;

-- 7. Pelanggan yang pernah order melebihi 1000
SELECT * FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE total_amount > 1000
);