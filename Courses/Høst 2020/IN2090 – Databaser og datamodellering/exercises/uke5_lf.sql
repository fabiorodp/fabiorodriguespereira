/* Oppgave 1 – Enkle SELECT-setninger: */
--1)	Alle sjangere i tabellen Genre

SELECT *
FROM Genre;

/*
    genre    
-------------
 Action
 Adult
 Adventure
 Animation
 Biography
 Comedy
 Crime
 Documentary
 Drama
 Family
 Fantasy
 Film-Noir
 Game-Show
 History
 Horror
 Music
 Musical
 Mystery
 News
 Reality-TV
 Romance
 Sci-Fi
 Short
 Sport
 Talk-Show
 Thriller
 War
 Western
(28 rows)
*/


--2)	Filmid og  tittel  for alle  filmer  utgitt  i 1892 (12)
SELECT f.filmid, f.title
FROM film f
WHERE f.prodyear = 1892
;

/*
 filmid  |          title
---------+-------------------------
  436251 | Clown et ses chiens, Le
  700124 | Clown and His Dogs, The
  954426 | Boxing
 1394843 | Pauvre Pierrot
 1874971 | Un bon bock
 2286076 | Poor Pierrot
 2320346 | Fencing
 2887002 | Hand Shake, A
 3086012 | Good Beer, A
 3111303 | Man on Parallel Bars
 3111751 | Wrestling
 5500730 | Prince de Galles, Le
(12 rows)
*/


--3)	Filmid og tittel for alle filmer der filmid er mellom 2000 og 2030 (14)
SELECT f.filmid, f.title
FROM film f
WHERE f.filmid >= 2000 AND f.filmid <= 2030
;

/*
filmid | title
--------+--------------------------------------------------------
  2001 | Bowling Balls
  2003 | Musta rakkaus
  2004 | Espantalho
  2006 | Northern Lights
  2010 | 'Cannibal Apocalypse' Redux
  2017 | Chronicles of the Dark Carnival, The
  2018 | Oral Majority 3
  2019 | Nainen on valttia
  2020 | Cidade Oculta
  2021 | Highlander: Endgame
  2022 | Animales devoradores: El hombre
  2023 | Blood Red Planet
  2024 | Pura vida Ibiza
  2026 | 'Capulina contra las momias' (El terror de Guanajuato)
(14 rows)
*/


--4)	Filmid og tittel på alle filmer med Star Wars i navnet (129)
SELECT f.title, f.filmid
FROM Film f
WHERE f.title LIKE '%Star Wars%'
;

/*
title                            	| filmid
--------------------------------------------------------------------+---------
'Star Wars' Holiday Special, The                               	|	7450
'Star Wars': A Musical Journey                                 	|	7466
'Star Wars': Feel the Force                                    	|	7482
Star Wars: Rebel Assault                                       	|   47911
Star Wars: Revelations                                         	|   62417
Star Wars: Jedi Knight - Dark Forces II                        	|  127428
Star Wars: Episode I - The Phantom Menace                      	|  127652
...
(129 rows)
*/


-- 5)	Fornavn og etternavn til personid 465221 (1)
SELECT p.firstname, p.lastname
FROM Person p
WHERE p.personid = 465221
;

/*
firstname | lastname
-----------+----------
Johnny	| Depp
(1 row)
*/


-- 6)	Alle unike rolletyper (parttype) i tabellen Filmparticipation (7)
SELECT DISTINCT parttype
FROM filmparticipation
;
/*

parttype
------------------
writer
costume designer
director
editor
cast
composer
producer
(7 rows)
*/

-- 7)	Tittel og produksjonsår for alle filmer som inneholder ordene «Rush Hour» (15)
SELECT f.title, f.prodyear
FROM film f
WHERE f.title LIKE '%Rush Hour%'
;

