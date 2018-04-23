DROP TABLE IF EXISTS Ansatt;

CREATE TABLE IF NOT EXISTS Ansatt
(
  AnsattNr    INTEGER,
  Etternavn   VARCHAR(40),
  Fornavn     VARCHAR(20),
  Fødselsdato DATE,
  Ansattdato  DATE,
  Stilling    VARCHAR(30),
  Avdeling    VARCHAR(20),
  Lønn        DECIMAL(8, 2),
  PRIMARY KEY (AnsattNr)
) DEFAULT CHARSET=utf8;


INSERT INTO Ansatt (AnsattNr, Etternavn, Fornavn, Fødselsdato, Ansattdato, Stilling, Avdeling, Lønn)
VALUES
  (1,  'Veum',       'Varg',       '1964-11-01', '1992-01-01', 'Assistent',       'Lager',          323000.00),
  (2,  'Stein',      'Trude',      '1973-10-10', '2000-10-10', 'DBA',             'IT',             570500.00),
  (3,  'Dudal',      'Inger-Lise', '1990-03-09', '1988-12-24', 'Sekretær',        'Økonomi',        399000.00),
  (4,  'Hansen',     'Hans',       '1985-12-31', '2006-08-23', 'Programmerer',    'IT',             425200.00),
  (5,  'Bjørnsen',   'Henrik',     '1970-05-17', '2000-01-01', 'Selger',          'Marked',         475000.00),
  (6,  'Gredelin',   'Sofie',      '1972-06-23', '1998-05-18', 'Underdirektør',   'Administrasjon', 725800.00),
  (7,  'Zimmermann', 'Robert',     '1976-07-24', '1995-05-17', 'Regnskapsfører',  'Økonomi',        475000.00),
  (8,  'Nilsen',     'Lise',       '1973-01-31', '2002-04-03', 'Direktør',        'Administrasjon', 775300.00),
  (11, 'Fosheim',    'Katinka',    '1975-02-28', '2001-09-13', 'Selger',          'Marked',         520000.00),
  (13, 'Lovløs',     'Ada',        '1983-12-01', '2005-08-12', 'Programmerer',    'IT',             484200.00),
  (16, 'Fjeld',      'Jørn',       NULL,         '2008-01-02', 'Selger',          'Marked',         446000.00),
  (17, 'Karlsen',    'Arve',       '1978-10-03', '2009-05-17', 'Lagerleder',      'Lager',          420100.00),
  (20, 'Felgen',     'Reodor',     '1981-09-12', '2001-12-12', 'Sykkelreparatør', 'Lager',          379500.00),
  (23, 'Norheim',    'Ola',        '1980-03-02', '2001-12-13', 'Salgssekretær',   'Marked',         427300.00),
  (29, 'Wirkola',    'Gabriel',    '1974-07-25', '2009-04-21', 'Sekretær',        'Marked',         407000.00);
