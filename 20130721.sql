-- Select top 20 shipping addresses, count
select distinct top 20 sh.[Ship-to Address] as "Address", sh.[Ship-to City], COUNT(sh.[Shipment Date]) as "Shipments"
from [urban_NAV600].[dbo].[Urban-Brand GmbH$Sales Header] as sh
where MONTH(sh.[Shipment Date]) >= MONTH (Getdate()) 
group by sh.[Ship-to City],[Ship-to Address],sh.[Ship-to Address 2],sh.[Ship-to Code]
order by COUNT(sh.[Shipment Date]) desc;

-- Executing query:
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
Query returned successfully with no result in 23 ms.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1',"Hallbauer", "Mark","Erika-Mann-Str 17, 80636", "München");

ERROR:  column "Hallbauer" does not exist
LINE 13: VALUES ('1',"Hallbauer", "Mark","Erika-Mann-Str 17, 80636", ...
                     ^


********** Error **********

ERROR: column "Hallbauer" does not exist
SQL state: 42703
Character: 214

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');

Query returned successfully: one row affected, 19 ms execution time.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

Select * from persons;

Total query runtime: 19 ms.
1 row retrieved.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

/*
Select * from persons;
*/

CREATE SEQUENCE mytable_myid_seq;

/*ALTER TABLE Persons AUTO_INCREMENT=100*/
Query returned successfully with no result in 18 ms.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

/*
Select * from persons;
*/

/*CREATE SEQUENCE mytable_myid_seq;*/

ALTER TABLE Persons 
    ADD myid INT UNIQUE;

/*ALTER TABLE Persons AUTO_INCREMENT=100*/
NOTICE:  ALTER TABLE / ADD UNIQUE will create implicit index "persons_myid_key" for table "persons"


Query returned successfully with no result in 20 ms.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

/*
Select * from persons;
*/

/*CREATE SEQUENCE mytable_myid_seq;*/

/*ALTER TABLE Persons 
    ADD myid INT UNIQUE;*/

ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');

/*ALTER TABLE Persons AUTO_INCREMENT=100*/
Query returned successfully with no result in 19 ms.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

/*
Select * from persons;
*/

/*CREATE SEQUENCE mytable_myid_seq;*/

/*
ALTER TABLE Persons 
    ADD myid INT UNIQUE;
*/

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');
Query returned successfully: one row affected, 19 ms execution time.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

Select * from persons;

/*CREATE SEQUENCE mytable_myid_seq;*/

/*
ALTER TABLE Persons 
    ADD myid INT UNIQUE;
*/

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/


Total query runtime: 18 ms.
1 row retrieved.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from persons;

/*CREATE SEQUENCE mytable_myid_seq;*/

/*
ALTER TABLE Persons 
    ADD myid INT UNIQUE;
*/

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

drop table Persons;


Query returned successfully with no result in 20 ms.

-- Executing query:
/*
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
*/

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

Select * from persons;

/*CREATE SEQUENCE mytable_myid_seq;*/

/*
ALTER TABLE Persons 
    ADD myid INT UNIQUE;
*/

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  relation "persons" does not exist
LINE 17: Select * from persons;
                       ^


********** Error **********

ERROR: relation "persons" does not exist
SQL state: 42P01
Character: 296

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

Select * from persons;

/*CREATE SEQUENCE mytable_myid_seq;*/

/*
ALTER TABLE Persons 
    ADD myid INT UNIQUE;
*/

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  relation "persons" does not exist
LINE 15: Select * from persons;
                       ^


********** Error **********

ERROR: relation "persons" does not exist
SQL state: 42P01
Character: 314

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/

/*
ALTER TABLE Persons 
    ADD myid INT UNIQUE;
*/

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  relation "persons" does not exist
LINE 15: Select * from Persons;
                       ^


********** Error **********

ERROR: relation "persons" does not exist
SQL state: 42P01
Character: 314

-- Executing query:
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/

/*
ALTER TABLE Persons 
    ADD myid INT UNIQUE;
*/

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully with no result in 15 ms.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/

/*
ALTER TABLE Persons 
    ADD myid INT UNIQUE;
*/

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 18 ms.
0 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


ALTER TABLE Persons 
    ADD PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  column "personid" of relation "persons" already exists


********** Error **********

ERROR: column "personid" of relation "persons" already exists
SQL state: 42701

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


ALTER TABLE Persons 
    update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  syntax error at or near "update"
LINE 21:     update PersonID INT UNIQUE;
             ^


********** Error **********

ERROR: syntax error at or near "update"
SQL state: 42601
Character: 392

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );

