-- 
-- Oppgave A. Registrere data med SQL
-- 

-- 
-- Øke prisen på alle sykkelmodeller med 10 kroner. 
--

UPDATE modell
set Dagpris = 10


--
-- Registrere en ny kunde. 
--

INSERT kunde (Fornavn, Etternavn, Mobil)  
VALUES ('Are', 'Behn', 99445577)

--
-- Registrere et nytt utleieforhold for denne kunden. La TidInn inneholde et nullmerke. 
--

INSERT INTO utleie (KNr, MNr, KopiNr, tidUt)
VALUES (7, 1, 2, '2017-04-25')

--
-- Registrere innlevering for det nye utleieforholdet.
--

UPDATE utleie
SET TidInn = '2018-04-25'
WHERE KNr = 7 AND MNr = 1 AND KopiNr = 2 AND TidUt = '2017-04-25'

--
-- Slett både det nye utleieforholdet og den nye kunden.
--

DELETE FROM Kunde
WHERE KNr = 7


--
-- Oppgave C. Ytre koblinger
--

--
-- For hver kunde, vis alle utleieforhold. 
-- Sorter utskriften med hensyn på navnet til kunden og dernest på utleietidspunkt. 
-- Ta med samtlige kunder i utskriften, også de som ennå ikke er knyttet til noe utleieforhold.
-- (TIPS: Outer join Funksjon, fordi de som ennå ikke er knyttet til noe utleieforhold.)
--

SELECT utleie.*, CONCAT (kunde.Fornavn, ' ', kunde.Etternavn) AS Navn
FROM kunde LEFT OUTER JOIN utleie ON kunde.KNr = utleie.KNr
ORDER BY kunde.fornavn, kunde.Etternavn, utleie.tidUt

-- alternativ 2

SELECT u.*, k.Fornavn, k.Etternavn
FROM kunde as k LEFT OUTER JOIN utleie AS u ON k.KNr = u.KNr
ORDER BY k.Fornavn, k.Etternavn, u.TidUt

--
-- Vis antall utleieforhold for samtlige kunder.
-- 

SELECT k.*, u.TidUt, COUNT(*) AS 'Antall Utleieforhold'
FROM kunde AS k LEFT OUTER JOIN utleie AS u ON k.KNr = u.KNr
GROUP BY k.Fornavn, k.Etternavn, u.tidUt

--
-- Oppgave D. Egenkoblinger
-- 

--
-- Oppgave 4b fra Databasesystemer.
-- Vis alle avganger mellom Gardermoen og Charles deGaulle med avgang etter 
-- kl. 12. Flyplassnummeret til flyplassene er ikke kjent. 
-- Tips: Bruk en egenkobling.
-- 




--
-- Oppgave 4c fra Databasesystemer.
-- Vis alle reiseruter mellom Oslo og Paris med nøyaktig en mellomlanding.
-- 
-- Vi må finne to avganger a1 og a2, som er slik at a1 har avgang fra Oslo, a2 har ankomst i Paris, 
-- og a1 har ankomst på samme flyplass (og før) som a2 har avgang. 