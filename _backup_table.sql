-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas generowania: 15 Lut 2017, 12:27
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
-- Struktura tabeli dla tabeli `ng_text`
--

CREATE TABLE `ng_text` (
  `id` int(11) NOT NULL,
  `text` text COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ng_text`
--

INSERT INTO `ng_text` (`id`, `text`) VALUES
(1, 'Witaj!<br><div>Aplikacja wykorzystuje Angular v1.4.8, Bootstrap v3.3.7, jQuery v3.1.1.</div><div><br></div><div>Możliwości aplikacji:</div><div><ul><li>rejestracja użytkowników w bazie danych<br></li><li>logowanie użytkowników<br></li><li>edycja profilu</li><li>panel administratora do zarządzania listą kont (L: admin, H: 12345)<br></li><li>zmiana tekstu powitalnego na tej stronie<br></li></ul></div><div><br></div><div>Jeszcze do poprawy:</div><div><ol><li>order by userow<br></li><li>edycja userow może inputy w divach, wcześniej delete&nbsp;<br></li><li>wysłanie całego obiektu na serwer<br></li><li>kolory wszystkich info</li></ol></div>');

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
(81, 'admin', '827ccb0eea8a706c4c34a16891f84e7b', 'admin@admin.pl', '1986-04-29T23:00:00.000Z', 'brak', 'https://nie.mam', 'pl'),
(91, 'dpres', 'c4ca4238a0b923820dcc509a6f75849b', 'dpres@pl', '2022-01-27T23:00:00.000Z', '123123123', 'http://dpres.pl', 'polska'),
(120, 'kkkkkkk3', '0cc175b9c0f1b6a831c399e2697726611', '2', '1', NULL, NULL, NULL),
(137, 'admina', '4124bc0a9335c27f086f24ba207a4912', NULL, NULL, NULL, NULL, NULL),
(138, 'adamek', 'c4ca4238a0b923820dcc509a6f75849b', '', '2017-02-12T00:00:00.000Z', '', '', '');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `ng_text`
--
ALTER TABLE `ng_text`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT dla tabeli `ng_text`
--
ALTER TABLE `ng_text`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `ng_users`
--
ALTER TABLE `ng_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;