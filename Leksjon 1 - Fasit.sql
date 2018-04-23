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

/* Oppgave 7
 * Personer ansatt før 1998 sortert på lønn, de som tjener mest først. 
 * Tips: Skriv konkrete datoer slik: '2016-12-24' (julaften 2016). 
 * Du kan alternativt bruke funksjonen YEAR.
 */

  SELECT Etternavn, fornavn, Ansattdato, lønn 
  FROM ansatt
  WHERE YEAR(Ansattdato) < 1998 
  ORDER BY lønn DESC

 /* Oppgave 8
  * All informasjon om ansatte som har "sekretær" i tittelen. 
  *Tips: Bruk "jokernotasjon"!
  */

 SELECT CONCAT (fornavn, ' ', etternavn) AS Navn, Stilling
 FROM ansatt
 WHERE stilling LIKE 'sek%'

 /* Oppgave 9
  * Ansattnr og stilling til alle ansatte som er eldre enn 40 år og tjener mindre enn 450.000 kroner 
  * i året. 
  * Tips: Funksjonen DATE_ADD legger et tidsintervall til en dato. 
  * F.eks. vil DATE_ADD('2016-12-24', INTERVAL 3 DAY) returnere datoen '2016-12-27'. 
  * Intervallet kan angis i ulike måleenheter, f.eks. WEEK, MONTH eller YEAR. CURDATE gir dagens dato. Du må bruke den slik: CURDATE() - altså med tomme parenteser!*  
  */

-- CURDATE = Gir dagens Dato

SELECT Fødselsdato, CONCAT(fornavn, ' ', etternavn) AS NavnAnsattNr, Stilling, lønn
FROM ansatt
WHERE DATE_ADD(Fødselsdato, INTERVAL 40 YEAR) < CURDATE() AND lønn < 450000





