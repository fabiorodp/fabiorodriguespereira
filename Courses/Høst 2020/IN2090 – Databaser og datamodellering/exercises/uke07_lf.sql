-- 1)
/* Hvilke verdier forekommer i attributtet filmtype i relasjonen filmitem?
 Lag en oversikt over filmtypene og hvor mange filmer innen hver type (7). */

SELECT filmtype, COUNT(*) ant
FROM filmitem
GROUP BY filmtype
ORDER BY ant DESC;

/*
 filmtype |  ant   
----------+--------
 C        | 549782
 E        | 446402
 TV       |  74725
 V        |  61050
 TVS      |  52098
 VG       |   6804
 mini     |   6769
(7 rows)
*/

-- 2) 
/* Skriv ut serietittel, produksjonsår og antall episoder for de 15 eldste
TV-seriene i filmdatabasen (sortert stigende etter produksjonsår). */
SELECT s.seriesid, maintitle, firstprodyear, count(e.episodeid)
FROM series s INNER JOIN episode e ON s.seriesid=e.seriesid
GROUP BY s.seriesid, maintitle, firstprodyear
ORDER BY firstprodyear ASC
LIMIT 15;
/*
 seriesid |        maintitle         | firstprodyear | count 
----------+--------------------------+---------------+-------
   685463 | Picture Page             |          1936 |     3
 14320602 | Starlight                |          1936 |     9
 14661946 | Theatre Parade           |          1936 |     4
   509297 | BBC TV Cricket           |          1938 |     2
  4573368 | Ann and Harold           |          1938 |     3
   370184 | Percy Ponsonby           |          1939 |     1
  1724755 | Piste aux étoiles, La    |          1945 |     1
  2151126 | Kaleidoscope             |          1946 |     6
  5203976 | For the Children         |          1946 |     2
  8710741 | Hour Glass               |          1946 |     2
    58347 | Kraft Television Theatre |          1947 |   507
    79211 | Pantomime Quiz           |          1947 |    55
  4202437 | Mainly for Women         |          1947 |     2
  9193793 | Meet the Press           |          1947 |   142
     2763 | Actor's Studio           |          1948 |    63
(15 rows)
*/

-- 3)
/* Mange titler har vært brukt i flere filmer. Skriv ut en oversikt over titler 
som har vært brukt i mer enn 30 filmer. Bak hver tittel skriv antall ganger den 
er brukt. Ordne linjene med hyppigst forekommende tittel først. (12 eller 26) */

SELECT title, COUNT(*) AS ant
FROM film
GROUP BY title
HAVING COUNT(*) > 30
ORDER BY ant DESC;
/*
            title             | ant 
------------------------------+-----
 Hamlet                       |  67
 Carmen                       |  55
 Eurovision Song Contest, The |  52
 ...
 Othello                      |  32
 Romeo and Juliet             |  31
 Alone                        |  31
 Escape                       |  31
(26 rows)
*/
-- Bare kinofilmer (12 rader)
SELECT title, COUNT(*) AS ant
FROM film INNER JOIN filmitem ON film.filmid = filmitem.filmid
WHERE filmitem.filmtype = 'C'
GROUP BY title
HAVING COUNT(*) > 30
ORDER BY ant DESC;
/*
        title        | ant 
---------------------+-----
 Popular Science     |  45
 Love                |  42
 Mother              |  41
 Hamlet              |  39
 Stranger, The       |  37
 Desire              |  37
 Unusual Occupations |  35
 Trap, The           |  34
 Carmen              |  34
 Home                |  33
 Jealousy            |  31
 Destiny             |  31
(12 rows)
*/

-- 4) 
/*
Finn de "Pirates of the Caribbean"-filmene som er med i flere enn 3 genre (4)
*/

SELECT title, count(*) as antall_genre
FROM film f NATURAL JOIN filmgenre fg
WHERE f.title LIKE 'Pirates of the Caribbean%'
GROUP BY f.filmid, title
HAVING count(*) > 3;

