-- Megan Crane 
-- Design Project
-- SQL File

--Create Statements

drop table if exists Character;

create table Character (
Cid char(4) not null,
Name text not null,
Gender text not null,
Wid char(4) references Worlds(Wid),
Mid char(4) references Movies(Mid),
Gid char(4)  references Games(Gid),
primary key (cid)
);

drop table if exists Hero;

create table Hero (
HDesc text not null,
Cid char(4) not null references Character(Cid),
primary key(Cid)
);

drop table if exists Villain;

create table Villain (
VDesc text not null,
Cid char(4) not null references Character(Cid),
primary key (Cid)
);

drop table if exists Summon;

create table Summon (
SDesc text not null,
Cid char(4) not null references Character(Cid),
primary key (cid)
);

drop table if exists Movies;

create table Movies (
Mid char(4) not null,
Name text not null,
YearReleased char(4) not null,
primary key (Mid)
);

drop table if exists Games;

create table Games (
Gid char(4) not null,
Name text not null,
YearReleased char(4),
primary key (gid)
);

drop table if exists Worlds;

create table Worlds (
Wid char(4) not null,
Name text not null,
Mid char(4) not null references Movies(Mid),
primary key (wid)
);

drop table if exists Weapon;

create table Weapon (
WPid char(4) not null,
Name text not null,
Description text not null,
Cid char(4) references Character(Cid),
primary key (WPid)
);

-- View
create view Villain_Location AS

select  c.name, 
	w.name, 
	VDesc
from    character c,
          villain v,
          worlds
where   c.cid = v.cid
and     c.wid = w.wid
order by c.name asc

--reports and queries

--1.
select c.name, 
       c.cid,
       HDesc, 
       WPid, 
       w.name, 
       Description
from character c, 
     hero h, 
     weapon w
where     w.cid = c.cid
         and h.cid = c.cid
order by c.cid asc

--2. 
select  c.name, 
	c.cid, 
	c.mid, 
	c.gid, 
	m.name, 
	g.name
from character c
full outer join movies m
on m.mid = c.mid
full outer join games g
on g.gid = c.gid;

-- Stored Procedures
-- 1.
create or replace function HeroWorld(int, refcursor) returns refcursor as $$
declare
	world_num int := $1;
	resultset refcursor := $4;
begin
	open resultset for
		select c.name, w.wid, w.name, h.hdesc
		from character c,
			weapons w,
			hero h
		where world_num in (c.wid)
		and c.cid = h.cid;
	return resultset;
end;
$$
language plpgsql;
select HeroWorld(0001, ‘results’);
fetch all from results;

--2.
create function MovieTitle()
return trigger as $$
begin
	if (name = null) then
		update movies set name = 'Unkown Movie Title' where name = null;
	end if;
end
$$language plpgsql;

-- Trigger

Create Trigger movie_title_trigger
	After insert or update
	On Movies
	For each row
	Execute Procedure MovieTitle();

-- Security
Create User KHAdmin with Password 'Alpaca'; 
Revoke all on Character from KHAdmin; 
Revoke all on Hero from KHAdmin; 
Revoke all on Villain from KHAdmin; 
Revoke all on Summon from KHAdmin; 
Revoke all on Worlds from KHAdmin; 
Revoke all on Weapon from KHAdmin; 
Revoke all on Movies from KHAdmin; 
Revoke all on Games from KHAdmin; 

Grant insert, update, delete, select on Character to KHAdmin; 
Grant insert, update, delete, select on Hero to KHAdmin; 
Grant insert, update, delete, select on Villain to KHAdmin; 
Grant insert, update, delete, select on Summon to KHAdmin; 
Grant insert, update, delete, select on Worlds to KHAdmin; 
Grant insert, update, delete, select on Weapon to KHAdmin; 
Grant insert, update, delete, select on Movies to KHAdmin; 
Grant insert, update, delete, select on Games KHAdmin; 

Create User KHUser with Password 'Alpaca' 
 
Revoke all on Character from KHUser; 
Revoke all on Hero from KHUser; 
Revoke all on Villain from KHUser; 
Revoke all on Summon from KHUser; 
Revoke all on Worlds from KHUser; 
Revoke all on Weapon from KHUser; 
Revoke all on Movies from KHUser; 
Revoke all on Games from KHUser; 

Grant select on Character to KHUser; 
Grant select on Hero to KHUser; 
Grant select on Villain to KHUser; 
Grant select on Summon to KHUser; 
Grant select on Worlds to KHUser; 
Grant select on Weapon to KHUser; 
Grant select on Movies to KHUser; 
Grant select on Games to KHUser; 