create table umlagerung
(EAN varchar(255),
Menge int,
PO int);


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully with no result in 90 ms.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );

-- create table umlagerung
-- (EAN varchar(255),
-- Menge int,
-- PO int);

COPY umlagerung FROM '/Users/markhallbauer/Documents/Shared/20130715-Umlagerung.csv' WITH DELIMITER ';' CSV HEADER;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully: 4610 rows affected, 47 ms execution time.

-- Executing query:
select * from umlagerung;
Total query runtime: 238 ms.
4610 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );

create table umlagerung2
(EAN varchar(255),
Menge int,
PO int);

-- COPY umlagerung FROM '/Users/markhallbauer/Documents/Shared/20130715-Umlagerung.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully with no result in 19 ms.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully: 3871 rows affected, 20 ms execution time.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select * from umlagerung
where umlagerung.EAN = umlagerung2.EAN;

/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  missing FROM-clause entry for table "umlagerung2"
LINE 20: where umlagerung.EAN = umlagerung2.EAN;
                                ^


********** Error **********

ERROR: missing FROM-clause entry for table "umlagerung2"
SQL state: 42P01
Character: 435

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 33 ms.
247 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN, sum(umlagerung2.Menge) as Menge2, sum(umlagerung.Menge) as Menge
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  column "umlagerung2.ean" must appear in the GROUP BY clause or be used in an aggregate function
LINE 19: select umlagerung2.EAN, sum(umlagerung2.Menge) as Menge2, su...
                ^


********** Error **********

ERROR: column "umlagerung2.ean" must appear in the GROUP BY clause or be used in an aggregate function
SQL state: 42803
Character: 394

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN, sum(umlagerung2.Menge) as Menge2, sum(umlagerung.Menge) as Menge
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN, Menge2, Menge
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  column reference "menge" is ambiguous
LINE 23: group by umlagerung2.EAN, Menge2, Menge
                                           ^


********** Error **********

ERROR: column reference "menge" is ambiguous
SQL state: 42702
Character: 585

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN, sum(umlagerung2.Menge) as Menge2, sum(umlagerung.Menge) as Menge
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN, sum(umlagerung2.Menge) , sum(umlagerung.Menge)
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  aggregates not allowed in GROUP BY clause
LINE 19: select umlagerung2.EAN, sum(umlagerung2.Menge) as Menge2, su...
                                 ^


********** Error **********

