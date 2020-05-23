
/* CREATE AN EMPTY TABLE FOR Q1 */
/* COL1: Customers */
-- a
CREATE TABLE Customers (
     cid  number(9) PRIMARY KEY, 
     cname varchar(15) NOT NULL,
     age      number,
     zipcode  number(5));
/*COL2: Vehicles */
CREATE TABLE Vehicles(
    vin number(9) PRIMARY KEY,
    manufacturer varchar(15) NOT NULL,
    year number(4),
    seats number(2));
/*COL 3:  Sales */
CREATE TABLE Sales (
   cid   number(3),
   vin   number(7),
   price number(10, 2),
   PRIMARY KEY (cid, vin),
   FOREIGN KEY (cid) REFERENCES Customers,
   FOREIGN KEY (vin) REFERENCES Vehicles
  );
/* END of Table */
-- insert data to queries
INSERT INTO Customers (cid, cname, age, zipcode)
	VALUES (1, 'Mike', 45, 02112);
INSERT INTO Customers
	VALUES (2, 'Betty', 55, 02125);
INSERT INTO Customers
	VALUES (3, 'Natan', 35,  02113);
INSERT INTO Customers
	VALUES (4, 'John', 34, 02125);
INSERT INTO Customers
	VALUES (5, 'TIAGO', 24,  02113);

insert into Vehicles (vin, manufacturer, year, seats)
	 values (101 ,'BMW',   1999,  5);
insert into Vehicles
    values (102, 'NISSAN', 2017,  6);
insert into Vehicles
    values (103, 'ACURA',    2015,  5);
insert into Vehicles
    values (104, 'TOYOTA', 2005,  7);
insert into Vehicles
    values (105, 'TESLA',  2019,  4);

insert into  Sales (cid, vin, price) 
	         values (1, 101, 5000);
insert into  Sales  
			values  (2, 102, 3000000);
insert into  Sales  
			values  (2, 103,  50000000);
insert into  Sales  
			values  (4, 104,  NULL);
insert into  Sales  
			values  (2, 105,  10000);
insert into  Sales  
			values  (3, 102, 30000);
insert into  Sales  
			values  (2, 104,  NULL);
insert into  Sales  
			values  (3, 105,  10000);


-- b
SELECT c.cname FROM Customers c, Sales s 
WHERE c.cid = s.cid AND s.price > 20000;
--c
SELECT v.manufacturer FROM Vehicles v, Customers c, Sales s WHERE 
c.cid = s.cid AND s.vin = v.vin AND c.zipcode != 02125 GROUP BY v.manufacturer;
--d
SELECT  c.age FROM Customers c ,Vehicles v, Sales s 
WHERE c.cid = s.cid AND v.vin = s.vin
and v.seats != 6 OR v.vin = NULL;
--e 
SELECT v.manufacturer FROM Vehicles v, Customers c, Sales s 
WHERE c.cid = s.cid AND v.vin= s.vin AND c.zipcode;
--f
SELECT v.year FROM Vehicles v, Sales s 
WHERE v.vin = s.vin AND s.price = (SELECT MIN(s.price) FROM Sales s);
--g
SELECT ROUND(AVG(s.price), 2) FROM Sales s, Vehicles v
WHERE v.vin = s.vin OR s.price != NULL;
--h

--i
SELECT DISTINCT c.zipcode
FROM Customers c,Vehicles v,Sales s
WHERE c.cid = s.cid and v.vin = s.vin;
--j
SELECT v.year
FROM Vehicles v, Sales s
WHERE v.vin = s.vin AND s.price > 30000
GROUP BY v.vin
HAVING COUNT(v.vin) > 100; --order
--k
SELECT ROUND(AVG(s.price), 2)
FROM Sales s, Vehicles v
WHERE v.vin = s.vin and s.price >= 100000
GROUP BY v.vin;