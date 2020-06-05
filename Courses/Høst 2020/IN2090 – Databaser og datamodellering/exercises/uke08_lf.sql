-- Oppgave 1

SELECT p.personid, p.firstname, p.lastname, count(fp.personid) AS count
FROM person AS p
     LEFT OUTER JOIN filmparticipation AS fp
     USING (personid)
WHERE p.lastname = 'Abbott'
GROUP BY p.personid, p.firstname, p.lastname;

--  personid |     firstname     | lastname | count 
-- ----------+-------------------+----------+-------
--      2488 | Chris             | Abbott   |    17
--      4617 | Frank             | Abbott   |     3
--      6514 | Paris             | Abbott   |     4
--       966 | Lee               | Abbott   |    17
--      5922 | Esther            | Abbott   |     1
--      2471 | Michael W.        | Abbott   |     4
--     14401 | Rob               | Abbott   |     1
--      5970 | Georganne         | Abbott   |     1
--     14481 | Shawn             | Abbott   |     6
--      2375 | Leigh             | Abbott   |    13
--     13329 | David             | Abbott   |     3
--     13489 | Frankie           | Abbott   |     6
--     13153 | Billy             | Abbott   |     1
--      6642 | Susan             | Abbott   |     5
--      5129 | Odin              | Abbott   |     0
--      2616 | Jess              | Abbott   |     1
--      ...
--      2536 | Eleanor Halliwell | Abbott   |     3
--      6370 | Mishael           | Abbott   |     0
--      5682 | Carly             | Abbott   |     2
--      6498 | Pamela            | Abbott   |    11
-- (243 rows)

-- Oppgave 2

-- a)

SELECT f.title
FROM film AS f
     INNER JOIN filmgenre AS g USING (filmid)
WHERE f.filmid NOT IN (SELECT filmid FROM filmrating) AND
      g.genre = 'Western' AND
      f.prodyear > 2007;

-- b)

SELECT f.title
FROM film AS f
     INNER JOIN filmgenre AS g USING (filmid)
     LEFT OUTER JOIN filmrating AS r USING (filmid)
WHERE r.filmid IS NULL AND
      g.genre = 'Western' AND
      f.prodyear > 2007;

-- c)

SELECT title
FROM film
WHERE prodyear > 2007 AND
      filmid IN (
        (SELECT filmid
         FROM filmgenre
         WHERE genre = 'Western')
        EXCEPT
        (SELECT filmid
         FROM filmrating));

-- d)

SELECT f.title
FROM film AS f
     INNER JOIN filmgenre AS fg
     USING (filmid)
WHERE f.prodyear > 2007 AND
      fg.genre = 'Western' AND
      NOT EXISTS (
        SELECT *
        FROM filmrating AS r
        WHERE r.filmid = f.filmid);

--                title               
-- -----------------------------------
--  Hard Ride, The
--  Vultures
--  Wild Michigan
--  Manhunt
--  Saxon
--  Blood Meridian
--  Boone's Lick
--  Busted Down on Bourbon Street
--  Brigands of Rattleborge, The
--  Dead West
--  Westworld
--  Good, the Bad, and the Weird, The
--  Moses Taite's War
--  Last Horseman, The
-- (14 rows)

-- Oppgave 3

SELECT count(DISTINCT filmid) AS nr_movies
FROM film
WHERE filmid IN (
    (SELECT filmid
     FROM filmgenre
     WHERE genre = 'Comedy')
    UNION
    (SELECT fp.filmid
     FROM person AS p
          INNER JOIN filmparticipation AS fp
          USING (personid)
     WHERE p.firstname = 'Jim' AND p.lastname = 'Carrey'));

-- eller

SELECT count(*) AS nr_movies
FROM (SELECT DISTINCT filmid
      FROM film
      WHERE filmid IN (
          (SELECT filmid
           FROM filmgenre
           WHERE genre = 'Comedy')
          UNION
          (SELECT fp.filmid
           FROM person AS p
                INNER JOIN filmparticipation AS fp
                USING (personid)
           WHERE p.firstname = 'Jim' AND p.lastname = 'Carrey'))) AS t;

