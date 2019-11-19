CREATE DATABASE copenhagen CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE copenhagen


-- Adminer 4.7.4 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Countries`;
CREATE TABLE `Countries` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key for a Country',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Country name',
  `iso2` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'official ISO country code',
  `iso3` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'official ISO country code',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Countries` (`id`, `name`, `iso2`, `iso3`) VALUES
(1,	'United Kingdom',	'GB',	'GBR'),
(2,	'France',	'FR',	'FRA');

DROP TABLE IF EXISTS `Cities`;
CREATE TABLE `Cities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key for a City',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'City name',
  `country_id` smallint(5) unsigned NOT NULL COMMENT 'Foreign key to Countries table',
  `latitude` decimal(10,8) NOT NULL COMMENT 'City Latitude',
  `longitude` decimal(10,8) NOT NULL COMMENT 'City Longitude',
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `Cities_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `Countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Cities` (`id`, `name`, `country_id`, `latitude`, `longitude`) VALUES
(1,	'London',	1,	51.50722200,	-0.12750000),
(2,	'Bayswater',	1,	51.50950000,	-0.19290000),
(3,	'Lyon',	2,	45.76000000,	4.84000000);

DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key for a Category',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Category name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Categories` (`id`, `name`) VALUES
(1,	'restaurant'),
(2,	'breakfast'),
(3,	'italian'),
(4,	'mexican'),
(5,	'lyonnais'),
(6,	'danish'),
(7,	'coffee shop');

DROP TABLE IF EXISTS `Venues`;
CREATE TABLE `Venues` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key for a Venue',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Venue name',
  `latitude` decimal(10,8) NOT NULL COMMENT 'Venue Latitude',
  `longitude` decimal(10,8) NOT NULL COMMENT 'Venue Longitude',
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'VEnue Address',
  `updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Venue update timestamp',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Venues` (`id`, `name`, `latitude`, `longitude`, `address`, `updated`) VALUES
(1,	'Au Petit Bouchon Chez Georges',	45.76702490,	4.83679810,	'8 Rue du Garet, 69001 Lyon, France',	'2019-11-17 15:16:30'),
(2,	'Golborne Deli',	51.52183000,	-0.20887800,	'100-102 Golborne Rd, London W10 5PS',	'2019-11-17 15:18:56'),
(3,	'Taqueria',	51.51468200,	-0.19657700,	'141-145 Westbourne Grove, Notting Hill, London W11 2RS',	'2019-11-17 15:21:09'),
(4,	'Snaps and Rye',	51.5218763,	-0.2084877,	'93 Golborne Rd, London W10 5NL',	'2019-11-17 15:23:19');

DROP TABLE IF EXISTS `VenueCategory`;
CREATE TABLE `VenueCategory` (
  `venue_id` int(11) unsigned NOT NULL,
  `category_id` smallint(5) unsigned NOT NULL,
  UNIQUE KEY `venue_id_category_id` (`venue_id`,`category_id`),
  KEY `category_id` (`category_id`),
  KEY `venue_id` (`venue_id`),
  CONSTRAINT `VenueCategory_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`id`),
  CONSTRAINT `VenueCategory_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `Venues` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `VenueCategory` (`venue_id`, `category_id`) VALUES
(1,	1),
(1,	5),
(2,	1),
(2,	2),
(2,	3),
(2,	7),
(3,	1),
(3,	4),
(4, 1),
(4, 6);

DROP TABLE IF EXISTS `VenueCity`;
CREATE TABLE `VenueCity` (
  `venue_id` int(11) unsigned NOT NULL,
  `city_id` int(11) unsigned NOT NULL,
  UNIQUE KEY `venue_id_city_id` (`venue_id`,`city_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `VenueCity_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `Venues` (`id`),
  CONSTRAINT `VenueCity_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `Cities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `VenueCity` (`venue_id`, `city_id`) VALUES
(1,	3),
(2,	1),
(3,	1),
(3,	2),
(4,	1);

-- 2019-11-17 15:38:59

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
