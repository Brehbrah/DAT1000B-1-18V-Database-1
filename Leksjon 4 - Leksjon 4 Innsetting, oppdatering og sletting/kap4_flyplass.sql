-- Database: Flyplass



-- Sletter tabellene

-- For å få et skript som kan kjøres flere ganger:

-- DROP TABLE Flyavgang;
-- DROP TABLE Flyselskap;
-- DROP TABLE Flyplass;


-- MySQL
-- For å få et skript som kan kjøres flere ganger,
-- og som fungerer enten tabellen(e) finnes eller ikke:

-- DROP TABLE IF EXISTS Flyavgang;
-- DROP TABLE IF EXISTS Flyselskap;
-- DROP TABLE IF EXISTS Flyplass;



-- Oppretter tabellene

CREATE TABLE Flyplass
(
  Nr     INTEGER,
  Navn   VARCHAR(50),
  Bynavn VARCHAR(50),
  CONSTRAINT FlyplassPK PRIMARY KEY (Nr)
);


CREATE TABLE Flyselskap
(
  Kode CHAR(2),
  Navn VARCHAR(50),
  CONSTRAINT FlyselskapPK PRIMARY KEY (Kode)
);

CREATE TABLE Flyavgang
(
  SelskapKode CHAR(2),
  LøpeNr      INTEGER,
  AvgPlass    INTEGER,
  AvgKl       TIME,
  AnkPlass    INTEGER,
  AnkKl       TIME,
  CONSTRAINT FlyplassPK PRIMARY KEY (SelskapKode, LøpeNr),
  CONSTRAINT FlyavgangFlyselskapFK FOREIGN KEY (SelskapKode)
    REFERENCES Flyselskap (Kode),
  CONSTRAINT FlyavgangFlyplassFK1 FOREIGN KEY (AvgPlass)
    REFERENCES FlyPlass (Nr),
  CONSTRAINT FlyavgangFlyplassFK2 FOREIGN KEY (AnkPlass)
    REFERENCES FlyPlass (Nr)
);



-- Setter inn eksempeldata

INSERT INTO Flyplass(Nr, Navn, Bynavn)
  VALUES (1, 'Gardermoen', 'Oslo');

INSERT INTO Flyplass(Nr, Navn, Bynavn)
  VALUES (2, 'Heathrow', 'London');

INSERT INTO Flyplass(Nr, Navn, Bynavn)
  VALUES (3, 'Charles de Gaulle', 'Paris');


INSERT INTO Flyselskap(Kode, Navn)
  VALUES ('LH', 'Lufthansa');

INSERT INTO Flyselskap(Kode, Navn)
  VALUES ('DY', 'Norwegian');

INSERT INTO Flyselskap(Kode, Navn)
  VALUES ('SK', 'SAS');


INSERT INTO Flyavgang(SelskapKode, LøpeNr, AvgPlass, AvgKl, AnkPlass, AnkKl)
  VALUES ('DY', 510, 3, '16:30', 1, '18:15');

INSERT INTO Flyavgang(SelskapKode, LøpeNr, AvgPlass, AvgKl, AnkPlass, AnkKl)
  VALUES ('SK', 890, 1, '10:30', 2, '12:05');

INSERT INTO Flyavgang(SelskapKode, LøpeNr, AvgPlass, AvgKl, AnkPlass, AnkKl)
  VALUES ('SK', 835, 1, '08:25', 3, '10:50');
