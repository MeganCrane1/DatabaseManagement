-- Megan Crane
-- Stored Procedures
-- Database Management 
-- 4/22/14

-- 1.  Function PreReqsFor(courseNum)- Returns the immediate prerequisites for the	
-- passed-in course number

create or replace function PreReqsFor(int, refcursor) returns refcursor as
$$
declare 
	course_num int := $1; 
	resultset refcursor := $2;

begin
	open resultset for
		select c.name, c.num
		from   courses c,
		       prerequisites p
		where  course_num in (p.coursenum)
		       and p.prereqnum = c.num;
	return resultset;
end;
$$
language plpgsql;

select PreReqsFor(308, 'results');
Fetch all from results;

-- 2. Function IsPreReqFor(courseNum) - Returns the courses for which the passed-in course number
-- is an immediate pre-requisite

create or replace function IsPreReqFor(int, refcursor) returns refcursor as
$$
declare 
	course_num int := $1; 
	resultset refcursor := $2;

begin
	open resultset for
		select c2.name, c2.num, c2.credits
		from courses c1,
		     courses c2,
		     prerequisites p1
		where course_num = c1.num
		  and c1.num = p1.prereqnum
		  and p1.coursenum = c2.num;
	return resultset;
end;
$$
language plpgsql;

select IsPreReqFor(220, 'results');
Fetch all from results;