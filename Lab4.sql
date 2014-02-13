-- Megan Crane
-- Lab 4
-- 2/9/14

-- Q1
-- Get the cities of agents booking an order for customer “Basics”.

select city
from agents
where aid in (  select aid
		from orders
		where cid in (  select cid
				from customers
				where name = 'Basics' )
	     )

-- Q2	     
-- Get the pids	of products ordered through any	agent who makes	at least one order for	
-- a customer in Kyoto.	

select distinct pid
from orders
where aid in (	select aid
		from orders 
		where cid in (  select cid
				from customers
				where city = 'Kyoto' )
	     )	
order by pid asc

-- Q3
-- Find	the cids and names of customers	who never placed an order through agent	a03.


select distinct cid, name
from customers
where cid not in
	(select cid
	from orders
	where aid in
	
	(select aid 
	from orders 
	where aid = 'a03')
	)




-- Q4
-- Get	the cids and names of customers	who ordered both product p01 and p07.

select name, cid
from customers
where cid in ( select cid 
	       from orders
               where pid in ('p01', 'p07')
               group by cid
               having count(distinct pid) = 2)


-- Q5
-- Get the pids	of products ordered by any customers who ever placed an	order through	
-- agent a03.	

select distinct pid
from orders
where cid in ( select cid
	       from orders
	       where aid = 'a03')
order by pid asc	       

-- Q6
-- Get the names and discounts of all customers	who place orders through agents	in	
-- Dallas or Duluth.


select distinct name, discount
from customers
where cid in ( select cid 
	       from orders
	       where aid in (  select aid 
			       from agents
			       where city = 'Dallas'
				  or city = 'Duluth' )
	     )
order by name asc	

-- Q7
-- Find	all customers who have the same	discount as that of any	customers in Dallas or	
-- Kyoto.


select name
from customers
where discount in
	(select discount
	 from customers
	 where city = 'Kyoto'
	   or city = 'Dallas')

	
	
