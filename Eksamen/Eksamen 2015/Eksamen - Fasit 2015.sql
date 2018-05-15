--
-- 1-a 
-- Skriv en SQL-spørring som viser kundenr og regnr for alle forsikringer av type Kasko der 
-- årlig kjørelengde (KmPrAar) er over 20 000 km. Utskriften skal ordnes etter kundenr. 
--

SELECT KundeNr, RegNr, ForsType, KmPrAar
FROM forsikring
WHERE KmPrAar > 20000 AND ForsType = 'Kasko'
ORDER BY KundeNr

--
-- 1-b 
-- Skriv en SQL-spørring som viser antall forsikringer av hver type (Ansvar, Delkasko og 
-- Kasko). Navngi kolonnene Forsikringstype og Antall. 
--

SELECT ForsType AS 'Forsikrings Type', COUNT(*) AS antall
FROM forsikring
GROUP BY ForsType


--
-- 1-c 
-- Skriv en SQL-spørring som viser antall skadesaker for hver forsikring. Det holder å vise 
-- forsikringsnr og antallet, men ta med samtlige forsikringer i utskriften selv om det ikke er 
-- registrert noen skadesaker på denne forsikringen. 
-- 

SELECT f.ForsNr, s.ForsNr, s.SkadeType, COUNT(*) AS Antall, f.ForsType
FROM forsikring AS f LEFT OUTER JOIN skadesak AS s ON f.ForsNr = s.ForsNr
GROUP BY f.ForsNr 

--
-- 1-d 
-- Skriv SQL-kode som oppretter tabellen Forsikring med primærnøkler og fremmednøkler. 
-- Husk at primærnøkkelen er auto-nummerert. Alle kolonner må alltid fylles ut. 
 
-- Foreslå også en måte å sikre at kolonnen ForsType kun vil inneholde én av verdiene Ansvar, 
-- Delkasko eller Kasko, og at Bonus kun vil inneholde tall mellom 0 og 100. 
-- 

CREATE TABLE IF NOT EXISTS forsikring (
	ForsNr INTEGER INCREMENT, 
	KundeNr INTEGER NOT NULL,
	RegNr VARCHAR (7) UNIQUE NOT NULL,
	RegAar INTEGER NOT NULL,
	KmPrAar INTEGER NOT NULL,
	ForsType VARCHAR(10),
	Bonus INTEGER,
	AarsPremie DECIMAL(10,2),
	CONSTRAINT ForsikringPK PRIMARY KEY (ForsNr), 
	CONSTRAINT ForsikringFK FOREIGN KEY (KundeNr) REFERENCES Kunde (KNr)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- 1-e 
-- Skriv SQL-kode for å registrere en ny skadesak for forsikringsnummer 2. Registreringsdato 
-- skal settes til dagens dato og skadetype til «Kollisjon». Samtidig skal bonus for kunden settes 
-- ned med 10 prosentpoeng.
-- 

INSERT INTO skadesak (ForsNr, RegDato, SkadeType)
VALUES (2, '2018.05.10', 'Kollisjon') 

UPDATE forsikring
SET Bonus = bonus - 10
WHERE ForsNr = 2

--
-- 1-f 
-- Lag et utsnitt (view) som viser alle skadesaker registrert siste år (RegDato). Utsnittet skal i 
-- tillegg til alle kolonner fra Skadesak også inneholde alle kolonner fra Kunde, samt 
-- forsikringstype og bonus fra Forsikring.
--

CREATE VIEW nySkadeSak AS
SELECT k.*, s.RegDato, s.SkadeType, f.Bonus, f.ForsType
FROM skadesak AS s, kunde AS k, forsikring AS f
WHERE k.KundeNr = f.KundeNr AND f.ForsNr = s.ForsNr AND YEAR(s.RegDato) = YEAR(CURDATE())



