--a. creating tables
CREATE table Movies(  
   movie_id  number(20) PRIMARY KEY, 
    title varchar(50) NOT NULL,
    year  number(4),
    studio    varchar(100));
CREATE table Actors(
    actor_id  number(10) PRIMARY KEY,
    name  varchar(100) NOT NULL,
    nationality  varchar);
CREATE table StarsIn(
  actor_id number(10),
  movie_id number(20),
  character varchar(200),
  FOREIGN KEY (actor_id) REFERENCES Actors,
  FOREIGN KEY (movie_id) REFERENCES Movies );


INSERT INTO Movies(movie_id, title, year, studio)
  VALUES (111, 'Forrest of Narnia', 1994, 'Paramount Pictures');
INSERT INTO Movies 
  VALUES (222, 'Mission: Impossible', 2007,'Paramount Pictures');
INSERT INTO Movies
  VALUES (333, 'Avengers: EndGame', 2019,   'Universal');
INSERT INTO Movies
  VALUES (444, 'Inception', 2000, 'Twentieth Century Fox');
INSERT INTO Movies
  VALUES (555, 'Bad Boys for Life', 2020,  'Columbia Pictures');
INSERT INTO Movies
  VALUES (666, 'Avengers: Infinity War', 2018,   'Universal');


insert into Actors (actor_id, name, nationality)
   values (101 ,'Tom Cruise',   'US');
insert into Actors
    values (102, 'Tom Hanks', 'US');
insert into Actors
    values (103, 'Robert Downey Jr',   'US');
insert into Actors
    values (104, 'Will Smith', 'US');
insert into Actors
    values (105, 'Ryan Reynolds',  'CA');


insert into StarsIn
    values (103, 333,   'Iron man');
--stars in all studio
insert into StarsIn
    values (105, 111,   'A');
insert into StarsIn
    values (105, 222,   'B');
insert into StarsIn
    values (105, 333,   'C');
insert into StarsIn
    values (105, 444,   'D');
insert into StarsIn
    values (105, 555,   'E');
insert into StarsIn
    values (105, 666,   'E');


--a 
CREATE VIEW CharactersPlayed (name, nationality, character, year)
AS select a.name, a.nationality,  s.character, m.year from Actors a, 
Movies m, StarsIn s where s.actor_id = a.actor_id and s.movie_id = m.movie_id;

--B
Select distinct c.nationality from CharactersPlayed c, Movies m where c.character = 'Forrest Gump';

--c
SELECT c.year, COUNT(distinct c.nationality) FROM CharactersPlayed c GROUP BY c.year;