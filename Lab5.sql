-- Megan Crane
-- Lab 5 SQL Queries 
-- 2/20/14
-- I worked on this lab with Graham Harrison if some of our queries look similar and looked as stackoverflow charts for references 

-- 1. Get the cities of agents booking an order for customer "Basics" using joins.

select agents.city
from    orders,
	agents,
	customers
where agents.aid = orders.aid
      and customers.cid = orders.cid
      and customers.name = 'Basics'

-- 2. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto



select distinct  Loopthrough2nd.pid 
from  Orders Loopthrough1st, orders Loopthrough2nd, Customers
where Loopthrough1st.cid = customers.cid 
	and   Loopthrough1st.aid = Loopthrough2nd.aid
	and   customers.city = 'Kyoto'


-- 3. Get the names of customers who have never placed an order with a subquery

select name
from customers
where cid not in 
	(select cid
	 from orders)

-- 4. Get the names of customers who have never placed an order, use an outer join.

select name
from    customers c
FULL OUTER JOIN orders o
ON c.cid = o.cid
where o.cid is NULL 

-- 5. Get the names of customers who placed at least one order through an agent in their city, and the agents names

select distinct customers.name,
	agents.name
from customers,
	orders,
	agents,
	products
where customers.cid = orders.cid
	and agents.aid = orders.aid
	and products.pid = orders.pid
	and customers.city = agents.city


-- 6. Get the names of customers and agents in the same city, along with the name of the city, regardless of whether or not the customer has ever placed an order with that agent

select customers.name, agents.name, customers.city, agents.city
from 	customers,
	agents
where customers.city = agents.city




-- 7. Get the name and city of customers who live in the city where the least number of products are made

select  c2.name, c2.city
from    customers c1,
	orders,
	products,
	customers c2
where   c1.cid = orders.cid
	and products.pid = orders.pid
	and c1.city = products.city
	and c1.city = c2.city
	group by  c2.name, c2.city
	order by count (c2.city) desc
	limit 2



	