-- OPPGAVE 1
CREATE TABLE kunde (
    kundenummer INT PRIMARY KEY,
    kundenavn VARCHAR(50) NOT NULL,
    kundeadresse VARCHAR(50),
    postnr VARCHAR(4),
    poststed VARCHAR(20)
);

CREATE TABLE ansatt (
    ansattnr INT PRIMARY KEY,
    navn VARCHAR(50) NOT NULL,
    fødselsdato DATE,
    ansattDato DATE
);

CREATE TABLE prosjekt (
    prosjektnummer INT PRIMARY KEY,
    prosjektleder INT,
    prosjektnavn VARCHAR(50) NOT NULL,
    kundenummer INT,
    status VARCHAR(8) CHECK (status = 'planlagt' OR status = 'aktiv' OR status = 'ferdig'),

    FOREIGN KEY (kundenummer) REFERENCES kunde (kundenummer),
    FOREIGN KEY (prosjektleder) REFERENCES ansatt (ansattnr)
);

CREATE TABLE ansattDeltarIProsjekt (
    ansattnr INT,
    prosjektnummer INT,

    PRIMARY KEY (ansattnr, prosjektnummer),
    FOREIGN KEY (ansattnr) REFERENCES ansatt (ansattnr),
    FOREIGN KEY (prosjektnummer) REFERENCES prosjekt (prosjektnummer)
);

-- OPPGAVE 2
/*
a) Ansatt: ansattnr
   AnsattDeltarIProsjekt: {ansattnr, prosjektnr} (én primærnøkkel som består av to attributter)
b) Ansatt: ansattnr
   AnsattDeltarIProsjekt: ansattnr og prosjektnr
c) ansattnr (kandidatnøkkel = minimal supernøkkel. Primærnøkler er dermed også kandidatnøkler)
d) Alle kombinasjoner av attributter der kombinasjonen kun gir unike tupler, dvs alle kombinasjoner
   som består av minst én kandidatnøkkel: {ansattnr}, {ansattnr, navn}, {ansattnr, fødselsdato},
   {ansattnr, navn, fødselsdato}, {ansattnr, ansattdato}, {ansattnr, navn, ansattdato},
   {ansattnr, navn, fødselsdato, ansattdato}
e) kundenummer -> kundenavn, kundeadresse, postnr, poststed
   postnr -> poststed
*/

-- OPPGAVE 3
INSERT INTO kunde VALUES
    (123, 'Donald', '1313 Webfoot Walk', null, 'Duckburg, Calisota'),
    (124, 'Batman', 'Wayne Manor', '0123', 'Gotham City'),
    (125, 'Flanders', '740 Evergreen Terrace', '9653', 'Springfield'),
    (126, 'Paddington Bear', '32 Windsor Gardens', null, 'London'),
    (127, 'Spongebob SquarePants', '124 Conch Street', null, 'Bikini Bottom');

INSERT INTO ansatt VALUES
    (321, 'Lois Lane', '1962-01-01', '1962-08-16'),
    (320, 'Sirius Black', '1980-12-08', '2001-11-30'),
    (319, 'Lord Emsworth', '1969-9-26', '1968-11-22'),
    (318, 'Sherlock Holmes', '1965-7-29', '1964-12-4'),
    (317, 'Monica Geller', '1962-10-5', '1963-02-16');

INSERT INTO prosjekt VALUES
    (981, 321, 'Manhattan Project', 124, 'ferdig'),
    (980, 320, 'Development of Windows Vista', 123, 'aktiv');

INSERT INTO ansattDeltarIProsjekt VALUES
    (319, 981),
    (319, 980),
    (317, 980),
    (318, 981);

-- OPPGAVE 4
-- 4a
SELECT k.kundenummer, k.kundenavn, k.kundeadresse
FROM kunde k;

-- 4b
SELECT DISTINCT a.navn
FROM prosjekt p INNER JOIN ansatt a ON p.prosjektleder = a.ansattnr;

-- 4c
SELECT adip.ansattnr
FROM ansattDeltarIProsjekt adip INNER JOIN prosjekt p ON adip.prosjektnummer = p.prosjektnummer
WHERE p.prosjektnavn = 'Manhattan Project'; --'Ruter App';
-- Samme type oppgave, mer eksplosivt prosjekt.

-- 4d
SELECT a.*
FROM kunde k INNER JOIN prosjekt p ON p.kundenummer = k.kundenummer
    INNER JOIN ansattDeltarIProsjekt adip ON p.prosjektnummer = adip.prosjektnummer
    INNER JOIn ansatt a ON adip.ansattnr = a.ansattnr
WHERE k.kundenavn = 'Batman'; -- 'NSB';
-- Samme type oppgave, flere flaggermuser.

-- OPPGAVE 5
-- 5a
UPDATE kunde
SET postnr = '9999'
WHERE kundenummer = 126;
-- 5b
INSERT INTO ansatt VALUES (404, 'You are fired', null, null);
DELETE FROM ansatt WHERE ansattnr = 404;
