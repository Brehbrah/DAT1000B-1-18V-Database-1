--
-- 1-a 
-- Skriv en SQL-spørring som viser turer som starter i juli og koster under 8000 kr. Utskriften 
-- skal sorteres stigende etter pris. Hvis flere turer har samme pris skal disse sorteres etter 
-- startdato. 
--

SELECT *
FROM tur 
WHERE MONTH(STARTDATO) = 7 AND pris < 8000 
ORDER BY STARTDATO

--
-- 1-b 
-- Skriv en SQL-spørring som viser medlemsnummer og navn for alle medlemmer som er 
-- påmeldt en tur som starter fra hytte nummer 2. 
--

SELECT medlem.*, påmelding.MNr, tur.
FROM medlem, tur, påmelding
WHERE medlem.MNr = hytte.HNr 
AND tur.TNr = påmelding.TNr
AND tur.starthytte = 2;

--
-- 1-c 
-- Skriv en SQL-spørring som viser antall påmeldte til hver enkelt tur. Utskriften skal vise 
-- turnummer, beskrivelsen av turen, startdato for turen og antall påmeldte. 
--

SELECT tur.TNr, tur.omtale, tur.StartDato, COUNT(*) AS 'Antall påmeldte'
FROM tur, påmelding
WHERE tur.TNr = påmelding.TNr 
GROUP BY tur.TNr, tur.omtale, tur.startsdato

--
-- 1-d 
-- Skriv SQL-kode som oppretter tabellen Hytte. Sørg for at navnet på hytta må fylles ut. 
-- Kolonnen HytteType skal kun inneholde verdiene Betjent, Selvbetjent og Ubetjent. 
-- Forklar teknikker som kan brukes for å sikre dette. 
--

CREATE TABLE IF NOT EXISTS Hytte (
	HNr INTEGER AUTO_INCREMENT,
	Namn VARCHAR (45) NOT NULL,
	AntSenger INTEGER,
	HytteType VARCHAR (45),
	PRIMARY KEY (HNr),
) ENGINE = InnoDB DEFAULT CHARSET=utf8;

-- For å sikre innhold i HytteType: 
-- a) Lage hjelpetabell for hyttetype med fremmednøkkel. 
-- b) Legge på CHECK-regel 
-- c) Lage trigger 
-- d) (Bruke enum, ikke forventet) 

--
-- 1-e 
-- Skriv SQL-kode for å registrere et nytt medlem og melde vedkommende på tur nummer 3. 
--

INSERT INTO medlem (Fornamn,etternamn, tlf)
VALUES 
('Are', 'Behn', '22334455')

INSERT INTO påmelding (TNr, Mnr)
VALUES 
(3,LAST_INSERT_ID())

--
-- 1-f 
-- Skriv en SQL-spørring som viser navn på medlemmer som ikke er påmeldt noen turer. 
--

SELECT medlem.*, påmelding.*
FROM medlem, påmelding
WHERE medlem.Mnr = påmelding.MNr NOT IN(SELECT medlem.MNr, påmelding.MNr FROM medlem, påmelding) 

--
-- Oppgave 3-a
-- 

/*

Det er foreslått å utvide tabellen Tur fra oppgave 1 med data om samtlige hytter som en tur er 
innom, slik: 
 
TurUtvidet(TNr, Beskrivelse, Pris, Dato, Hytte) 
 
Følgende er et eksempel på en rad i denne tabellen: 
 
(1, 'Krevende topptur',  7500, '2017-04-28', 1) 
 
Det betyr at tur nummer 1 har beskrivelse Krevende topptur, pris 7500 kr og at denne turen er 
innom hytte nummer 1 den 28. april 2017. Merk: Hvis denne turen er innom tre hytter, så vil 
turnummer (TNr) 1 forekomme på tre rader i tabellen TurUtvidet. 
 
Forklar kort hva som er uheldig med tabellen TurUtvidet. Skriv deretter ned funksjonelle 
avhengigheter, bestem kandidatnøkkel og utfør normalisering til BCNF. Vis primærnøkler 
med understreking og merk fremmednøkler med en stjerne i sluttresultatet. Gjør dine egne 
forutsetninger hvis oppgaveteksten er uklar. 

*/ 

/*

Funksjonelle Avhengigheter

Kandidat Nøkkel

Normalisering

*/
