--
-- 1-a 
-- Skriv en SQL-spørring som viser alle container-typer med maksimalvekt over 5000 kg og 
-- dagpris under 1800 kr.
-- 

SELECT type_navn, max_vekt, dagpris
FROM container_type
WHERE max_vekt > 5000 AND dagpris < 1800

--
-- 1-b 
-- Skriv en SQL-spørring som viser oppdrag der det enten skal bli levert eller hentet en container 
-- 17.12.2014. Sorter utskriften med hensyn på kundens adresse. 
-- 

SELECT o.*, k.adresse 
FROM kunde as k, oppdrag as o 
WHERE k.tlf = o.tlf 
AND (o.fra_dato = '2014-12-17' OR o.til_dato = '2014-12-17') 
ORDER BY k.adresse; 

--
-- 1-c 
-- Skriv en SQL-spørring som viser antall containere av hver enkelt type. Ta med type_id og 
-- type_navn i utskriften i tillegg til antallet. 
-- 

SELECT ct.type_id, ct.type_navn, COUNT(*) AS 'Antall Container Type'
FROM container_type as ct, container AS c
WHERE ct.type_id = c.type_id
GROUP BY ct.type_navn

--
-- 1-d 
-- Skriv SQL-kode som oppretter tabellen oppdrag. Husk å få med primærnøkler og 
-- fremmednøkler. Sørg for at alle kolonner bortsett fra til_dato alltid må fylles ut. Husk også at 
-- kolonnen onr skal være auto-nummerert. 
-- 

CREATE TABLE IF NOT EXISTS oppdrag (
	onr INTEGER AUTO_INCREMENT, 
	tlf INTEGER (12) NOT NULL,
	cnr INTEGER NOT NULL,
	fra_dato DATE NOT NULL,
	til_dato DATE NOT NULL,
	PRIMARY KEY (onr),
	FOREIGN KEY (tlf) REFERENCES kunde (tlf),
	FOREIGN KEY (cnr) REFERENCES conntainer (cnr)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;

--
-- 1-e 
-- Skriv SQL-kode som legger inn en ny kunde og også et nytt oppdrag for denne kunden. Velg 
-- eksempeldata selv. 
-- 

INSERT INTO kunde (tlf, adresse)
VALUES ('22887733', 'Skippergata 89') 

INSERT INTO oppdrag (onr, tlf, cnr, fra_dato, til_dato)
VALUES (5, '22887733', 3, '2018-01-05', '2018-02-10')

--
-- 1-f 
-- Lag et utsnitt (view) som viser totalbeløp som er fakturert hver kunde, beregnet ut fra dagpris 
-- og antall dager. For å beregne antall dager fra en dato d1 til en dato d2 kan du bruke 
-- funksjonen DATEDIFF(d2, d1). Ta med telefonnummeret til kunden i utsnittet.
--

CREATE VIEW faktura AS 
	SELECT k.*, container_type, SUM(ct.dagpris) 
	FROM kunde AS k, container AS c, container_type AS ct oppdrag AS o
	WHERE


/*

3-a 
Databasen fra oppgave 1 skal nå utvides. Bedriften disponerer et antall lastebiler, og de ulike 
oppdragene blir fortløpende fordelt på ledige lastebiler. Flere lastebiler kan dele på ett 
oppdrag. Det er foreslått å utvide databasen med en ny tabell lastebil for å håndtere dette: 
 
- lastebil(regnr, reg_aar, modell, max_vekt, onr) 
 
Følgende er et eksempel på en rad i denne tabellen: 
 
('LY12345', 2012, 'Volvo XL', 8500, 3) 
 
Dette betyr at lastebil med registreringsnummer LY12345 ble første gang registrert i 2012, og 
at den er brukt i oppdrag 3. Denne lastebilen er av modell Volvo XL og denne modellen har 
maksimalvekt 8500 kg. 
 
Forklar først hvorfor en slik løsning er problematisk. Skriv deretter ned funksjonelle 
avhengigheter, bestem kandidatnøkkel og utfør normalisering til BCNF. Vis primærnøkler og 
fremmednøkler i sluttresultatet. Gjør dine egne forutsetninger hvis oppgaveteksten er uklar. 


Årsaken til denne tabellen ikke går følger som slikt at hvis det blir gjennomført en annen lastebil 
registrert også i 2012 i første gangen, så vil de også lage en dobbel lagring på andre rader i tillegg 
for regnNr, modell, Max_vekt, onr. Dette dobbel lagring er hva vi kaller redudands og det 
blir bare mer unødvendig og meningsløs datalagrings plass

Funksjonelle Avhengighter

regnNr --> reg_aar
regNr --> modell
regNr --> modell
regNr + onr --> alle kolonner


Kandidatsnøkkel

regNr og onr

Normalisering

oppdrag(reg_aar*, onr*)
lasteBil(regNr,reg_aar, modell*)
modellBil(modell, max_vekt)

*/

CREATE TABLE IF NOT EXISTS konto (
	kontoNr INTEGER AUTO_INCREMENT,
	kundeNr INTEGER NOT NULL, 
	Rente DECIMAL (8,2) NOT NULL,
	Saldo DECIMAL (15,2) NOT NULL,
	KontoType VARCHAR (45) NOT NULL
	PRIMARY KEY (kontoNr), 
	FOREIGN KEY kundeNr REFERENCES kunde (kundeNr)
) ENGINE = InnoDB DEFAULT CHARSET= uf8;

CREATE TABLE IF NOT EXISTS hytte (
	HNr INTEGER AUTO_INCREMENT,
	Navn VARCHAR (45) NOT NULL,
	antSenger INTEGER NOT NULL,
	HytteType VARCHAR(45) NOT NULL
	CONSTRAINT HytteTypePK PRIMARY KEY (HNr),
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS forsikring (
	forsNr INTEGER AUTO_INCREMENT,
	kundeNr INTEGER NOT NULL,
	RegNr VARCHAR (30) NOT NULL,
	RegAar INTEGER (4) NOT NULL,
	KmPrAar INTEGER NOT NULL,
	ForsType VARCHAR (45) NOT NULL,
	Bonus INTEGER NOT NULL,
	AarsPremie DECIMAL (15,2),
	CONSTRAINT ForsikringPK PRIMARY KEY (forsNr),
	CONSTRAINT ForsikringFK FOREIGN KEY kundeNr REFERENCES kunde (kundeNr)
)Engine = InnoDB DEFAULT CHARSET=utf8;