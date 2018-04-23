/* Oppgave 1a
 * All informasjon om filmer produsert i 1988
 */

 SELECT tittel, år
 FROM film
 WHERE år < 1988
 ORDER BY år ASC

 /* Oppgave 1b 
  * tittel på amerikanske filmer produsert på 1980-tallet
  */

 SELECT Tittel, land, år
 FROM film
 WHERE år < 1980  AND land = 'USA'

 /* Oppgave 1c
  * Komedier med aldersgrense under 10 år og spilletid under 130 minutter
  */

  SELECT Tittel, Alder, sjanger, tid
  FROM film
  WHERE alder < 10 AND tid < 130

 /* Oppgave 1d
  * Tittel på alle action-og westernfilmer
  */

 SELECT tittel, sjanger
 FROM film
 WHERE sjanger = ('action' AND 'western') 

 /* Oppgave 1e 
  * alle produksjonsland, sortert og uten gjentakelser
  */

 SELECT DISTINCT Land, tittel
 FROM film
 ORDER by land DESC

 /* Oppgave 1f 
  * Korteste og lengste spilletid innen hver sjanger
  */

 SELECT Tittel, tid
 FROM film
 ORDER BY tid DESC

 /* Oppgave 1g
 * Antall filmer som ikke er til salgs
 */

 SELECT tittel, pris
 FROM film
 WHERE pris IS NULL

 /* Oppgave 1h
 * Antall filmer under 100 kr 
 */

 SELECT tittel, pris
 FROM film
 WHERE pris  < 100

 /* Oppgave 1i 
  * Filmer med tittel som slutter på 'now'
  */

 SELECT Tittel
 FROM film
 WHERE tittel LIKE '%NOW%'

 /* Oppgave 1j 
  *Gjennomsnittspris for sjangre med flere enn 2 filmer 
  */

 SELECT Sjanger, AVG(Pris) AS Snittpris
 FROM Film
 GROUP BY Sjanger
 HAVING COUNT(*) > 2


 /* Oppgave 1k
  * Differansen mellom dyreste og billigste film innen hver sjanger
  */

 SELECT Tittel, Sjanger, Pris
 FROM film
 ORDER BY pris DESC 

 /* Oppgave 1l 
  * Totalt antall filmer og antall filmer til salgs, fordelt på produksjonsland
  */

  SELECT COUNT(*) AS AntallFilmer, COUNT(Pris) AS AntallSalg, land
  FROM film
  GROUP BY Land

 /* Oppgave 1m 
  * Antall år siden utgivelse for filmer eldre enn 50 år.
  * Tips: vedlegg A lister navn på noen datofunksjoner. Du trenger kanskje
  * en funksjon for å finne dagens dato, og en funksjon for å trekke ut årstallet
  * fra en dato
  */