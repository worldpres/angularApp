-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas generowania: 12 Lut 2017, 21:08
-- Wersja serwera: 10.0.29-MariaDB-0ubuntu0.16.04.1
-- Wersja PHP: 7.0.13-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `angular`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ng_users`
--

CREATE TABLE `ng_users` (
  `id` int(11) NOT NULL,
  `login` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_polish_ci DEFAULT NULL,
  `birth` varchar(50) COLLATE utf8_polish_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8_polish_ci DEFAULT NULL,
  `www` varchar(50) COLLATE utf8_polish_ci DEFAULT NULL,
  `nation` varchar(50) COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ng_users`
--

INSERT INTO `ng_users` (`id`, `login`, `password`, `email`, `birth`, `phone`, `www`, `nation`) VALUES
(81, 'admin', '827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL),
(91, 'dpres', 'c4ca4238a0b923820dcc509a6f75849b', 'dpres@pl', NULL, NULL, NULL, NULL);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `ng_users`
--
ALTER TABLE `ng_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `ng_users`
--
ALTER TABLE `ng_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
