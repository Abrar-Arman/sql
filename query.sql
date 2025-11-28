CREATE DATABASE film_actor;


-- Database Design
CREATE TABLE  directors(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(20) NOT NULL,
country VARCHAR(20) NOT NULL
)
;
CREATE TABLE films (
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 title VARCHAR(20) NOT NULL,
 relase_year INT NOT NULL,
 description VARCHAR(80),
 director_id INT REFERENCES directors(id)
)
;
CREATE TABLE actors (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(20) NOT NULL,
country VARCHAR(20) NOT NULL
);
CREATE TABLE film_actor (
 film_id INT REFERENCEs films(id),
 actor_id INT REFERENCES actors(id),
 salary NUMERIC(10,2) NOT NULL ,
 PRIMARY KEY (film_id, actor_id)
);

--  Sample Data
INSERT INTO directors(name, country)
VALUES ('Christopher Nolan','UK'),('Steven Spielberg','USA');
INSERT INTO films(title,relase_year,director_id)
VALUES ('Inception',2010,1),('Interstellar',2011,1),('Jurassic Park',2010,1);
INSERT INTO actors(name, country)
VALUES ('Leonardo DiCaprio', 'USA'),
('Matthew McConaughey', 'USA'),
('Laura Dern', 'USA'),
('Rumi Hiiragi', 'Japan');
INSERT INTO film_actor
VALUES (1, 1, 1500000.00), 
(2, 2, 1200000.00),  
(2, 1, 900000.00);


-- Query 
  -- List all films with their directors
  select f.title,d.name,d.country as directorNmae 
  from films f join directors d on f.director_id=d.id;

  --List all actors in each film.
  select  a.name as actorName,f.title as filmName
  from (actors as a JOIN film_actor as fa on fa.actor_id=a.id) join films f on f.id=fa.film_id

  --List all films and show actors even if some films have no actors.
  select title as filmTitle,name as actorName
  from (films f LEFT JOIN film_actor fa on fa.film_id=f.id) LEFT  join actors a on a.id=fa.actor_id


-- CREATE USER TABLE + RELATION
 CREATE TABLE users(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 gender CHAR(1) NOT NULL
 );
 CREATE TABLE ratings(
 film_id INT  REFERENCES films(id),
 user_id INT REFERENCES users(id),
 rating NUMERIC(2,1) NOT NULL ,
 comment VARCHAR(80),
 PRIMARY KEY (film_id,user_id)
 );
 INSERT INTO users(gender)
 VALUES ('F'),('M');
 INSERT INTO ratings(film_id, user_id, rating)
 VALUES (1,1,4.5),(1,2,3.0),(2,2,2.0),(3,1,5.0),(3,2,5.0);
 
--Show average rating per film
select title,AVG(rating) AS avgRating
from ratings r  join films f on r.film_id=f.id
GROUP BY film_id,title
-- List films and ratings even if some films have no ratings
select title,rating
from ratings r  RIGHT JOIN films f on r.film_id=f.id

 
 