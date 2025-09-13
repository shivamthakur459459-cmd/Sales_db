-- ===========================================
-- SIMPLE SALES DATABASE (Beginner Friendly)
-- Without AUTO_INCREMENT / Primary Key
-- ===========================================

-- Drop tables if already exist
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- 1. Customers Table
CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(100),
    region VARCHAR(50)
);

-- 2. Products Table
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- 3. Sales Table
CREATE TABLE sales (
    sale_id INT,
    sale_date DATE,
    product_id INT,
    customer_id INT,
    quantity INT,
    total_amount DECIMAL(10,2)
);

-- ===========================================
-- INSERT SAMPLE DATA
-- ===========================================

-- Customers
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
INSERT INTO customers VALUES (3, 'Charlie', 'East');
INSERT INTO customers VALUES (4, 'David', 'West');
INSERT INTO customers VALUES (5, 'Eva', 'North');

-- Products
INSERT INTO products VALUES (1, 'Laptop', 'Electronics', 800.00);
INSERT INTO products VALUES (2, 'Phone', 'Electronics', 500.00);
INSERT INTO products VALUES (3, 'Headphones', 'Accessories', 100.00);
INSERT INTO products VALUES (4, 'Tablet', 'Electronics', 300.00);
INSERT INTO products VALUES (5, 'Keyboard', 'Accessories', 50.00);

-- Sales
INSERT INTO sales VALUES (1, '2025-09-01', 1, 1, 2, 1600.00);
INSERT INTO sales VALUES (2, '2025-09-01', 2, 2, 1, 500.00);
INSERT INTO sales VALUES (3, '2025-09-01', 3, 3, 3, 300.00);
INSERT INTO sales VALUES (4, '2025-09-02', 4, 4, 1, 300.00);
INSERT INTO sales VALUES (5, '2025-09-02', 5, 5, 4, 200.00);
INSERT INTO sales VALUES (6, '2025-09-02', 1, 2, 1, 800.00);
INSERT INTO sales VALUES (7, '2025-09-03', 2, 3, 2, 1000.00);
INSERT INTO sales VALUES (8, '2025-09-03', 3, 1, 2, 200.00);

-- ===========================================
-- SALES REPORT QUERIES
-- ===========================================

-- 1. Daily Sales Totals
SELECT 
    sale_date,
    SUM(total_amount) AS total_sales
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- 2. Average Transaction Value per Day
SELECT 
    sale_date,
    ROUND(AVG(total_amount), 2) AS avg_transaction
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- 3. Top 5 Best-Selling Products (by quantity sold)
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold,
    SUM(s.total_amount) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- 4. Top 5 Highest Revenue Products
SELECT 
    p.product_name,
    SUM(s.total_amount) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- 5. Sales by Customer Region
SELECT 
    c.region,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_sales DESC;

-- 6. Daily Number of Transactions
SELECT 
    sale_date,
    COUNT(sale_id) AS total_transactions
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- 7. Top Customers by Spending
SELECT 
    c.name AS customer_name,
    SUM(s.total_amount) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 10;