/*
                        title                           | prodyear
----------------------------------------------------------+----------
 Rush Hour                                                |   1941
 Rush Hour                                                |   1998
 Reel Comedy: Rush Hour 2                                 |   2001
 Rush Hour 3                                              |   2007
 Rush Hour                                                |   2006
 Rush Hour 2                                              |   2001
 Rush Hour, The                                           |   1974
 Stoßzeit - Rush Hour                                     |   1970
 Rush Hour, The                                           |   1928
 SimCity 4: Rush Hour                                     |   2003
 Rush Hour - Due mine vaganti                             |   2000
 Colpo grosso al drago rosso - Rush Hour 2                |   2002
 Piece of the Action: Behind the Scenes of 'Rush Hour', A |   1999
 Rush Hour                                                |   1970
 Reel Comedy: Rush Hour                                   |   1998
(15 rows)
*/

-- 8) Vis filmid, navn og produksjonsår for filmer som inneholder ordet «Norge»
SELECT filmid, title, prodyear
FROM film
WHERE title LIKE '%Norge%';

-- 9) Vis filmid for kinofilmer som har filmtittelen Love (kinofilmer har filmtype «C»)
SELECT fi.filmid
FROM filmitem fi INNER JOIN film f ON f.filmid = fi.filmid
WHERE fi.filmtype = 'C'
AND f.title = 'Love';

-- 10) Hvor mange filmer i filmdatabasen er norske?*/
SELECT COUNT(*) AS antallNorskeFilmer
FROM Filmcountry
WHERE country = 'Norway';

/* Oppgave 2 – Nestede setninger: */
-- 1)	Filmid og filmtype (fra Filmitem) for alle filmer som ble produsert i 1894 (82)
SELECT *
FROM Filmitem fi
WHERE fi.filmid in (SELECT f.filmid FROM Film f WHERE f.prodyear = 1894)
;

(Ekvivalent med:
SELECT *
FROM Filmitem fi INNER JOIN Film f ON (f.filmid = fi.filmid)
WHERE f.prodyear = 1894;)

/*
 filmid  | filmtype 
---------+----------
  105825 | C
  265931 | C
  286394 | C
  365419 | C
  377434 | C
  377514 | C
  380074 | C
  413004 | C
  432746 | C
  438139 | C
  457691 | C
  492331 | C
  492890 | C
  ...
(82 rows)
*/

-- 2)	Alle kvinnelige skuespillere (cast) i filmen med filmid 357076. Skriv ut navn på skuespillerne
--      sortert på etternavn i alfabetisk rekkefølge (11)
SELECT p.firstname, p.lastname
FROM Person p
WHERE 	p.gender = 'F' AND p.personid in 
  (SELECT fp.personid 
  FROM Filmparticipation fp 
  WHERE fp.filmid = 357076 AND fp.parttype = 'cast'
  )
 ORDER BY p.lastname
;

/*
 firstname |  lastname   
-----------+-------------
 Victoria  | Beynon-Cole
 Cate      | Blanchett
 Sabine    | Crossen
 Lori      | Dungey
 Megan     | Edwards
 Taea      | Hartwell
 Katie     | Jackson
 Sarah     | McLeod
 Elizabeth | Moody
 Kate      | O'Rourke
 Liv       | Tyler
(11 rows)
*/

/* Oppgave 3 – Setninger med ulike typer JOIN: */
--1) Vis alle genrene til filmen 'Pirates of the Caribbean: The Legend of Jack Sparrow'
SELECT f.title, fg.genre
FROM film f NATURAL JOIN filmgenre fg
WHERE f.title = 'Pirates of the Caribbean: The Legend of Jack Sparrow';
/*
                        title                         |   genre
------------------------------------------------------+-----------
 Pirates of the Caribbean: The Legend of Jack Sparrow | Action
 Pirates of the Caribbean: The Legend of Jack Sparrow | Adventure
 Pirates of the Caribbean: The Legend of Jack Sparrow | Comedy
 Pirates of the Caribbean: The Legend of Jack Sparrow | Drama
 Pirates of the Caribbean: The Legend of Jack Sparrow | Thriller
(5 rows)

*/

