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
