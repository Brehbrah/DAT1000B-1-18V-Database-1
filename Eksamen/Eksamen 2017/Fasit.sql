--
-- 1-a 
-- Lag en SQL-spørring som viser kontonummer og saldo for alle sparekontoer med rente under 3 %. Sorter 
-- utskriften med hensyn på rente, de med høyest rente først. 
--

SELECT kontoNr, saldo
FROM konto
WHERE kontoType = 'sparekonto' AND rente < 3.0 
ORDER BY rente DESC

--
-- 1-b 
-- Lag en SQL-spørring som viser alle transaksjoner utført i inneværende måned (altså den måneden som 
-- spørringen blir utført). Ta med kontotypen for begge kontoene. 
-- 

SELECT transaksjon.*, fra.kontoNr, til.kontoNr
FROM transaksjon, tranksasjon.fraKonto AS fra, transkasjon.tilKonto AS til
WHERE fra.kontoNr = transaksjon.fraKonto 
AND til.kontoNr =transaksjon.tilKonto
AND YEAR(dato) = YEAR(CURDATE())
AND MONTH(dato) = MONTH (CURRDATE())  

--
-- 1-c 
-- Lag en SQL-spørring som viser totalt antall uttak fra hver kontotype. 
-- 

SELECT kontoType, COUNT(*) AS 'antall Uttak'
FROM konto, transaksjon
WHERE transkasjon.fraKonto = konto.kontoNr
GROUP BY kontoType

--
-- 1-d 
-- Skriv SQL-kode som oppretter tabellen Konto. Sørg for at Rente og Saldo alltid må fylles ut. 
--

CREATE TABLE IF NOT EXISTS konto (
	kontoNr INTEGER,
	KundeNr INTEGER,
	rente DECIMAL (8,2) NOT NULL,
	saldo DECiMAL (11,2) NOT NULL,
	kontoType CHAR (45),
	PRIMARY KEY (kontoNr),
	FOREIGN KEY kundeNr REFERENCES kunde(kundeNr)
) ENGINE = InnoDB DEFAULT CHARSET=utf8

--
-- 1-e 
-- Lag en SQL-spørring som lister alle kontoer som det ikke er tatt ut penger fra. 
--

SELECT *
FROM konto 
WHERE KontoNr NOT IN (SELECT fraKonto FROM transaksjon)

--
-- 1-f) 
-- Lag en visning (view) som viser antall kontoer og samlet saldo for hver kunde. 
-- 

CREATE VIEW 
	(KundeNr, Fornavn, Etternavn, kontoType, antallKontoer, samletSaldo)
AS
	SELECT kunde.kundeNr, kunde.Fornavn, kunde.etternavn, kontoType, COUNT(*), SUM(saldo)
	FROM kunde, konto
	WHERE kunde.kundeNr = konto.kontoNr 
	GROUP BY kunde.kundeNr