--2) Alle genrer for filmen med filmid 985057
SELECT * from film NATURAL JOIN filmgenre where filmid = 985057; 
/*
 filmid |  title  | prodyear |   genre
--------+---------+----------+-----------
 985057 | Matilda |     1996 | Action
 985057 | Matilda |     1996 | Adventure
 985057 | Matilda |     1996 | Comedy
 985057 | Matilda |     1996 | Crime
 985057 | Matilda |     1996 | Drama
 985057 | Matilda |     1996 | Family
 985057 | Matilda |     1996 | Fantasy
 985057 | Matilda |     1996 | Mystery
 985057 | Matilda |     1996 | Thriller
(9 rows)
*/

-- 3)	Tittel produksjonsår og filmtype for alle filmer som ble produsert i 1894 (82)
SELECT f.title, f.prodyear, fi.filmtype
FROM Film f, Filmitem fi
WHERE f.prodyear = 1894
  AND f.filmid = fi.filmid
;

SELECT f.title, f.prodyear, fi.filmtype
FROM Film f NATURAL JOIN Filmitem fi
WHERE f.prodyear = 1894
;

SELECT f.title, f.prodyear, fi.filmtype
FROM Film f INNER JOIN Filmitem fi ON f.filmid = fi.filmid
WHERE f.prodyear = 1894
;

/*
                     title                      | prodyear | filmtype
------------------------------------------------+----------+----------
 Fancy Club Swinger                             |     1894 | C
 Barbershop, The                                |     1894 | C
 Amateur Gymnast, No. 2                         |     1894 | C
 Caicedo (with Pole)                            |     1894 | C
 Annabelle Butterfly Dance                      |     1894 | C
 Annabelle Sun Dance                            |     1894 | C
 Annie Oakley                                   |     1894 | C
 Barber Shop, The                               |     1894 | C
 Armand D'Ary                                   |     1894 | C
 Cock Fight, The                                |     1894 | C
 ....
(82 rows)
*/

-- 4)	Alle kvinnelige skuespillere(cast) i filmen med filmid 357076. Skriv ut navn og pa skuespillerene og filmid (11)
SELECT DISTINCT p.firstname, p.lastname, fp.filmid
FROM Person p, Filmparticipation fp
WHERE p.gender = 'F'
  AND fp.filmid = 357076
  AND fp.parttype = 'cast'
  AND p.personid = fp.personid
;

SELECT DISTINCT p.firstname, p.lastname, fp.filmid
FROM Person p NATURAL JOIN Filmparticipation fp
WHERE p.gender = 'F'
  AND fp.filmid = 357076
  AND fp.parttype = 'cast'
;

SELECT DISTINCT p.firstname, p.lastname, fp.filmid
FROM Person p INNER JOIN Filmparticipation fp ON p.personid = fp.personid
WHERE p.gender = 'F'
  AND fp.filmid = 357076
  AND fp.parttype = 'cast'
;

/*
 firstname |  lastname   | filmid
-----------+-------------+--------
 Cate      | Blanchett   | 357076
 Elizabeth | Moody       | 357076
 Kate      | O'Rourke    | 357076
 Katie     | Jackson     | 357076
 Liv       | Tyler       | 357076
 Lori      | Dungey      | 357076
 Megan     | Edwards     | 357076
 Sabine    | Crossen     | 357076
 Sarah     | McLeod      | 357076
 Taea      | Hartwell    | 357076
 Victoria  | Beynon-Cole | 357076
(11 rows)
*/

--	BONUS: Hva er tittelen? Legg til en ekstra kolonne med tittelen (krever join med enda en tabell). (11)
SELECT DISTINCT p.firstname, p.lastname, fp.filmid, f.title
FROM Person p, Filmparticipation fp, Film f
WHERE p.gender = 'F'
  AND fp.filmid = 357076
  AND fp.parttype = 'cast'
  AND p.personid = fp.personid
  AND fp.filmid = f.filmid
;