/*
                         title                          | antall_genre
--------------------------------------------------------+--------------
 Pirates of the Caribbean: Dead Man's Chest             |            4
 Pirates of the Caribbean: The Curse of the Black Pearl |            4
 Pirates of the Caribbean: At World's End               |            4
 Pirates of the Caribbean: The Legend of Jack Sparrow   |            5
(4 rows)

*/

-- 5) 
/*
Hvilke verdier (fornavn) forekommer hyppigst i firstname-attributtet i tabellen Person?
Finn alle fornavn, og sorter fallende etter antall forekomster. Ikke tell med forekomster
der fornavn-verdien er tom. Begrens gjerne antall rader. (176030 rader, 16108 for flest
fornavn)
*/ 
SELECT p.firstname, COUNT(*) AS sammeFornavn
FROM Person p
WHERE p.firstname <> ''
GROUP BY p.firstname
ORDER BY count(*) DESC
LIMIT 20;

/*                   firstname                     | sammefornavn
---------------------------------------------------+--------------
 John                                              |        16108
 David                                             |        15009
 Michael                                           |        14184
 Robert                                            |        10020
.....
*/

-- 6) 
/* Finn filmene som er med i flest genrer: Skriv ut filmid, tittel og antall genre,
og sorter fallende etter antall genre. Du kan begrense resultatet til 25 rader.*/
SELECT filmid, title, count(*)
FROM film NATURAL JOIN filmgenre
GROUP BY filmid, title
ORDER BY count(*) DESC
LIMIT 25;
/*
 filmid  |                  title                   | count 
---------+------------------------------------------+-------
  694579 | Pokémon Heroes                           |     9
  434615 | Utopia's Redemption                      |     9
  985057 | Matilda                                  |     9
 2060042 | Elder Scrolls III: Morrowind, The        |     8
 1554123 | Rupan sansei: Walther P38                |     8
 1853731 | Vampires, Les                            |     8
 1299610 | Chiquititas: Rincón de luz               |     8
 ...
 (25 rows)
*/

-- 7)
/*
Lag en oversikt over regissører som har regissert mer enn 5 norske filmer. (60)
*/ 

SELECT lastname || ', ' || firstname AS navn
FROM Filmcountry
  NATURAL JOIN Film
  NATURAL JOIN Filmparticipation
  NATURAL JOIN Person
WHERE country = 'Norway'
  AND parttype = 'director'
GROUP BY lastname, firstname
HAVING COUNT(*) > 5;

/*
            navn
-----------------------------
 Andersen, Knut
 Sandø, Toralf
 Holst, Marius
 Heggedal, Jon
 Breien, Anja
 Vennerød, Petter
 ...
 (60 rows)
*/

-- 8)
/* Skriv ut serieid, serietittel og produksjonsår for TV-serier, sortert fallende
etter produksjonsår. Begrens resultatet til 50 filmer. Tips: Ikke ta med serier
der produksjonsåret er null.
*/
SELECT s.seriesid, maintitle, firstprodyear
FROM series s
WHERE firstprodyear is not null
ORDER BY firstprodyear DESC
LIMIT 50;
/*
 seriesid |          maintitle           | firstprodyear
----------+------------------------------+---------------
    87425 | Saka no ue no kumo           |          2009
  2177832 | Last Horseman, The           |          2009
    78907 | Pacific War, The             |          2009
  7980888 | Pacific, The                 |          2009
  7332328 | Untitled Star Wars TV Series |          2009
...
*/


-- 9)
/*
Hva er gjennomsnittlig score (rank) for filmer med over 100 000 stemmer (votes)?
*/
SELECT avg(rank)
FROM filmrating
WHERE votes > 100000;
/*
       avg       
-----------------
 8.4270270708445
(1 row)
*/

