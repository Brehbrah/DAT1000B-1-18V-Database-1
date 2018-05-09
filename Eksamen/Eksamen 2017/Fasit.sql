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


--
-- Oppgave 3
-- 

-- 
-- 3-a
-- 

-- 
-- Konto(KontoNr, KundeNr, Rente, Saldo, KontoType, MaxAntallUttak)  
--

Det blir redudans i tabellen. Alle rader gitt med en kontotyper vil generere flere duplikater
rader med tiden i hensyn av kontoNr, kundeNr, saldo, og MaxAntalluttak. Dette vil gjenta seg 
opplysninger av data om igjen.

/*

Funksjonelle avghengighter 

- kontoNr --> Alle kolonner
- KundeNr --> Rente, MaxAntallUttak

Kandiats nøkkel

- KontoNr

Normalisering

Konto(KontoNr, kundeNr*, saldo, kontoType* )
Kunde(kontoType, rente, MaxAntallUttak)

*/

--
-- 3-b 
-- Vis med et konkret eksempel mot databasen i oppgave 1 hvordan tapt oppdatering kan oppstå i et 
-- databasesystem uten skikkelig flerbrukerkontroll. Gjør deretter rede for hvordan man kan bruke låser for å 
-- unngå dette problemet.
--

1) Det kan oppstå tapt oppdatering skyldes hvis to vedkommer ønsker f.eks. å oppdatere database systemet 
samtidig. La oss tenke f.eks. hvis Person1 (admin) ønsker å oppdatere saldo på kontoen ved enten beregne
ett eller annet mattematiske kalkulasjoner, og person2 (admin) ønsker også gjøre mattematiske kalkulasjoner
, så vil det oppstå tapt oppdatering. Dette skyldes pga. peron1 jobber inne i en samme lokal verdi
med person2. Dette vil risikere at tapte informasjoner der person1 har bearbeidet blir tapt, pga. person2
f.eks. har oppdatert nye informasjoner. 

For å forhindre dette problemet, så kan vi ha noe som heter "kø ordning" for samtidig bruk. 
Det beste løsningen er å utføre transkasjonen en etter en, og kalles da "sekvensielle utførelse." 
Dette vil sørge å forhindre alle samtidighetsproblemer. Ulempen er at det kan føles at det vil ta lengre
tid å oppdateres, pga. det brukeren står i kø for å oppdateres.

Vi kan lage en mekanisme som er en "låse" system. Her vil vi gi tilgang til en spesifikt område 
i database der noen har tilgang til ett bestemt område. Hvis dette blir innvilget, vil DBHS kunne stenge
andre trankasjoner som trenger tilgang til et bestemt type område av databasen. Dette vil førge
at vedkommende er på "vente kø". 

Vi har "skrive kø og lese kø". 
'Skrive kø' er mekanisme som gjør at vi kan oppdatere en eller flere 
informasjoner inne i database systemet. 

"Lese kø" er kun transaksjonene kan leses/vises bare. Når det er lese kø, så vil det ikke være noe 
problemer at mange kan lese samtidig, pga. brukeren "skriver" ikke, og det fører til da ingen
data oppdateringer inn på database systemet. 

--
-- 3-c 
-- Forklar hva en indeks er, gjerne ved hjelp av en figur. Diskuter deretter hvilke indekser som det kan være 
-- aktuelt å opprette mot databasen i oppgave 1 (forutsatt mer realistiske datamengder enn i vedlegget). 
--

Index er prinsippet som en stikkords register i en bok. Dette består av 'søke nøkler' og 'pekere'.
'Søke nøkkel' er verdier fra en kolonne, og 'pekeren' er addresser til blokkere eller poster. 

index er alltid sortert med hensyn på søkenøkkel (kolonne verdien).