SELECT DISTINCT p.firstname, p.lastname, fp.filmid, f.title
FROM Person p NATURAL JOIN Filmparticipation fp NATURAL JOIN Film f
WHERE p.gender = 'F'
  AND fp.filmid = 357076
  AND fp.parttype = 'cast'
;

SELECT DISTINCT p.firstname, p.lastname, fp.filmid, f.title
FROM Person p INNER JOIN Filmparticipation fp ON p.personid = fp.personid
  INNER JOIN Film f ON fp.filmid = f.filmid
WHERE p.gender = 'F'
  AND fp.filmid = 357076
  AND fp.parttype = 'cast'
;

/*
 firstname |  lastname   | filmid |                       title
-----------+-------------+--------+----------------------------------------------------
 Cate      | Blanchett   | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Elizabeth | Moody       | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Kate      | O'Rourke    | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Katie     | Jackson     | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Liv       | Tyler       | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Lori      | Dungey      | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Megan     | Edwards     | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Sabine    | Crossen     | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Sarah     | McLeod      | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Taea      | Hartwell    | 357076 | Lord of the Rings: The Fellowship of the Ring, The
 Victoria  | Beynon-Cole | 357076 | Lord of the Rings: The Fellowship of the Ring, The
(11 rows)
*/

--5)	Finn fornavn og etternavn på alle personer som har deltatt i TV-serien South Park. Bruk tabellene Person, Filmparticipation og Series, og løs det med:
-- a.	INNER JOIN
SELECT DISTINCT p.personid, p.lastname, p.firstname, s.maintitle
FROM Person p
INNER JOIN Filmparticipation fp
    ON p.personid = fp.personid
INNER JOIN Series s
    ON s.seriesid = fp.filmid
WHERE s.maintitle = 'South Park';

-- b.	 Implisitt join
SELECT DISTINCT p.personid, p.lastname, p.firstname, s.maintitle
FROM Person p, Filmparticipation fp, Series s
WHERE s.seriesid = fp.filmid
    AND p.personid = fp.personid
    AND maintitle = 'South Park';

-- c.	NATURAL JOIN
SELECT DISTINCT p.personid, p.lastname, p.firstname, s.maintitle
FROM Person p NATURAL JOIN Filmparticipation fp NATURAL JOIN Series
WHERE s.maintitle LIKE 'South Park';

-- d.	Hvorfor gir NATURAL JOIN ulikt resultat fra INNER JOIN og implisitt join? Forklar.
/*`NATURAL JOIN` joiner «automatisk» på attributtene som har _samme navn_.
Dette fungerer i join-operasjonen mellom tabellen `Person` og `Filmparticipation` 
fordi begge har attributtet `personid` som det joines på. Men mellom `Filmparticipation` 
og `Series` er det ingen attributter med felles navn: vi må joine på `filmparticipation.filmid` 
og `series.seriesid`, og det går ikke med `NATURAL JOIN`. Vi må derfor bruke en annen 
join-metode (som i a eller b). */

-- 6) Navn på alle skuespillere (cast) i filmen, deres rolle (parttype) i filmen «Harry Potter and the Goblet of Fire» (vær presis med staving), få med tittelen til filmen også.
SELECT DISTINCT p.firstname, p.lastname, fp.parttype, f.title
FROM Person p NATURAL JOIN Filmparticipation fp NATURAL JOIN film f
WHERE title = 'Harry Potter and the Goblet of Fire' AND parttype = 'cast';

-- 7) navn på alle skuespillere (cast) i filmen Baile Perfumado
SELECT DISTINCT p.firstname || ' ' || p.lastname AS name
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE fp.parttype = 'cast'
AND f.title = 'Baile Perfumado';

-- 8) Skriv ut tittel og regissør for norske filmer produsert før 1960.
select film.title, person.firstname || ' ' || person.lastname as fullname
from filmcountry
    natural join film
    natural join filmparticipation
    natural join person
where filmcountry.country = 'Norway'
    and parttype = 'director'
    and prodyear < 1960;