-- 10) 
/*
Hvilke filmer (tittel og score) med over 100 000 stemmer har en høyere score enn snittet
blant filmer med over 100 000 stemmer (subspørring!) (20).
*/
SELECT title, rank
FROM film INNER JOIN filmrating ON film.filmid = filmrating.filmid
WHERE votes > 100000 AND rank >= (
    SELECT avg(rank)
    FROM filmrating
    WHERE votes > 100000
);
/*
                       title                        | rank 
----------------------------------------------------+------
 Silence of the Lambs, The                          |  8.6
 Matrix, The                                        |  8.6
 American Beauty                                    |  8.5
 Goodfellas                                         |  8.7
 Lord of the Rings: The Fellowship of the Ring, The |  8.7
 Lord of the Rings: The Return of the King, The     |  8.8
 Lord of the Rings: The Two Towers, The             |  8.7
 Pulp Fiction                                       |  8.8
 Memento                                            |  8.6
 Se7en                                              |  8.5
 Godfather: Part II, The                            |    9
 Fight Club                                         |  8.6
 Raiders of the Lost Ark                            |  8.7
 Godfather, The                                     |  9.1
 Star Wars                                          |  8.8
 Usual Suspects, The                                |  8.7
 Star Wars: Episode V - The Empire Strikes Back     |  8.8
 One Flew Over the Cuckoo's Nest                    |  8.8
 Shawshank Redemption, The                          |  9.2
 Schindler's List                                   |  8.8
(20 rows)

*/

-- 11)
/*
Hvilke 100 verdier (fornavn) forekomer hyppigst i firstname-attributtet i tabellen Person?
*/
SELECT firstname, COUNT(*) AS sammeFornavn
FROM Person
WHERE firstname <> ''
GROUP BY firstname
ORDER BY sammeFornavn DESC
LIMIT 100;
/*
  firstname  | sammefornavn 
-------------+--------------
 John        |        16108
 David       |        15009
 Michael     |        14184
 Robert      |        10020
 Paul        |         9151
 Peter       |         9151
...
*/

-- 12)
/* 
Hvilke to fornavn forekommer mer enn 6000 ganger og akkurat like mange ganger? (Paul og Peter, vanskelig!)
*/
SELECT A.fornavn, A.antall, B.fornavn, B.antall
FROM (
  SELECT firstname AS fornavn, COUNT(*) AS antall
  FROM Person
  GROUP BY firstname
  HAVING COUNT(*) > 5999) AS A
INNER JOIN (
  SELECT firstname AS fornavn, COUNT(*) AS antall
  FROM Person
  GROUP BY firstname
  HAVING COUNT(*) > 5999) AS B
ON A.antall = B.antall AND A.fornavn <> B.fornavn;

/*
 fornavn | antall | fornavn | antall 
---------+--------+---------+--------
 Peter   |   9151 | Paul    |   9151
 Paul    |   9151 | Peter   |   9151
(2 rows)
*/

-- 13)
/*
Hvor mange filmer har Tancred Ibsen regissert?
*/
SELECT COUNT(DISTINCT filmid) AS tancredIbsenFilmer
FROM Filmparticipation
  NATURAL JOIN Person
WHERE
  lastname = 'Ibsen' AND firstname = 'Tancred'
  AND parttype = 'director';

-- eller

SELECT COUNT(*) AS tancredIbsenFilmer
FROM (
  SELECT DISTINCT filmid AS tancredIbsenFilmer
  FROM Filmparticipation
    NATURAL JOIN Person
  WHERE
    lastname = 'Ibsen' AND firstname = 'Tancred'
    AND parttype = 'director') AS t;

/*
 tancredibsenfilmer 
--------------------
                 24
(1 row)
*/

-- 14)
/*
Lag en oversikt over regissører som har regissert mer enn 5 norske filmer (60)
*/
SELECT lastname || ', ' || firstname AS navn
FROM Filmcountry
  NATURAL JOIN Film
  NATURAL JOIN Filmparticipation
  NATURAL JOIN Person
