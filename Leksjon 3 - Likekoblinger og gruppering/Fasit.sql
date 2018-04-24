--
-- Oppgave A - Likekoblinger
-- 

-- 1. Vis hele vare-tabellen, men erstatt katnr med navn på kategorien.

SELECT VNr, Betegnelse, Pris, Kategori.Navn, Antall, Hylle
FROM Vare, Kategori
WHERE Vare.KatNR = Kategori.KatNr

-- Kap. 4, oppgave 1c - Alle ordrelinjer påført varenavn og ordredato.

SELECT ordrelinje.*, ordre.OrdreDato, vare.Betegnelse
FROM ordre, ordrelinje, vare
WHERE ordrelinje.OrdreNr = ordre.OrdreNr AND ordrelinje.VNr = vare.VNr

-- Kap. 4, oppgave 1d - Beløp for hver ordrelinje.

SELECT o.OrdreNr, OL.PrisPrEnhet, v.Betegnelse, v.Pris
FROM ordrelinje AS OL, ordre AS O, vare AS V
WHERE o.OrdreNr = ol.OrdreNr AND v.Pris = ol.PrisPrEnhet 

-- Vis ordrenr, ordredato og kundens etternavn for alle ordrer, sortert på etternavn.

SELECT ordre.OrdreNr, ordre.OrdreDato, kunde.Etternavn 
FROM kunde, ordre
WHERE ordre.KNr = kunde.KNr
ORDER BY kunde.Etternavn ASC

 -- Alternativ 2

SELECT o.OrdreNr, o.OrdreDato, OL.*, CONCAT(k.Fornavn, ' ', k.Etternavn) AS Navn
FROM ordre AS o, ordrelinje AS OL, kunde as K
WHERE o.OrdreNr = OL.OrdreNr AND k.KNr = o.KNr
ORDER BY Navn ASC

-- TIPS:
-- Husk at f.eks. Knr må peke på en annen tabell som også har KNr, ellers blir det ikke riktig 
-- med utskriften. Dette ser vi via WHERE ordre.KNr = kunde.KNr

-- 
-- Oppgave B. Gruppering og mengdefunksjoner
-- 

-- 1. Prisen på den dyreste varen.

SELECT MAX(pris) AS Dyrest, Betegnelse
FROM vare

-- 2. Prisen på dyreste vare i hver enkelt varekategori.

SELECT vare.KatNr, MAX(vare.Pris) AS Dyreste 
FROM vare
GROUP BY vare.KatNr

-- 3. Høyeste og laveste månedslønn i hver stillingskategori.

SELECT AnsNr, Fødselsdato, CONCAT(Fornavn, ' ', Etternavn) AS Navn, Stilling, MIN(ROUND(ÅRSLØNN,2))/12 AS Lavest, MAX(ROUND(Årslønn, 2))/12 AS Høyeste
FROM ansatt
GROUP BY stilling ASC

-- 4. Varekategorier som inneholder flere enn 10 varer.

SELECT KatNr, Betegnelse, COUNT(*) as AntallVare
FROM vare
Having AntallVare >= 10

--
-- Oppgave C. Likekoblinger og gruppering
--

-- Kap. 4, 1e. Samlet beløp hver kunde har handlet for.

SELECT k.KNr, CONCAT (k.Fornavn, ' ', k.Etternavn) AS NAVN, SUM(ol.Antall * ol.PrisPrEnhet) AS Beløp
FROM ordrelinje AS OL, ordre AS O, kunde AS K
where ol.OrdreNr = o.OrdreNr AND k.KNr = o.KNr
GROUP BY k.KNr, k.Fornavn, k.Etternavn

-- Kap. 4, 1g. Samlet beløp pr. ordre.

SELECT OrdreNr, SUM(PrisPrEnhet * antall) AS SamletBeløp
FROM ordrelinje
GROUP BY OrdreNr

-- Kap. 4, 1j. Hvor mye hver varekategori har solgt for.

SELECT Kategori.KatNr, Kategori.Navn, SUM(Ordrelinje.Antall*PrisPrEnhet) AS SamletPris
FROM Vare, Ordrelinje, Kategori
WHERE Vare.VNr = Ordrelinje.VNr AND Vare.KatNr = Kategori.KatNr
GROUP BY Kategori.KatNr, Kategori.Navn
ORDER BY SUM(Ordrelinje.Antall*PrisPrEnhet) DESC

-- Antall kvinnelige og mannlige ansatte på hvert poststed. 
-- Sorter på poststed (navnet på poststedet).

SELECT fornavn, etternavn, poststed.*, kjønn, COUNT(*) AS AntallPersoner
FROM ansatt, poststed
WHERE poststed.PostNr = ansatt.PostNr
GROUP BY fornavn, etternavn, kjønn 
ORDEr BY poststed ASC