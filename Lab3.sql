-- Q1

select city, name
from agents
where name = 'Smith'

-- Q2

select pid, name, quantity
from products
where priceusd > 1.25

-- Q3

select ordno, aid
from orders

-- Q4

select name, city
from customers
where city = 'Dallas'

-- Q5

select name
from agents
where city != 'New York' 
AND city != 'Newark'

-- Q6

select *
from products
where city != 'New York'
AND city != 'Newark'
AND priceusd >= 1.00

-- Q7

select *
from orders
where mon != 'jan'
AND mon != 'mar'

-- Q8

select *
from orders
where mon = 'feb'
AND dollars < 100.00

-- Q9

select *
from orders
where cid = 'c001'