WHERE country = 'Norway'
  AND parttype = 'director'
GROUP BY lastname, firstname
HAVING COUNT(*) > 5
ORDER BY lastname ASC;

/*
            navn             
-----------------------------
 Andersen, Knut
 Asphaug, Martin
 Bang-Hansen, Pål
 Berg, Arnljot
 Bergstrøm, Kåre
 Bleness, Magne
...
(60 rows)
*/

-- 15)
/*
Lag en oversikt (filmtittel) over norske filmer med mer enn én regissør (135).
*/
SELECT filmid, title
FROM Filmcountry
  NATURAL JOIN Film
  NATURAL JOIN Filmparticipation
  NATURAL JOIN Person
WHERE country = 'Norway'
  AND parttype = 'director'
GROUP BY filmid, title
HAVING COUNT(*) > 1;

/*
 filmid  |                       title                       
---------+---------------------------------------------------
     664 | Portrettet
     774 | 22
    1187 | Love Never Dies
    1191 | Kaptein Sabeltann
    1301 | Jeppe på bjerget
    2919 | One Love
    ...
(135 rows)
*/

-- 16)
/*
Finn regissører som har regissert alene mer enn 5 norske filmer (utfordring!) (49)
*/
SELECT lastname || ', ' || firstname AS navn, COUNT(*) AS antall
FROM Filmcountry
  NATURAL JOIN Film
  NATURAL JOIN Filmparticipation
  NATURAL JOIN Person
WHERE country = 'Norway'
  AND parttype = 'director'
  AND filmid NOT IN
   ( SELECT filmid
     FROM Filmcountry
        NATURAL JOIN Film
        NATURAL JOIN Filmparticipation
        NATURAL JOIN Person
     WHERE country = 'Norway'
        AND parttype = 'director'
     GROUP BY filmid, title
     HAVING COUNT(*) > 1 )
GROUP BY lastname, firstname
HAVING COUNT(*) > 5
ORDER BY antall DESC;

/*
            navn             | antall 
-----------------------------+--------
 Bronken, Per                |     23
 Müller, Nils R.             |     22
 Bohwim, Knut                |     18
 Skouen, Arne                |     16
 Caprino, Ivo                |     15
 Breistein, Rasmus           |     14
 Bleness, Magne              |     14
 Ibsen, Tancred              |     14
 ...
 (49 rows)
*/

--17) 
/* 
Finn tittel, produksjonsår og filmtype for alle kinofilmer som ble produsert i året 1893 (4)
*/ 
SELECT f.title, f.prodyear, fi.filmtype
FROM film f NATURAL JOIN filmitem fi
WHERE f.prodyear = 1893;

/*
        title        | prodyear | filmtype 
---------------------+----------+----------
 Blacksmith Scene    |     1893 | C
 Blacksmith Scene #1 |     1893 | C
 Blacksmithing Scene |     1893 | C
 Horse Shoeing       |     1893 | C
(4 rows)
*/

-- 18)
/*
Finn navn på alle skuespillere (cast) i filmen Baile Perfumado (14).
*/
SELECT DISTINCT p.firstname || ' ' || p.lastname AS name
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE fp.parttype LIKE 'cast'
      AND f.title LIKE 'Baile Perfumado';

/*
          name           
-------------------------
 Aramis Trindade
 Chico Díaz
 Cláudio Mamberti
 Daniela Mastroianni
 Duda Mamberti
 Geninha da Rosa Borges
 Germano Haiut
 Giovanna Gold
 Jofre Soares
 John Donovan
 Luiz Carlos Vasconcelos
 Manoel Constantino
 Roger de Renor
 Rutílio Oliveira
(14 rows)
*/

