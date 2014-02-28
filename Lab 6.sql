-- Megan Crane
-- Lab 6
-- Worked with Graham Harrison, referenced stackoverflow CAST function

-- 1. Get the name and city of customers who live in a city where the most number of products are made

select  customers.name, customers.city
from    customers,
	products,
	orders
where   customers.cid = orders.cid
	and products.pid = orders.pid
	and products.quantity > (Select Avg(products.quantity)
				from products)
limit 1

-- 2. Get the name and city of customers who live in any city where the most number of products are made

select  c2.name, c2.city
from    customers c1,
	products,
	orders,
	customers c2
where   c1.cid = orders.cid
	and products.pid = orders.pid
	and c2.city = c1.city
	and products.quantity > (Select Avg(products.quantity)
				from products)
limit 2


-- 3. List the products whose priceUSD is above the average priceUSD

select products.name, priceUSD
from products 
where priceUSD > (Select Avg(priceUSD) 
		  from products)

-- 4. Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from hight to low

select customers.name, orders.pid, orders.dollars
from    customers,
	orders
where orders.cid = customers.cid
order by orders.dollars desc

-- 5. Show all customer names (in order) and their total orderd, and nothing more. Use coalesce to avoid showing NULLS

select customers.name, coalesce (sum(orders.dollars), 0)
from customers left outer join orders on customers.cid = orders.cid
group by customers.cid
order by customers.name asc

-- 6. Show the names of all customers who bought products from agents based in New York along with the names of the products they ordered, and the names of the agents who sold them

select customers.name, agents.name, products.name
from customers,
     agents,
     products,
     orders
where customers.cid = orders.cid
	and agents.aid = orders.aid
	and products.pid = orders.pid
	and agents.city = 'New York'

-- 7. Write a query to check the accuracy of the dollars column in the Orders table. This means calculating Orders.dollars from other data in other tables and then comparing those values to the values in Orders.dollars

select orders.dollars,CAST((orders.qty * products.priceUSD) - (orders.qty * products.priceUSD *(customers.discount/100.00)) as numeric(12,2))as PriceCheck
from    orders,
	products,
	customers
where orders.pid = products.pid 
	and customers.cid = orders.cid
