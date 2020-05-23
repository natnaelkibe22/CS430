--Parts (pid:integer, pname:string, year:integer, price:integer)
--Suppliers (sid:integer, sname: string, state:string, zipcode:string)
--Orders (pid:integer, sid:integer, quantity:integer)

--a. creating tables
CREATE table Parts(
   pid  int PRIMARY KEY,
    pname varchar(100) NOT NULL,
    year  number(4),
    price   int
  );
CREATE table Suppliers(
    sid  int PRIMARY KEY,
    sname  varchar(100) NOT NULL,
    state  varchar(50),
    zipcode varchar(5)
  );
CREATE table Orders(
  pid int,
  sid int,
  quantity int,
  FOREIGN KEY (pid) REFERENCES Parts,
  FOREIGN KEY (sid) REFERENCES Suppliers
);


insert into Parts values (1, 'intel i9 CPU', 2020, 300);
insert into Parts values (2, 'Corcier RAM', 2019, 129);
insert into Parts values (3, 'RTX 2080ti GPU',2019, 2000);
insert into Parts values (4, 'Homedepot', 2013, 40);
  insert into Parts values (5, 'intel i7 CPU', 2016, 109);
  insert into Parts values (6, 'intel i5 CPU', 2013, 59);
insert into Parts values (7, 'intel i3 CPU', 2008, 30);
insert into Parts values (8, 'samsung RAM', 2014, 39);
  insert into Parts values (9, 'GTX 1080ti GPU', 2016, 650);

		insert into Suppliers values (1, 'Intel', 'California', 01838);
		insert into Suppliers values (2, 'Corcier', 'Chicago', 02532);
		insert into Suppliers values (3, 'Nvidia', 'California', 01839);
		insert into Suppliers values (4, 'Samsung', 'Maine', 03398);
      		insert into Suppliers values (5, 'Homedepot', 'Kansas', 02478);


		insert into Orders values (2, 2, 100);
		insert into Orders values (1, 1, 1000);
			insert into Orders values (9, 3, 200);
		insert into Orders values (8, 4,400 );
