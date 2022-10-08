-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : sam. 08 oct. 2022 à 12:27
-- Version du serveur :  10.3.32-MariaDB
-- Version de PHP : 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bleusaille`
--

-- --------------------------------------------------------

--
-- Structure de la table `ACCESS`
--

CREATE TABLE `ACCESS` (
  `Matricule` int(255) NOT NULL,
  `Mdp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `LISTING`
--

CREATE TABLE `LISTING` (
  `Nom` varchar(255) NOT NULL,
  `Prenom` varchar(255) NOT NULL,
  `Sexe` varchar(255) NOT NULL,
  `DateN` text NOT NULL,
  `Adresse` text NOT NULL,
  `Med` text NOT NULL DEFAULT '',
  `Com` text NOT NULL DEFAULT '',
  `Tel` varchar(255) NOT NULL,
  `Regio` varchar(255) NOT NULL,
  `Supp` tinyint(1) NOT NULL DEFAULT 0,
  `RespLegal` text NOT NULL COMMENT 'nom et prénom du responsable légale',
  `NumRespLegal` varchar(255) NOT NULL,
  `Ramassage1` text NOT NULL DEFAULT ' ',
  `Ramassage2` text NOT NULL DEFAULT ' ',
  `Ramassage3` text NOT NULL DEFAULT ' ',
  `Ramassage4` text NOT NULL DEFAULT ' '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `REGIO`
--

CREATE TABLE `REGIO` (
  `Lieu` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `REGIO`
--

INSERT INTO `REGIO` (`Lieu`) VALUES
('Boraine'),
('Carolo'),
('Centrale'),
('Fronta');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ACCESS`
--
ALTER TABLE `ACCESS`
  ADD PRIMARY KEY (`Matricule`);

--
-- Index pour la table `LISTING`
--
ALTER TABLE `LISTING`
  ADD PRIMARY KEY (`Nom`,`Prenom`),
  ADD KEY `Region` (`Regio`);

--
-- Index pour la table `REGIO`
--
ALTER TABLE `REGIO`
  ADD PRIMARY KEY (`Lieu`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `LISTING`
--
ALTER TABLE `LISTING`
  ADD CONSTRAINT `Region` FOREIGN KEY (`Regio`) REFERENCES `REGIO` (`Lieu`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