-- 19)
/*
Finn tittel og produksjonsår for alle filmene som Ingmar Bergman har vært 
regissør (director) for. Sorter tuplene kronologisk etter produksjonsår (62).
*/
SELECT f.title, f.prodyear
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE p.lastname LIKE 'Bergman'
AND p.firstname LIKE 'Ingmar'
AND fp.parttype LIKE 'director'
ORDER BY f.prodyear DESC;

/*
                  title                  | prodyear 
-----------------------------------------+----------
 Saraband                                |     2003
 Bildmakarna                             |     2000
 Larmar och gör sig till                 |     1997
 Sista skriket                           |     1995
 Backanterna                             |     1993
...
*/

-- 20)
/*
Finn produksjonsår for første og siste film Ingmar Bergman regisserte
*/
SELECT MIN(f.prodyear) AS first, MAX(f.prodyear) AS last
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE fp.parttype LIKE 'director'
      AND p.lastname LIKE 'Bergman'
      AND p.firstname LIKE 'Ingmar';

/*
 first | last 
-------+------
  1946 | 2003
(1 row)
*/

-- 21)
/*
Finn tittel og produksjonsår for de filmene hvor mer enn 300 personer har deltatt, 
uansett hvilken funksjon de har hatt (11).
*/
SELECT f.title, f.prodyear, COUNT(*) AS participants
FROM film f NATURAL JOIN filmparticipation fp
GROUP BY f.title, f.prodyear
HAVING COUNT(DISTINCT fp.personid) > 300
ORDER BY participants DESC;

-- Antatt her at vi ikke trenger å filtrere bort VG delen av filmtype.
-- (GTA: San Andreas er jo tross alt et videospill og ikke en film)

/*
              title              | prodyear | participants 
---------------------------------+----------+--------------
 Around the World in Eighty Days |     1956 |         1312
 Stuck on You                    |     2003 |          452
 50 y más                        |     2005 |          382
 Ten Commandments, The           |     1956 |          381
 Malcolm X                       |     1992 |          356
 Grand Theft Auto: San Andreas   |     2004 |          348
 Producers, The                  |     2005 |          336
 40 ans de la 2, Les             |     2004 |          317
 3000 scénarios contre un virus  |     1994 |          314
 Televisión cumple contigo, La   |     2006 |          308
 Live 8                          |     2005 |          308
(11 rows)
*/

-- 22)
/*
Finn oversikt over regissører som har regissert kinofilmer over et stort tidsspenn. 
I tillegg til navn, ta med antall kinofilmer og første og siste år (prodyear) 
personen hadde regi. Skriv ut alle som har et tidsintervall på mer enn 49 år mellom 
første og siste film og sorter dem etter lengden på dette tidsintervallet, de lengste først (230).
*/
SELECT p.firstname || ' ' || p.lastname AS name, COUNT(*) AS produced,
        MIN(f.prodyear) AS first, MAX(f.prodyear) AS last,
        MAX(f.prodyear) - MIN(f.prodyear) AS periode
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE fp.parttype LIKE 'director'
GROUP BY p.personid, name
HAVING (MAX(f.prodyear) - MIN(f.prodyear) > 49)
ORDER BY periode DESC;
-- Trenger å gruppere på personid i tillegg siden to regissører kan ha samme navn.

/*
             name             | produced | first | last | periode 
------------------------------+----------+-------+------+---------
 Wladyslaw Starewicz          |       35 |  1910 | 2003 |      93
 Raoul Walsh                  |      139 |  1912 | 2003 |      91
 Yakov Poselsky               |        4 |  1917 | 1996 |      79
 Oskar Fischinger             |       38 |  1926 | 2004 |      78
 Joris Ivens                  |       45 |  1911 | 1989 |      78
 Manoel de Oliveira           |       45 |  1931 | 2008 |      77
 ...
 (230 rows)
*/

