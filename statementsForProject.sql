-- 1. A query to view store name and address for all stores, ordered by store name
SELECT name "Store Name", concat(street, ',', ' ', street2, ',', ' ', city, ' ', state, ' ', zip) "Store Address"
FROM stores, address
WHERE stores.address_id=address.id
ORDER BY name ASC;

-- 2. A query to view all stores and their total sales in dollars, ordered by store name
SELECT stores.name "Store Name", SUM(quantity * price) as "Total Sales in Dollars"
FROM stores
INNER JOIN purchases on stores.id=purchases.store_id
INNER JOIN purchase_items on purchases.id=purchase_items.purchase_id
INNER JOIN items on purchase_items.item_id=items.id
GROUP BY stores.id
ORDER BY stores.name ASC;

-- 3. A query to view all stores and their members (customers), ordered by store name
SELECT name "Store Name", concat(first_name, ' ', last_name) "Members" 
FROM stores, customers
WHERE customers.store_id=stores.id
ORDER BY stores.name ASC;

-- 4. A query to view Administaff, Inc. store name, item name, quantity in store, price per unit, and notes about unit, ordered by item name
SELECT stores.name "Store Name", items.name "Item Name", inventory.quantity "Quantity in Store", items.price "Price per Unit", notes "Notes"
FROM stores
INNER JOIN inventory on stores.id=inventory.store_id
INNER JOIN items on inventory.item_id=items.id
WHERE stores.name='Administaff, Inc.'
ORDER BY items.name;

-- 5. A query to view a list of Administaff, Inc. month of purchase and total sales, ordered by ascending months
SELECT EXTRACT(MONTH FROM purchase_date) AS "Month of Purchase", SUM(purchase_items.quantity * items.price) as "Total Sales"
FROM purchases
INNER JOIN stores on purchases.store_id=stores.id
INNER JOIN purchase_items on purchases.id=purchase_items.purchase_id
INNER JOIN items on purchase_items.item_id=items.id
WHERE stores.name='Administaff, Inc.'
GROUP BY "Month of Purchase"
ORDER BY "Month of Purchase" ASC;

-- 6. A query to view Benchmark Electronics, Inc. store name, payment method, and count of purchase by payment method, ordered by payment method
SELECT name "Store Name", payment_method "Payment Method",
COUNT(payment_type_id) AS "Count of Purchases by Purchase Method"
FROM stores
INNER JOIN purchases on stores.id=purchases.store_id
INNER JOIN payment_types on purchases.payment_type_id=payment_types.id
WHERE stores.name='Benchmark Electronics, Inc.'
GROUP BY payment_types.payment_method, stores.name, stores.id
ORDER BY payment_method;

-- 7. A query to view store name, item name where inventory is fewer than ten, and the quantity of that item, ordered by store name
SELECT stores.name "Store Name", items.name "Item Name if Fewer Than 10 in Stock",
SUM(inventory.quantity) AS "Quantity in Store"
FROM stores
INNER JOIN inventory on stores.id=inventory.store_id
INNER JOIN items on inventory.item_id=items.id
WHERE inventory.quantity < 10
GROUP BY stores.name, items.name
ORDER BY stores.name;

-- 8. A query to see Alfred Poggi's purchase history (first name, last name, purchase date, name of item purchased, payment type, and quantity of item, ordered by purchase date newest to oldest)
SELECT first_name "First Name", last_name "Last Name", purchase_date "Date of Purchase", items.name "Item Name", payment_types.payment_method "Payment Method", purchase_items.quantity "Quantity"
FROM customers
INNER JOIN purchases on customers.id=purchases.customer_id
INNER JOIN payment_types on purchases.payment_type_id=payment_types.id
INNER JOIN purchase_items on purchases.id=purchase_items.purchase_id
INNER JOIN items on purchase_items.item_id=items.id
WHERE customers.last_name='Poggi'
GROUP BY customers.first_name, customers.last_name, purchases.purchase_date, items.name, payment_types.payment_method, purchase_items.quantity
ORDER BY purchases.purchase_date DESC;

-- 9. A query to update past purchases that used Apple Pay to become purchases using Credit
UPDATE purchases
SET payment_type_id = 3
WHERE payment_type_id = 5;

-- 10. A query to remove Apple Pay from the list of payment types
DELETE FROM payment_types
WHERE payment_method = 'apple pay';

-- 11. A query to add a new item (name "Frosted Flakes", price 5, notes "They're Grate!")
INSERT INTO items (name, price, notes)
VALUES ('Frosted Flakes', 5, 'They''re Grate!');

-- 12. A query to add 50 of the new Frosted Flakes item to every store with a name containing the letter "a"
INSERT INTO inventory (id, store_id, item_id, quantity)
SELECT nextval('inventory_id_seq') AS id, stores.id AS store_id, items.id AS item_id, 50 AS quantity
FROM stores, items
WHERE items.name = 'Frosted Flakes' AND (stores.name LIKE '%a%');

-- 13. A query to update notes for item Frosted Flakes, from "They're Grate!" to "They're Gr-r-reat!"
UPDATE items
SET notes = 'They''re Gr-r-reat!'
WHERE items.name = 'Frosted Flakes';
