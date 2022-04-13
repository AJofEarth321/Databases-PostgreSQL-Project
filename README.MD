Postgres Project

Instructions On How To Load Project Dump File In pgAdmin

Download project_dump.backup file from the project folder
After creating a new database in pgAdmin, right click on newly created database, then click Restore

Leave Format as "Custom or tar"
In the Filename selector, find and select project_dump.backup

Leave Number of jobs empty
For Role Name, click the drop-down and select postgres

Click Restore at the bottom to restore


Relational Databases

Foreign Key Relationships



Table Name
Foreign Key (FK) Name
Table Matching FK




customers
store_id
stores


stores
address_id
address


purchases
store_id
stores


purchases
customer_id
customers


purchases
payment_type_id
payment_types


purchase_items
purchase_id
purchases


purchase_items
item_id
items


inventory
store_id
stores


inventory
item_id
items




Multiple Choice


Users are not allowed to add items to purchases where the amount of items bought exceeds the amount of items in the store. This is because:

There is a Trigger Function preventing new purchases that exceed the current inventory.



Why will the following SQL statement not work in the stores database?

SELECT s.name AS "Store Name", a.street AS "Street Address", a.street2 AS "Suite", a.city AS "City", a.state AS "State", a.zip AS "Zip Code"
FROM stores s
INNER JOIN address a
ON address_id = a.id


address_id is an ambiguous field because it is not qualified with a table or alias name (should be s.address_id or stores.address_id).



What is the relationship between the stores and customers tables?
2. Stores is a one-to-many relationship with Customers.


What is the relationship between the purchases and items tables?
4. Purchases and Items are unrelated tables.