-- 23) 
/*
Finn filmid, tittel og antall medregissører (parttype ’director’) (0 der han har regissert alene) 
for filmer som Ingmar Bergman har regissert (62).
*/
WITH ingmarbergmanmovies AS (
  SELECT fp.filmid
  FROM filmparticipation fp INNER JOIN person p ON fp.personid = p.personid
  WHERE fp.parttype = 'director'
  AND p.firstname = 'Ingmar'
  AND p.lastname = 'Bergman'
),
ant_regissorer AS (
  SELECT fp.filmid, COUNT(*) ant
  FROM filmparticipation fp
  WHERE fp.filmid IN (SELECT * FROM ingmarbergmanmovies)
  AND fp.parttype = 'director'
  GROUP BY fp.filmid
)
SELECT f.filmid, f.title, (ar.ant - 1) AS ant_medregissorer
FROM film f INNER JOIN ant_regissorer ar ON f.filmid = ar.filmid;

/*
 filmid |                  title                  | ant_medregissorer 
--------+-----------------------------------------+-------------------
  10242 | Skepp till India land                   |                 0
  19285 | Stimulantia                             |                 8
  42980 | Hustruskolan                            |                 0
  50738 | Fanny och Alexander                     |                 0
 206075 | Ansikte mot ansikte                     |                 0
 206091 | Ansiktet                                |                 0
 225906 | Drömspel, Ett                           |                 0
 ...
 (62 rows)
*/

-- 24)
/*
Finn filmid, antall involverte personer, produksjonsår og rating for alle filmer 
som Ingmar Bergman har regissert. Ordne kronologisk etter produksjonsår (56).
*/
WITH ingmarbergmanmovies AS (
  SELECT fp.filmid
  FROM filmparticipation fp INNER JOIN person p ON fp.personid = p.personid
  WHERE fp.parttype = 'director'
  AND p.firstname = 'Ingmar'
  AND p.lastname = 'Bergman'
),
crew AS (
  SELECT fp.filmid, COUNT(*) as ant
  FROM filmparticipation fp
  WHERE fp.filmid IN (SELECT * FROM ingmarbergmanmovies)
  GROUP BY filmid
)
SELECT f.filmid, c.ant, f.prodyear, fr.rank AS rating
FROM film f INNER JOIN crew c ON f.filmid = c.filmid
  INNER JOIN filmrating fr ON fr.filmid = f.filmid
WHERE f.filmid IN (SELECT * FROM ingmarbergmanmovies)
ORDER BY f.prodyear;

/*
 filmid | ant | prodyear | rating 
--------+-----+----------+--------
 526715 |  38 |     1946 |    7.3
 736149 |  26 |     1946 |    6.5
  10242 |  31 |     1947 |    6.8
 569009 |  45 |     1948 |    6.6
 736261 |  31 |     1948 |      6
 736677 |  34 |     1949 |    6.5
...
(56 rows)
*/

-- 25)
/*
Finn produksjonsår og tittel for alle filmer som både Angelina Jolie og Antonio Banderas har deltatt i sammen (3).
*/
-- Kan også løses f.eks. med join og subspørring
SELECT f.title, f.prodyear
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE p.firstname = 'Angelina' AND p.lastname = 'Jolie'
  AND fp.filmid IN (
      SELECT fp2.filmid
      FROM filmparticipation fp2 NATURAL JOIN person p
      WHERE p.firstname = 'Antonio' AND p.lastname = 'Banderas'
  );

/*
                title                 | prodyear 
--------------------------------------+----------
 Original Sin                         |     2001
 55th Annual Golden Globe Awards, The |     1998
 72nd Annual Academy Awards, The      |     2000
(3 rows)
*/


