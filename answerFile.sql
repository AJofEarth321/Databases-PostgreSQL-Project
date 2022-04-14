-- 1. 
SELECT s.name AS "Store Name", a.street AS "Street Address", a.street2 AS "Suite", a.city AS "City", a.state AS "State", a.zip AS "Zip Code"
FROM stores s
INNER JOIN address a
ON s.address_id = a.id
ORDER BY s.name;

-- 2. 
SELECT s.name AS "Store Name", sum(pi.quantity * i.price) AS "Total Sales" 
FROM purchases p
INNER JOIN stores s ON p.store_id = s.id 
INNER JOIN purchase_items pi ON p.id = pi.purchase_id
INNER JOIN items i ON pi.item_id = i.id
GROUP BY s.name
ORDER BY s.name;

-- 3. 
SELECT s.name AS "Store Name", c.first_name || ' ' || c.last_name AS "Customer Name" 
FROM customers c
INNER JOIN stores s
ON c.store_id = s.id 
ORDER BY s.name;

-- 4. 
SELECT s.name AS "Store Name", it.name AS "Item Name", inv.quantity, it.price, it.notes 
FROM inventory inv
INNER JOIN stores s
ON inv.store_id = s.id 
INNER JOIN items it
ON inv.item_id = it.id 
WHERE s.name = 'Administaff, Inc.'
ORDER BY "Item Name";

-- 5. 
SELECT EXTRACT(MONTH FROM
 purchase_date) AS "Month of Purchase", sum(purchase_items.quantity * items.price) AS "Total sales" 
FROM purchases 
INNER JOIN stores ON stores.id = purchases.store_id 
INNER JOIN purchase_items ON purchases.id = purchase_items.purchase_id
INNER JOIN items ON items.id = purchase_items.item_id
WHERE stores.name = 'Administaff, Inc.'
GROUP BY "Month of Purchase"
ORDER BY "Month of Purchase"

-- 6. 
SELECT stores.name AS "Store Name", payment_types.payment_method AS "Payment Method", COUNT(payment_types.payment_method) AS "Number of Purchases"
FROM stores 
INNER JOIN purchases 
ON stores.id = purchases.store_id 
INNER JOIN payment_types 
ON purchases.payment_type_id = payment_types.id
WHERE stores.name = 'Benchmark Electronics, Inc.'
GROUP BY stores.name, payment_types.payment_method
ORDER BY "Payment Method";

-- 7. 
SELECT stores.name AS "Store Name", items.name AS "Item", inventory.quantity AS "Quantity" 
FROM inventory 
INNER JOIN stores 
ON inventory.store_id = stores.id 
INNER JOIN items 
ON inventory.item_id = items.id 
WHERE quantity < 10
ORDER BY stores.name;

-- 8.
SELECT customers.first_name || ' ' || customers.last_name AS "Customer Name", 
purchases.purchase_date AS "Purchase Date", 
items.name AS "Item Name",
payment_types.payment_method AS "Payment Method",
purchase_items.quantity
FROM customers
JOIN purchases ON purchases.customer_id = customers.id
JOIN purchase_items ON purchase_items.purchase_id = purchases.id
JOIN items ON items.id = purchase_items.item_id
JOIN payment_types ON payment_types.id = purchases.payment_type_id
WHERE customers.first_name = 'Alfred' 
AND customers.last_name ='Poggi'
GROUP BY 1, 2, 3, 4, 5
ORDER BY purchases.purchase_date DESC;

-- 9.
UPDATE purchases
SET payment_type_id = (SELECT id FROM payment_types
    WHERE payment_method = 'credit')
WHERE payment_type_id = (SELECT id FROM payment_types
    WHERE payment_method = 'apple pay');

-- 10.
DELETE FROM payment_types
WHERE payment_method = 'apple pay';

-- 11.
INSERT INTO items (name, price, notes) 
VALUES ('Frosted Flakes', 5, 'They''re Grate!');

-- 12. 
INSERT INTO inventory (store_id, item_id, quantity) 
    SELECT distinct inventory.store_id, (SELECT id FROM items
    WHERE items.name = 'Frosted Flakes'), 50 FROM inventory WHERE
    inventory.store_id IN (SELECT id FROM stores 
    WHERE name like '%a%');

-- 13.
UPDATE items
SET notes = 'They''re Gr-r-reat!'
WHERE notes = 'They''re Grate!';
