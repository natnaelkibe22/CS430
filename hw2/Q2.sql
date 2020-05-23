/*
Movies (movie_id:integer, title:string, year:integer, studio:string)
Actors (actor_id:integer, name:string, nationality:string)
StarsIn(actor_id:integer, movie_id:integer, character:string)
*/
/* Author: Natnael Kibe    HW2                        CS430 */

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




insert into StarsIn( actor_id, movie_id, character)
   values (101 , 222,   'Gom C');
insert into StarsIn
    values (102,  111, 'Tom H.');
insert into StarsIn
    values (103, 666,   'Iron man');
insert into StarsIn
    values (102, NULL ,   NULL);
insert into StarsIn
    values (102,  555, 'Tom H.');
insert into StarsIn
    values (102,  444, 'Gom H');
insert into StarsIn
    values (104, 555,   'Will S.');
insert into StarsIn
    values (102,  666, 'Tom H');   



--b  correct
SELECT title, studio FROM Movies m, Actors a, StarsIn s
WHERE m.movie_id = s.movie_id AND a.actor_id = s.actor_id AND
a.name = 'Tom Hanks';
--c correct
SELECT name FROM Actors a 
WHERE a.nationality = 'US';
--d  wrong
select a.nationality
from Movies m, Actors a, StarsIn s
where s.actor_id = a.actor_id
AND m.movie_id = s.movie_id
group by s.actor_id
having count(distinct m.studio) = (SELECT count(distinct m.studio) from Movies m);
--e  correct
SELECT count(DISTINCT name) FROM Movies m, Actors a, StarsIn s WHERE
a.actor_id = s.actor_id AND m.movie_id = s.movie_id AND s.character LIKE 'G__%';
--f
SELECT title, COUNT(a.actor_id) FROM Movies m, Actors a, StarsIn s 
WHERE a.actor_id = s.actor_id AND m.movie_id = s.movie_id 
AND m.studio = 'Universal' GROUP BY m.title
HAVING COUNT(a.actor_id) >= 10;