ERROR: aggregates not allowed in GROUP BY clause
SQL state: 42803
Character: 411

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN, sum(umlagerung2.Menge) as Menge2, sum(umlagerung.Menge) as Menge
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 33 ms.
247 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN, sum(umlagerung2.Menge) as Menge2, sum(umlagerung.Menge) as Menge, sum(umlagerung2.Menge,umlagerung.Menge)
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  function sum(integer, integer) does not exist
LINE 19: ...Menge) as Menge2, sum(umlagerung.Menge) as Menge, sum(umlage...
                                                              ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.


********** Error **********

ERROR: function sum(integer, integer) does not exist
SQL state: 42883
Hint: No function matches the given name and argument types. You might need to add explicit type casts.
Character: 477

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN, sum(umlagerung2.Menge) as Menge2, sum(umlagerung.Menge) as Menge, (sum(umlagerung2.Menge) + sum(umlagerung.Menge)) as Total
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 32 ms.
247 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN, sum(umlagerung2.Menge) as 'Menge 20130716', sum(umlagerung.Menge) as 'Menge 20130715', (sum(umlagerung2.Menge) + sum(umlagerung.Menge)) as Total
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  syntax error at or near "'Menge 20130716'"
LINE 19: select umlagerung2.EAN, sum(umlagerung2.Menge) as 'Menge 201...
                                                           ^


********** Error **********

ERROR: syntax error at or near "'Menge 20130716'"
SQL state: 42601
Character: 437

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select umlagerung2.EAN, sum(umlagerung2.Menge) as "Menge 20130716", sum(umlagerung.Menge) as "Menge 20130715", (sum(umlagerung2.Menge) + sum(umlagerung.Menge)) as Total
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 32 ms.
247 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select distinct umlagerung2.EAN, sum(umlagerung2.Menge) as "Menge 20130716", sum(umlagerung.Menge) as "Menge 20130715", (sum(umlagerung2.Menge) + sum(umlagerung.Menge)) as Total
from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 35 ms.
247 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select distinct umlagerung2.EAN, 
sum(umlagerung2.Menge) as "Menge 20130716", 
sum(umlagerung.Menge) as "Menge 20130715", 
(sum(umlagerung2.Menge) + sum(umlagerung.Menge)) as Total

from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 37 ms.
247 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select distinct umlagerung2.EAN, 
	sum(umlagerung2.Menge) as "Menge 20130716", 
	sum(umlagerung.Menge) as "Menge 20130715", 
	(sum(umlagerung2.Menge) + sum(umlagerung.Menge)) as Total

from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean
group by umlagerung2.EAN
order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 37 ms.
247 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;

select distinct umlagerung2.EAN, 
	sum(umlagerung2.Menge) as "Menge 20130716", 
	sum(umlagerung.Menge) as "Menge 20130715", 
	(sum(umlagerung2.Menge) + sum(umlagerung.Menge)) as Total

from umlagerung2
inner join umlagerung
on umlagerung2.ean = umlagerung.ean

group by umlagerung2.EAN

order by umlagerung2.ean;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 36 ms.
247 rows retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;



select count(distinct EAN) from umlagerung2;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 85 ms.
1 row retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;



-- select count(distinct EAN) from umlagerung2;

drop table umlagerung2;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully with no result in 19 ms.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';' CSV HEADER;

-- select * from umlagerung;



select count(distinct EAN) from umlagerung2;

-- drop table umlagerung2;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


ERROR:  relation "umlagerung2" does not exist
LINE 21: select count(distinct EAN) from umlagerung2;
                                         ^


********** Error **********

ERROR: relation "umlagerung2" does not exist
SQL state: 42P01
Character: 421

-- Executing query:
create table umlagerung2
(EAN varchar(255),
Menge int,
PO int);
Query returned successfully with no result in 20 ms.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';'; --CSV HEADER

-- select * from umlagerung;



-- select count(distinct EAN) from umlagerung2;

-- drop table umlagerung2;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully: 3872 rows affected, 19 ms execution time.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';'; --CSV HEADER

-- select * from umlagerung;



select count(distinct EAN) from umlagerung2;

-- drop table umlagerung2;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 88 ms.
1 row retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';'; --CSV HEADER

-- select * from umlagerung;



select count(distinct EAN) from umlagerung;

-- drop table umlagerung2;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 69 ms.
1 row retrieved.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung2
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';'; --CSV HEADER

-- select * from umlagerung;



-- select count(distinct EAN) from umlagerung;

drop table umlagerung;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully with no result in 19 ms.

-- Executing query:
create table umlagerung
(EAN varchar(255),
Menge int,
PO int);
Query returned successfully with no result in 20 ms.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung
-- (EAN varchar(255),
-- Menge int,
-- PO int);

COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130715-Umlagerung.csv' WITH DELIMITER ';'; --CSV HEADER

-- select * from umlagerung;



-- select count(distinct EAN) from umlagerung;

-- drop table umlagerung;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Query returned successfully: 4611 rows affected, 19 ms execution time.

-- Executing query:
-- CREATE TABLE Persons
-- (
-- PersonID int,
-- LastName varchar(255),
-- FirstName varchar(255),
-- Address varchar(255),
-- City varchar(255)
-- );
-- 
-- create table umlagerung
-- (EAN varchar(255),
-- Menge int,
-- PO int);

-- COPY umlagerung2 FROM '/Users/markhallbauer/Documents/Shared/20130715-Umlagerung.csv' WITH DELIMITER ';'; --CSV HEADER

-- select * from umlagerung;



select count(distinct EAN) from umlagerung;

-- drop table umlagerung;


/*
INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1','Hallbauer', 'Mark', 'Erika-Mann-Str 17, 80636', 'München');
*/

-- Select * from Persons;

/*CREATE SEQUENCE mytable_myid_seq;*/


-- ALTER TABLE Persons 
--     update PersonID INT UNIQUE;

/*
ALTER TABLE Persons 
    ALTER COLUMN myid 
        SET DEFAULT NEXTVAL('mytable_myid_seq');
*/

/*UPDATE Persons 
    SET myid = NEXTVAL('mytable_myid_seq');*/

-- drop table Persons;


Total query runtime: 22 ms.
1 row retrieved.

-- Executing query:
COPY umlagerung FROM '/Users/markhallbauer/Documents/Shared/20130715-Umlagerung.csv' WITH DELIMITER ';'; --CSV HEADER
Query returned successfully: 4611 rows affected, 21 ms execution time.