--  nr_movies 
-- -------
--  81098
-- (1 row)

-- Oppgave 4

SELECT title
FROM film
WHERE filmid IN (
    (SELECT fp.filmid
     FROM person AS p
          INNER JOIN filmparticipation AS fp
          USING (personid)
     WHERE p.firstname = 'Jim' AND p.lastname = 'Carrey')
            EXCEPT
    (SELECT filmid
     FROM filmgenre
     WHERE genre = 'Comedy'));

-- eller

SELECT f.title
FROM film AS f
     INNER JOIN filmparticipation AS fp USING (filmid)
     INNER JOIN person AS p USING (personid)
WHERE p.firstname = 'Jim' AND
      p.lastname = 'Carrey' AND
      f.filmid NOT IN
        (SELECT filmid
         FROM filmgenre
         WHERE genre = 'Comedy');
--                                                     title                                                     
-- --------------------------------------------------------------------------------------------------------------
--  Eternal Sunshine of the Spotless Mind
--  Ripley's Believe It or Not!
--  Horton Hears a Who
--  AFI's 100 Years... 100 Stars
--  Itsy Bitsy Spider, The
--  50 Greatest Comedy Films, The
--  Mo' Funny: Black Comedy in America
--  Inside the Mind of Michel Gondry
--  In My Life
--  Andy Kaufman's Really Big Show
--  Forbes Celebrity 100: Who Made Bank?
--  ¿De qué te ríes?
--  Majestic, The
--  68th Annual Academy Awards, The
--  When Stand-Up Comics Ruled the World
--  Teen Choice Awards 2003, The
--  71st Annual Academy Awards, The
--  Junket Whore
--  Playboy: Inside the Playboy Mansion
--  1999 MTV Movie Awards
--  Return to Edge City
--  76th Annual Academy Awards, The
--  Lemony Snicket's A Series of Unfortunate Events
--  Terrible Tragedy: Alarming Evidence from the Making of the Film - A Woeful World, A
--  Concert for New York City, The
--  Masters of Illusion: The Wizards of Special Effects
--  Celebrity Debut
--  Number 23, The
--  30th Annual People's Choice Awards, The
--  Tribute to Sam Kinison, A
--  Truman Show, The
--  Nickelodeon Kids' Choice Awards '04
--  Riddle Me This: Why Is Batman Forever?
--  Playboy: Playmate Pajama Party
--  Look Inside 'Eternal Sunshine of the Spotless Mind', A
--  Award Show Awards Show, The
--  Doing Time on Maple Drive
--  Batman Forever
--  American Film Institute Salute to Clint Eastwood, The
--  AFI's 100 Years, 100 Laughs: America's Funniest Movies
--  Nickelodeon Kids' Choice Awards '03
--  How's It Going to End? The Making of 'The Truman Show'
--  AFI Tribute to Meryl Streep
--  Mike Hammer: Murder Takes All
--  American Film Institute Salute to Steven Spielberg, The
--  62nd Annual Golden Globe Awards, The
--  Moving Image Salutes Ron Howard
--  Still Dumb After All These Years
--  Christmas from Hollywood
--  Jim Carrey Spotlight
--  Hollywood Salutes Nicolas Cage: An American Cinematheque Tribute
--  MTV Video Music Awards 2000
--  America: A Tribute to Heroes
--  Jim Carrey Uncensored
--  69th Annual Academy Awards, The
--  1995 MTV Movie Awards
--  2000 Blockbuster Entertainment Awards
--  Terrible Tragedy: Alarming Evidence from the Making of the Film - Costumes and Other Suspicious Disguises, A
--  Cartoon Logic
--  Introducing Cameron Diaz
--  Dead Pool, The
--  Shadows of the Bat: The Cinematic Saga of the Dark Knight - Reinventing a Hero
-- (62 rows)

-- Oppgave 5

(SELECT company_name
 FROM customers
 WHERE country = 'Sweden' OR
       country = 'Norway')
UNION
(SELECT company_name
 FROM suppliers
 WHERE country = 'Norway' OR
       country = 'Sweden');

