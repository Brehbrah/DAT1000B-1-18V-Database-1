-- 
-- Oppgave 1. Opprette Utopia Tabell
--

--
-- Sletter tabellen først
--

DROP TABLE IF EXISTS gave;
DROP TABLE IF EXISTS del;
DROP TABLE IF EXISTS oppbygging;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS onske;

--
-- Deretter oppretter ny tabeller
--

CREATE TABLE IF NOT EXISTS gave (
	gnr int (10) NOT NULL AUTO_INCREMENT, 
	navn CHAR(25) NOT NULL, 
	prod_tid int (50),
	PRIMARY KEY (gnr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS del (
	dnr int (10) NOT NULL AUTO_INCREMENT, 
	navn CHAR (25) NOT NULL, 
	lager_ant int (50),
	PRIMARY KEY (dnr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS oppbygging (
	gnr int (10) NOT NULL AUTO_INCREMENT, 
	dnr int (10) NOT NULL, 
	ant int (10) NOT NULL, 
	PRIMARY KEY (gnr, dnr),
	FOREIGN KEY (dnr) REFERENCES del (dnr),
	FOREIGN KEY (gnr) REFERENCES gave(gnr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS person (
	pnr int (20) NOT NULL AUTO_INCREMENT, 
	fornavn CHAR (25) NOT NULL, 
	etternavn CHAR (25) NOT NULL,
	fdato DATE,
	PRIMARY KEY (pnr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS onske (
	onr int (10) NOT NULL AUTO_INCREMENT,
	pnr int (10) NOT NULL,
	gnr int (10) NOT NULL,
	prioritet int (10) NOT NULL,
	ferdig int (10) NOT NULL,
	PRIMARY KEY (onr),
	FOREIGN KEY (pnr) REFERENCES person (pnr),
	FOREIGN KEY (gnr) REFERENCES oppbygging (gnr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 
-- Oppgave 2
-- Forklar kort rekkefølgen og hvilke valg man må gjøre i phpMyAdmin.
-- 

1. Sjekke ut rekkefølgen av tabellen da vi lagde på Oppgave 1 og det skal vi importeres 
   riktig rekkefølge
2. Gå inn i tabellen f.eks. Gave tabellen først
3. Trykke på "import" knappen
4. Trykk på "choose Files" og finn gave.csv filen.
5. Uncheck "Enable foreign key checks"
6. bla ned til du finner "format" og velg csv
7. Trykk på Checkbox "Update data when duplicate keys found on import (add ON DUPLICATE KEY UPDATE)"
8. På "Columns separated with:", så byttes det ut med Semikolon istedenfor en komma.
9. Trykk på Go for å importere .csv filen gaven
10. Forsett instruksene fra punkt 1 til 8 igjen og gjør dette riktig i 
   kronologisk til alt er blitt importert

--
-- Oppgave 3
-- Lag en spørring som viser alle personer født mellom år 2000 og 2010 med et 
-- etternavn som begynner på "H". Listen skal være sortert på navn.
-- 

SELECT *
FROM person 
WHERE YEAR(fdato) BETWEEN 2000 AND 2010 AND etternavn LIKE '%H%'
ORDER BY fornavn, etternavn

--
-- Oppgave 4
-- Lag en spørring som viser alle modellfly.
-- 

SELECT navn
FROM gave
WHERE navn LIKE 'modell%'

--
-- Oppgave 5
-- Lag en spørring som viser alle gaveønskene til person 23 (Ninni Bårdsen). 
-- Utskriften skal vise navnet på hver gave, sammen med prioritet og 
-- produksjonstid (prod_tid) for denne gaven. Vis gavene etter stigende prioritet.
-- 

SELECT g.*, o.*, p.pnr, p.fornavn, p.etternavn  
FROM person as p, gave as g, onske AS o
WHERE o.gnr = g.gnr AND o.pnr = p.pnr AND o.pnr = 23
ORDER BY g.navn 

--
-- Oppgave 6
-- Lag en spørring som viser hvilke deler som inngår i produksjonen av gave nr. 4, 
-- og hvor mange enheter av hver del. Ta med navn på hver enkelt del i utskriften.
-- 

SELECT d.dnr, d.lager_ant, COUNT(*) AS antallEnheter, o.*, g.navn
FROM gave AS g, del AS d, oppbygging as o
WHERE d.dnr = o.dnr AND g.gnr = 4

--
-- Oppgave 7
-- Lag en spørring som teller opp antall ønsker for personer med flere enn 7 ønsker. 
-- Spørreresultatet skal vise personnr, fornavn og etternavn i én kolonne, samt antall ønsker. 
-- Sorter utskriften etter fødselsår, de yngste først.
-- 

SELECT p.pnr, p.fornavn, p.etternavn, YEAR(fdato) AS 'f.Dato', COUNT(*) AS 'Antall Ønsker'
FROM person AS p, onske AS o
WHERE p.pnr = o.pnr
GROUP BY p.pnr, fornavn, etternavn, fdato
HAVING COUNT(*) > 7
ORDER BY fdato DESC;

--
-- Oppgave 8 
-- Det er kommet inn en ønskeliste fra en person som ennå ikke er registrert i systemet. 
-- Listen inneholder tre ønsker. Skriv spørringer for å legge til personen og ønskelisten. 
-- Velg eksempeldata selv, men husk at primærnøkkel i ønskelisten er autonummerert. 
-- Tips: Dette må løses med flere spørringer.
-- 

-- Spørring for å legge til en person
INSERT INTO person (fornavn, etternavn, fdato)
VALUES ('Samsung', 'Apple', '2014-02-28')

-- spørring for å legge inn en ønskeliste

INSERT INTO onske (onr, pnr, gnr, prioritet, ferdig)
VALUES (777, 101, 5, 1, 0)

--
-- Oppgave 9
-- Lag en spørring som viser hvor lang tid det vil ta å gjennomføre årets julegaveproduksjon, 
-- for å finne ut om alt vil være klart til jul.
-- Vi antar at det til enhver tid er 8 nisser på jobb. 
-- Kolonnen prod_tid viser hvor mange minutter det tar for 1 nisse å gjøre ferdig 
-- ett eksemplar av denne gaven. Vi forenkler litt og antar at 2 nisser kan 
-- samarbeide perfekt og gjøre jobben på halve tiden, at 3 nisser kan gjøre 
-- jobben på en tredjedel av tiden osv. Vis svaret både i antall minutter 
-- og antall døgn avrundet oppover. 
-- Tips: Funksjonen CEILING runder av oppover.
--

-- Ett døgn = 24 t og du skal få det i minutter, 
-- 60 x 24 1440 min. Så er det 8 alver som jobber 1440 x 8

SELECT CEILING(SUM(gave.prod_tid/11520)) AS Dager, CEILING(SUM(gave.prod_tid/8)) AS MINUTTER
FROM Ønske Inner Join gave ON ønske.gnr = gave.gnr 

-- 
-- Oppgave 10
-- Lag en spørring som viser hvor mange ønskelister hver gave er med på. 
-- Samtlige gaver skal med i spørreresultatet, selv om denne gaven ikke er 
-- med på noen ønskelister (skal da stå med 0). Sorter utskriften på gavenavn.
-- 

SELECT g.gnr, COUNT(*) AS 'Ant.Gaver' , g.navn 
FROM gave AS g LEFT OUTER JOIN onske as o ON g.gnr = o.gnr 
GROUP BY g.gnr
ORDER BY g.navn


