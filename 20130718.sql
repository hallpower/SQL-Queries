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

-- select EAN, Menge from umlagerung
-- where EAN = '4013283712009'
-- union --all
-- select EAN, Menge from umlagerung2
-- where EAN = '4013283712009';

-- select umlagerung.EAN, (umlagerung.Menge + umlagerung2.Menge) as Total
-- from umlagerung
-- full outer join umlagerung2
-- on umlagerung.EAN = umlagerung2.EAN;

-- create table voll_erfüllbar
-- (Location_Code varchar(255),
-- DHL_Reporting_Dt date, 
-- Document_No_ varchar(255),
-- Anzahl_Datensätze int,
-- Outstanding_Quantity float);


-- select umlagerung.EAN, 
-- umlagerung.Menge as Heute, 
-- umlagerung2.menge as Gestern, 
-- (umlagerung.Menge + umlagerung2.Menge) as Gesamt
-- from umlagerung
-- 
-- full join umlagerung2 --left join
-- on umlagerung.EAN=umlagerung2.EAN
-- 
-- -- where umlagerung.EAN = '4013283712009'
-- 
-- order by umlagerung.EAN;

-- COPY voll_erfüllbar FROM '/Users/markhallbauer/Documents/Shared/20130716-Umzugsauftrag.csv' WITH DELIMITER ';'; --CSV HEADER

-- select * from umlagerung;

-- select distinct umlagerung2.EAN, 
-- 	sum(umlagerung2.Menge) as "Menge 20130716", 
-- 	sum(umlagerung.Menge) as "Menge 20130715", 
-- 	(sum(umlagerung2.Menge) + sum(umlagerung.Menge)) as Total
-- 
-- from umlagerung2
-- inner join umlagerung
-- on umlagerung2.ean = umlagerung.ean
-- 
-- group by umlagerung2.EAN
-- 
-- order by umlagerung2.ean;

-- select count(distinct EAN) from umlagerung;

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

-- create table for following: best_str, LineNo, ItemNo, Unit, QuantityOrdered, QuantityShipped, File_Name, Modified, Created
-- CREATE TABLE Booking_Time
-- (
-- best_str varchar(255), 
-- LineNo  varchar(255), 
-- ItemNo varchar(255), 
-- Unit varchar(255), 
-- QuantityOrdered varchar(255), 
-- QuantityShipped varchar(255), 
-- File_Name varchar(255), 
-- Modified varchar(255), 
-- Created varchar(255)
-- );

--drop table Booking_Time;
--select headers from Booking_Time;


-- create Table upload_time
-- (file_name varchar(255),
-- uDate varchar(255), 
-- uTime varchar(255)
-- );

-- COPY upload_time FROM '/Users/markhallbauer/Documents/Temp/XML_Datei_Erstellungszeiten.csv' WITH DELIMITER ',' CSV HEADER;

-- select * from upload_time;

-- copy (select bt.best_str, bt.del_slip, bt.itemno, bt.unit, bt.quantityordered, 
-- bt.quantityshipped, bt.file_name, cast(bt.modified as date) as "Date", cast(bt.modified as time) as "Time"
-- from Booking_Time as bt) to '/Users/markhallbauer/Documents/Temp/Upload_Times.csv' DELIMITER ',' CSV HEADER;
-- 
-- left join upload_time as ut
-- on bt.file_name = ut.file_name;

select distinct del_slip from Booking_Time;

--select count(best_str) from Booking_Time;

--select distinct del_slip from Booking_Time;
--where itemno = '4008600178415'; --000000009655

-- select ul.ean, ul2.ean
-- from umlagerung as ul
-- full outer join umlagerung2 as ul2
-- on ul.ean = ul2.ean;


-- select distinct ean from
-- (select ean from umlagerung
-- union all
-- select ean from umlagerung2) as foo
-- where ean in ('5010415203724', '7040351521000', '8714929157050', '4018852011965', '4008976120018', '4007923687079', '4008976214083', '4015400527282'); 

-- where ean in (5010415203724,7040351521000,8714929157050,4018852011965,4008976120018,4007923687079,4008976214083,4015400527282);

