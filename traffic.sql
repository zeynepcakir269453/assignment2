-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 21 Nis 2024, 14:17:34
-- Sunucu sürümü: 10.4.28-MariaDB
-- PHP Sürümü: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `traffic`
--

DELIMITER $$
--
-- Yordamlar
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user_with_traffic` (IN `user_id` INT, IN `user_name` VARCHAR(255), IN `user_type` VARCHAR(255), IN `visit_dates` TEXT, IN `visit_times` TEXT)   BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE num_visits INT;
    DECLARE visit_date DATE;
    DECLARE visit_time INT;
    
    SET num_visits = JSON_LENGTH(visit_dates);
    
    INSERT INTO users (id, name, user_type) VALUES (user_id, user_name, user_type);
    
    WHILE i <= num_visits DO
        SET visit_date = JSON_UNQUOTE(JSON_EXTRACT(visit_dates, CONCAT('$[', i - 1, ']')));
        SET visit_time = CAST(JSON_UNQUOTE(JSON_EXTRACT(visit_times, CONCAT('$[', i - 1, ']'))) AS UNSIGNED);
        
        INSERT INTO traffic (user_id, visited_on, time_spent) VALUES (user_id, visit_date, visit_time);
        
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `traffic`
--

CREATE TABLE `traffic` (
  `user_id` int(11) DEFAULT NULL,
  `visited_on` date DEFAULT NULL,
  `time_spent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `traffic`
--

INSERT INTO `traffic` (`user_id`, `visited_on`, `time_spent`) VALUES
(1, '2019-05-01', 15),
(2, '2019-05-02', 20),
(2, '2019-05-03', 10),
(4, '2024-04-01', 10),
(4, '2024-04-02', 15),
(4, '2024-04-03', 20),
(5, '2024-04-01', 10),
(5, '2024-04-02', 15),
(5, '2024-04-03', 20),
(15, '2024-04-01', 10),
(15, '2024-04-02', 15),
(15, '2024-04-03', 20);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `name`, `user_type`) VALUES
(1, 'Matt', 'user'),
(2, 'John', 'user'),
(3, 'Louis', 'admin'),
(4, 'Alice', 'user'),
(5, 'Alice', 'user'),
(15, 'Alice', 'user');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