--     company_name    
-- --------------------
--  Norske Meierier
--  Berglunds snabbköp
--  Svensk Sjöföda AB
--  Santé Gourmet
--  Folk och fä HB
--  PB Knäckebröd AB
-- (6 rows)

-- Oppgave 6

SELECT c.company_name
FROM customers AS c
WHERE EXISTS (
    SELECT * 
    FROM orders AS o 
         INNER JOIN order_details AS d USING (order_id)
         INNER JOIN products AS p USING (product_id)
    WHERE o.customer_id = c.customer_id AND
          p.product_name = 'Pavlova');
-- 
--           company_name          
-- --------------------------------
--  Berglunds snabbköp
--  Bon app'
--  Ernst Handel
--  Frankenversand
--  France restauration
--  Furia Bacalhau e Frutos do Mar
--  Hungry Owl All-Night Grocers
--  Königlich Essen
--  La maison d'Asie
--  Lehmanns Marktstand
--  LILA-Supermercado
--  LINO-Delicateses
--  Mère Paillarde
--  Morgenstern Gesundkost
--  Old World Delicatessen
--  Ottilies Käseladen
--  Piccolo und mehr
--  QUICK-Stop
--  Rancho grande
--  Rattlesnake Canyon Grocery
--  Ricardo Adocicados
--  Richter Supermarkt
--  Santé Gourmet
--  Save-a-lot Markets
--  Seven Seas Imports
--  Simons bistro
--  Spécialités du monde
--  The Big Cheese
--  Wartian Herkku
--  White Clover Markets
--  Wilman Kala
-- (31 rows)

-- Oppgave 7

SELECT s.company_name, count(c.customer_id) AS num_customers
FROM suppliers AS s
     LEFT OUTER JOIN customers AS c
       USING (country)
GROUP BY s.supplier_id
ORDER BY num_customers DESC;

--               company_name              | num_customers 
-- ----------------------------------------+---------------
--  New England Seafood Cannery            |            13
--  Bigfoot Breweries                      |            13
--  New Orleans Cajun Delights             |            13
--  Grandma Kelly's Homestead              |            13
--  Heli Süßwaren GmbH & Co. KG            |            11
--  Plutzer Lebensmittelgroßmärkte AG      |            11
--  Gai pâturage                           |            11
--  Nord-Ost-Fisch Handelsgesellschaft mbH |            11
--  Aux joyeux ecclésiastiques             |            11
--  Escargots Nouveaux                     |            11
--  Refrescos Americanas LTDA              |             9
--  Exotic Liquids                         |             7
--  Specialty Biscuits, Ltd.               |             7
--  Cooperativa de Quesos 'Las Cabras'     |             5
--  Formaggi Fortini s.r.l.                |             3
--  Ma Maison                              |             3
--  Pasta Buttini s.r.l.                   |             3
--  Forêts d'érables                       |             3
--  PB Knäckebröd AB                       |             2
--  Lyngbysild                             |             2
--  Svensk Sjöföda AB                      |             2
--  Karkki Oy                              |             2
--  Norske Meierier                        |             1
--  Pavlova, Ltd.                          |             0
--  Leka Trading                           |             0
--  Zaanse Snoepfabriek                    |             0
--  Tokyo Traders                          |             0
--  G'day, Mate                            |             0
--  Mayumi's                               |             0
-- (29 rows)

-- Oppgave 6.1.5 
/*
a)	a < 50 OR a >= 50 
Alle tupler hvor a ikke er null.

b)	a = 0 OR b = 10 
Alle tupler hvor a=o og b enten er null eller har en verdi
OG
Alle tupler hvor b=10 og a enten er null eller har en verdi.

c)	a = 20 AND b = 10 
Hvis a og b er de eneste attributtene er (a,b)=(20,10) eneste
mulige kandidat.

d)	a = b
Hvis en av a eller b har verdien null, er resultatet av beregningen
a=b lik "unknown". Denne verdien er ikke lik 'true'. 
Eneste tupler som tilfredstiller denne er derfor de hvor
a og b er ikke-null og har samme verdi.

e)	a > b 
Tilsvarende. For at verdien skal kunne bli sann ('true'), må både
a og b være ulik null. Dessuten må verdien i a være større enn
den i b.
*/ 
