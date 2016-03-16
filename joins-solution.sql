-- 1. Get all customers and their addresses.
SELECT customers.first_name, customers.last_name, addresses.street, addresses.city, addresses.state, addresses.zip, addresses.address_type
FROM customers
JOIN addresses
ON customers.id = addresses.customer_id;

-- 2. Get all orders and their line items.
SELECT orders.id, orders.order_date, orders.total, line_items.unit_price, line_items.quantity
FROM orders
JOIN line_items
ON orders.id = line_items.order_id;

-- 3. Which warehouses have cheetos?
SELECT products.description, warehouse.warehouse, warehouse_product.warehouse_id
FROM products
JOIN warehouse_product
ON products.id = warehouse_product.product_id
JOIN warehouse
ON warehouse_product.warehouse_id = warehouse.id
WHERE products.description = 'cheetos'; -- can be matched also by product_id if DB would be large


-- 4. Which warehouses have diet pepsi?
SELECT products.description, warehouse.warehouse, warehouse_product.warehouse_id
FROM products
JOIN warehouse_product
ON products.id = warehouse_product.product_id
JOIN warehouse
ON warehouse_product.warehouse_id = warehouse.id
WHERE products.id = '6';


-- 5. Get the number of orders for each customer. NOTE: It is OK if those
--    without orders are not included in results. ???
SELECT customers.first_name, customers.last_name, COUNT(orders.id) AS numberOfOrders
FROM customers
JOIN addresses
ON customers.id = addresses.customer_id
LEFT JOIN orders
ON addresses.id = orders.address_id GROUP BY customers.id;

-- 6. How many customers do we have?
SELECT COUNT(*) AS "Total customers" FROM customers;


-- 7. How many products do we carry?
SELECT COUNT(products.id) AS "Total number of products we carry" FROM products;


-- 8. What is the total available on-hand quantity of diet pepsi?
SELECT products.description, SUM(on_hand) AS "Total on-hand"
FROM warehouse_product
RIGHT OUTER JOIN products
ON warehouse_product.product_id = products.id
WHERE products.id=6
GROUP BY products.description; --pepsi product_id is 6
