-- 
-- Oppgave A - Lage tabeller med phpMyAdmin: Sykkelmodeller og sykler
-- 

-- Tabell for Modell

CREATE TABLE IF NOT EXISTS Modell (
	MNr int (12) NOT NULL AUTO_INCREMENT, 
	Fabrikk char (50) DEFAULT NULL, 
	Betegnelse char(50) DEFAULT NULL, 
	Kategori char(50) DEFAULT NULL, 
	Dagpris decimal(10,2),
	PRIMARY KEY(MNr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabell for Sykkel

CREATE TABLE IF NOT EXISTS Sykkel (
	MNr int (12) NOT NULL AUTO_INCREMENT, 
	KopiNr int (10) DEFAULT NULL, 
	Ramme int (10) DEFAULT NULL, 
	Farge char(50) DEFAULT NULL,
	PRIMARY KEY (MNR, KopiNr),
	FOREIGN KEY (MNr) REFERENCES Modell (MNr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Oppgave C - Lage tabeller med SQL: Kunder og utleieforhold
-- 

CREATE TABLE IF NOT EXISTS Kunde (
	KNr int (10) NOT NULL AUTO_INCREMENT, 
	Fornavn CHAR(50) NOT NULL, 
	Etternavn CHAR(50) NOT NULL, 
	Mobil int (11) NOT NULL,
	PRIMARY KEY (KNr) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Utleie (
	KNr int (10) NOT NULL AUTO_INCREMENT, 
	MNr int (10) NOT NULL, 
	KopiNr int (10) NOT NULL, 
	TidUt DATE NOT NULL DEFAULT '0000-00-00', 
	TidInn DATE NOT NULL DEFAULT '0000-00-00',
	PRIMARY KEY (KNr, MNr, KopiNr),
	FOREIGN KEY (KNr) REFERENCES Kunde (KNr),
	FOREIGN KEY (MNr, KopiNr) REFERENCES sykkel (MNr, KopiNr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Oppgave D - Importere data
--

-- KNr;Fornavn;Etternavn;Mobil
INSERT INTO `Kunde` VALUES
(1, 'Varg', 'Virrum', '99887766'),
(2, 'Trude', 'Stein', '44556677'),
(4, 'Katinka', 'Fosheim', '45671234'),
(5, 'Robert', 'Romman', '98765432'),
(6, 'Jon', 'Vein', '1726354');


Insert Into `Modell` VALUES
(1, 'Avanto', 'Birken Classic', 'Terreng', '75.00'),
(2, 'Trailo', 'Askeladden', 'Hybrid', '55.00'),
(3, 'Perimeter', 'Downtown', 'Bysykkel', '120.00'),
(4, 'Avante', 'Dovregubben', 'Bysykkel', '105,00'),
(5, 'Avante', 'Atlantis', 'Landevei', '90.00'),
(6, 'Perimeter', 'Medita', 'Terreng', '95.00'),
(7, 'Avante', 'Aeroflyt', 'Landevei', '115.00'),
(8, 'Trailo', 'MultiX', 'Hybrid', '150.00'),
(9, 'Trailo', 'Trailfinder', 'Terreng', '140.00'),
(10, 'Perimeter', 'Vasaknekk', 'Terreng', '50.00'),
(11, 'Avante', 'Olebrum', 'Hybrid', '125.00'),
(12, 'Trailo', 'Alfavei', 'Terreng', '80.00');

-- MNr;Kopinr;Ramme;Farge
INSERT INTO `Sykkel` VALUES
(1, 1, 25, 'grå'),
(1,2, 28, 'rød'),
(2, 1, 25, 'blå'),
(2,2,27, 'svart'),
(2, 3, 27, 'grå'),
(3, 1, 28, 'rød'),
(3, 2, 28, 'blå'),
(4, 1, 25, 'svart'),
(5, 1, 25, 'blå'),
(5, 2, 28, 'rød'),
(5, 3, 28, 'grå'),
(5, 4, 28, 'svart'),
(6, 1, 28, 'blå'),
(7, 1, 25, 'rød'),
(7, 2, 25, 'grå'),
(7, 3, 27, 'blå'),
(8, 1, 27, 'rød'),
(8, 2, 27, 'blå'),
(8, 3, 27, 'grå'),
(9, 1, 28, 'rød'),
(9, 2, 28, 'rød'),
(10, 1, 28, 'rød'),
(10, 2, 25, 'svart'),
(10, 3, 25, 'blå'),
(11, 1, 27, 'grå'),
(12, 1, 27, 'rød'),
(12, 2, 25, 'svart'),
(12, 3, 28, 'blå');

-- KNr;MNr;KopiNr;TidUt;TidInn
INSERT INTO `Utleie` VALUES
(1, 2, 1, '2014-08-13 18:30', '2014-08-14 16:05'),
(1, 1, 1, '2014-08-13 18:52', '2014-08-15 12:33'),
(2, 1, 2, '2014-08-13 21:30', '2014-08-14 19:55'),
(4, 3, 1, '2014-08-13 22:13', NULL),
(4, 12, 1, '2014-08-14 11:07',NULL),
(5, 1, 1, '2014-08-14 14:21', NULL),
(5, 12, 2, '2014-08-14 16:30', '2014-08-14 23:02'),
(6, 8, 1, '2014-08-14 20:46', NULL);

-- 
-- Oppgave E - Forretningsregler med NOT NULL og UNIQUE
-- 

CREATE TABLE IF NOT EXISTS Kunde (
	KNr int (10) NOT NULL AUTO_INCREMENT, 
	Fornavn CHAR(50) NOT NULL, 
	Etternavn CHAR(50) NOT NULL, 
	Mobil int (11) NOT NULL UNIQUE,
	PRIMARY KEY (KNr) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Utleie (
	KNr int (10) NOT NULL AUTO_INCREMENT, 
	MNr int (10) NOT NULL, 
	KopiNr int (10) NOT NULL, 
	TidUt DATE NOT NULL DEFAULT '0000-00-00', 
	TidInn DATE NOT NULL DEFAULT '0000-00-00',
	PRIMARY KEY (KNr, MNr, KopiNr),
	FOREIGN KEY (KNr) REFERENCES Kunde (KNr),
	FOREIGN KEY (MNr, KopiNr) REFERENCES sykkel (MNr, KopiNr)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Oppgave F - Forretningsregler og fremmednøkler
-- 

/* Du skal nå lage hjelpetabeller for å ta vare på lovlige farger og kategorier, 
 * og deretter bruke fremmednøkler for å sikre at kun lovlige verdier blir registrert.
 * 
 * Lag tabeller Farge og Kategori. 
 * Begge tabeller skal kun inneholde en eneste kolonne med samme navn som tabellen. 
 * Sørg for at kolonnene Sykkel.Farge og Modell.
 * Kategori blir fremmednøkler mot disse hjelpetabellene.
*/
CREATE TABLE IF NOT EXISTS Farge (
	Farge CHAR(50),
	CONSTRAINT FargePK PRIMARY KEY (Farge)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Kategori (
	Kategori char (50),
	Modell char (50),
	CONSTRAINT KategoriPK PRIMARY KEY(Kategori)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

/* 
 * Fyll tabellene med data fra tilhørende kolonner Sykkel.Farge og Modell.Kategori. 
 * Det kan f.eks. gjøres ved å taste inn for hånd i phpMyAdmin, eller 
 * lagre verdiene på en tekstfil og importere. (Det finnes flere teknikker.)
*/

INSERT INTO farge (farge, modell) VALUES 
('RosaBlå', 'Heftig');

-- Endre i tabellen Farge slik at det blir mulig å registrere grønne sykler.

UPDATE farge 
SET Farge = 'blåååååå';