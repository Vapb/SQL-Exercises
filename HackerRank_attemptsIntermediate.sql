-- Some interesting questions that i
--- Given the product and invoice details for products at an online store, find all the products that were not sold. For each such product, display its SKU and product name. Order the result by SKU, ascending.
select 'customer' as category,
        c.id as id, customer_name as name
from customer c
left join invoice i on c.id = i.customer_id
where i.id is null 

-- Query all customers who spent bellow 0.25 of average
SELECT c.customer_name, CAST((total_price) as decimal(20,6))
FROM customer c
INNER JOIN invoice i on c.id = i.customer_id
GROUP BY c.customer_name
HAVING total_price <= (SELECT AVG(total_price) * 0.25 
                       FROM invoice)
ORDER BY total_price DESC;


-- Bussiness Expansion/
-- As part of business expansion efforts at a company, your help is needed to find all pairs of customers and agents who have been in contact more than once. For each such pair, display the user id, first name, and last name, and the customer id, name, and the number of their contacts. Order the result by user id ascending.
select us.id , us.first_name, us.last_name, cust.id,cust.customer_name,count() 
from contact con 
inner join user_account us on us.id=con.user_account_id 
inner join customer cust on cust.id=con.customer_id 
group by us.id , us.first_name, us.last_name, cust.id,cust.customer_name,cust.contact_person 
having count()>1


-- A business is analyzing data by country. For each country, display the country name, total number of invoices, and their average amount.
--Format the average as a floating-point number with 6 decimal places.
--Return only those countries where their average invoice amount is greater than the average invoice amount over all invoices.
SELECT country_name, count(*), CAST(avg(invoice.total_price) as decimal(20,6))
FROM country
INNER JOIN city ON city.country_id = country.id
INNER JOIN customer ON customer.city_id = city.id
INNER JOIN invoice ON invoice.customer_id = customer.id
GROUP BY country.country_name
HAVING avg(invoice.total_price) > (SELECT avg(invoice.total_price) FROM invoice)


-- For each pair of city and product, return the names of the city and product, as well the total amount spent on the product to 2 decimal places. Order the result by the amount spent from high to low then by city name and product name in ascending order.
SELECT city.name, product.name, ROUND(sum(invoice_item.line_total_price), 2) as total
FROM city
INNER JOIN customer ON customer.city_id = city.id
INNER JOIN invoice ON invoice.customer_id = customer.id
INNER JOIN invoice_item  ON invoice_item.invoice_id = invoice.id
INNER JOIN product  ON product.id = invoice_item.product_id
GROUP BY city.name, product.name
ORDER BY total desc, city.name, product.name;
