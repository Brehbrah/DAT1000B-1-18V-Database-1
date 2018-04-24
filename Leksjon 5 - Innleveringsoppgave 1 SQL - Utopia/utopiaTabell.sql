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