-- 26) 
/*
Finn tittel, navn og roller for personer som har hatt mer enn én rolle i samme film blant kinofilmer 
som ble produsert i 2003. (Med forskjellige roller mener vi cast, director, producer osv.
Vi skal altså ikke ha med de som har to ulike cast-roller)
*/
SELECT DISTINCT f.title, concat(p.firstname, ' ', p.lastname) AS name, fp.parttype
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
INNER JOIN (
    SELECT fp.personid, fp.filmid
    FROM filmparticipation fp NATURAL JOIN film NATURAL JOIN filmitem
    WHERE film.prodyear = 2003 AND filmitem.filmtype = 'C'
    GROUP BY fp.personid, fp.filmid
    HAVING count(distinct parttype) > 1
) q ON q.filmid = fp.filmid AND q.personid = fp.personid
ORDER BY name ASC;

-- eller
SELECT DISTINCT f.title, p.firstname || ' ' || p.lastname as name, fp.parttype
FROM film f NATURAL JOIN filmitem fi NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE f.prodyear = 2003
AND fi.filmtype = 'C'
GROUP BY f.title, p.firstname, p.lastname, fp.parttype, fp.personid, f.filmid
HAVING (
    SELECT count(distinct fp1.parttype)
    FROM filmparticipation fp1
    WHERE fp1.personid = fp.personid AND f.filmid = fp1.filmid) > 1
ORDER BY f.title, name, fp.parttype;


-- 27)
/*
Finn navn og antall filmer for personer som har deltatt i mer enn 15 filmer i 2008, 2009 
eller 2010, men som ikke har deltatt i noen filmer i 2005 (2).
*/
--Løsning med NOT IN
SELECT p.firstname || ' ' || p.lastname AS name, count(distinct filmid) AS antall
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE f.prodyear IN (2008,2009,2010) AND fp.personid not IN (
    SELECT personid
    FROM filmparticipation fp NATURAL JOIN film f
    WHERE f.prodyear = 2005
)
GROUP BY fp.personid, name
HAVING count(distinct filmid) > 15;

/*
 firstname | lastname | count 
-----------+----------+-------
 Mary      | Parent   |    25
 Scott     | Stuber   |    26
(2 rows)
*/


-- 28) 
/*
Finn navn på regissør og filmtittel for filmer hvor mer enn 200 personer har deltatt, 
uansett hvilken funksjon de har hatt. Ta ikke med filmer som har hatt flere (mer enn én) regissører (33).
*/
SELECT p.firstname, p.lastname, f.title
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE fp.parttype = 'director' AND
f.filmid IN(SELECT f.filmid
            FROM film f NATURAL JOIN filmparticipation fp
            GROUP BY f.filmid
            HAVING count(distinct fp.personid) > 200) AND
f.filmid not IN(SELECT f.filmid
                FROM film f NATURAL JOIN filmparticipation fp
                WHERE fp.parttype='director'
                GROUP BY f.filmid
                HAVING count(fp.parttype) > 1);

--eller
SELECT p.firstname || ' ' || p.lastname as name, f.title
FROM film f NATURAL JOIN filmparticipation fp NATURAL JOIN person p
INNER JOIN (
    SELECT filmid
    FROM filmparticipation
    WHERE parttype = 'director'
    AND filmid IN (
        SELECT filmid
        FROM filmparticipation fp
        GROUP BY filmid
        HAVING count(*) > 200
    )
    GROUP BY filmid
    HAVING count(*) = 1
) q ON q.filmid = fp.filmid
WHERE parttype = 'director';

