-- Oppgave 1
/* Etternavn og årslønn for ansatte som tjener mer enn 500.000 kroner i året. 
 * Tips: Resultatet skal altså ha 2 kolonner.
 */

 SELECT etternavn, lønn
 FROM  ansatt
 WHERE lønn < 500000

-- Oppgave 2
/*Etternavn, stilling og årslønn for alle som ikke er sekretærer
 * og tjener mindre enn 400.000 kroner i året.
*/

SELECT etternavn, stilling, lønn
FROM ansatt
WHERE stilling <> 'sekretær' AND lønn < 400000

-- alternativ 

SELECT etternavn, stilling, lønn
FROM ansatt 
WHERE NOT (stilling = 'sekretær') AND lønn < 400000

/* Oppgave 3
 * Alle stillingsbetegnelser som er i bruk, og slik at 
 * ingen stillingsbetegnelser kommer flere ganger.
 */ 

 SELECT DISTINCT Stilling, Etternavn, fornavn
 FROM ansatt 

 /* Oppgave 4
  * Listen av ansatte sortert først på stilling, og deretter på etternavn.
  */

 SELECT etternavn, fornavn, stilling
 FROM ansatt
 ORDER BY  stilling ASC

 /* Oppgave 5
 * Ansattnummer og navn for alle ansatte født i 1970. 
 * Fornavn og etternavn skal stå i én kolonne adskilt av ett blankt tegn. 
 * Utskriften skal dessuten inneholde årstall for ansettelse.
 * Tips: Bruk funksjonen CONCAT for å sette sammen tekster. 
 * Prøv først å skrive SELECT CONCAT('a','b','c') i SQL-vinduet.
 * Svaret blir 'abc'. Bruk funksjonen YEAR for å trekke ut årstallet fra en dato. 
 * Se SQL-dokumentasjonen til MySQL for eksempler.
 */

 SELECT CONCAT (fornavn, ' ', etternavn) AS Navn, AnsattNr, Fødselsdato 
 FROM ansatt
 WHERE year(Fødselsdato) = 1970

 /* Oppgave 6
  * Etternavn og månedslønn for ansatte i markedsavdelingen. 
  * Tips: Bruk funksjonen ROUND for å avrunde månedslønn til to desimaler, 
  * f.eks. vil ROUND(123.456, 1) gi 123.5.
  */

 SELECT Etternavn, avdeling, lønn AS Månedslønn
 FROM ansatt 
 WHERE avdeling LIKE 'mark%' AND round(lønn,2)/12

  

