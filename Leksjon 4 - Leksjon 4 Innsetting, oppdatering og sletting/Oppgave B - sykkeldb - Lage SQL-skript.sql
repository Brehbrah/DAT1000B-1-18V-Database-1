-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Vert: localhost
-- Generert den: 08. Mai, 2014 11:54 AM
-- Tjenerversjon: 5.5.16
-- PHP-Versjon: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Sletter tabellene
--

DROP TABLE IF EXISTS `Utleie`;
DROP TABLE IF EXISTS `Kunde`;
DROP TABLE IF EXISTS `Sykkel`;
DROP TABLE IF EXISTS `Modell`;


--
-- Tabellstruktur for tabell `kunde`
--

CREATE TABLE IF NOT EXISTS `Kunde` (
  `KNr` int(11) NOT NULL AUTO_INCREMENT,
  `Fornavn` varchar(20) NOT NULL,
  `Etternavn` varchar(50) NOT NULL,
  `Mobil` varchar(15) UNIQUE DEFAULT NULL,
  PRIMARY KEY (`knr`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dataark for tabell `kunde`
--

INSERT INTO `Kunde` VALUES
(1, 'Varg', 'Virrum', '99887766'),
(2, 'Trude', 'Stein', '44556677'),
(4, 'Katinka', 'Fosheim', '45671234'),
(5, 'Robert', 'Romman', '98765432'),
(6, 'Jon', 'Vein', '81726354');

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `modell`
--

CREATE TABLE IF NOT EXISTS `Modell` (
  `MNr` int(11) NOT NULL AUTO_INCREMENT,
  `Fabrikk` varchar(50) DEFAULT NULL,
  `Betegnelse` varchar(50) DEFAULT NULL,
  `Kategori` varchar(20) DEFAULT NULL,
  `Dagpris` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`MNr`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dataark for tabell `modell`
--

INSERT INTO `Modell` VALUES
(1, 'Avante', 'Birken classic', 'Terreng', '75.00'),
(2, 'Trailo', 'Askeladden', 'Hybrid', '55.00'),
(3, 'Perimeter', 'Downtown', 'Bysykkel', '120.00'),
(4, 'Avante', 'Dovregubben', 'Terreng', '105.00'),
(5, 'Avante', 'Atlantis', 'Landevei', '90.00'),
(6, 'Perimeter', 'Medita', 'Terreng', '95.00'),
(7, 'Avante', 'Aeroflyt', 'Landevei', '115.00'),
(8, 'Trailo', 'MultiX', 'Hybrid', '150.00'),
(9, 'Trailo', 'Trailfinder', 'Terreng', '140.00'),
(10, 'Perimeter', 'Vasaknekk', 'Terreng', '50.00'),
(11, 'Avante', 'Olebrum', 'Hybrid', '125.00'),
(12, 'Trailo', 'Alfavei', 'Terreng', '80.00');

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `sykkel`
--

CREATE TABLE IF NOT EXISTS `Sykkel` (
  `MNr` int(11) NOT NULL DEFAULT '0',
  `KopiNr` smallint(6) NOT NULL DEFAULT '0',
  `Ramme` smallint(6) DEFAULT NULL,
  `Farge` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`MNr`,`KopiNr`),
  FOREIGN KEY (`MNr`) REFERENCES `Modell` (`MNr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dataark for tabell `sykkel`
--

INSERT INTO `Sykkel` VALUES
(1, 1, 25, 'grå'),
(1, 2, 28, 'rød'),
(2, 1, 25, 'blå'),
(2, 2, 27, 'svart'),
(2, 3, 27, 'grå'),
(3, 1, 28, 'rød'),
(3, 2, 28, 'blå'),
(4, 1, 25, 'svart'),
(5, 1, 25, 'blå'),
(5, 2, 28, 'rød'),
(5, 3, 28, 'grå'),
(5, 4, 28, 'svart'),
(6, 1, 28, 'blå'),
(7, 1, 25, 'rød'),
(7, 2, 25, 'grå'),
(7, 3, 27, 'blå'),
(8, 1, 27, 'rød'),
(8, 2, 27, 'blå'),
(8, 3, 27, 'grå'),
(9, 1, 28, 'rød'),
(9, 2, 28, 'rød'),
(10, 1, 28, 'rød'),
(10, 2, 25, 'svart'),
(10, 3, 25, 'blå'),
(11, 1, 27, 'grå'),
(12, 1, 27, 'rød'),
(12, 2, 25, 'svart'),
(12, 3, 28, 'blå');

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `utleie`
--

CREATE TABLE IF NOT EXISTS `Utleie` (
  `KNr` int(11) DEFAULT NULL,
  `MNr` int(11) NOT NULL DEFAULT '0',
  `KopiNr` smallint(6) NOT NULL DEFAULT '0',
  `TidUt` date NOT NULL DEFAULT '0000-00-00',
  `TidInn` date DEFAULT NULL,
  PRIMARY KEY (`MNr`,`KopiNr`,`TidUt`),
  FOREIGN KEY (`KNr`) REFERENCES `Kunde` (`KNr`),
  FOREIGN KEY (`MNr`, `KopiNr`) REFERENCES `Sykkel` (`MNr`, `KopiNr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dataark for tabell `utleie`
--

INSERT INTO `Utleie` VALUES
(1, 1, 1, '2014-08-13', '2014-08-15'),
(5, 1, 1, '2014-08-14', NULL),
(2, 1, 2, '2014-08-13', '2014-08-14'),
(1, 2, 1, '2014-08-13', '2014-08-14'),
(4, 3, 1, '2014-08-13', NULL),
(6, 8, 1, '2014-08-14', NULL),
(4, 12, 1, '2014-08-14', NULL),
(5, 12, 2, '2014-08-14', '2014-08-14');


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