/*
 firstname |     lastname      |                           title                            
-----------+-------------------+------------------------------------------------------------
 Milos     | Forman            | Man on the Moon
 Alejandro | González Iñárritu | Babel
 James D.  | Mortellaro        | EverQuest II
 Gérard    | Courant           | Cinématon
 Christine | Edzard            | Little Dorrit
 Fernando  | Méndez Leite      | XX premios Goya
 Jérôme    | Revon             | 40 ans de la 2, Les
 Aleksandr | Sokurov           | Russkiy kovcheg
 Oliver    | Stone             | Any Given Sunday
 Oliver    | Stone             | JFK
 John      | Landis            | Kentucky Fried Movie, The
 Roger     | Nygard            | Trekkies
 Gavin     | Taylor            | Hey, Mr. Producer! The Musical World of Cameron Mackintosh
 Michael   | Curtiz            | Mission to Moscow
 Cecil B.  | DeMille           | Buccaneer, The
 Cecil B.  | DeMille           | Ten Commandments, The
 Cecil B.  | DeMille           | Union Pacific
 Louis J.  | Horvitz           | 75th Annual Academy Awards, The
 Clark     | Jones             | Night of 100 Stars
 Julie     | Taymor            | Across the Universe
 Lisardo   | García            | 50 y más
 Doug      | Sakmann           | Punk Rock Holocaust
 Charles   | Band              | Petrified
 Susan     | Dynner            | Punk's Not Dead
 Victor    | Fleming           | Joan of Arc
 Susan     | Stroman           | Producers, The
 Orson     | Welles            | Citizen Kane
 Jared     | Hess              | Napoleon Dynamite
 Spike     | Lee               | Malcolm X
 Cecil B.  | DeMille           | Unconquered
 Gloria    | Galiano           | Televisión cumple contigo, La
 Tetsuya   | Nomura            | Kingdom Hearts II
 Tim       | VandeSteeg        | Fall Into Me
(33 rows)
*/

-- 29) 
/*
Finn navn i leksikografisk orden på regissører som har regissert alene kinofilmer med 
mer enn 150 deltakere og som har en regissørkarriere (jf. spørsmål 19) på mer enn 49 år (7).
*/
SELECT p.lastname || ', ' || p.firstname AS name
FROM person p
WHERE p.personid IN (
    SELECT fp.personid
    FROM filmparticipation fp
    WHERE parttype = 'director'
    AND fp.filmid IN (
        SELECT filmid
        FROM filmparticipation NATURAL JOIN film f
        WHERE parttype = 'director'
        AND filmid IN (
            SELECT filmid
            FROM filmparticipation fp
            GROUP BY filmid
            HAVING count(*) > 150
        )
        GROUP BY filmid
        HAVING count(*) = 1
    )
) AND p.personid IN (
    SELECT fp.personid
    FROM filmparticipation fp NATURAL JOIN film f NATURAL JOIN filmitem i
    WHERE fp.parttype = 'director'
        AND i.filmtype = 'C'
    GROUP BY fp.personid
    HAVING max(f.prodyear)-min(f.prodyear) > 49
)
ORDER BY name ASC;

-- eller
SELECT DISTINCT p.firstname, p.lastname
FROM film f0 NATURAL JOIN filmparticipation fp NATURAL JOIN person p
WHERE fp.parttype = 'director' AND
exists (SELECT f.filmid
        FROM film f NATURAL JOIN filmitem fi NATURAL JOIN filmparticipation fp1
        WHERE fp1.parttype = 'director' AND fi.filmtype='C' AND fp1.personid = fp.personid AND f.filmid
        IN (SELECT f2.filmid
            FROM film f2 NATURAL JOIN filmitem fi2 NATURAL JOIN filmparticipation fp3
            WHERE fp3.parttype='director' AND fi2.filmtype='C' AND f2.filmid
            IN (SELECT f3.filmid
                FROM film f3 NATURAL JOIN filmitem fi3 NATURAL JOIN filmparticipation fp4
                WHERE fi3.filmtype ='C'
                GROUP BY f3.filmid
                HAVING count(distinct fp4.personid) > 150)
        GROUP BY f2.filmid
        HAVING count(fp3.parttype) = 1))
GROUP BY p.firstname, p.lastname
HAVING (max(f0.prodyear) - min(f0.prodyear) > 49)
ORDER BY p.firstname, p.lastname DESC

/*
       name        
-------------------
 Cukor, George
 Fellini, Federico
 Ford, John
 Lumet, Sidney
 Scorsese, Martin
 Spielberg, Steven
 Welles, Orson
(7 rows)
*/



