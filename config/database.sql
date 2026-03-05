-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 05/03/2026 às 21:52
-- Versão do servidor: 11.8.3-MariaDB-log
-- Versão do PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "-03:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `u943718437_slivigame`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `character_states`
--

CREATE TABLE `character_states` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `state` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `character_states`
--

INSERT INTO `character_states` (`id`, `user_id`, `state`, `value`, `created_at`, `updated_at`) VALUES
(1, 1, 'HUNGER', 0, '2025-12-20 16:51:33', '2026-03-05 21:48:05'),
(2, 1, 'ENERGY', 0, '2025-12-20 16:51:33', '2026-03-05 21:48:05'),
(3, 1, 'SLEEP', 84, '2025-12-20 16:51:33', '2026-03-05 21:45:04'),
(4, 1, 'TEMPERATURE', 50, '2025-12-20 16:51:33', '2026-02-20 21:54:03'),
(6, 1, 'FUN', 60, '2026-01-07 17:04:36', '2026-03-04 14:29:24'),
(13, 1, 'BRAVO', 20, '2026-01-07 17:04:36', '2026-02-24 22:58:51'),
(47, 6, 'HUNGER', 0, '2026-03-04 14:34:25', '2026-03-04 20:20:06'),
(48, 6, 'ENERGY', 0, '2026-03-04 14:34:25', '2026-03-04 20:20:06'),
(49, 6, 'SLEEP', 0, '2026-03-04 14:34:25', '2026-03-05 02:38:04'),
(50, 6, 'TEMPERATURE', 50, '2026-03-04 14:34:25', '2026-03-04 14:34:25'),
(51, 6, 'FUN', 50, '2026-03-04 14:34:25', '2026-03-04 14:34:25'),
(52, 6, 'BRAVO', 0, '2026-03-04 14:34:25', '2026-03-04 14:34:25'),
(53, 7, 'HUNGER', 100, '2026-03-04 21:20:44', '2026-03-05 21:51:55'),
(54, 7, 'ENERGY', 100, '2026-03-04 21:20:44', '2026-03-05 21:51:56'),
(55, 7, 'SLEEP', 100, '2026-03-04 21:20:44', '2026-03-05 21:51:58'),
(56, 7, 'TEMPERATURE', 50, '2026-03-04 21:20:44', '2026-03-04 21:20:44'),
(57, 7, 'FUN', 50, '2026-03-04 21:20:44', '2026-03-04 21:20:44'),
(58, 7, 'BRAVO', 10, '2026-03-04 21:20:44', '2026-03-05 21:52:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `emotions`
--

CREATE TABLE `emotions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `emotion` varchar(50) NOT NULL,
  `color` varchar(7) NOT NULL,
  `face_expression` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `emotions`
--

INSERT INTO `emotions` (`id`, `user_id`, `emotion`, `color`, `face_expression`, `created_at`) VALUES
(1, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-20 16:51:18'),
(2, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-22 15:49:50'),
(3, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-22 15:49:55'),
(4, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-22 16:12:02'),
(5, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-22 16:12:02'),
(6, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2025-12-22 16:13:09'),
(7, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-22 16:13:19'),
(8, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-22 16:13:19'),
(9, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2025-12-22 16:16:51'),
(10, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2025-12-26 11:14:43'),
(11, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-26 11:19:31'),
(12, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2025-12-26 11:54:23'),
(13, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-26 17:02:16'),
(14, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2025-12-29 00:29:13'),
(15, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-29 00:29:55'),
(16, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2025-12-29 00:30:33'),
(17, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2025-12-29 00:47:51'),
(18, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-29 00:50:06'),
(19, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2025-12-29 01:03:31'),
(20, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2025-12-29 01:04:14'),
(21, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-01-04 16:44:14'),
(22, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-01-04 16:50:56'),
(23, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-01-07 16:16:18'),
(24, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-01-07 16:20:09'),
(25, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-01-10 11:23:35'),
(26, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-01-10 11:24:42'),
(27, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-01-10 11:43:06'),
(28, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-01-10 11:47:50'),
(29, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-01-10 15:42:27'),
(30, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-01-13 18:44:11'),
(31, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-01-13 19:01:17'),
(32, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-01-13 19:18:21'),
(33, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-01-13 19:19:26'),
(34, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-01-13 19:30:57'),
(35, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-01-13 19:32:10'),
(36, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-01-14 19:14:54'),
(37, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-01-17 11:59:09'),
(38, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-01-17 12:01:09'),
(39, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-01-18 19:41:13'),
(40, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-01-18 19:41:45'),
(41, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-01-18 19:56:20'),
(42, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-01-20 19:14:02'),
(43, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-01-20 19:14:34'),
(44, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-01-20 19:15:55'),
(45, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-01-25 13:46:08'),
(46, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-08 13:44:57'),
(47, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-08 13:48:10'),
(48, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-11 12:01:51'),
(49, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-11 12:07:47'),
(50, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-11 13:25:11'),
(51, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-11 13:30:18'),
(52, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-02-11 13:31:12'),
(53, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-02-11 13:32:03'),
(54, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-15 21:36:33'),
(55, 1, 'CANSADO', '#808080', 'body_cinza_cansado.png', '2026-02-15 23:07:12'),
(56, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-02-16 00:49:10'),
(57, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-16 21:38:51'),
(58, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-02-16 21:39:34'),
(59, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-16 22:29:01'),
(60, 1, 'TRISTE', '#0000FF', 'body_azul_triste.png', '2026-02-16 22:43:05'),
(61, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-16 23:28:24'),
(62, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-16 23:46:28'),
(63, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-16 23:47:39'),
(64, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-17 02:36:02'),
(65, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-17 04:00:05'),
(66, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-17 15:05:07'),
(67, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-17 16:00:06'),
(68, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-17 17:11:31'),
(69, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-17 17:21:00'),
(70, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-17 17:31:03'),
(71, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-17 19:10:07'),
(72, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-17 20:50:04'),
(73, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-18 16:06:03'),
(74, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-18 16:16:06'),
(75, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-18 16:19:37'),
(76, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-18 21:30:44'),
(77, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-18 21:52:04'),
(78, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-02-20 18:22:04'),
(79, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-20 18:27:42'),
(80, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-20 18:48:12'),
(81, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-22 17:05:04'),
(82, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-22 21:52:04'),
(83, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-22 22:51:41'),
(84, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-22 23:19:50'),
(85, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-23 12:16:08'),
(86, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-23 15:25:04'),
(87, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-23 16:16:04'),
(88, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-02-23 22:34:24'),
(89, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-23 22:35:44'),
(90, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-24 00:54:03'),
(91, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-24 18:49:03'),
(92, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-25 03:00:05'),
(93, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-26 00:53:17'),
(94, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-26 06:39:04'),
(95, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-26 22:54:50'),
(96, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-27 00:11:03'),
(97, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-27 06:52:04'),
(98, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-28 17:58:26'),
(99, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-02-28 17:59:49'),
(100, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-02-28 20:00:07'),
(101, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-02-28 21:56:04'),
(102, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-03-02 14:53:03'),
(103, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-03-02 15:29:04'),
(104, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-03-02 18:52:04'),
(105, 1, 'NERVOSO', '#FF0000', 'body_vermelho_nervoso.png', '2026-03-02 21:01:03'),
(108, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-02 23:49:03'),
(110, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-03-03 01:23:03'),
(111, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-03-03 11:42:05'),
(112, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-03 11:44:40'),
(113, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-03-03 11:44:46'),
(114, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-03 11:44:53'),
(115, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-03-03 12:33:04'),
(116, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-03 13:14:03'),
(117, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-03-03 17:02:04'),
(118, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-03-04 14:25:47'),
(122, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-04 14:31:04'),
(124, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-03-04 14:32:05'),
(125, 6, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-04 14:34:25'),
(126, 6, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-03-04 16:20:07'),
(127, 6, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-03-04 17:46:03'),
(128, 6, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-03-04 18:38:04'),
(129, 7, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-04 21:20:45'),
(130, 7, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-03-04 23:04:06'),
(131, 7, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-03-05 00:31:08'),
(132, 7, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-03-05 01:25:04'),
(133, 1, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-05 16:01:04'),
(134, 1, 'NEUTRO', '#FFD700', 'body_amarelo_neutro.png', '2026-03-05 17:47:05'),
(135, 1, 'BRAVO', '#00FF00', 'body_verde_bravo.png', '2026-03-05 19:15:04'),
(136, 1, 'ASSUSTADO', '#800080', 'body_roxo_assustado.png', '2026-03-05 20:05:07'),
(137, 7, 'FELIZ', '#FFA500', 'body_laranja_feliz.png', '2026-03-05 21:52:04');

-- --------------------------------------------------------

--
-- Estrutura para tabela `foods`
--

CREATE TABLE `foods` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image_key` varchar(50) NOT NULL,
  `hunger` int(11) NOT NULL,
  `energy` int(11) NOT NULL,
  `happiness` int(11) NOT NULL,
  `temperature` int(2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `foods`
--

INSERT INTO `foods` (`id`, `name`, `image_key`, `hunger`, `energy`, `happiness`, `temperature`, `created_at`) VALUES
(13, 'Maçã', 'apple', 15, -10, 15, 0, '2026-01-10 15:33:48'),
(14, 'Pizza', 'pizza', 40, -20, 25, 2, '2026-01-10 15:54:27'),
(15, 'Bife', 'bife', 15, -25, 20, 2, '2026-01-10 15:54:27'),
(16, 'Frango', 'chicken', 25, 15, 20, 0, '2026-01-13 18:45:26');

-- --------------------------------------------------------

--
-- Estrutura para tabela `login_history`
--

CREATE TABLE `login_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_time` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `session_token`, `created_at`, `expires_at`) VALUES
(1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NjQyMDgyNiwiZXhwIjoxNzY2NTA3MjI2fQ.uhpm3XCTRx9gLEz0UMm6BsEp2QmIwK6pU9Gqy3K-hnU', '2025-12-22 16:27:06', NULL),
(2, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NjQyMTA4OSwiZXhwIjoxNzY2NTA3NDg5fQ.U5qtkfTWzXKAKyZbsw29_tQgZnNHwuqE3o7iUSCUHhY', '2025-12-22 16:31:29', NULL),
(3, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NjQyMTE4NCwiZXhwIjoxNzY2NTA3NTg0fQ.2k7sbEq8bvabfC5yjXpx9o-sGmh3YaTRdD4jqh1o67Y', '2025-12-22 16:33:04', NULL),
(4, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc0NzY2MywiZXhwIjoxNzY2ODM0MDYzfQ.U-x0_9IslIN_hXUdY6f9O5Z4faC0NhIiQTbp_0VRtJo', '2025-12-26 11:14:23', NULL),
(5, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc0OTM3MiwiZXhwIjoxNzY2ODM1NzcyfQ.DRpoVP2LWW_wcoIcf86GOzLZJDRwgmedMMNcwuY8qPo', '2025-12-26 11:42:52', NULL),
(6, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc0OTU4OCwiZXhwIjoxNzY2ODM1OTg4fQ.SSJJNEIdR5dQ9W1O6a3Tsnm1ebTg4tdVtEss1P7odp4', '2025-12-26 11:46:28', NULL),
(7, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc0OTYwMSwiZXhwIjoxNzY2ODM2MDAxfQ.Garv3EnjZs0F-TsFmU8VCZt7UNNgb-XJ7fuuC027WTY', '2025-12-26 11:46:41', NULL),
(8, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc0OTYyNCwiZXhwIjoxNzY2ODM2MDI0fQ.DCOs7JrogcCNoQRpuWRyDPLxrPQKS80ximXR8gxlOl4', '2025-12-26 11:47:04', NULL),
(9, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc0OTY1MywiZXhwIjoxNzY2ODM2MDUzfQ.jxd_kniPD961oHnpW0lpoH7P58zz7kzJq9BR4a_QgiE', '2025-12-26 11:47:33', NULL),
(10, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc0OTY4OSwiZXhwIjoxNzY2ODM2MDg5fQ.CYq5I_DdzkN30qakao-VNAfcd-Yg-X679MZhBR_xZxw', '2025-12-26 11:48:09', NULL),
(11, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc1MDAxMiwiZXhwIjoxNzY2ODM2NDEyfQ.Bq0xV1rRoi5FZYGPCk8pPHoAWft7EYZjeO_LFf8GaVs', '2025-12-26 11:53:32', NULL),
(12, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc1MDA2MywiZXhwIjoxNzY2ODM2NDYzfQ.SRUEZcOvGLBsTYzNv_w7eKc-GuKiJd3I3QAPhbnvVDU', '2025-12-26 11:54:23', NULL),
(13, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc2ODMzOCwiZXhwIjoxNzY2ODU0NzM4fQ.L5-IYXrdn8uuUZj5azd7eqv59awtyS4dBevQmgnMxSA', '2025-12-26 16:58:58', NULL),
(14, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc2ODQzNSwiZXhwIjoxNzY2ODU0ODM1fQ.utG54u2scMnAEpDUWZrP63BIWS8Tsv3HDiPzs0yRv9M', '2025-12-26 17:00:35', NULL),
(15, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njc2ODUzNiwiZXhwIjoxNzY2ODU0OTM2fQ.nZw8O70U-jJizlHqR52rRpB3mAR2KjZN4-rO_V6uUp4', '2025-12-26 17:02:16', NULL),
(16, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk2ODEzNiwiZXhwIjoxNzY3MDU0NTM2fQ.LOVa-jEJMvftGLgSglJDCnIrw1if8I2tMchmc1lWPxg', '2025-12-29 00:28:56', NULL),
(17, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk2ODE5NSwiZXhwIjoxNzY3MDU0NTk1fQ.I10KTZhIZdjFhiUIIpHj-xgScASRNkDBLt1320Bc6x8', '2025-12-29 00:29:55', NULL),
(18, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk2ODIzMywiZXhwIjoxNzY3MDU0NjMzfQ.WSjSbtVyd3xFZbs0Hf6E-x6ENmjrNI2Ex4eNAFv1exM', '2025-12-29 00:30:33', NULL),
(19, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk2ODc1NiwiZXhwIjoxNzY3MDU1MTU2fQ.p1jrAic0kFu1OlgW6meiS7FVhbYG1dn4INuJ4JQUEsA', '2025-12-29 00:39:16', NULL),
(20, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk2OTIyNCwiZXhwIjoxNzY3MDU1NjI0fQ.dfVJcAEFaWQeGV3I78Jre5j0AmKI1PZa371mlkCPkDk', '2025-12-29 00:47:04', NULL),
(21, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk2OTI3MSwiZXhwIjoxNzY3MDU1NjcxfQ.mqJZXHqlFeRpVy4CMUgiqdwaAfilfnwmvlsILgJ6XU4', '2025-12-29 00:47:51', NULL),
(22, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk2OTQwNiwiZXhwIjoxNzY3MDU1ODA2fQ.SxXTF-zcURDeXSA-MsA8MBABZr9OeOjIPiy0G7tyrpw', '2025-12-29 00:50:06', NULL),
(23, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk2OTc0MywiZXhwIjoxNzY3MDU2MTQzfQ.dZZ4fs7m4xuFn448j3d3O5wUS0-0HTQXko_G7Q8seYE', '2025-12-29 00:55:43', NULL),
(24, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk3MDIxMSwiZXhwIjoxNzY3MDU2NjExfQ.y-gaupX-bCro2k6TPcAHRg3yw7gyvDiS4dMmM_2aJJU', '2025-12-29 01:03:31', NULL),
(25, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2Njk3MDI1MywiZXhwIjoxNzY3MDU2NjUzfQ.ubgEuYT3fLrCw7AhHyxcA43XOlStATs5tPXbdNyzPR4', '2025-12-29 01:04:13', NULL),
(26, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NTQ1NSwiZXhwIjoxNzY3NjMxODU1fQ.L_5wc-Ar0zNDjKx0fD0VRqnY9YKVJBxeUisYa92smmQ', '2026-01-04 16:50:55', NULL),
(27, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NTU1NCwiZXhwIjoxNzY3NjMxOTU0fQ.dO9TA7qkCZy-evvEmiF5sbfN1JGanmv4DBXpKCM3_2Y', '2026-01-04 16:52:34', NULL),
(28, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NTY4NSwiZXhwIjoxNzY3NjMyMDg1fQ.0Yns2xVmxCRyTMrY0itl7mKSUmMfheI_diEFMuCHdT8', '2026-01-04 16:54:45', NULL),
(29, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NTkwMiwiZXhwIjoxNzY3NjMyMzAyfQ.-v4cCsc4jjWaXG5yvAuSwVlfRnVMotpIeyWudW74Mhk', '2026-01-04 16:58:22', NULL),
(30, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NjE3NSwiZXhwIjoxNzY3NjMyNTc1fQ.dv67zcG8JHHf94YphvDmGTFZilAhu4htlVCnrP9Gy4I', '2026-01-04 17:02:55', NULL),
(31, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NjM3MiwiZXhwIjoxNzY3NjMyNzcyfQ.jN_zTVlsWb-68pvTXioK42dHv-NjVmVHOGmyZTPjVMs', '2026-01-04 17:06:12', NULL),
(32, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NjQxOCwiZXhwIjoxNzY3NjMyODE4fQ.k75xY9dUjvQuiW04_InKrEvkFL778ijaTMYKAvTDF5o', '2026-01-04 17:06:58', NULL),
(33, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NjQ4NiwiZXhwIjoxNzY3NjMyODg2fQ.vVOHocMcUBjlvVGoovCUA4TnnDTlLfZzZS-Z59EIccs', '2026-01-04 17:08:06', NULL),
(34, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzU0NjYwNywiZXhwIjoxNzY3NjMzMDA3fQ.bIRRPREcnGk6R6Ho_mXZg7vYza5xALeTEU1KceDk0sk', '2026-01-04 17:10:07', NULL),
(35, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzgwMjgwOCwiZXhwIjoxNzY3ODg5MjA4fQ.KS4Rw8rHThKeD-QUd--DQUQNtyW6P6voKCNIiagbu3M', '2026-01-07 16:20:08', NULL),
(36, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzgwMzExNSwiZXhwIjoxNzY3ODg5NTE1fQ.eX-GXDAdcXV9_Xr3cjy21qyFHsEy-LTmK_1MzwDtv4c', '2026-01-07 16:25:15', NULL),
(37, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2NzgwMzIzNSwiZXhwIjoxNzY3ODg5NjM1fQ.tQJ1lVKYd2yP67e7MQB9mxEOJqPzcwDmIPQFLdUNVgA', '2026-01-07 16:27:15', NULL),
(38, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODMzMDc5NCwiZXhwIjoxNzY4NDE3MTk0fQ.BPW8BlWIySjRu2tbItd7SDe6dcTlKtqFc_vpMdWSm88', '2026-01-13 18:59:54', NULL),
(39, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODMzMTAxMSwiZXhwIjoxNzY4NDE3NDExfQ.lLNtx8f0UFDcelZ3OL8QOTe2uujtnuazDR9du4JSnc0', '2026-01-13 19:03:31', NULL),
(40, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODMzMTkwMSwiZXhwIjoxNzY4NDE4MzAxfQ.AmKw-Eh9w5CzheiFzcJWIMmjEonVZznsMWHWog3tgTs', '2026-01-13 19:18:21', NULL),
(41, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODMzMTk2NiwiZXhwIjoxNzY4NDE4MzY2fQ.Tnb3KIb3_dPH3Zxjsq6Wo-7R0W_Xu8q3fcsjLeQFkBY', '2026-01-13 19:19:26', NULL),
(42, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODMzMjY5MCwiZXhwIjoxNzY4NDE5MDkwfQ.0vmJHm9kjJpJw0rAGlchLs6dZP-Yf0S2PdyTtaEprCM', '2026-01-13 19:31:30', NULL),
(43, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODc2NTI3MywiZXhwIjoxNzY4ODUxNjczfQ.TeaU79vetqwBgsOjPVuJaJOmvYSnUGqAbH_lwvaLiaU', '2026-01-18 19:41:13', NULL),
(44, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODc2NTM0MSwiZXhwIjoxNzY4ODUxNzQxfQ._9Entq_nzzdQaHjaKCNzZMCtuhesTiiw4AsKw7MqLLI', '2026-01-18 19:42:21', NULL),
(45, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODc2NTQ4NSwiZXhwIjoxNzY4ODUxODg1fQ.10SXcbNqj84I4hkOZpRHzQzPgTfLgj_yys-zgjM2dRk', '2026-01-18 19:44:45', NULL),
(46, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODc2NTYyNCwiZXhwIjoxNzY4ODUyMDI0fQ.eqSQFvIITIMoHzzdr48t8yh56-E6NthVYKbhCmtqV_Q', '2026-01-18 19:47:04', NULL),
(47, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODc2NjE4OCwiZXhwIjoxNzY4ODUyNTg4fQ.U00sbCFL6tnNtToQceK44zsxxvq_SBEtLuA9XfwluxM', '2026-01-18 19:56:28', NULL),
(48, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODkzNjQ0MiwiZXhwIjoxNzY5MDIyODQyfQ.nywz2eYQ_maKwH_laK9JfF6wGmjUm3yAM95lITaaXUg', '2026-01-20 19:14:02', NULL),
(49, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODkzNjQ5NSwiZXhwIjoxNzY5MDIyODk1fQ.LSIrv9RhQbMKYkuSMflPrDdsETZemt-nFHWz_P55y_M', '2026-01-20 19:14:55', NULL),
(50, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2ODkzNjk4NSwiZXhwIjoxNzY5MDIzMzg1fQ.iEeXqlCcUvsLSXYR03qpPhuYU71tGaG9ctdPKeIQrKs', '2026-01-20 19:23:05', NULL),
(51, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2OTM0ODc2OCwiZXhwIjoxNzY5NDM1MTY4fQ.usoGTIoYfwORao0iepFohKhRprc-vo_fQlvK90GOGeI', '2026-01-25 13:46:08', NULL),
(52, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2OTM0ODc5OCwiZXhwIjoxNzY5NDM1MTk4fQ.s6w1OPzdd3tAD9P5sNfi7u4zXopl4XgDrXMWETE0rZI', '2026-01-25 13:46:38', NULL),
(53, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2OTM0ODk0MCwiZXhwIjoxNzY5NDM1MzQwfQ.S0q6UtddHFpqkMjjXpO9IZmlwPek-h0Sdhn_Jjuo1QE', '2026-01-25 13:49:00', NULL),
(54, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2OTUxNzQyNCwiZXhwIjoxNzY5NjAzODI0fQ.OX1OjVbWntrdtsQLTPCb1ZdSAZNnkh1OkzblT3gYOUI', '2026-01-27 12:37:04', NULL),
(55, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2OTUxNzQ3OCwiZXhwIjoxNzY5NjAzODc4fQ.0VsPO6NitcgbyzVO_6GSkfmCeQxMLCq0tPZdhBhOriE', '2026-01-27 12:37:58', NULL),
(56, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2OTUxNzg1MywiZXhwIjoxNzY5NjA0MjUzfQ.tY4HupxwKxsLh8MNO-rCGGvwTJyN50ORYRzXemqg2ms', '2026-01-27 12:44:13', NULL),
(57, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2OTUxOTczMywiZXhwIjoxNzY5NjA2MTMzfQ.aqB-FdT5leoP2Ol5vkOcrARkVfrmA0Bq7WWbbKPmhUQ', '2026-01-27 13:15:33', NULL),
(58, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc2OTUyMDE0MCwiZXhwIjoxNzY5NjA2NTQwfQ.GAEGITGBDQFZI2FEkQbPdq6a-ZualB_SqNaXhlgWXwo', '2026-01-27 13:22:20', NULL),
(59, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDU1ODQ4OSwiZXhwIjoxNzcwNjQ0ODg5fQ.JGcXUt6fGhxY2m2W6AjwMKoybmesScW1egjjkdcGO4I', '2026-02-08 13:48:09', NULL),
(60, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDU1ODY2NCwiZXhwIjoxNzcwNjQ1MDY0fQ.nkw7oscGENdV5cW8ARfBsWLl_Hy2Mp-E6ctDE42-6BQ', '2026-02-08 13:51:04', NULL),
(61, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDU1ODk1OSwiZXhwIjoxNzcwNjQ1MzU5fQ.kZdsmWdHUiMHVn3QCkpkerFDD3gg9WW6YeJe62RC40M', '2026-02-08 13:55:59', NULL),
(62, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDgxMTMxMSwiZXhwIjoxNzcwODk3NzExfQ.wSKt39-aivRcwRS5V9pOueMF-Np-p1wFko-NWe1FtxQ', '2026-02-11 12:01:51', NULL),
(63, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDgxMTM5NiwiZXhwIjoxNzcwODk3Nzk2fQ.dK42DFPPkc7QvL-BCF6z1JGLSFWxp-lW9QXMEJE6Gdk', '2026-02-11 12:03:16', NULL),
(64, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDgxMTcwMywiZXhwIjoxNzcwODk4MTAzfQ.3D4cQSIUQyToT0DfbYTks8hKyBZdA_cTk6viwYImHoc', '2026-02-11 12:08:23', NULL),
(65, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDgxMTc4OSwiZXhwIjoxNzcwODk4MTg5fQ.Aa0D1xqJsLPhAXFNgIezLMrR324SBuLg5uJOxDN_eXo', '2026-02-11 12:09:49', NULL),
(66, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDgxMjI4OSwiZXhwIjoxNzcwODk4Njg5fQ.7KyrIZoRVf14lGmGlBtUsI8D7DvRsxWlye5m4V2k6Xo', '2026-02-11 12:18:09', NULL),
(67, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDgxMzkwNywiZXhwIjoxNzcwOTAwMzA3fQ.DnLSqw6FuHydGGYOdafBPUshWu7vfXvY35zuMtFIw9c', '2026-02-11 12:45:07', NULL),
(68, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MDgxNjk4NywiZXhwIjoxNzcwOTAzMzg3fQ.J8DcCZQzPDwLDy5lb6Ed1h5HQEc163Lw5VNXabpQwYY', '2026-02-11 13:36:27', NULL),
(69, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MTE4ODQ0NywiZXhwIjoxNzcxMjc0ODQ3fQ.uS36r7vLYDbYPhLAzP0WMRKMfbxxeEtXc3_BBdYUOJU', '2026-02-15 20:47:27', NULL),
(70, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MTE5MTM5MiwiZXhwIjoxNzcxMjc3NzkyfQ.iXvSMrBvbRYkIIi6GrPPSJ8BJNpIARFn5tgGTte_0ms', '2026-02-15 21:36:32', NULL),
(71, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MTE5NjMzMywiZXhwIjoxNzcxMjgyNzMzfQ.5LUHn4y3FTLbhQnlmUAXSmqZ_jsAyDULYzviUz2QnT0', '2026-02-15 22:58:53', NULL),
(72, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MTE5ODcwNiwiZXhwIjoxNzcxMjg1MTA2fQ.Do3JZ_o4dEvRoqHPW0CEeGWZtPpcvck4lsNrG4mS0Dc', '2026-02-15 23:38:26', NULL),
(73, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MTIwMjk1MCwiZXhwIjoxNzcxMjg5MzUwfQ.XXO7jyTLhSRQCinhzLoUAuaRY-w3Avz_b5KwO0g6PHw', '2026-02-16 00:49:10', NULL),
(74, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MTM0MDY1NCwiZXhwIjoxNzcxNDI3MDU0fQ.m-FkEXNHf4TJ_dq9nUiF55W0TD8dyDT3J1TYipUUCq4', '2026-02-17 15:04:14', NULL),
(75, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MjMwMTQ3OCwiZXhwIjoxNzcyMzg3ODc4fQ.T4l9J-qonf6drW4vwas4PExETpmM7Wv22NZRBXLvCgk', '2026-02-28 17:57:58', NULL),
(76, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MjQ4MzIxMCwiZXhwIjoxNzcyNTY5NjEwfQ.BzKiK3xJzErBtRzYcmiRsUZfi-w14zsuAkdI6dfZ-H0', '2026-03-02 20:26:50', NULL),
(78, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MjQ5NTkxMiwiZXhwIjoxNzcyNTgyMzEyfQ.jhUuNIii242xRigjE2cjTtCnIGUCARsXsrtXKv1RNQ0', '2026-03-02 23:58:32', NULL),
(79, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MjU0MjY5OSwiZXhwIjoxNzcyNjI5MDk5fQ.VNBsgPFR_VLOYUKb5Ms9D7ONQ-1LiXTIFgRKrJbSbP0', '2026-03-03 12:58:19', NULL),
(83, 1, '23', '2026-03-04 14:33:14', NULL),
(84, 6, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjYsImlhdCI6MTc3MjYzNDg2NSwiZXhwIjoxNzcyNzIxMjY1fQ.rB8zRl4lIdIMY69EZkcDp5UWiEuyark6JWzv5Gqg6HQ', '2026-03-04 14:34:25', NULL),
(85, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTc3MjYzNDkwOSwiZXhwIjoxNzcyNzIxMzA5fQ.fzi8odyrtwBgdB-3KdyFLzPR2S2qrSw8qStvdZVlGIo', '2026-03-04 14:35:09', NULL),
(86, 7, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjcsImlhdCI6MTc3MjY1OTI0NCwiZXhwIjoxNzcyNzQ1NjQ0fQ.q93jfLuG6-c-WBGUY_syHiupGdoY0eZ9DIQO72GP4OQ', '2026-03-04 21:20:44', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_clothes`
--

CREATE TABLE `slivi_clothes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `temperature` int(1) NOT NULL,
  `category` enum('CHAPÉUS','ÓCULOS','CAMISAS','JAQUETAS','CALÇAS','SAPATOS') NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_clothes`
--

INSERT INTO `slivi_clothes` (`id`, `name`, `slug`, `temperature`, `category`, `created_at`) VALUES
(1, 'Jaqueta Moletom Preta', 'black_hoodie_jacket', 5, 'JAQUETAS', '2026-02-23 22:31:00'),
(2, 'Calça Moletom Preta', 'black_hoodie_simple', 5, 'CALÇAS', '2026-02-23 22:31:44'),
(3, 'Jaqueta Azul Moletom', 'blue_hoodie_jacket', 5, 'JAQUETAS', '2026-02-24 16:50:00'),
(4, 'Jaqueta Jeans', 'blue_jeans_jacket', 5, 'JAQUETAS', '2026-02-24 16:50:00'),
(5, 'Jeans Azul', 'blue_jeans_simpleV3', 3, 'CALÇAS', '2026-02-24 17:18:45'),
(6, 'Camisa Brancha', 'white_social_buttons_shirt', 3, 'CAMISAS', '2026-02-24 17:19:39');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_game_scores`
--

CREATE TABLE `slivi_game_scores` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `game` varchar(255) NOT NULL,
  `score` int(11) NOT NULL,
  `duration` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_game_scores`
--

INSERT INTO `slivi_game_scores` (`id`, `user_id`, `game`, `score`, `duration`, `created_at`) VALUES
(1, 1, 'PULSE', 8420, '47', '2026-02-20 18:19:41'),
(2, 1, 'PULSE', 8420, '47', '2026-02-20 18:21:27'),
(3, 1, 'PULSE', 8420, '47', '2026-02-20 18:27:54'),
(4, 1, 'PULSE', 8420, '47', '2026-02-20 18:37:41'),
(5, 1, 'PULSE', 8420, '47', '2026-02-20 18:39:23'),
(6, 1, 'PULSE', 8420, '47', '2026-02-20 18:41:48'),
(7, 1, 'PULSE', 3100, '42', '2026-02-20 18:48:12'),
(8, 1, 'PULSE', 2300, '35', '2026-02-20 18:48:50'),
(9, 1, 'PULSE', 1800, '31', '2026-02-20 18:52:06'),
(10, 1, 'PULSE', 4500, '31', '2026-02-20 18:52:32'),
(11, 1, 'PULSE', 3381, '86', '2026-02-20 22:55:53'),
(12, 1, 'PULSE', 3381, '86', '2026-02-20 22:55:53'),
(13, 1, 'MAESTRO', 2419, '22', '2026-02-22 23:17:00'),
(14, 1, 'MAESTRO', 2419, '22', '2026-02-22 23:18:57'),
(15, 1, 'PULSE', 2419, '22', '2026-02-22 23:19:50'),
(16, 1, 'MAESTRO', 2419, '22', '2026-02-22 23:25:47'),
(17, 1, 'MAESTRO', 1426, '34', '2026-02-23 00:20:35'),
(18, 1, 'MAESTRO', 2527, '38', '2026-02-23 00:22:46'),
(19, 1, 'MAESTRO', 1735, '28', '2026-02-23 00:25:30'),
(20, 1, 'MAESTRO', 1735, '28', '2026-02-23 00:26:13'),
(21, 1, 'MAESTRO', 1735, '28', '2026-02-23 00:32:16'),
(22, 1, 'MAESTRO', 1735, '28', '2026-02-23 00:33:47'),
(23, 1, 'MAESTRO', 1735, '28', '2026-02-23 00:34:21'),
(24, 1, 'MAESTRO', 1735, '28', '2026-02-23 00:35:12'),
(25, 1, 'MAESTRO', 360, '17', '2026-02-23 00:35:50'),
(26, 1, 'PULSE', 1190, '45', '2026-02-23 00:45:42'),
(27, 1, 'PULSE', 1190, '45', '2026-02-23 00:45:42'),
(28, 1, 'PULSE', 1706, '54', '2026-02-23 00:49:54'),
(29, 1, 'PULSE', 1706, '54', '2026-02-23 00:50:46'),
(30, 1, 'PULSE', 1706, '54', '2026-02-23 00:51:25'),
(31, 1, 'PULSE', 1706, '54', '2026-02-23 00:51:59'),
(32, 1, 'PULSE', 1706, '54', '2026-02-23 00:52:25'),
(33, 1, 'PULSE', 1906, '54', '2026-02-23 00:52:38');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_notifications`
--

CREATE TABLE `slivi_notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `message` varchar(255) NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_notifications`
--

INSERT INTO `slivi_notifications` (`id`, `user_id`, `type`, `title`, `message`, `is_read`, `created_at`) VALUES
(15, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-17 14:51:22'),
(16, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-17 14:51:23'),
(17, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-17 16:10:07'),
(18, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-17 16:52:06'),
(19, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-17 21:52:03'),
(20, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-18 04:52:03'),
(21, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-18 11:52:03'),
(22, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-18 16:06:03'),
(23, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-18 16:20:04'),
(24, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-18 21:30:04'),
(25, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-18 23:12:03'),
(26, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-19 06:12:03'),
(27, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-19 13:12:04'),
(28, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-19 20:12:04'),
(29, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-20 18:28:04'),
(30, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-20 18:49:03'),
(31, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-21 00:49:04'),
(32, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-21 06:50:05'),
(33, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-21 12:50:05'),
(34, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-21 18:51:03'),
(35, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-22 00:51:05'),
(36, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-22 06:52:04'),
(37, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-22 12:52:04'),
(38, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-22 17:02:04'),
(39, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-22 21:28:04'),
(40, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-22 23:20:04'),
(41, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 00:10:05'),
(42, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 02:11:04'),
(43, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-23 02:20:05'),
(44, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 04:12:04'),
(45, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-23 05:20:05'),
(46, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 06:12:04'),
(47, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 08:12:04'),
(48, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-23 08:20:05'),
(49, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 10:13:03'),
(50, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-23 11:20:06'),
(51, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 12:13:03'),
(52, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 15:08:03'),
(53, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-23 16:16:04'),
(54, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 17:08:03'),
(55, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-23 19:08:04'),
(56, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-24 00:54:03'),
(57, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-24 02:24:04'),
(58, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-24 03:54:06'),
(59, 1, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!', 0, '2026-02-24 04:10:06'),
(60, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-24 04:24:04'),
(61, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-24 06:25:04'),
(62, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-24 06:55:05'),
(63, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-24 08:25:04'),
(64, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-24 09:56:03'),
(65, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-24 10:25:05'),
(66, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-24 12:26:03'),
(67, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-24 12:56:03'),
(68, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-24 14:26:03'),
(69, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-24 15:56:04'),
(70, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-24 16:26:04'),
(71, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-24 22:59:03'),
(72, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 02:38:06'),
(73, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-25 02:59:04'),
(74, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 04:39:03'),
(75, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 06:39:04'),
(76, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-25 06:59:04'),
(77, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 08:40:06'),
(78, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 10:41:03'),
(79, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-25 11:00:06'),
(80, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 12:41:03'),
(81, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 14:41:03'),
(82, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-25 15:00:06'),
(83, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 16:41:03'),
(84, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-25 17:46:06'),
(85, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 18:41:06'),
(86, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-25 19:00:07'),
(87, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 20:42:04'),
(88, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-25 21:04:04'),
(89, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-25 21:47:03'),
(90, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-25 22:43:03'),
(91, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-25 23:01:04'),
(92, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 00:43:03'),
(93, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-26 01:47:04'),
(94, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-26 03:02:04'),
(95, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-26 05:15:05'),
(96, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-26 05:47:04'),
(97, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 06:18:04'),
(98, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-26 07:02:04'),
(99, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 08:19:03'),
(100, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-26 09:48:03'),
(101, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 10:19:03'),
(102, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-26 11:02:05'),
(103, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 12:19:03'),
(104, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-26 13:48:03'),
(105, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 14:19:04'),
(106, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-26 14:56:04'),
(107, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-26 15:03:06'),
(108, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 16:19:04'),
(109, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-26 17:48:03'),
(110, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 18:20:05'),
(111, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-26 19:04:05'),
(112, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 20:20:07'),
(113, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-26 20:57:03'),
(114, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-26 21:48:04'),
(115, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-26 22:21:04'),
(116, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-26 22:55:04'),
(117, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-26 23:05:05'),
(118, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-27 01:48:04'),
(119, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-27 03:06:04'),
(120, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-27 04:02:05'),
(121, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-27 05:48:04'),
(122, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 06:27:03'),
(123, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-27 07:06:04'),
(124, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 08:27:04'),
(125, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-27 09:48:04'),
(126, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-27 10:03:03'),
(127, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 10:28:04'),
(128, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-27 11:07:03'),
(129, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 12:28:04'),
(130, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-27 13:48:04'),
(131, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 14:29:03'),
(132, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-27 15:07:04'),
(133, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 16:29:04'),
(134, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-27 17:48:04'),
(135, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 18:30:06'),
(136, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-27 19:07:05'),
(137, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-27 19:12:04'),
(138, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 20:30:06'),
(139, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-27 21:48:05'),
(140, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-27 22:31:03'),
(141, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-27 23:07:05'),
(142, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 00:31:03'),
(143, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-28 01:13:04'),
(144, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-28 01:49:05'),
(145, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 02:31:03'),
(146, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-28 03:08:04'),
(147, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 04:31:04'),
(148, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-28 05:50:05'),
(149, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 06:31:05'),
(150, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-28 07:09:03'),
(151, 1, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-02-28 07:14:03'),
(152, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 08:32:03'),
(153, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-28 09:51:03'),
(154, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 10:32:03'),
(155, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-28 11:09:03'),
(156, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 12:32:04'),
(157, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-28 13:51:03'),
(158, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 14:32:04'),
(159, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-28 15:09:04'),
(160, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 16:36:19'),
(161, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-02-28 17:51:04'),
(162, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-28 17:59:03'),
(163, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-28 19:09:04'),
(164, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 19:43:03'),
(165, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 21:43:03'),
(166, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-02-28 21:56:04'),
(167, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-02-28 23:10:04'),
(168, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-02-28 23:43:03'),
(169, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-01 00:56:04'),
(170, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 01:43:04'),
(171, 1, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!', 0, '2026-03-01 02:04:06'),
(172, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-01 03:10:05'),
(173, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 03:44:04'),
(174, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-01 03:57:03'),
(175, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 05:45:05'),
(176, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-01 06:57:05'),
(177, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-01 07:10:05'),
(178, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 07:46:04'),
(179, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 09:47:03'),
(180, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-01 09:58:04'),
(181, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-01 11:11:03'),
(182, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 11:47:03'),
(183, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-01 12:58:04'),
(184, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 13:47:04'),
(185, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-01 15:11:03'),
(186, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 15:47:04'),
(187, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-01 15:58:04'),
(188, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 17:48:05'),
(189, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-01 18:58:04'),
(190, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-01 19:11:03'),
(191, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 19:49:03'),
(192, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 21:49:04'),
(193, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-01 21:59:05'),
(194, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-01 23:11:03'),
(195, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-01 23:49:04'),
(196, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-02 01:00:06'),
(197, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 01:50:06'),
(198, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-02 03:11:04'),
(199, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 03:51:03'),
(200, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-02 04:00:07'),
(201, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 05:51:03'),
(202, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-02 07:01:05'),
(203, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-02 07:12:03'),
(204, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 07:51:03'),
(205, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 09:51:04'),
(206, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-02 10:01:05'),
(207, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-02 11:12:05'),
(208, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 11:52:06'),
(209, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-02 13:02:04'),
(210, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 13:52:06'),
(211, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-02 15:13:03'),
(212, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 15:53:03'),
(213, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 17:53:03'),
(214, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-02 18:52:04'),
(215, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-02 19:13:05'),
(216, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-02 19:53:05'),
(217, 1, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!', 0, '2026-03-02 21:10:05'),
(218, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-02 23:14:04'),
(219, 2, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-02 23:50:08'),
(220, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 01:02:04'),
(221, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 03:02:04'),
(222, 1, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!', 0, '2026-03-03 03:10:05'),
(223, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-03 03:15:05'),
(224, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 05:02:04'),
(225, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 07:02:04'),
(226, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-03 07:16:06'),
(227, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 09:02:05'),
(228, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 11:02:06'),
(229, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-03 11:17:04'),
(230, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-03 15:17:04'),
(231, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 16:37:03'),
(232, 1, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!', 0, '2026-03-03 16:53:04'),
(233, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 18:37:03'),
(234, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-03 19:17:05'),
(235, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 20:37:03'),
(236, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-03 22:37:03'),
(237, 1, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!', 0, '2026-03-03 22:53:04'),
(238, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-03 23:18:04'),
(239, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 00:37:03'),
(240, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-03-04 01:17:06'),
(241, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 02:37:03'),
(242, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 03:18:04'),
(243, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 04:37:03'),
(244, 1, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!', 0, '2026-03-04 04:53:05'),
(245, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-03-04 05:18:03'),
(246, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 06:37:04'),
(247, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 07:18:04'),
(248, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 08:38:03'),
(249, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-03-04 09:18:05'),
(250, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 10:38:04'),
(251, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 11:19:04'),
(252, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 12:38:05'),
(253, 1, 'BORED', 'Que tédio... 🎾', 'O Slivi quer brincar!', 0, '2026-03-04 13:18:07'),
(254, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-04 14:26:04'),
(255, 6, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 14:35:05'),
(256, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 15:19:05'),
(257, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 17:18:05'),
(258, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-04 17:26:04'),
(259, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 17:28:05'),
(260, 6, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 18:35:05'),
(261, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-04 18:38:04'),
(262, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 19:18:05'),
(263, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 19:19:05'),
(264, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 19:28:05'),
(265, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-04 20:26:05'),
(266, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 21:19:03'),
(267, 7, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 21:21:04'),
(268, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 21:28:05'),
(269, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-04 21:38:06'),
(270, 6, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 22:35:05'),
(271, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 23:19:03'),
(272, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-04 23:20:05'),
(273, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-04 23:27:04'),
(274, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-04 23:28:06'),
(275, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 00:14:04'),
(276, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 00:39:04'),
(277, 1, 'COLD', 'Brrr! Esfriou ❄️', 'Vista o Slivi adequadamente!', 0, '2026-03-05 01:12:04'),
(278, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 01:19:03'),
(279, 7, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 01:22:07'),
(280, 7, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 01:25:04'),
(281, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 01:29:05'),
(282, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 02:14:04'),
(283, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 02:28:05'),
(284, 6, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 02:36:04'),
(285, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 03:19:03'),
(286, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 03:20:05'),
(287, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 03:30:06'),
(288, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 03:39:04'),
(289, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 04:15:09'),
(290, 7, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 04:25:09'),
(291, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 05:19:03'),
(292, 7, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 05:23:03'),
(293, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 05:29:04'),
(294, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 05:31:09'),
(295, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 06:16:03'),
(296, 6, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 06:36:04'),
(297, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 06:39:04'),
(298, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 07:19:03'),
(299, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 07:21:03'),
(300, 7, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 07:26:05'),
(301, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 07:32:04'),
(302, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 08:16:04'),
(303, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 08:30:06'),
(304, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 09:19:03'),
(305, 7, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 09:23:04'),
(306, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 09:32:04'),
(307, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 09:40:05'),
(308, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 10:16:06'),
(309, 7, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 10:27:03'),
(310, 6, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 10:36:04'),
(311, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 11:19:03'),
(312, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 11:21:06'),
(313, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 11:31:05'),
(314, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 11:32:04'),
(315, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 12:17:04'),
(316, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 12:40:07'),
(317, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 13:19:03'),
(318, 7, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 13:23:04'),
(319, 7, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 13:27:03'),
(320, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 13:33:03'),
(321, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 14:17:04'),
(322, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 14:32:04'),
(323, 6, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 14:36:04'),
(324, 6, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-03-05 15:06:04'),
(325, 7, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-03-05 15:06:05'),
(326, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 15:19:04'),
(327, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 15:22:05'),
(328, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 15:33:03'),
(329, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 15:41:03'),
(330, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 16:17:06'),
(331, 7, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 16:27:04'),
(332, 7, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 17:23:05'),
(333, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 17:33:04'),
(334, 6, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 18:36:04'),
(335, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 18:41:04'),
(336, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 18:55:06'),
(337, 1, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 19:23:05'),
(338, 7, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 19:27:05'),
(339, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 19:33:04'),
(340, 1, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 20:05:07'),
(341, 7, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 20:05:07'),
(342, 1, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 20:56:04'),
(343, 6, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-03-05 21:06:05'),
(344, 7, 'RAIN', 'Está chovendo! ☔', 'Não deixe o Slivi pegar chuva.', 0, '2026-03-05 21:06:05'),
(345, 7, 'BRAVO', 'Grrr... 🎾', 'O Slivi está ficando bravo!', 0, '2026-03-05 21:23:05'),
(346, 6, 'HUNGER_LOW', 'Estou com fome! 🍔', 'O Slivi precisa comer.', 0, '2026-03-05 21:34:03'),
(347, 6, 'ENERGY_LOW', 'Que sono... 😴', 'O Slivi está exausto.', 0, '2026-03-05 21:41:04');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_objectives_template`
--

CREATE TABLE `slivi_objectives_template` (
  `id` int(11) NOT NULL,
  `game` enum('pulse','maestro') NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `target_value` int(11) NOT NULL,
  `reward_coins` int(11) DEFAULT 0,
  `reward_clothing_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `logic_strategy` enum('single_match','cumulative') NOT NULL,
  `reset_period` enum('none','daily','weekly') DEFAULT 'none',
  `active` tinyint(1) NOT NULL,
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conditions`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_objectives_template`
--

INSERT INTO `slivi_objectives_template` (`id`, `game`, `category`, `type`, `target_value`, `reward_coins`, `reward_clothing_id`, `description`, `logic_strategy`, `reset_period`, `active`, `conditions`) VALUES
(24, 'pulse', 'score', 'score', 1000, 50, NULL, 'Faça 1.000 pontos em um voo', 'single_match', 'none', 1, NULL),
(25, 'pulse', 'score', 'score', 2500, 100, NULL, 'Faça 2.500 pontos em um voo.', 'single_match', 'daily', 1, NULL),
(26, 'pulse', 'score', 'score', 5000, 250, NULL, 'Faça 5.000 pontos em um voo.', 'single_match', 'none', 1, NULL),
(27, 'pulse', 'score', 'score', 10000, 500, NULL, 'Mestre do Ar: 10.000 pontos em um voo', 'single_match', 'none', 1, NULL),
(28, 'pulse', 'score', 'score', 5000, 100, NULL, 'Acumule 5.000 pontos hoje', 'cumulative', 'daily', 1, NULL),
(29, 'pulse', 'score', 'score', 20000, 400, NULL, 'Acumule 20.000 pontos totais', 'cumulative', 'none', 1, NULL),
(30, 'pulse', 'score', 'score', 50000, 1000, NULL, 'Lenda das Alturas: 50.000 pontos totais', 'cumulative', 'none', 1, NULL),
(31, 'pulse', 'skill', 'combo_max', 20, 60, NULL, 'Mantenha um combo por 20 segundos', 'single_match', 'none', 1, NULL),
(32, 'pulse', 'skill', 'combo_max', 50, 200, NULL, 'Mantenha um combo por 50 segundos', 'single_match', 'none', 1, NULL),
(33, 'pulse', 'score', 'score', 1500, 80, NULL, 'Supere 1.500 pontos na primeira partida do dia', 'single_match', 'daily', 1, NULL),
(34, 'pulse', 'fever', 'fever_activations', 1, 30, NULL, 'Ative o Fever Mode uma vez', 'single_match', 'none', 1, NULL),
(35, 'pulse', 'fever', 'fever_activations', 3, 100, NULL, 'Ative o Fever Mode 3 vezes no mesmo voo', 'single_match', 'none', 1, NULL),
(36, 'pulse', 'fever', 'fever_activations', 5, 250, NULL, 'Sobrecarga: 5 Fevers em um único voo', 'single_match', 'none', 1, NULL),
(37, 'pulse', 'fever', 'fever_activations', 10, 150, NULL, 'Ative o Fever Mode 10 vezes hoje', 'cumulative', 'daily', 1, NULL),
(38, 'pulse', 'fever', 'fever_boxes', 15, 50, NULL, 'Colete 15 caixas em um único Fever', 'single_match', 'none', 1, NULL),
(39, 'pulse', 'fever', 'fever_boxes', 30, 120, NULL, 'Turbulência Positiva: 30 caixas em um Fever', 'single_match', 'none', 1, NULL),
(40, 'pulse', 'fever', 'fever_total', 100, 300, NULL, 'Pulsar Constante: 100 Fevers na carreira', 'cumulative', 'none', 1, NULL),
(41, 'pulse', 'fever', 'fever_activations', 2, 70, NULL, 'Ative 2 Fevers antes dos 60s de jogo', 'single_match', 'none', 1, NULL),
(42, 'pulse', 'fever', 'fever_boxes', 50, 100, NULL, 'Colete 50 caixas dentro de Fevers hoje', 'cumulative', 'daily', 1, NULL),
(43, 'pulse', 'fever', 'fever_activations', 1, 40, NULL, 'Ative o Fever sem coletar caixas bônus', 'single_match', 'none', 1, NULL),
(44, 'pulse', 'collect', 'magnetic_boxes', 3, 50, NULL, 'Use o Ímã 3 vezes em um voo', 'single_match', 'none', 1, NULL),
(45, 'pulse', 'collect', 'magnetic_boxes', 10, 100, NULL, 'Colete 10 Ímãs hoje', 'cumulative', 'daily', 1, NULL),
(46, 'pulse', 'collect', 'ghost_boxes', 2, 60, NULL, 'Fique intangível 2 vezes em um voo', 'single_match', 'none', 1, NULL),
(47, 'pulse', 'collect', 'ghost_boxes', 5, 120, NULL, 'Use 5 Caixas Fantasmas hoje', 'cumulative', 'daily', 1, NULL),
(48, 'pulse', 'collect', 'bonus_boxes', 5, 80, NULL, 'Pegue 5 Caixas Bônus em uma corrida', 'single_match', 'none', 1, NULL),
(49, 'pulse', 'collect', 'bonus_boxes', 20, 200, NULL, 'Acumule 20 Caixas Bônus', 'cumulative', 'none', 1, NULL),
(50, 'pulse', 'collect', 'total_boxes', 50, 40, NULL, 'Colete 50 caixas positivas em um voo', 'single_match', 'none', 1, NULL),
(51, 'pulse', 'collect', 'total_boxes', 100, 100, NULL, 'Colete 100 caixas positivas em um voo', 'single_match', 'none', 1, NULL),
(52, 'pulse', 'collect', 'total_boxes', 500, 200, NULL, 'Caçador de Caixas: 500 caixas hoje', 'cumulative', 'daily', 1, NULL),
(53, 'pulse', 'collect', 'total_boxes', 5000, 1000, NULL, 'Magnata das Caixas: 5.000 no total', 'cumulative', 'none', 1, NULL),
(54, 'pulse', 'collect', 'magnetic_boxes', 50, 300, NULL, 'Mestre do Magnetismo: 50 Ímãs totais', 'cumulative', 'none', 1, NULL),
(55, 'pulse', 'collect', 'ghost_boxes', 25, 300, NULL, 'Espírito Veloz: 25 Fantasmas totais', 'cumulative', 'none', 1, NULL),
(56, 'pulse', 'collect', 'bonus_boxes', 100, 500, NULL, 'Sortudo Nato: 100 Caixas Bônus totais', 'cumulative', 'none', 1, NULL),
(57, 'pulse', 'collect', 'magnetic_boxes', 1, 20, NULL, 'Use um Ímã durante o Fever Mode', 'single_match', 'none', 1, NULL),
(58, 'pulse', 'collect', 'ghost_boxes', 1, 30, NULL, 'Use um Fantasma durante o Fever Mode', 'single_match', 'none', 1, NULL),
(59, 'pulse', 'collect', 'bonus_boxes', 2, 50, NULL, 'Pegue 2 Caixas Bônus em menos de 10s', 'single_match', 'none', 1, NULL),
(60, 'pulse', 'collect', 'total_boxes', 75, 90, NULL, 'Voo limpo: 75 caixas sem usar Ímã', 'single_match', 'none', 1, NULL),
(61, 'pulse', 'collect', 'magnetic_boxes', 5, 60, NULL, 'Colete um Ímã na primeira partida do dia', 'cumulative', 'daily', 1, NULL),
(62, 'pulse', 'collect', 'total_boxes', 1000, 400, NULL, 'Desafio Semanal: 1.000 caixas coletadas', 'cumulative', 'weekly', 1, NULL),
(63, 'pulse', 'collect', 'bonus_boxes', 10, 250, NULL, 'Desafio Semanal: 10 Caixas Bônus', 'cumulative', 'weekly', 1, NULL),
(64, 'pulse', 'time', 'duration_seconds', 60, 40, NULL, 'Voe por 60 segundos', 'single_match', 'none', 1, NULL),
(65, 'pulse', 'time', 'duration_seconds', 120, 100, NULL, 'Voe por 2 minutos', 'single_match', 'none', 1, NULL),
(66, 'pulse', 'time', 'duration_seconds', 300, 500, NULL, 'Resistência Máxima: 5 minutos no ar', 'single_match', 'none', 1, NULL),
(67, 'pulse', 'time', 'matches_played', 3, 30, NULL, 'Faça 3 voos hoje', 'cumulative', 'daily', 1, NULL),
(68, 'pulse', 'time', 'matches_played', 10, 100, NULL, 'Faça 10 voos hoje', 'cumulative', 'daily', 1, NULL),
(69, 'pulse', 'time', 'matches_played', 50, 250, NULL, 'Piloto Experiente: 50 voos totais', 'cumulative', 'none', 1, NULL),
(70, 'pulse', 'time', 'matches_played', 200, 1000, NULL, 'Ás dos Ares: 200 voos totais', 'cumulative', 'none', 1, NULL),
(71, 'pulse', 'time', 'duration_seconds', 30, 20, NULL, 'Voe 30s sem pegar nenhuma caixa', 'single_match', 'none', 1, NULL),
(72, 'pulse', 'time', 'total_duration', 3600, 600, NULL, 'Uma hora de voo acumulada', 'cumulative', 'none', 1, NULL),
(73, 'pulse', 'skill', 'perfect_streak', 50, 150, NULL, 'Pegue 50 caixas sem errar nenhuma no caminho', 'single_match', 'none', 1, NULL),
(74, 'maestro', 'score', 'score', 500, 40, NULL, 'Alcance 500 pontos no rio', 'single_match', 'none', 1, NULL),
(75, 'maestro', 'score', 'score', 1500, 100, NULL, 'Alcance 1.500 pontos no rio', 'single_match', 'none', 1, NULL),
(76, 'maestro', 'score', 'score', 3000, 200, NULL, 'Alcance 3.000 pontos no rio', 'single_match', 'none', 1, NULL),
(77, 'maestro', 'score', 'score', 7000, 600, NULL, 'Maestro Supremo: 7.000 pontos', 'single_match', 'none', 1, NULL),
(78, 'maestro', 'score', 'score', 4000, 120, NULL, 'Some 4.000 pontos hoje.', 'cumulative', 'daily', 1, NULL),
(79, 'maestro', 'score', 'score', 20000, 500, NULL, 'Navegador de Carreira: 20.000 pontos', 'cumulative', 'none', 1, NULL),
(80, 'maestro', 'score', 'score', 1000, 70, NULL, 'Faça 1.000 pontos na primeira descida do dia', 'single_match', 'daily', 1, NULL),
(81, 'maestro', 'skill', 'fast_current_collect', 5, 50, NULL, 'Pegue 5 itens na correnteza acelerada', 'single_match', 'none', 1, NULL),
(82, 'maestro', 'skill', 'fast_current_collect', 15, 150, NULL, 'Pegue 15 itens na correnteza acelerada', 'single_match', 'none', 1, NULL),
(83, 'maestro', 'skill', 'max_clean_time', 30, 60, NULL, '30 segundos sem tocar em lama ou espinho', 'single_match', 'none', 1, NULL),
(84, 'maestro', 'survival', 'storm_survivals', 1, 40, NULL, 'Sobreviva a uma tempestade', 'single_match', 'none', 1, NULL),
(85, 'maestro', 'survival', 'storm_survivals', 4, 200, NULL, 'Sobreviva a 4 tempestades em uma partida', 'single_match', 'none', 1, NULL),
(86, 'maestro', 'survival', 'storm_survivals', 20, 400, NULL, 'Capitão: 20 tempestades superadas', 'cumulative', 'none', 1, NULL),
(87, 'maestro', 'skill', 'negative_avoided', 20, 70, NULL, 'Desvie de 20 obstáculos em uma partida', 'single_match', 'none', 1, NULL),
(88, 'maestro', 'skill', 'negative_avoided', 100, 150, NULL, 'Desvie de 100 obstáculos hoje', 'cumulative', 'daily', 1, NULL),
(89, 'maestro', 'skill', 'negative_avoided', 1000, 800, NULL, 'Intocável: 1.000 desvios totais', 'cumulative', 'none', 1, NULL),
(90, 'maestro', 'skill', 'negative_hits', 0, 100, NULL, 'Navegação Perfeita: 1 min sem erros', 'single_match', 'none', 1, NULL),
(91, 'maestro', 'skill', 'mud_recoveries', 2, 50, NULL, 'Recupere-se da lama 2 vezes', 'single_match', 'none', 1, NULL),
(92, 'maestro', 'skill', 'mud_recoveries', 10, 120, NULL, 'Recupere-se da lama 10 vezes hoje', 'cumulative', 'daily', 1, NULL),
(93, 'maestro', 'survival', 'storm_items', 5, 80, NULL, 'Colete 5 itens positivos dentro da tempestade', 'single_match', 'none', 1, NULL),
(94, 'maestro', 'skill', 'spike_dodge', 10, 60, NULL, 'Passe raspando por 10 espinhos', 'single_match', 'none', 1, NULL),
(95, 'maestro', 'survival', 'fast_current_time', 40, 100, NULL, 'Fique 40s na correnteza máxima', 'single_match', 'none', 1, NULL),
(96, 'maestro', 'skill', 'clean_storm', 1, 90, NULL, 'Atravesse a tempestade sem nenhum hit', 'single_match', 'none', 1, NULL),
(97, 'maestro', 'skill', 'mud_avoid', 30, 110, NULL, 'Desvie de 30 poças de lama seguidas', 'single_match', 'none', 1, NULL),
(98, 'maestro', 'skill', 'spike_avoid', 50, 100, NULL, 'Desvie de 50 espinhos hoje', 'cumulative', 'daily', 1, NULL),
(99, 'maestro', 'collect', 'items_collected', 40, 40, NULL, 'Colete 40 itens positivos', 'single_match', 'none', 1, NULL),
(100, 'maestro', 'collect', 'items_collected', 100, 120, NULL, 'Colete 100 itens em uma descida', 'single_match', 'none', 1, NULL),
(101, 'maestro', 'collect', 'items_collected', 250, 150, NULL, 'Colete 250 itens hoje', 'cumulative', 'daily', 1, NULL),
(102, 'maestro', 'collect', 'items_collected', 5000, 1000, NULL, 'Mestre Coletor: 5.000 itens totais', 'cumulative', 'none', 1, NULL),
(103, 'maestro', 'collect', 'streak_positive', 20, 80, NULL, 'Sequência de 20 itens sem errar', 'single_match', 'none', 1, NULL),
(104, 'maestro', 'collect', 'items_collected', 50, 60, NULL, 'Colete 50 itens sem sofrer dano', 'single_match', 'none', 1, NULL),
(105, 'maestro', 'collect', 'special_items', 5, 100, NULL, 'Pegue 5 itens raros no rio', 'single_match', 'none', 1, NULL),
(106, 'maestro', 'collect', 'items_collected', 1000, 500, NULL, 'Semana Produtiva: 1.000 itens', 'cumulative', 'weekly', 1, NULL),
(107, 'maestro', 'collect', 'items_collected', 1, 20, NULL, 'Pegue um item no primeiro segundo da partida', 'single_match', 'none', 1, NULL),
(108, 'maestro', 'collect', 'items_collected', 10, 50, NULL, 'Pegue 10 itens durante a tempestade', 'single_match', 'none', 1, NULL),
(109, 'maestro', 'collect', 'items_collected', 5, 40, NULL, 'Pegue 5 itens nos cantos do rio', 'single_match', 'none', 1, NULL),
(110, 'maestro', 'collect', 'items_collected', 30, 70, NULL, 'Colete 30 itens usando apenas metade da tela', 'single_match', 'none', 1, NULL),
(111, 'maestro', 'collect', 'streak_positive', 50, 250, NULL, 'Combo Maestro: 50 itens seguidos', 'single_match', 'none', 1, NULL),
(112, 'maestro', 'collect', 'items_collected', 100, 50, NULL, 'Colete 100 itens antes das 10h da manhã', 'cumulative', 'daily', 1, NULL),
(113, 'maestro', 'collect', 'items_collected', 20, 40, NULL, 'Pegue 20 itens na correnteza lenta', 'single_match', 'none', 1, NULL),
(114, 'maestro', 'time', 'duration_seconds', 60, 45, NULL, 'Navegue por 1 minuto', 'single_match', 'none', 1, NULL),
(115, 'maestro', 'time', 'duration_seconds', 180, 150, NULL, 'Navegue por 3 minutos', 'single_match', 'none', 1, NULL),
(116, 'maestro', 'time', 'duration_seconds', 600, 800, NULL, 'Resistência Fluvial: 10 minutos', 'single_match', 'none', 1, NULL),
(117, 'maestro', 'time', 'matches_played', 5, 50, NULL, 'Navegue 5 vezes hoje', 'cumulative', 'daily', 1, NULL),
(118, 'maestro', 'time', 'matches_played', 20, 200, NULL, 'Navegue 20 vezes hoje', 'cumulative', 'daily', 1, NULL),
(119, 'maestro', 'time', 'matches_played', 100, 500, NULL, 'Velho Lobo do Rio: 100 partidas', 'cumulative', 'none', 1, NULL),
(120, 'maestro', 'time', 'total_navigation_time', 3600, 700, NULL, '1 hora total navegando sobre a folha', 'cumulative', 'none', 1, NULL),
(121, 'maestro', 'time', 'matches_played', 1, 20, NULL, 'Jogue uma partida de madrugada (00h-06h)', 'single_match', 'none', 1, NULL),
(122, 'maestro', 'time', 'duration_seconds', 45, 50, NULL, 'Fique parado no centro por 45s', 'single_match', 'none', 1, NULL),
(123, 'maestro', 'time', 'matches_played', 500, 2000, NULL, 'Imortal do Rio Slivi: 500 partidas', 'cumulative', 'none', 1, NULL),
(124, 'pulse', 'collect', 'total_boxes', 75, 0, NULL, 'Colete 75 caixas sem usar Ímã.', 'single_match', 'daily', 1, '{\"used_magnet\": false}'),
(125, 'pulse', 'collect', 'total_boxes', 40, 0, NULL, 'Colete 40 caixas.', 'cumulative', 'daily', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_questions_game`
--

CREATE TABLE `slivi_questions_game` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL COMMENT 'ID do admin ou usuário que criou a pergunta',
  `tema` varchar(100) NOT NULL COMMENT 'Ex: Astronomia, História, Cultura Pop',
  `nivel` enum('facil','medio','dificil') NOT NULL COMMENT 'Nível de dificuldade',
  `pontos` int(11) NOT NULL COMMENT 'Valor base da carta (Ex: 10, 20, 50)',
  `enunciado` text NOT NULL COMMENT 'O texto da pergunta',
  `alternativa_a` varchar(255) NOT NULL,
  `alternativa_b` varchar(255) NOT NULL,
  `alternativa_c` varchar(255) NOT NULL,
  `resposta_correta` char(1) NOT NULL COMMENT 'Armazena apenas A, B ou C',
  `status` tinyint(1) DEFAULT 1 COMMENT '1 = Ativa (vai pro jogo), 0 = Inativa',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_questions_game`
--

INSERT INTO `slivi_questions_game` (`id`, `id_user`, `tema`, `nivel`, `pontos`, `enunciado`, `alternativa_a`, `alternativa_b`, `alternativa_c`, `resposta_correta`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cultura Geral', 'facil', 10, 'Qual é a capital do Brasil?', 'Rio de Janeiro', 'Brasília', 'São Paulo', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(2, 1, 'Matemática', 'facil', 10, 'Quanto é 5 + 3?', '6', '7', '8', 'C', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(3, 1, 'Geografia', 'facil', 10, 'Qual planeta é conhecido como planeta vermelho?', 'Terra', 'Marte', 'Júpiter', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(4, 1, 'História', 'facil', 10, 'Quem descobriu o Brasil?', 'Pedro Álvares Cabral', 'Cristóvão Colombo', 'Dom Pedro I', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(5, 1, 'Tecnologia', 'facil', 10, 'O que significa a sigla Wi-Fi?', 'Wireless Fidelity', 'Wide File', 'Web Finder', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(6, 1, 'Esportes', 'facil', 10, 'Quantos jogadores há em um time de futebol?', '9', '10', '11', 'C', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(7, 1, 'Ciência', 'facil', 10, 'Qual é o estado físico da água em temperatura ambiente?', 'Sólido', 'Líquido', 'Gasoso', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(8, 1, 'Cinema', 'facil', 10, 'Qual personagem é um encanador famoso da Nintendo?', 'Sonic', 'Mario', 'Link', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(9, 1, 'Animais', 'facil', 10, 'Qual animal é conhecido como o rei da selva?', 'Leão', 'Tigre', 'Elefante', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(10, 1, 'Cultura Pop', 'facil', 10, 'Qual cor representa o Hulk?', 'Vermelho', 'Azul', 'Verde', 'C', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(11, 1, 'Geografia', 'facil', 10, 'Qual oceano é o maior do mundo?', 'Atlântico', 'Índico', 'Pacífico', 'C', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(12, 1, 'Matemática', 'facil', 10, 'Quanto é 10 x 2?', '12', '20', '30', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(13, 1, 'Tecnologia', 'facil', 10, 'Qual empresa criou o iPhone?', 'Google', 'Apple', 'Microsoft', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(14, 1, 'Ciência', 'facil', 10, 'Qual órgão bombeia o sangue?', 'Pulmão', 'Coração', 'Cérebro', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(15, 1, 'História', 'facil', 10, 'Em que século estamos?', 'Século XX', 'Século XXI', 'Século XIX', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(16, 1, 'Geografia', 'medio', 20, 'Qual país tem a maior população do mundo?', 'Estados Unidos', 'Índia', 'China', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(17, 1, 'História', 'medio', 20, 'Em que ano o homem pisou na Lua?', '1965', '1969', '1972', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(18, 1, 'Tecnologia', 'medio', 20, 'Qual linguagem é mais usada para desenvolvimento web frontend?', 'Python', 'JavaScript', 'C++', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(19, 1, 'Ciência', 'medio', 20, 'Qual gás é essencial para a respiração humana?', 'Hidrogênio', 'Oxigênio', 'Nitrogênio', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(20, 1, 'Cultura Pop', 'medio', 20, 'Qual é o nome da escola do Harry Potter?', 'Durmstrang', 'Hogwarts', 'Beauxbatons', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(21, 1, 'Matemática', 'medio', 20, 'Quanto é 12 x 8?', '86', '96', '108', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(22, 1, 'Cinema', 'medio', 20, 'Quem interpretou o Homem de Ferro no cinema?', 'Chris Evans', 'Robert Downey Jr.', 'Chris Hemsworth', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(23, 1, 'Geografia', 'medio', 20, 'Qual é o maior país da América do Sul?', 'Brasil', 'Argentina', 'Colômbia', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(24, 1, 'História', 'medio', 20, 'Quem foi o primeiro presidente do Brasil?', 'Getúlio Vargas', 'Deodoro da Fonseca', 'Dom Pedro II', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(25, 1, 'Tecnologia', 'medio', 20, 'O que significa a sigla HTML?', 'HyperText Markup Language', 'HighText Machine Language', 'HyperTool Markup Link', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(26, 1, 'Ciência', 'medio', 20, 'Quantos planetas existem no sistema solar?', '8', '9', '7', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(27, 1, 'Cultura Pop', 'medio', 20, 'Qual jogo popular envolve construir com blocos?', 'Minecraft', 'Fortnite', 'Roblox', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(28, 1, 'Esportes', 'medio', 20, 'Em que país surgiu o futebol?', 'Brasil', 'Inglaterra', 'Espanha', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(29, 1, 'Matemática', 'medio', 20, 'Qual é a raiz quadrada de 81?', '8', '9', '7', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(30, 1, 'Geografia', 'medio', 20, 'Qual é a capital da Argentina?', 'Santiago', 'Buenos Aires', 'Montevidéu', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(31, 1, 'Ciência', 'dificil', 50, 'Qual é o elemento químico de símbolo Fe?', 'Ferro', 'Flúor', 'Fósforo', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(32, 1, 'História', 'dificil', 50, 'Em que ano caiu o Muro de Berlim?', '1985', '1989', '1991', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(33, 1, 'Tecnologia', 'dificil', 50, 'Qual padrão é usado para comunicação HTTP segura?', 'SSL/TLS', 'FTP', 'SMTP', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(34, 1, 'Geografia', 'dificil', 50, 'Qual é o deserto mais seco do mundo?', 'Saara', 'Atacama', 'Gobi', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(35, 1, 'Ciência', 'dificil', 50, 'Qual partícula tem carga negativa?', 'Próton', 'Nêutron', 'Elétron', 'C', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(36, 1, 'História', 'dificil', 50, 'Quem foi o líder da Revolução Russa de 1917?', 'Stalin', 'Lênin', 'Trotsky', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(37, 1, 'Tecnologia', 'dificil', 50, 'Qual estrutura de dados funciona como LIFO?', 'Fila', 'Lista', 'Pilha', 'C', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(38, 1, 'Cultura Pop', 'dificil', 50, 'Qual estúdio criou o filme A Viagem de Chihiro?', 'Pixar', 'Ghibli', 'DreamWorks', 'B', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(39, 1, 'Matemática', 'dificil', 50, 'Quanto é 7² + 5²?', '49', '74', '78', 'C', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53'),
(40, 1, 'Geografia', 'dificil', 50, 'Qual país possui mais fusos horários?', 'Rússia', 'Estados Unidos', 'China', 'A', 1, '2026-02-25 18:59:53', '2026-02-25 18:59:53');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_seals_template`
--

CREATE TABLE `slivi_seals_template` (
  `id` int(11) NOT NULL,
  `game` enum('pulse','maestro','quiz','slivi','special') NOT NULL,
  `tier` enum('inicial','intermediario','avancado','epico','secreto') NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `target_value` int(11) NOT NULL,
  `reward_xp` int(11) DEFAULT 0,
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conditions`)),
  `active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_seals_template`
--

INSERT INTO `slivi_seals_template` (`id`, `game`, `tier`, `name`, `description`, `image_url`, `type`, `target_value`, `reward_xp`, `conditions`, `active`, `created_at`) VALUES
(1, 'pulse', 'inicial', 'Aprendiz dos Saltos', 'Aprendiz dos Saltos', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(2, 'pulse', 'inicial', 'Pé Elástico', 'Pé Elástico', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(3, 'pulse', 'inicial', 'Ritmo Rápido', 'Ritmo Rápido', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(4, 'pulse', 'inicial', 'Reflexo Vivo', 'Reflexo Vivo', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(5, 'pulse', 'inicial', 'Saltador Nato', 'Saltador Nato', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(6, 'pulse', 'intermediario', 'Domador de Obstáculos', 'Domador de Obstáculos', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(7, 'pulse', 'intermediario', 'Senhor do Timing', 'Senhor do Timing', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(8, 'pulse', 'intermediario', 'Combo Impecável', 'Combo Impecável', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(9, 'pulse', 'intermediario', 'Dançarino do Caos', 'Dançarino do Caos', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(10, 'pulse', 'intermediario', 'Mestre do Ritmo', 'Mestre do Ritmo', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(11, 'pulse', 'avancado', 'Lenda da Agilidade', 'Lenda da Agilidade', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(12, 'pulse', 'avancado', 'Imperador dos Pulos', 'Imperador dos Pulos', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(13, 'pulse', 'avancado', 'Arquitetador do Ar', 'Arquitetador do Ar', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(14, 'pulse', 'avancado', 'Sombra Veloz', 'Sombra Veloz', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(15, 'pulse', 'avancado', 'Senhor dos Milissegundos', 'Senhor dos Milissegundos', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(16, 'pulse', 'epico', 'Deus do Timing', 'Deus do Timing', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(17, 'pulse', 'epico', 'Fantasma da Plataforma', 'Fantasma da Plataforma', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(18, 'pulse', 'epico', 'Sincronizado Supremo', 'Sincronizado Supremo', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(19, 'pulse', 'epico', 'Avatar da Velocidade', 'Avatar da Velocidade', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(20, 'pulse', 'epico', 'Entidade dos Reflexos', 'Entidade dos Reflexos', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(21, 'maestro', 'inicial', 'Sobrevivente da Margem', 'Sobrevivente da Margem', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(22, 'maestro', 'inicial', 'Navegador Curioso', 'Navegador Curioso', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(23, 'maestro', 'inicial', 'Remador Iniciante', 'Remador Iniciante', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(24, 'maestro', 'inicial', 'Amigo das Águas', 'Amigo das Águas', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(25, 'maestro', 'inicial', 'Guardião da Balsa', 'Guardião da Balsa', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(26, 'maestro', 'intermediario', 'Senhor das Correntes', 'Senhor das Correntes', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(27, 'maestro', 'intermediario', 'Mestre da Precisão', 'Mestre da Precisão', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(28, 'maestro', 'intermediario', 'Estrategista Fluvial', 'Estrategista Fluvial', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(29, 'maestro', 'intermediario', 'Desbravador da Correnteza', 'Desbravador da Correnteza', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(30, 'maestro', 'intermediario', 'Olho da Tempestade', 'Olho da Tempestade', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(31, 'maestro', 'avancado', 'Domador das Águas', 'Domador das Águas', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(32, 'maestro', 'avancado', 'Rei do Fluxo', 'Rei do Fluxo', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(33, 'maestro', 'avancado', 'Capitão do Destino', 'Capitão do Destino', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(34, 'maestro', 'avancado', 'Arquimago da Correnteza', 'Arquimago da Correnteza', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(35, 'maestro', 'avancado', 'Comandante das Profundezas', 'Comandante das Profundezas', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(36, 'maestro', 'epico', 'Entidade do Rio Eterno', 'Entidade do Rio Eterno', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(37, 'maestro', 'epico', 'Lenda das Águas Selvagens', 'Lenda das Águas Selvagens', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(38, 'maestro', 'epico', 'Imperador da Correnteza', 'Imperador da Correnteza', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(39, 'maestro', 'epico', 'Espírito da Sobrevivência', 'Espírito da Sobrevivência', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(40, 'maestro', 'epico', 'Guardião do Fluxo Supremo', 'Guardião do Fluxo Supremo', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(41, 'quiz', 'inicial', 'Curioso Oficial', 'Curioso Oficial', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(42, 'quiz', 'inicial', 'Explorador de Saberes', 'Explorador de Saberes', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(43, 'quiz', 'inicial', 'Aprendiz da Verdade', 'Aprendiz da Verdade', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(44, 'quiz', 'inicial', 'Pensador Rápido', 'Pensador Rápido', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(45, 'quiz', 'inicial', 'Caçador de Respostas', 'Caçador de Respostas', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(46, 'quiz', 'intermediario', 'Estrategista Mental', 'Estrategista Mental', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(47, 'quiz', 'intermediario', 'Mestre das Alternativas', 'Mestre das Alternativas', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(48, 'quiz', 'intermediario', 'Oráculo Iniciante', 'Oráculo Iniciante', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(49, 'quiz', 'intermediario', 'Analista Ágil', 'Analista Ágil', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(50, 'quiz', 'intermediario', 'Dominador do Quiz', 'Dominador do Quiz', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(51, 'quiz', 'avancado', 'Crânio Supremo', 'Crânio Supremo', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(52, 'quiz', 'avancado', 'Sábio das Mil Perguntas', 'Sábio das Mil Perguntas', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(53, 'quiz', 'avancado', 'Arquiteto do Conhecimento', 'Arquiteto do Conhecimento', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(54, 'quiz', 'avancado', 'Senhor das Respostas', 'Senhor das Respostas', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(55, 'quiz', 'avancado', 'Mentor da Lógica', 'Mentor da Lógica', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(56, 'quiz', 'epico', 'Entidade do Saber', 'Entidade do Saber', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(57, 'quiz', 'epico', 'Consciência Coletiva', 'Consciência Coletiva', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(58, 'quiz', 'epico', 'Arquimago do Conhecimento', 'Arquimago do Conhecimento', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(59, 'quiz', 'epico', 'Guardião da Verdade', 'Guardião da Verdade', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(60, 'quiz', 'epico', 'Avatar da Inteligência', 'Avatar da Inteligência', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(61, 'slivi', 'inicial', 'Amigo do Slivi', 'Amigo do Slivi', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(62, 'slivi', 'inicial', 'Cuidador Atento', 'Cuidador Atento', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(63, 'slivi', 'inicial', 'Protetor Iniciante', 'Protetor Iniciante', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(64, 'slivi', 'inicial', 'Companheiro Presente', 'Companheiro Presente', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(65, 'slivi', 'inicial', 'Tutor Carinhoso', 'Tutor Carinhoso', NULL, 'progress', 1, 50, NULL, 1, '2026-03-05 19:51:23'),
(66, 'slivi', 'intermediario', 'Guardião da Rotina', 'Guardião da Rotina', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(67, 'slivi', 'intermediario', 'Zelador Oficial', 'Zelador Oficial', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(68, 'slivi', 'intermediario', 'Mestre da Constância', 'Mestre da Constância', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(69, 'slivi', 'intermediario', 'Amigo Fiel', 'Amigo Fiel', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(70, 'slivi', 'intermediario', 'Protetor da Energia', 'Protetor da Energia', NULL, 'progress', 1, 100, NULL, 1, '2026-03-05 19:51:23'),
(71, 'slivi', 'avancado', 'Pilar do Bem-Estar', 'Pilar do Bem-Estar', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(72, 'slivi', 'avancado', 'Guardião Vital', 'Guardião Vital', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(73, 'slivi', 'avancado', 'Anjo do Slivi', 'Anjo do Slivi', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(74, 'slivi', 'avancado', 'Mestre do Equilíbrio', 'Mestre do Equilíbrio', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(75, 'slivi', 'avancado', 'Herói da Saúde', 'Herói da Saúde', NULL, 'progress', 1, 200, NULL, 1, '2026-03-05 19:51:23'),
(76, 'slivi', 'epico', 'Lenda do Cuidado', 'Lenda do Cuidado', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(77, 'slivi', 'epico', 'Coração do Slivi', 'Coração do Slivi', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(78, 'slivi', 'epico', 'Entidade do Bem-Estar', 'Entidade do Bem-Estar', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(79, 'slivi', 'epico', 'Guardião Supremo da Vida', 'Guardião Supremo da Vida', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23'),
(80, 'slivi', 'epico', 'Alma Gêmea do Slivi', 'Alma Gêmea do Slivi', NULL, 'progress', 1, 500, NULL, 1, '2026-03-05 19:51:23');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_speeches`
--

CREATE TABLE `slivi_speeches` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phrase` text NOT NULL,
  `audio_url` varchar(255) NOT NULL,
  `is_reproduced` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_speeches`
--

INSERT INTO `slivi_speeches` (`id`, `user_id`, `phrase`, `audio_url`, `is_reproduced`, `created_at`) VALUES
(26, 1, 'Estou muito', 'src/audios/speech_1_1771430674.mp3', 0, '2026-02-18 16:04:35'),
(27, 1, 'Estou nervoso.', 'src/audios/speech_1_1771430703.mp3', 0, '2026-02-18 16:05:04'),
(28, 1, 'Estou bravo.', 'src/audios/speech_1_1771430771.mp3', 0, '2026-02-18 16:06:13'),
(29, 1, 'Estou com fome.', 'src/audios/speech_1_1771430834.mp3', 0, '2026-02-18 16:07:14'),
(30, 1, 'Sinto um vulcãozinho querendo explodir por aqui.', 'src/audios/speech_1_1771431082.mp3', 0, '2026-02-18 16:11:23'),
(31, 1, 'Tudo está em seu lugar certo.', 'src/audios/speech_1_1771431401.mp3', 0, '2026-02-18 16:16:41'),
(32, 1, 'Minha barra de fúria está cheia e pronta para explodir.', 'src/audios/speech_1_1771431508.mp3', 0, '2026-02-18 16:18:30'),
(33, 1, 'Meu medidor de irritação está no máximo!', 'src/audios/speech_1_1771431521.mp3', 0, '2026-02-18 16:18:42'),
(34, 1, 'Minha barra de humor está quebrada.', 'src/audios/speech_1_1771431533.mp3', 0, '2026-02-18 16:18:53'),
(35, 1, 'Minhas pálpebras estão pesadas, preciso de um cochilo mágico.', 'src/audios/speech_1_1771431588.mp3', 0, '2026-02-18 16:19:50'),
(36, 1, 'Meus pixels estão embaçados de sono.', 'src/audios/speech_1_1771449890.mp3', 0, '2026-02-18 21:24:50'),
(37, 1, 'Minha energia está no mínimo, preciso de um sono level up.', 'src/audios/speech_1_1771449894.mp3', 0, '2026-02-18 21:24:55'),
(38, 1, 'Minha barra de energia está no vermelho, preciso de um *checkpoint* de sono.', 'src/audios/speech_1_1771449914.mp3', 0, '2026-02-18 21:25:15'),
(39, 1, 'Minha energia flui como um rio calmo.', 'src/audios/speech_1_1771450254.mp3', 0, '2026-02-18 21:30:56'),
(40, 1, 'Cada engrenagem no meu interior funciona sem pressa.', 'src/audios/speech_1_1771450275.mp3', 0, '2026-02-18 21:31:16'),
(41, 1, 'Minha bateria está em 1%, preciso recarregar com comida.', 'src/audios/speech_1_1771450337.mp3', 0, '2026-02-18 21:32:18'),
(42, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771450346.mp3', 0, '2026-02-18 21:32:28'),
(43, 1, 'Eu comeria até as estrelas se fossem comestíveis agora.', 'src/audios/speech_1_1771450363.mp3', 0, '2026-02-18 21:32:45'),
(44, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771450383.mp3', 0, '2026-02-18 21:33:05'),
(45, 1, 'Sinto um buraco negro na barriga, pronto para engolir tudo.', 'src/audios/speech_1_1771451432.mp3', 0, '2026-02-18 21:50:33'),
(46, 1, 'Meu medidor de fome está piscando no vermelho.', 'src/audios/speech_1_1771451497.mp3', 0, '2026-02-18 21:51:39'),
(47, 1, 'Meu sistema interno está operando com tranquilidade.', 'src/audios/speech_1_1771454800.mp3', 0, '2026-02-18 22:46:42'),
(48, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771455371.mp3', 0, '2026-02-18 22:56:12'),
(49, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771455433.mp3', 0, '2026-02-18 22:57:15'),
(50, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771455510.mp3', 0, '2026-02-18 22:58:31'),
(51, 1, 'Estou como uma pedra no rio, firme e tranquilo.', 'src/audios/speech_1_1771455742.mp3', 0, '2026-02-18 23:02:23'),
(52, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771455773.mp3', 0, '2026-02-18 23:02:54'),
(53, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771455846.mp3', 0, '2026-02-18 23:04:07'),
(54, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771455917.mp3', 0, '2026-02-18 23:05:17'),
(55, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771455963.mp3', 0, '2026-02-18 23:06:04'),
(56, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456031.mp3', 0, '2026-02-18 23:07:12'),
(57, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456069.mp3', 0, '2026-02-18 23:07:49'),
(58, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456123.mp3', 0, '2026-02-18 23:08:44'),
(59, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456173.mp3', 0, '2026-02-18 23:09:34'),
(60, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456211.mp3', 0, '2026-02-18 23:10:13'),
(61, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456271.mp3', 0, '2026-02-18 23:11:12'),
(62, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456358.mp3', 0, '2026-02-18 23:12:39'),
(63, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456426.mp3', 0, '2026-02-18 23:13:47'),
(64, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456466.mp3', 0, '2026-02-18 23:14:28'),
(65, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456485.mp3', 0, '2026-02-18 23:14:46'),
(66, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456524.mp3', 0, '2026-02-18 23:15:25'),
(67, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456659.mp3', 0, '2026-02-18 23:17:40'),
(68, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456724.mp3', 0, '2026-02-18 23:18:45'),
(69, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771456759.mp3', 0, '2026-02-18 23:19:20'),
(70, 1, 'Minha barra de sono está no vermelho, quase desmaiando.', 'src/audios/speech_1_1771778769.mp3', 0, '2026-02-22 16:46:10'),
(71, 1, 'Minha barra de energia está no fim, sinto o sistema desligando.', 'src/audios/speech_1_1771778788.mp3', 0, '2026-02-22 16:46:30'),
(72, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1771977974.mp3', 0, '2026-02-25 00:06:15'),
(73, 1, 'Estou me sentindo estranho agora.', 'src/audios/speech_1_1772146722.mp3', 0, '2026-02-26 22:58:42');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_status`
--

CREATE TABLE `slivi_status` (
  `user_id` bigint(20) NOT NULL,
  `is_sleeping` tinyint(1) DEFAULT NULL,
  `started_at` timestamp NOT NULL,
  `ended_at` timestamp NOT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_status`
--

INSERT INTO `slivi_status` (`user_id`, `is_sleeping`, `started_at`, `ended_at`, `updated_at`) VALUES
(1, 0, '2026-03-03 12:55:09', '2026-03-04 14:25:42', '2026-03-04 14:25:42');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_user_equipped_clothes`
--

CREATE TABLE `slivi_user_equipped_clothes` (
  `user_id` int(11) NOT NULL,
  `category` enum('CHAPÉUS','ÓCULOS','CAMISAS','JAQUETAS','CALÇAS','SAPATOS') NOT NULL,
  `cloth_slug` varchar(255) NOT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_user_equipped_clothes`
--

INSERT INTO `slivi_user_equipped_clothes` (`user_id`, `category`, `cloth_slug`, `updated_at`) VALUES
(1, 'JAQUETAS', 'black_hoodie_jacket', '2026-03-03 11:44:59'),
(1, 'CALÇAS', 'black_hoodie_simple', '2026-03-03 11:45:02');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_user_objectives`
--

CREATE TABLE `slivi_user_objectives` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `objective_id` int(11) NOT NULL,
  `current_value` int(11) DEFAULT 0,
  `status` enum('active','completed','claimed') DEFAULT 'active',
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_reset_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_user_objectives`
--

INSERT INTO `slivi_user_objectives` (`id`, `user_id`, `objective_id`, `current_value`, `status`, `updated_at`, `last_reset_at`) VALUES
(1, 1, 25, 1906, 'active', '2026-02-23 00:52:38', '2026-02-23 00:52:38'),
(5, 1, 125, 22, 'active', '2026-02-20 18:52:32', '2026-02-20 15:52:32'),
(6, 1, 78, 2095, 'active', '2026-02-23 00:35:50', '2026-02-23 00:35:50');

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_user_seals`
--

CREATE TABLE `slivi_user_seals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seal_id` int(11) NOT NULL,
  `current_value` int(11) DEFAULT 0,
  `status` enum('active','completed','claimed') DEFAULT 'active',
  `unlocked_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `slivi_user_wardrobe`
--

CREATE TABLE `slivi_user_wardrobe` (
  `user_id` int(11) NOT NULL,
  `cloth_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `slivi_user_wardrobe`
--

INSERT INTO `slivi_user_wardrobe` (`user_id`, `cloth_id`, `created_at`) VALUES
(1, 1, '2026-02-23 23:10:01'),
(1, 2, '2026-02-23 23:10:01'),
(1, 4, '2026-02-24 16:50:29'),
(1, 5, '2026-02-24 17:19:06'),
(1, 6, '2026-02-24 17:19:50');

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `slivi_name` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `coins` char(255) NOT NULL,
  `experience` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 1,
  `device_token` text NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `username`, `slivi_name`, `password_hash`, `email`, `coins`, `experience`, `level`, `device_token`, `active`, `created_at`) VALUES
(1, 'WillCunha', 'Mr.Will', '$2y$10$TpPmYU5mVpma9Uk2wbOVNOVDQIA548kk2JO0fT60TH2zGcg/w0cVu', 'teste@teste.com', '', 0, 1, 'ExponentPushToken[KqWG8pCQVHaSB-aRf2dsEl]', 1, '2025-12-16 13:42:21'),
(6, 'ElMrWill', 'ElMrWill', '$2y$10$gJ0YzGQn14x8uO3B9SFDa.d0dSd.0F9qZ.Xke74jVUvjzMnzhotdq', 'willian@hotmail.com', '', 0, 1, 'ExponentPushToken[KqWG8pCQVHaSB-aRf2dsEl]', 1, '2026-03-04 14:34:25'),
(7, 'OWill', 'Will', '$2y$10$LCZagfv2QEpsa8.Dy4WbNOXdFlYtdTQxQSD7GCkWFFMZPyMP.Dyzy', 'williancunha@gmail.com', '', 0, 1, 'ExponentPushToken[KqWG8pCQVHaSB-aRf2dsEl]', 1, '2026-03-04 21:20:44');

-- --------------------------------------------------------

--
-- Estrutura para tabela `user_locations`
--

CREATE TABLE `user_locations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `user_locations`
--

INSERT INTO `user_locations` (`id`, `user_id`, `latitude`, `longitude`, `created_at`) VALUES
(1, 1, 12.58000000, 38.30000000, '2026-01-20 18:46:36'),
(2, 1, -12.58000000, -38.30000000, '2026-01-20 18:49:26'),
(3, 1, -22.43000000, -46.95000000, '2026-01-20 18:50:51'),
(4, 1, -12.96912840, -38.51176180, '2026-01-20 19:14:08'),
(5, 1, -12.96781410, -38.51077660, '2026-01-20 19:14:58'),
(6, 1, -12.96912840, -38.51176180, '2026-01-20 19:16:45'),
(7, 1, -12.96912840, -38.51176180, '2026-01-20 19:16:53'),
(8, 1, -12.96912840, -38.51176180, '2026-01-20 19:17:00'),
(9, 1, -12.96912840, -38.51176180, '2026-01-20 19:17:00'),
(10, 1, -12.96912840, -38.51176180, '2026-01-20 19:17:07'),
(11, 1, -12.96912840, -38.51176180, '2026-01-20 19:17:07'),
(12, 1, -12.96912840, -38.51176180, '2026-01-20 19:17:15'),
(13, 1, -12.96912840, -38.51176180, '2026-01-20 19:17:31'),
(14, 1, -12.96912840, -38.51176180, '2026-01-20 19:17:43'),
(15, 1, -12.96912840, -38.51176180, '2026-01-20 19:18:00'),
(16, 1, -12.96912840, -38.51176180, '2026-01-20 19:18:22'),
(17, 1, -12.96912840, -38.51176180, '2026-01-20 19:18:31'),
(18, 1, -12.96891730, -38.51317360, '2026-01-20 19:23:06'),
(19, 1, -12.96891730, -38.51317360, '2026-01-20 19:23:36'),
(20, 1, -12.96891730, -38.51317360, '2026-01-20 19:24:06'),
(21, 1, -12.96891730, -38.51317360, '2026-01-20 19:24:06'),
(22, 1, -12.96891730, -38.51317360, '2026-01-20 19:24:06'),
(23, 1, -12.96891730, -38.51317360, '2026-01-20 19:24:06'),
(24, 1, -12.96891730, -38.51317360, '2026-01-20 19:24:07'),
(25, 1, -12.96891730, -38.51317360, '2026-01-20 19:24:36'),
(26, 1, -12.96891730, -38.51317360, '2026-01-20 19:25:06'),
(27, 1, -12.96891730, -38.51317360, '2026-01-20 19:25:06'),
(28, 1, -12.96891730, -38.51317360, '2026-01-20 19:25:36'),
(29, 1, -12.96891730, -38.51317360, '2026-01-20 19:25:36'),
(30, 1, -12.96891730, -38.51317360, '2026-01-20 19:25:36'),
(31, 1, -12.96891730, -38.51317360, '2026-01-20 19:25:37'),
(32, 1, -12.96912840, -38.51176180, '2026-01-20 19:26:05'),
(33, 1, -12.96912840, -38.51176180, '2026-01-20 19:26:05'),
(34, 1, -12.96912840, -38.51176180, '2026-01-20 19:26:05'),
(35, 1, -12.96902470, -38.51296590, '2026-01-20 19:26:44'),
(36, 1, -12.96902470, -38.51296590, '2026-01-20 19:26:44'),
(37, 1, -12.96902470, -38.51296590, '2026-01-20 19:26:45'),
(38, 1, -12.96902470, -38.51296590, '2026-01-20 19:27:14'),
(39, 1, -12.96902470, -38.51296590, '2026-01-20 19:27:14'),
(40, 1, -12.96902470, -38.51296590, '2026-01-20 19:27:14'),
(41, 1, -12.96902470, -38.51296590, '2026-01-20 19:27:52'),
(42, 1, -12.96902470, -38.51296590, '2026-01-20 19:28:22'),
(43, 1, -12.96902470, -38.51296590, '2026-01-20 19:28:22'),
(44, 1, -12.96902470, -38.51296590, '2026-01-20 19:28:52'),
(45, 1, -12.96902470, -38.51296590, '2026-01-20 19:28:52'),
(46, 1, -12.96902470, -38.51296590, '2026-01-20 19:28:52'),
(47, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:22'),
(48, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:22'),
(49, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:22'),
(50, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:22'),
(51, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:22'),
(52, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:22'),
(53, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:52'),
(54, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:52'),
(55, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:52'),
(56, 1, -12.96902470, -38.51296590, '2026-01-20 19:29:52'),
(57, 1, -12.96902470, -38.51296590, '2026-01-20 19:30:22'),
(58, 1, -12.96902470, -38.51296590, '2026-01-20 19:30:22'),
(59, 1, -12.96902470, -38.51296590, '2026-01-20 19:30:52'),
(60, 1, -12.96902470, -38.51296590, '2026-01-20 19:30:52'),
(61, 1, -12.96902470, -38.51296590, '2026-01-20 19:30:52'),
(62, 1, -12.96902470, -38.51296590, '2026-01-20 19:30:52'),
(63, 1, -12.96902470, -38.51296590, '2026-01-20 19:31:22'),
(64, 1, -12.96902470, -38.51296590, '2026-01-20 19:31:22'),
(65, 1, -12.96902470, -38.51296590, '2026-01-20 19:31:23'),
(66, 1, -12.96902470, -38.51296590, '2026-01-20 19:31:52'),
(67, 1, -12.96902470, -38.51296590, '2026-01-20 19:31:52'),
(68, 1, -12.96902470, -38.51296590, '2026-01-20 19:31:52'),
(69, 1, -23.57000000, -46.19000000, '2026-01-24 10:04:48'),
(70, 1, -23.57000000, -46.19000000, '2026-01-24 10:05:21'),
(71, 1, -22.74373600, -41.89131730, '2026-01-25 13:46:09'),
(72, 1, -22.74348600, -41.89128240, '2026-01-25 13:46:39'),
(73, 1, -22.74349220, -41.89125640, '2026-01-25 13:49:01'),
(74, 1, -12.96878990, -38.51292680, '2026-01-27 12:37:05'),
(75, 1, -12.96878990, -38.51292680, '2026-01-27 12:37:58'),
(76, 1, -12.96902720, -38.51297670, '2026-01-27 12:44:13'),
(77, 1, -12.97108700, -38.51335150, '2026-01-27 13:15:35'),
(78, 1, -12.97108700, -38.51335150, '2026-01-27 13:16:18'),
(79, 1, -12.97108700, -38.51335150, '2026-01-27 13:18:55'),
(80, 1, -12.97108700, -38.51335150, '2026-01-27 13:19:25'),
(81, 1, -12.97108700, -38.51335150, '2026-01-27 13:19:25'),
(82, 1, -12.97108700, -38.51335150, '2026-01-27 13:19:25'),
(83, 1, -12.97108700, -38.51335150, '2026-01-27 13:19:25'),
(84, 1, -12.97108700, -38.51335150, '2026-01-27 13:19:25'),
(85, 1, -12.97108700, -38.51335150, '2026-01-27 13:19:55'),
(86, 1, -12.97108700, -38.51335150, '2026-01-27 13:19:55'),
(87, 1, -12.97108700, -38.51335150, '2026-01-27 13:20:25'),
(88, 1, -12.97108700, -38.51335150, '2026-01-27 13:20:55'),
(89, 1, -12.97108700, -38.51335150, '2026-01-27 13:20:55'),
(90, 1, -12.97108700, -38.51335150, '2026-01-27 13:21:25'),
(91, 1, -12.97108700, -38.51335150, '2026-01-27 13:21:25'),
(92, 1, -12.97108700, -38.51335150, '2026-01-27 13:21:25'),
(93, 1, -12.97108700, -38.51335150, '2026-01-27 13:21:25'),
(94, 1, -12.97108700, -38.51335150, '2026-01-27 13:22:20'),
(95, 1, -12.97108700, -38.51335150, '2026-01-27 13:23:01'),
(96, 1, -12.97108700, -38.51335150, '2026-01-27 13:23:47'),
(97, 1, -12.97108700, -38.51335150, '2026-01-27 13:28:38'),
(98, 1, -22.74542450, -41.89243110, '2026-02-08 13:48:10'),
(99, 1, -22.74542450, -41.89243110, '2026-02-08 13:48:44'),
(100, 1, -22.74542450, -41.89243110, '2026-02-08 13:51:04'),
(101, 1, -22.74542450, -41.89243110, '2026-02-08 13:53:05'),
(102, 1, -22.74542450, -41.89243110, '2026-02-08 13:56:20'),
(103, 1, -9.67696690, -35.75518920, '2026-02-11 12:01:55'),
(104, 1, -9.67696690, -35.75518920, '2026-02-11 12:02:43'),
(105, 1, -9.68157790, -35.72997540, '2026-02-11 12:03:19'),
(106, 1, -9.68308060, -35.72504700, '2026-02-11 12:08:27'),
(107, 1, -9.68310850, -35.72488540, '2026-02-11 12:09:49'),
(108, 1, -9.68310850, -35.72488540, '2026-02-11 12:10:29'),
(109, 1, -9.68322420, -35.72500650, '2026-02-11 12:18:31'),
(110, 1, -23.57000000, -46.19000000, '2026-02-11 12:32:16'),
(111, 1, -9.68322420, -35.72500650, '2026-02-11 12:33:09'),
(112, 1, -9.68327700, -35.72502370, '2026-02-11 12:45:08'),
(113, 1, -9.68322650, -35.72494630, '2026-02-11 12:50:52'),
(114, 1, -9.68322420, -35.72500650, '2026-02-11 12:51:17'),
(115, 1, -9.68326720, -35.72489790, '2026-02-11 13:12:06'),
(116, 1, -9.68326720, -35.72489790, '2026-02-11 13:12:51'),
(117, 1, -9.68298580, -35.72503680, '2026-02-11 13:13:55'),
(118, 1, -9.68293570, -35.72497240, '2026-02-11 13:33:12'),
(119, 1, -9.68331500, -35.72504360, '2026-02-11 13:36:30'),
(120, 1, -9.66789550, -35.72789090, '2026-02-11 13:39:16'),
(121, 1, -22.42536500, -46.93992580, '2026-02-15 21:36:33'),
(122, 1, -22.42536500, -46.93992580, '2026-02-15 21:36:33'),
(123, 1, -22.42536500, -46.93992580, '2026-02-15 21:37:03'),
(124, 1, -22.42536500, -46.93992580, '2026-02-15 21:37:03'),
(125, 1, -22.42536500, -46.93992580, '2026-02-15 21:37:48'),
(126, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(127, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(128, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(129, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(130, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(131, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(132, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(133, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(134, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(135, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(136, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(137, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(138, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(139, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(140, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(141, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(142, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(143, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(144, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(145, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(146, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(147, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(148, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(149, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(150, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(151, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(152, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(153, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(154, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(155, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(156, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(157, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:18'),
(158, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(159, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(160, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(161, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(162, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(163, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(164, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(165, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(166, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(167, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(168, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(169, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(170, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(171, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(172, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:19'),
(173, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(174, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(175, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(176, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(177, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(178, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(179, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(180, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(181, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(182, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(183, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(184, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(185, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(186, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(187, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(188, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(189, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:20'),
(190, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:21'),
(191, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:21'),
(192, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:21'),
(193, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:21'),
(194, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:21'),
(195, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:21'),
(196, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:21'),
(197, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(198, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(199, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(200, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(201, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(202, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(203, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(204, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(205, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(206, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(207, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(208, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(209, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(210, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(211, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(212, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(213, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(214, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(215, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(216, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(217, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(218, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(219, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(220, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(221, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(222, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(223, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(224, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(225, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(226, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(227, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(228, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(229, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(230, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(231, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(232, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(233, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(234, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(235, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(236, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(237, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(238, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(239, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(240, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(241, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(242, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(243, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(244, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:48'),
(245, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(246, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(247, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(248, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(249, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(250, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(251, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(252, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(253, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(254, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(255, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(256, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(257, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(258, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(259, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(260, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(261, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(262, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(263, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(264, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(265, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(266, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(267, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(268, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(269, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(270, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(271, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(272, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(273, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(274, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(275, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(276, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(277, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(278, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(279, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(280, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(281, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(282, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(283, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(284, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(285, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(286, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(287, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(288, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(289, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(290, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(291, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(292, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(293, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(294, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(295, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(296, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(297, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(298, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(299, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(300, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(301, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(302, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(303, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(304, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(305, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(306, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(307, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(308, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(309, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(310, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(311, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(312, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(313, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(314, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(315, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(316, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(317, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(318, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(319, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(320, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(321, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(322, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(323, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(324, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(325, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(326, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(327, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(328, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(329, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(330, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(331, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(332, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(333, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(334, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(335, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(336, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(337, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(338, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(339, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(340, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(341, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(342, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(343, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(344, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(345, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(346, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(347, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(348, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(349, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(350, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(351, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(352, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(353, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(354, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(355, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(356, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(357, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(358, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(359, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(360, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(361, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(362, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(363, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:49'),
(364, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(365, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(366, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(367, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(368, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(369, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(370, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(371, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(372, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(373, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(374, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(375, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(376, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(377, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(378, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(379, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(380, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(381, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(382, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(383, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(384, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(385, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(386, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(387, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(388, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(389, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(390, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(391, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(392, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(393, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(394, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(395, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(396, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(397, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(398, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(399, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(400, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(401, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(402, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(403, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(404, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(405, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(406, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(407, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(408, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(409, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(410, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(411, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(412, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(413, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(414, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(415, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(416, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(417, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(418, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(419, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(420, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(421, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(422, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(423, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(424, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(425, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(426, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(427, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(428, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(429, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(430, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(431, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(432, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(433, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(434, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(435, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(436, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(437, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(438, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(439, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(440, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(441, 1, -22.42536500, -46.93992580, '2026-02-15 21:38:50'),
(442, 1, -22.42536500, -46.93992580, '2026-02-15 21:39:18'),
(443, 1, -22.42536500, -46.93992580, '2026-02-15 21:39:48'),
(444, 1, -22.42536500, -46.93992580, '2026-02-15 21:40:18'),
(445, 1, -22.42536500, -46.93992580, '2026-02-15 21:40:48'),
(446, 1, -22.42536500, -46.93992580, '2026-02-15 21:40:48'),
(447, 1, -22.42536500, -46.93992580, '2026-02-15 21:40:48'),
(448, 1, -22.42536500, -46.93992580, '2026-02-15 21:40:48'),
(449, 1, -22.42536500, -46.93992580, '2026-02-15 21:42:14'),
(450, 1, -22.42536500, -46.93992580, '2026-02-15 21:42:44'),
(451, 1, -22.42536500, -46.93992580, '2026-02-15 21:42:44'),
(452, 1, -22.42536500, -46.93992580, '2026-02-15 21:42:45'),
(453, 1, -22.42536500, -46.93992580, '2026-02-15 21:43:57'),
(454, 1, -22.42536500, -46.93992580, '2026-02-15 21:44:27'),
(455, 1, -22.42536500, -46.93992580, '2026-02-15 21:45:25'),
(456, 1, -22.42536500, -46.93992580, '2026-02-15 21:45:59'),
(457, 1, -22.42536500, -46.93992580, '2026-02-15 21:46:29'),
(458, 1, -22.42536500, -46.93992580, '2026-02-15 21:48:00'),
(459, 1, -22.42536500, -46.93992580, '2026-02-15 21:48:35'),
(460, 1, -22.42536500, -46.93992580, '2026-02-15 21:49:05'),
(461, 1, -22.42536500, -46.93992580, '2026-02-15 21:49:05'),
(462, 1, -22.42536500, -46.93992580, '2026-02-15 21:49:35'),
(463, 1, -22.42536500, -46.93992580, '2026-02-15 21:50:05'),
(464, 1, -22.42536500, -46.93992580, '2026-02-15 21:50:37'),
(465, 1, -22.42536500, -46.93992580, '2026-02-15 21:51:07'),
(466, 1, -22.42536500, -46.93992580, '2026-02-15 21:51:07'),
(467, 1, -22.42536500, -46.93992580, '2026-02-15 21:51:07'),
(468, 1, -22.42536500, -46.93992580, '2026-02-15 21:51:37'),
(469, 1, -22.42536500, -46.93992580, '2026-02-15 21:51:37'),
(470, 1, -22.42536500, -46.93992580, '2026-02-15 21:51:37'),
(471, 1, -22.42536500, -46.93992580, '2026-02-15 21:52:07'),
(472, 1, -22.42536500, -46.93992580, '2026-02-15 21:52:07'),
(473, 1, -22.42536500, -46.93992580, '2026-02-15 21:52:07'),
(474, 1, -22.42536500, -46.93992580, '2026-02-15 21:53:10'),
(475, 1, -22.42536500, -46.93992580, '2026-02-15 21:53:40'),
(476, 1, -22.42536500, -46.93992580, '2026-02-15 21:53:40'),
(477, 1, -22.42536500, -46.93992580, '2026-02-15 21:53:40'),
(478, 1, -22.42536500, -46.93992580, '2026-02-15 21:54:10'),
(479, 1, -22.42536500, -46.93992580, '2026-02-15 21:54:10'),
(480, 1, -22.42536500, -46.93992580, '2026-02-15 21:54:10'),
(481, 1, -22.42536500, -46.93992580, '2026-02-15 21:57:33'),
(482, 1, -22.42536500, -46.93992580, '2026-02-15 21:59:05'),
(483, 1, -22.42536500, -46.93992580, '2026-02-15 21:59:33'),
(484, 1, -22.42536500, -46.93992580, '2026-02-15 22:00:03'),
(485, 1, -22.42536500, -46.93992580, '2026-02-15 22:00:33'),
(486, 1, -22.42536500, -46.93992580, '2026-02-15 22:00:33'),
(487, 1, -22.42536500, -46.93992580, '2026-02-15 22:01:03'),
(488, 1, -22.42536500, -46.93992580, '2026-02-15 22:01:04'),
(489, 1, -22.42536500, -46.93992580, '2026-02-15 22:01:42'),
(490, 1, -22.42536500, -46.93992580, '2026-02-15 22:01:42'),
(491, 1, -22.42536500, -46.93992580, '2026-02-15 22:02:12'),
(492, 1, -22.42536500, -46.93992580, '2026-02-15 22:02:12'),
(493, 1, -22.42536500, -46.93992580, '2026-02-15 22:02:42'),
(494, 1, -22.42536500, -46.93992580, '2026-02-15 22:02:42'),
(495, 1, -22.42536500, -46.93992580, '2026-02-15 22:03:48'),
(496, 1, -22.42536500, -46.93992580, '2026-02-15 22:03:48'),
(497, 1, -22.42533750, -46.93998150, '2026-02-15 22:10:56'),
(498, 1, -22.42533750, -46.93998150, '2026-02-15 22:10:56'),
(499, 1, -22.42533750, -46.93998150, '2026-02-15 22:11:29'),
(500, 1, -22.42533750, -46.93998150, '2026-02-15 22:11:29'),
(501, 1, -22.42533750, -46.93998150, '2026-02-15 22:11:59'),
(502, 1, -22.42533750, -46.93998150, '2026-02-15 22:11:59'),
(503, 1, -22.42533750, -46.93998150, '2026-02-15 22:12:29'),
(504, 1, -22.42533750, -46.93998150, '2026-02-15 22:12:29'),
(505, 1, -22.42533750, -46.93998150, '2026-02-15 22:16:18'),
(506, 1, -22.42533750, -46.93998150, '2026-02-15 22:16:19'),
(507, 1, -22.42533750, -46.93998150, '2026-02-15 22:16:48'),
(508, 1, -22.42533750, -46.93998150, '2026-02-15 22:17:18'),
(509, 1, -22.42533750, -46.93998150, '2026-02-15 22:17:18'),
(510, 1, -22.42533750, -46.93998150, '2026-02-15 22:17:48'),
(511, 1, -22.42533750, -46.93998150, '2026-02-15 22:20:52'),
(512, 1, -22.42533750, -46.93998150, '2026-02-15 22:20:52'),
(513, 1, -22.42533750, -46.93998150, '2026-02-15 22:21:28'),
(514, 1, -22.42533750, -46.93998150, '2026-02-15 22:21:28'),
(515, 1, -22.42533750, -46.93998150, '2026-02-15 22:21:58'),
(516, 1, -22.42533750, -46.93998150, '2026-02-15 22:22:39'),
(517, 1, -22.42533750, -46.93998150, '2026-02-15 22:22:39'),
(518, 1, -22.42534690, -46.93983130, '2026-02-15 22:26:40'),
(519, 1, -22.42534690, -46.93983130, '2026-02-15 22:27:10'),
(520, 1, -22.42534690, -46.93983130, '2026-02-15 22:27:40'),
(521, 1, -22.42534690, -46.93983130, '2026-02-15 22:27:40'),
(522, 1, -22.42534690, -46.93983130, '2026-02-15 22:27:43'),
(523, 1, -22.42534690, -46.93983130, '2026-02-15 22:28:10'),
(524, 1, -22.42534690, -46.93983130, '2026-02-15 22:28:11'),
(525, 1, -22.42534690, -46.93983130, '2026-02-15 22:28:46'),
(526, 1, -22.42534690, -46.93983130, '2026-02-15 22:59:14'),
(527, 1, -22.42534690, -46.93983130, '2026-02-15 22:59:14'),
(528, 1, -22.42533120, -46.93996410, '2026-02-15 23:01:06'),
(529, 1, -22.42533120, -46.93996410, '2026-02-15 23:01:07'),
(530, 1, -22.42533120, -46.93996410, '2026-02-15 23:01:36'),
(531, 1, -22.42533120, -46.93996410, '2026-02-15 23:01:36'),
(532, 1, -22.42533120, -46.93996410, '2026-02-15 23:04:28'),
(533, 1, -22.42533120, -46.93996410, '2026-02-15 23:04:28'),
(534, 1, -22.42533120, -46.93996410, '2026-02-15 23:05:06'),
(535, 1, -22.42535990, -46.93993860, '2026-02-15 23:05:50'),
(536, 1, -22.42533250, -46.93996080, '2026-02-15 23:06:34'),
(537, 1, -22.42533250, -46.93996080, '2026-02-15 23:06:34'),
(538, 1, -22.42533280, -46.93980370, '2026-02-15 23:38:44'),
(539, 1, -22.42533280, -46.93980370, '2026-02-15 23:38:45'),
(540, 1, -22.42533280, -46.93980370, '2026-02-15 23:39:33'),
(541, 1, -22.42533310, -46.93996520, '2026-02-16 00:49:10'),
(542, 1, -22.42533310, -46.93996520, '2026-02-16 00:49:11'),
(543, 1, -22.42533310, -46.93996520, '2026-02-16 00:50:11'),
(544, 1, -22.42533310, -46.93996520, '2026-02-16 00:50:11'),
(545, 1, -22.42533310, -46.93996520, '2026-02-16 00:52:21'),
(546, 1, -22.42533310, -46.93996520, '2026-02-16 00:52:21'),
(547, 1, -22.42533310, -46.93996520, '2026-02-16 01:06:04'),
(548, 1, -22.42533310, -46.93996520, '2026-02-16 01:06:05'),
(549, 1, -22.42533310, -46.93996520, '2026-02-16 01:11:25'),
(550, 1, -22.42535690, -46.93994890, '2026-02-16 21:38:51'),
(551, 1, -22.42535690, -46.93994890, '2026-02-16 21:38:51'),
(552, 1, -22.42535690, -46.93994890, '2026-02-16 21:39:20'),
(553, 1, -22.42535690, -46.93994890, '2026-02-16 21:39:21'),
(554, 1, -22.42535690, -46.93994890, '2026-02-16 21:54:05'),
(555, 1, -22.42535690, -46.93994890, '2026-02-16 21:54:05'),
(556, 1, -22.42535690, -46.93994890, '2026-02-16 21:57:01'),
(557, 1, -22.42535690, -46.93994890, '2026-02-16 21:57:01'),
(558, 1, -22.42889870, -46.93361930, '2026-02-16 22:18:00'),
(559, 1, -22.42889870, -46.93361930, '2026-02-16 22:18:30'),
(560, 1, -22.42889870, -46.93361930, '2026-02-16 22:18:30'),
(561, 1, -22.42889870, -46.93361930, '2026-02-16 22:24:07'),
(562, 1, -22.42889870, -46.93361930, '2026-02-16 22:24:08'),
(563, 1, -22.42889870, -46.93361930, '2026-02-16 22:27:34'),
(564, 1, -22.42889870, -46.93361930, '2026-02-16 22:28:01'),
(565, 1, -22.42889870, -46.93361930, '2026-02-16 22:28:01'),
(566, 1, -22.42889870, -46.93361930, '2026-02-16 22:28:01'),
(567, 1, -22.42889870, -46.93361930, '2026-02-16 22:29:33'),
(568, 1, -22.42889870, -46.93361930, '2026-02-16 22:36:42'),
(569, 1, -22.42889870, -46.93361930, '2026-02-16 22:36:43'),
(570, 1, -22.42889870, -46.93361930, '2026-02-16 22:40:36'),
(571, 1, -22.42889870, -46.93361930, '2026-02-16 22:41:06'),
(572, 1, -22.42889870, -46.93361930, '2026-02-16 22:41:06'),
(573, 1, -22.42889870, -46.93361930, '2026-02-16 22:41:36'),
(574, 1, -22.42889870, -46.93361930, '2026-02-16 22:41:36'),
(575, 1, -22.42889870, -46.93361930, '2026-02-16 22:41:36'),
(576, 1, -22.42889870, -46.93361930, '2026-02-16 22:42:06'),
(577, 1, -22.42889870, -46.93361930, '2026-02-16 22:42:36'),
(578, 1, -22.42889870, -46.93361930, '2026-02-16 22:43:06'),
(579, 1, -22.42889870, -46.93361930, '2026-02-16 22:43:36'),
(580, 1, -22.42889870, -46.93361930, '2026-02-16 22:43:36'),
(581, 1, -22.42889870, -46.93361930, '2026-02-16 22:49:26'),
(582, 1, -22.42889870, -46.93361930, '2026-02-16 22:49:57'),
(583, 1, -22.42889870, -46.93361930, '2026-02-16 22:49:57'),
(584, 1, -22.42889870, -46.93361930, '2026-02-16 22:50:26'),
(585, 1, -22.42889870, -46.93361930, '2026-02-16 22:50:27'),
(586, 1, -22.42889870, -46.93361930, '2026-02-16 22:50:57'),
(587, 1, -22.42889870, -46.93361930, '2026-02-16 22:50:57'),
(588, 1, -22.42889870, -46.93361930, '2026-02-16 22:51:27'),
(589, 1, -22.42889870, -46.93361930, '2026-02-16 22:51:27'),
(590, 1, -22.42889870, -46.93361930, '2026-02-16 22:52:04'),
(591, 1, -22.42889870, -46.93361930, '2026-02-16 22:52:34'),
(592, 1, -22.42889870, -46.93361930, '2026-02-16 22:52:34'),
(593, 1, -22.42889870, -46.93361930, '2026-02-16 22:53:04'),
(594, 1, -22.42889870, -46.93361930, '2026-02-16 22:53:34'),
(595, 1, -22.42889870, -46.93361930, '2026-02-16 22:54:08'),
(596, 1, -22.42889870, -46.93361930, '2026-02-16 22:54:38'),
(597, 1, -22.42889870, -46.93361930, '2026-02-16 22:54:38'),
(598, 1, -22.42889870, -46.93361930, '2026-02-16 22:55:08'),
(599, 1, -22.42889870, -46.93361930, '2026-02-16 22:55:08'),
(600, 1, -22.42889870, -46.93361930, '2026-02-16 22:55:08'),
(601, 1, -22.42889870, -46.93361930, '2026-02-16 22:55:08'),
(602, 1, -22.42889870, -46.93361930, '2026-02-16 22:55:38'),
(603, 1, -22.42889870, -46.93361930, '2026-02-16 22:55:38'),
(604, 1, -22.42889870, -46.93361930, '2026-02-16 22:57:41'),
(605, 1, -22.42889870, -46.93361930, '2026-02-16 22:57:41'),
(606, 1, -22.42533790, -46.93996040, '2026-02-17 15:03:08'),
(607, 1, -22.42533790, -46.93996040, '2026-02-17 15:03:09'),
(608, 1, -22.42533790, -46.93996040, '2026-02-17 15:04:26'),
(609, 1, -22.42533790, -46.93996040, '2026-02-17 15:04:28'),
(610, 1, -22.42533790, -46.93996040, '2026-02-17 15:07:50'),
(611, 1, -22.42533790, -46.93996040, '2026-02-17 15:07:50'),
(612, 1, -22.42533790, -46.93996040, '2026-02-17 15:08:20'),
(613, 1, -22.42533790, -46.93996040, '2026-02-17 15:08:20'),
(614, 1, -22.42533790, -46.93996040, '2026-02-17 15:09:42'),
(615, 1, -22.42533790, -46.93996040, '2026-02-17 15:09:42'),
(616, 1, -22.42535670, -46.93988140, '2026-02-17 20:44:16'),
(617, 1, -22.42535670, -46.93988140, '2026-02-17 20:44:16'),
(618, 1, -22.42535670, -46.93988140, '2026-02-17 20:49:16'),
(619, 1, -22.42535670, -46.93988140, '2026-02-17 20:50:17'),
(620, 1, -22.42535670, -46.93988140, '2026-02-17 20:50:17'),
(621, 1, -22.42535670, -46.93988140, '2026-02-17 20:52:51'),
(622, 1, -22.42535670, -46.93988140, '2026-02-17 20:52:52'),
(623, 1, -22.42535670, -46.93988140, '2026-02-17 20:57:33'),
(624, 1, -22.42535670, -46.93988140, '2026-02-17 20:57:33'),
(625, 1, -22.42535670, -46.93988140, '2026-02-17 20:58:39'),
(626, 1, -22.42535670, -46.93988140, '2026-02-17 21:03:18'),
(627, 1, -22.42533420, -46.93995980, '2026-02-18 21:24:09'),
(628, 1, -22.42533420, -46.93995980, '2026-02-18 21:24:10'),
(629, 1, -22.42533810, -46.93997180, '2026-02-18 21:24:36'),
(630, 1, -22.42533810, -46.93997180, '2026-02-18 21:24:36'),
(631, 1, -22.42532980, -46.93994920, '2026-02-18 21:26:54'),
(632, 1, -22.42533240, -46.93994020, '2026-02-18 21:27:52'),
(633, 1, -22.42533240, -46.93994020, '2026-02-18 21:28:21'),
(634, 1, -22.42533240, -46.93994020, '2026-02-18 21:28:51'),
(635, 1, -22.42533240, -46.93994020, '2026-02-18 21:34:11'),
(636, 1, -22.42533240, -46.93994020, '2026-02-18 21:34:12'),
(637, 1, -22.42532300, -46.93990280, '2026-02-18 21:49:57'),
(638, 1, -22.42532300, -46.93990280, '2026-02-18 21:49:59'),
(639, 1, -22.42532300, -46.93990280, '2026-02-18 22:42:18'),
(640, 1, -22.42532300, -46.93990280, '2026-02-18 22:42:19'),
(641, 1, -22.42532300, -46.93990280, '2026-02-18 22:45:44'),
(642, 1, -22.42532300, -46.93990280, '2026-02-18 22:45:44'),
(643, 1, -22.42532300, -46.93990280, '2026-02-18 22:46:35'),
(644, 1, -22.42532300, -46.93990280, '2026-02-18 22:47:06'),
(645, 1, -22.42532300, -46.93990280, '2026-02-18 22:47:06'),
(646, 1, -22.42532300, -46.93990280, '2026-02-18 22:55:05'),
(647, 1, -22.42532300, -46.93990280, '2026-02-18 22:55:06'),
(648, 1, -22.42532300, -46.93990280, '2026-02-18 22:56:17'),
(649, 1, -22.42532300, -46.93990280, '2026-02-18 22:56:17'),
(650, 1, -22.42532300, -46.93990280, '2026-02-18 22:57:24'),
(651, 1, -22.42532300, -46.93990280, '2026-02-18 22:57:54'),
(652, 1, -22.42532300, -46.93990280, '2026-02-18 22:59:30'),
(653, 1, -22.42532300, -46.93990280, '2026-02-18 22:59:31'),
(654, 1, -22.42532300, -46.93990280, '2026-02-18 23:00:00'),
(655, 1, -22.42532300, -46.93990280, '2026-02-18 23:00:02'),
(656, 1, -22.42532300, -46.93990280, '2026-02-18 23:00:30'),
(657, 1, -22.42532300, -46.93990280, '2026-02-18 23:00:31'),
(658, 1, -22.42532300, -46.93990280, '2026-02-18 23:00:31'),
(659, 1, -22.42532300, -46.93990280, '2026-02-18 23:00:31'),
(660, 1, -22.42532300, -46.93990280, '2026-02-18 23:00:31'),
(661, 1, -22.42532300, -46.93990280, '2026-02-18 23:01:00'),
(662, 1, -22.42532300, -46.93990280, '2026-02-18 23:01:31'),
(663, 1, -22.42532300, -46.93990280, '2026-02-18 23:01:31'),
(664, 1, -22.42532300, -46.93990280, '2026-02-18 23:04:22'),
(665, 1, -22.42532300, -46.93990280, '2026-02-18 23:04:53'),
(666, 1, -22.42532300, -46.93990280, '2026-02-18 23:11:27'),
(667, 1, -22.42532300, -46.93990280, '2026-02-18 23:11:27'),
(668, 1, -22.42532300, -46.93990280, '2026-02-18 23:11:57'),
(669, 1, -22.42532300, -46.93990280, '2026-02-18 23:11:57'),
(670, 1, -22.42532300, -46.93990280, '2026-02-18 23:16:55'),
(671, 1, -22.42532300, -46.93990280, '2026-02-18 23:16:56'),
(672, 1, -22.42532300, -46.93990280, '2026-02-18 23:19:32'),
(673, 1, -22.42532300, -46.93990280, '2026-02-18 23:28:32'),
(674, 1, -22.42532300, -46.93990280, '2026-02-18 23:28:33'),
(675, 1, -22.42532300, -46.93990280, '2026-02-18 23:29:15'),
(676, 1, -22.42532300, -46.93990280, '2026-02-18 23:29:45'),
(677, 1, -22.42533240, -46.93998450, '2026-02-19 21:26:07'),
(678, 1, -22.42533240, -46.93998450, '2026-02-19 21:26:08'),
(679, 1, -22.42533240, -46.93998450, '2026-02-19 21:26:37'),
(680, 1, -22.42533240, -46.93998450, '2026-02-19 21:26:37'),
(681, 1, -22.42533240, -46.93998450, '2026-02-19 21:27:07'),
(682, 1, -22.42533240, -46.93998450, '2026-02-19 21:28:07'),
(683, 1, -22.42533240, -46.93998450, '2026-02-19 21:28:07'),
(684, 1, -22.42533240, -46.93998450, '2026-02-19 21:28:37'),
(685, 1, -22.42534310, -46.93970190, '2026-02-19 21:30:42'),
(686, 1, -22.42534310, -46.93970190, '2026-02-19 21:30:42'),
(687, 1, -22.42534310, -46.93970190, '2026-02-19 21:33:37'),
(688, 1, -22.42534310, -46.93970190, '2026-02-19 21:34:33'),
(689, 1, -22.42534310, -46.93970190, '2026-02-19 21:34:34'),
(690, 1, -22.42534310, -46.93970190, '2026-02-19 21:35:32'),
(691, 1, -22.42534310, -46.93970190, '2026-02-19 21:36:07'),
(692, 1, -22.42534310, -46.93970190, '2026-02-19 21:36:07'),
(693, 1, -22.42534310, -46.93970190, '2026-02-19 21:38:56'),
(694, 1, -22.42534310, -46.93970190, '2026-02-19 21:51:09'),
(695, 1, -22.42534310, -46.93970190, '2026-02-19 21:51:09'),
(696, 1, -22.42534310, -46.93970190, '2026-02-19 21:52:36'),
(697, 1, -22.42534310, -46.93970190, '2026-02-19 22:20:51'),
(698, 1, -22.42534310, -46.93970190, '2026-02-19 22:20:52'),
(699, 1, -22.42534200, -46.93996390, '2026-02-19 22:30:05'),
(700, 1, -22.42534200, -46.93996390, '2026-02-19 22:30:06'),
(701, 1, -22.42534200, -46.93996390, '2026-02-19 22:34:57'),
(702, 1, -22.42534200, -46.93996390, '2026-02-19 22:42:15'),
(703, 1, -22.42534200, -46.93996390, '2026-02-19 22:42:15'),
(704, 1, -22.42534040, -46.93982660, '2026-02-20 22:28:10'),
(705, 1, -22.42534040, -46.93982660, '2026-02-20 22:28:10'),
(706, 1, -22.42534040, -46.93982660, '2026-02-20 22:28:43'),
(707, 1, -22.42534040, -46.93982660, '2026-02-20 22:29:33'),
(708, 1, -22.42534040, -46.93982660, '2026-02-20 22:30:03'),
(709, 1, -22.42534040, -46.93982660, '2026-02-20 22:30:03'),
(710, 1, -22.42534040, -46.93982660, '2026-02-20 22:33:28'),
(711, 1, -22.42534040, -46.93982660, '2026-02-20 22:33:29'),
(712, 1, -22.42534040, -46.93982660, '2026-02-20 22:37:18'),
(713, 1, -22.42534040, -46.93982660, '2026-02-20 22:37:19'),
(714, 1, -22.42534040, -46.93982660, '2026-02-20 22:38:19'),
(715, 1, -22.42534040, -46.93982660, '2026-02-20 22:38:19'),
(716, 1, -22.42534040, -46.93982660, '2026-02-20 22:44:19'),
(717, 1, -22.42534040, -46.93982660, '2026-02-20 22:44:19'),
(718, 1, -22.42534040, -46.93982660, '2026-02-20 22:47:46'),
(719, 1, -22.42534040, -46.93982660, '2026-02-20 22:48:32'),
(720, 1, -22.42534040, -46.93982660, '2026-02-20 22:48:33'),
(721, 1, -22.42534040, -46.93982660, '2026-02-20 22:51:36'),
(722, 1, -22.42534040, -46.93982660, '2026-02-20 22:52:56'),
(723, 1, -22.42534040, -46.93982660, '2026-02-20 22:53:26'),
(724, 1, -22.42534040, -46.93982660, '2026-02-20 22:53:26'),
(725, 1, -22.42534040, -46.93982660, '2026-02-20 22:55:52'),
(726, 1, -22.42534100, -46.93998050, '2026-02-21 22:47:08'),
(727, 1, -22.42534100, -46.93998050, '2026-02-21 22:47:09'),
(728, 1, -22.42534100, -46.93998050, '2026-02-21 22:53:18'),
(729, 1, -22.42534100, -46.93998050, '2026-02-21 22:53:18'),
(730, 1, -22.42534100, -46.93998050, '2026-02-21 22:55:26'),
(731, 1, -22.42534100, -46.93998050, '2026-02-21 22:55:27'),
(732, 1, -22.42530320, -46.93989260, '2026-02-22 01:41:49'),
(733, 1, -22.42530320, -46.93989260, '2026-02-22 01:41:50'),
(734, 1, -22.42530320, -46.93989260, '2026-02-22 01:43:04'),
(735, 1, -22.42530320, -46.93989260, '2026-02-22 01:43:05'),
(736, 1, -22.42530320, -46.93989260, '2026-02-22 01:49:03'),
(737, 1, -22.42530320, -46.93989260, '2026-02-22 01:49:04'),
(738, 1, -22.42533700, -46.93994660, '2026-02-22 02:45:47'),
(739, 1, -22.42533700, -46.93994660, '2026-02-22 02:45:47'),
(740, 1, -22.42533700, -46.93994660, '2026-02-22 02:48:38'),
(741, 1, -22.42533700, -46.93994660, '2026-02-22 02:49:41'),
(742, 1, -22.42533700, -46.93994660, '2026-02-22 03:03:18'),
(743, 1, -22.42533700, -46.93994660, '2026-02-22 03:03:18'),
(744, 1, -22.42537320, -46.93991350, '2026-02-22 14:49:23'),
(745, 1, -22.42537320, -46.93991350, '2026-02-22 14:49:23'),
(746, 1, -22.42537320, -46.93991350, '2026-02-22 14:51:18'),
(747, 1, -22.42537320, -46.93991350, '2026-02-22 14:51:18'),
(748, 1, -22.42535070, -46.93992170, '2026-02-22 15:18:09'),
(749, 1, -22.42535070, -46.93992170, '2026-02-22 15:18:10'),
(750, 1, -22.42535070, -46.93992170, '2026-02-22 15:19:51'),
(751, 1, -22.42535070, -46.93992170, '2026-02-22 15:19:51'),
(752, 1, -22.42535070, -46.93992170, '2026-02-22 15:26:33'),
(753, 1, -22.42535070, -46.93992170, '2026-02-22 15:26:34'),
(754, 1, -22.42535070, -46.93992170, '2026-02-22 15:27:19'),
(755, 1, -22.42535070, -46.93992170, '2026-02-22 15:27:19'),
(756, 1, -22.42532400, -46.93986630, '2026-02-22 16:30:32'),
(757, 1, -22.42532400, -46.93986630, '2026-02-22 16:30:32'),
(758, 1, -22.42532400, -46.93986630, '2026-02-22 16:31:08'),
(759, 1, -22.42532400, -46.93986630, '2026-02-22 16:39:37'),
(760, 1, -22.42532400, -46.93986630, '2026-02-22 16:39:38'),
(761, 1, -22.42532400, -46.93986630, '2026-02-22 16:41:31'),
(762, 1, -22.42532400, -46.93986630, '2026-02-22 16:42:47'),
(763, 1, -22.42532400, -46.93986630, '2026-02-22 16:44:19'),
(764, 1, -22.42532400, -46.93986630, '2026-02-22 16:45:50'),
(765, 1, -22.42532400, -46.93986630, '2026-02-22 16:47:18'),
(766, 1, -22.42532400, -46.93986630, '2026-02-22 16:48:44'),
(767, 1, -22.42532400, -46.93986630, '2026-02-22 16:48:45'),
(768, 1, -22.42532400, -46.93986630, '2026-02-22 16:49:19'),
(769, 1, -22.42532400, -46.93986630, '2026-02-22 16:49:49'),
(770, 1, -22.42532400, -46.93986630, '2026-02-22 16:49:49'),
(771, 1, -22.42540860, -46.93981500, '2026-02-22 22:49:01'),
(772, 1, -22.42540860, -46.93981500, '2026-02-22 22:49:02'),
(773, 1, -22.42540860, -46.93981500, '2026-02-22 22:49:31'),
(774, 1, -22.42540860, -46.93981500, '2026-02-22 22:49:31'),
(775, 1, -22.42540860, -46.93981500, '2026-02-22 22:51:14'),
(776, 1, -22.42540860, -46.93981500, '2026-02-22 22:51:44'),
(777, 1, -22.42540860, -46.93981500, '2026-02-22 22:57:44'),
(778, 1, -22.42540860, -46.93981500, '2026-02-22 22:57:45'),
(779, 1, -22.42540860, -46.93981500, '2026-02-22 22:59:57'),
(780, 1, -22.42540860, -46.93981500, '2026-02-22 23:00:27'),
(781, 1, -22.42540860, -46.93981500, '2026-02-22 23:07:29'),
(782, 1, -22.42540860, -46.93981500, '2026-02-22 23:11:43'),
(783, 1, -22.42540860, -46.93981500, '2026-02-22 23:11:44'),
(784, 1, -22.42540860, -46.93981500, '2026-02-22 23:13:10'),
(785, 1, -22.42540860, -46.93981500, '2026-02-22 23:16:32'),
(786, 1, -22.42540860, -46.93981500, '2026-02-22 23:16:33'),
(787, 1, -22.42538580, -46.93986690, '2026-02-23 00:19:49'),
(788, 1, -22.42538580, -46.93986690, '2026-02-23 00:19:50'),
(789, 1, -22.42538580, -46.93986690, '2026-02-23 00:21:54'),
(790, 1, -22.42538580, -46.93986690, '2026-02-23 00:41:26'),
(791, 1, -22.42538580, -46.93986690, '2026-02-23 00:41:27'),
(792, 1, -22.42538580, -46.93986690, '2026-02-23 00:41:56'),
(793, 1, -22.42538580, -46.93986690, '2026-02-23 00:42:26'),
(794, 1, -22.42538580, -46.93986690, '2026-02-23 00:44:53'),
(795, 1, -22.42538580, -46.93986690, '2026-02-23 00:48:47'),
(796, 1, -22.42538580, -46.93986690, '2026-02-23 00:48:48'),
(797, 1, -22.42543110, -46.93977880, '2026-02-23 23:23:01'),
(798, 1, -22.42543110, -46.93977880, '2026-02-23 23:23:02'),
(799, 1, -22.42543110, -46.93977880, '2026-02-23 23:27:59'),
(800, 1, -22.42543110, -46.93977880, '2026-02-23 23:28:29'),
(801, 1, -22.42543110, -46.93977880, '2026-02-23 23:30:05'),
(802, 1, -22.42543110, -46.93977880, '2026-02-23 23:30:36'),
(803, 1, -22.42543110, -46.93977880, '2026-02-23 23:31:06'),
(804, 1, -22.42543110, -46.93977880, '2026-02-23 23:31:37'),
(805, 1, -22.42543110, -46.93977880, '2026-02-23 23:32:07'),
(806, 1, -22.42543110, -46.93977880, '2026-02-23 23:32:43'),
(807, 1, -22.42543110, -46.93977880, '2026-02-23 23:33:13'),
(808, 1, -22.42543110, -46.93977880, '2026-02-23 23:33:13'),
(809, 1, -22.42543110, -46.93977880, '2026-02-23 23:33:43'),
(810, 1, -22.42543110, -46.93977880, '2026-02-23 23:33:43'),
(811, 1, -22.42543110, -46.93977880, '2026-02-23 23:33:43'),
(812, 1, -22.42543110, -46.93977880, '2026-02-23 23:34:13'),
(813, 1, -22.42543110, -46.93977880, '2026-02-23 23:38:05'),
(814, 1, -22.42543110, -46.93977880, '2026-02-23 23:43:42'),
(815, 1, -22.42543110, -46.93977880, '2026-02-23 23:43:42'),
(816, 1, -22.42543110, -46.93977880, '2026-02-23 23:44:12'),
(817, 1, -22.42543110, -46.93977880, '2026-02-23 23:44:12'),
(818, 1, -22.42533280, -46.93996610, '2026-02-24 17:11:22'),
(819, 1, -22.42533280, -46.93996610, '2026-02-24 17:11:23'),
(820, 1, -22.42533280, -46.93996610, '2026-02-24 17:20:50'),
(821, 1, -22.42533280, -46.93996610, '2026-02-24 17:24:57'),
(822, 1, -22.42533280, -46.93996610, '2026-02-24 17:24:58'),
(823, 1, -22.42533280, -46.93996610, '2026-02-24 17:30:04'),
(824, 1, -22.42533280, -46.93996610, '2026-02-24 17:30:05'),
(825, 1, -22.42535790, -46.93992930, '2026-02-24 22:11:39'),
(826, 1, -22.42535790, -46.93992930, '2026-02-24 22:11:39'),
(827, 1, -22.42535790, -46.93992930, '2026-02-24 22:12:42'),
(828, 1, -22.42535790, -46.93992930, '2026-02-24 22:19:16'),
(829, 1, -22.42535790, -46.93992930, '2026-02-24 22:19:17'),
(830, 1, -22.42535790, -46.93992930, '2026-02-24 22:20:08'),
(831, 1, -22.42540700, -46.93980250, '2026-02-24 22:57:04'),
(832, 1, -22.42540700, -46.93980250, '2026-02-24 22:57:04'),
(833, 1, -22.42533410, -46.93998340, '2026-02-24 23:58:12'),
(834, 1, -22.42533410, -46.93998340, '2026-02-24 23:58:13'),
(835, 1, -22.42533410, -46.93998340, '2026-02-25 00:09:04'),
(836, 1, -22.42533410, -46.93998340, '2026-02-25 00:09:04'),
(837, 1, -22.42533410, -46.93998340, '2026-02-25 00:10:46'),
(838, 1, -22.42533410, -46.93998340, '2026-02-25 00:12:29'),
(839, 1, -22.42533410, -46.93998340, '2026-02-25 00:12:59'),
(840, 1, -22.42533410, -46.93998340, '2026-02-25 00:15:08'),
(841, 1, -22.42537400, -46.93979040, '2026-02-26 00:52:54'),
(842, 1, -22.42537400, -46.93979040, '2026-02-26 00:52:55'),
(843, 1, -22.42537400, -46.93979040, '2026-02-26 00:53:26'),
(844, 1, -22.42537400, -46.93979040, '2026-02-26 00:53:26'),
(845, 1, -22.42537400, -46.93979040, '2026-02-26 00:54:06'),
(846, 1, -22.42537400, -46.93979040, '2026-02-26 00:54:48'),
(847, 1, -22.42537400, -46.93979040, '2026-02-26 00:55:41'),
(848, 1, -22.42537400, -46.93979040, '2026-02-26 00:56:10');
INSERT INTO `user_locations` (`id`, `user_id`, `latitude`, `longitude`, `created_at`) VALUES
(849, 1, -22.42537400, -46.93979040, '2026-02-26 00:56:10'),
(850, 1, -22.42537400, -46.93979040, '2026-02-26 00:56:40'),
(851, 1, -22.42537400, -46.93979040, '2026-02-26 00:57:10'),
(852, 1, -22.42537400, -46.93979040, '2026-02-26 00:57:10'),
(853, 1, -22.42537400, -46.93979040, '2026-02-26 00:57:40'),
(854, 1, -22.42537400, -46.93979040, '2026-02-26 00:58:10'),
(855, 1, -22.42537400, -46.93979040, '2026-02-26 00:58:10'),
(856, 1, -22.42537400, -46.93979040, '2026-02-26 00:59:21'),
(857, 1, -22.42537400, -46.93979040, '2026-02-26 00:59:57'),
(858, 1, -22.42537400, -46.93979040, '2026-02-26 01:00:27'),
(859, 1, -22.42537400, -46.93979040, '2026-02-26 01:00:27'),
(860, 1, -22.42537400, -46.93979040, '2026-02-26 01:01:04'),
(861, 1, -22.42537400, -46.93979040, '2026-02-26 01:01:34'),
(862, 1, -22.42537400, -46.93979040, '2026-02-26 01:02:26'),
(863, 1, -22.42537400, -46.93979040, '2026-02-26 01:02:26'),
(864, 1, -22.42537400, -46.93979040, '2026-02-26 01:02:56'),
(865, 1, -22.42537400, -46.93979040, '2026-02-26 01:02:56'),
(866, 1, -22.42545240, -46.93980870, '2026-02-26 22:54:46'),
(867, 1, -22.42545240, -46.93980870, '2026-02-26 22:54:46'),
(868, 1, -22.42545240, -46.93980870, '2026-02-26 22:55:36'),
(869, 1, -22.42545240, -46.93980870, '2026-02-26 22:55:37'),
(870, 1, -22.42545240, -46.93980870, '2026-02-26 22:59:26'),
(871, 1, -22.42545240, -46.93980870, '2026-02-26 23:01:33'),
(872, 1, -22.42545240, -46.93980870, '2026-02-26 23:04:32'),
(873, 1, -22.42545240, -46.93980870, '2026-02-26 23:05:02'),
(874, 1, -22.42545240, -46.93980870, '2026-02-26 23:05:02'),
(875, 1, -22.42545240, -46.93980870, '2026-02-26 23:06:29'),
(876, 1, -22.42545240, -46.93980870, '2026-02-26 23:06:29'),
(877, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(878, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(879, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(880, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(881, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(882, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(883, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(884, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(885, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(886, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(887, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(888, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(889, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(890, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(891, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(892, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(893, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(894, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(895, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(896, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(897, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(898, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(899, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(900, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(901, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(902, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(903, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(904, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(905, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(906, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(907, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(908, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(909, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(910, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(911, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(912, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(913, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(914, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(915, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(916, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(917, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(918, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(919, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(920, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(921, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(922, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(923, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(924, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(925, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(926, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(927, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(928, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(929, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(930, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(931, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(932, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(933, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(934, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(935, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(936, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(937, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(938, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(939, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(940, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(941, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(942, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(943, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(944, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(945, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(946, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(947, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(948, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(949, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(950, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(951, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(952, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(953, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(954, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(955, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(956, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(957, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(958, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(959, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:23'),
(960, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:24'),
(961, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:24'),
(962, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:24'),
(963, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:24'),
(964, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:25'),
(965, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:25'),
(966, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:25'),
(967, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(968, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(969, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(970, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(971, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(972, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(973, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(974, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(975, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(976, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(977, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(978, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(979, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(980, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(981, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(982, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(983, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(984, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(985, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(986, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(987, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(988, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:53'),
(989, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:54'),
(990, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:54'),
(991, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:54'),
(992, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:55'),
(993, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:55'),
(994, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:55'),
(995, 1, -22.42530910, -46.93974540, '2026-02-28 16:36:56'),
(996, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:09'),
(997, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:09'),
(998, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:09'),
(999, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:10'),
(1000, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:10'),
(1001, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:10'),
(1002, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:11'),
(1003, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:11'),
(1004, 1, -22.42530910, -46.93974540, '2026-02-28 16:38:11'),
(1005, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:12'),
(1006, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:12'),
(1007, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:12'),
(1008, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:12'),
(1009, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:13'),
(1010, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:13'),
(1011, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:13'),
(1012, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:13'),
(1013, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:14'),
(1014, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:14'),
(1015, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:14'),
(1016, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1017, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1018, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1019, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1020, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1021, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1022, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1023, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1024, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1025, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1026, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1027, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1028, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1029, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1030, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1031, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1032, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1033, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1034, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1035, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1036, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1037, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1038, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1039, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1040, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1041, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1042, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1043, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1044, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1045, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1046, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1047, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1048, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1049, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1050, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1051, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1052, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1053, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1054, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1055, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1056, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1057, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1058, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1059, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1060, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1061, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1062, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1063, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1064, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1065, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1066, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1067, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1068, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1069, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1070, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1071, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1072, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1073, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1074, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1075, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1076, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1077, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1078, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1079, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1080, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1081, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1082, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1083, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1084, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1085, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1086, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1087, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1088, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1089, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1090, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1091, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1092, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1093, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1094, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1095, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1096, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1097, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1098, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1099, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1100, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1101, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1102, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1103, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1104, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1105, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1106, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:42'),
(1107, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:43'),
(1108, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:43'),
(1109, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:43'),
(1110, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:43'),
(1111, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:44'),
(1112, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:44'),
(1113, 1, -22.42530910, -46.93974540, '2026-02-28 16:40:44'),
(1114, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1115, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1116, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1117, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1118, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1119, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1120, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1121, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1122, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1123, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1124, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1125, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1126, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1127, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1128, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1129, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1130, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1131, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:12'),
(1132, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:13'),
(1133, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:13'),
(1134, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:13'),
(1135, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:14'),
(1136, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:14'),
(1137, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:14'),
(1138, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1139, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1140, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1141, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1142, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1143, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1144, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1145, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1146, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1147, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1148, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1149, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1150, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1151, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1152, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1153, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1154, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1155, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1156, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1157, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1158, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1159, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1160, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1161, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1162, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1163, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1164, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1165, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1166, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1167, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1168, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1169, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1170, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1171, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1172, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1173, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1174, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1175, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1176, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1177, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1178, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1179, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1180, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1181, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1182, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1183, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1184, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1185, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1186, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1187, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1188, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1189, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1190, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1191, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1192, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1193, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1194, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1195, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1196, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1197, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1198, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1199, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1200, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1201, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1202, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1203, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1204, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1205, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1206, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1207, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1208, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1209, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1210, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1211, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1212, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1213, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1214, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1215, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1216, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1217, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1218, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1219, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1220, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1221, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1222, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:42'),
(1223, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:43'),
(1224, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:43'),
(1225, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:43'),
(1226, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:44'),
(1227, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:44'),
(1228, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:44'),
(1229, 1, -22.42530910, -46.93974540, '2026-02-28 16:41:45'),
(1230, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:53'),
(1231, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:53'),
(1232, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:54'),
(1233, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:54'),
(1234, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:54'),
(1235, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:55'),
(1236, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:55'),
(1237, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:55'),
(1238, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:56'),
(1239, 1, -22.42530910, -46.93974540, '2026-02-28 16:46:56'),
(1240, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1241, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1242, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1243, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1244, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1245, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1246, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1247, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1248, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1249, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1250, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1251, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1252, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1253, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1254, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1255, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1256, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1257, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1258, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1259, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1260, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1261, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1262, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:23'),
(1263, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:24'),
(1264, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:24'),
(1265, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:25'),
(1266, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:25'),
(1267, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:25'),
(1268, 1, -22.42530910, -46.93974540, '2026-02-28 16:47:26'),
(1269, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:53'),
(1270, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1271, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1272, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1273, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1274, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1275, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1276, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1277, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1278, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1279, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1280, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1281, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1282, 1, -22.42532130, -46.93991040, '2026-02-28 17:36:54'),
(1283, 1, -22.42534510, -46.93976760, '2026-02-28 17:37:48'),
(1284, 1, -22.42534510, -46.93976760, '2026-02-28 17:37:48'),
(1285, 1, -22.42534510, -46.93976760, '2026-02-28 17:37:48'),
(1286, 1, -22.42534510, -46.93976760, '2026-02-28 17:37:48'),
(1287, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:22'),
(1288, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:22'),
(1289, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:22'),
(1290, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:23'),
(1291, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:23'),
(1292, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:23'),
(1293, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:24'),
(1294, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:24'),
(1295, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:24'),
(1296, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:25'),
(1297, 1, -22.42531960, -46.93981370, '2026-02-28 17:45:33'),
(1298, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:06'),
(1299, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:06'),
(1300, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:07'),
(1301, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:07'),
(1302, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:07'),
(1303, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:08'),
(1304, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:08'),
(1305, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:08'),
(1306, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:09'),
(1307, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1308, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1309, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1310, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1311, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1312, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1313, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1314, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1315, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1316, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1317, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1318, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1319, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1320, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:36'),
(1321, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1322, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1323, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1324, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1325, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1326, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1327, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1328, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1329, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1330, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1331, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1332, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1333, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1334, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1335, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1336, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1337, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1338, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1339, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1340, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1341, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1342, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1343, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1344, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1345, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1346, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1347, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1348, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1349, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:37'),
(1350, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:38'),
(1351, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:38'),
(1352, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:38'),
(1353, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:39'),
(1354, 1, -22.42531960, -46.93981370, '2026-02-28 17:48:39'),
(1355, 1, -22.42531960, -46.93981370, '2026-02-28 17:49:20'),
(1356, 1, -22.42531960, -46.93981370, '2026-02-28 17:49:20'),
(1357, 1, -22.42531960, -46.93981370, '2026-02-28 17:49:21'),
(1358, 1, -22.42531960, -46.93981370, '2026-02-28 17:49:21'),
(1359, 1, -22.42531960, -46.93981370, '2026-02-28 17:49:21'),
(1360, 1, -22.42531960, -46.93981370, '2026-02-28 17:49:22'),
(1361, 1, -22.42532490, -46.93994970, '2026-02-28 17:58:19'),
(1362, 1, -22.42532490, -46.93994970, '2026-02-28 17:58:20'),
(1363, 1, -22.42532490, -46.93994970, '2026-02-28 17:58:49'),
(1364, 1, -22.42532490, -46.93994970, '2026-02-28 17:58:50'),
(1365, 1, -22.42532490, -46.93994970, '2026-02-28 18:03:11'),
(1366, 1, -22.42532490, -46.93994970, '2026-02-28 18:03:12'),
(1367, 1, -22.42532490, -46.93994970, '2026-02-28 18:03:41'),
(1368, 1, -22.42532490, -46.93994970, '2026-02-28 18:05:59'),
(1369, 1, -22.42532490, -46.93994970, '2026-02-28 18:06:29'),
(1370, 1, -22.42532490, -46.93994970, '2026-02-28 18:06:29'),
(1371, 1, -22.42532490, -46.93994970, '2026-02-28 18:06:29'),
(1372, 1, -22.42532490, -46.93994970, '2026-02-28 18:08:13'),
(1373, 1, -22.42533520, -46.93983050, '2026-02-28 18:26:11'),
(1374, 1, -22.42533520, -46.93983050, '2026-02-28 18:26:11'),
(1375, 1, -22.42533300, -46.93982870, '2026-03-02 14:51:43'),
(1376, 1, -22.42533300, -46.93982870, '2026-03-02 14:51:43'),
(1377, 1, -22.42537290, -46.93993600, '2026-03-02 20:26:51'),
(1378, 1, -22.42537290, -46.93993600, '2026-03-02 20:26:52'),
(1379, 1, -22.42534550, -46.93993510, '2026-03-02 20:28:06'),
(1380, 1, -22.42534550, -46.93993510, '2026-03-02 20:28:07'),
(1381, 2, -22.42533330, -46.93995100, '2026-03-02 23:43:59'),
(1382, 2, -22.42533330, -46.93995100, '2026-03-02 23:44:00'),
(1383, 2, -22.42533330, -46.93995100, '2026-03-02 23:48:53'),
(1384, 2, -22.42533330, -46.93995100, '2026-03-02 23:48:53'),
(1385, 1, -22.42533330, -46.93995100, '2026-03-02 23:58:32'),
(1386, 1, -22.42533330, -46.93995100, '2026-03-02 23:58:33'),
(1387, 1, -22.42548360, -46.93983000, '2026-03-03 11:41:13'),
(1388, 1, -22.42548360, -46.93983000, '2026-03-03 11:41:14'),
(1389, 1, -22.42548360, -46.93983000, '2026-03-03 11:41:44'),
(1390, 1, -22.42548360, -46.93983000, '2026-03-03 11:41:45'),
(1391, 1, -22.42548360, -46.93983000, '2026-03-03 11:43:47'),
(1392, 1, -22.42548360, -46.93983000, '2026-03-03 11:44:17'),
(1393, 1, -22.42548360, -46.93983000, '2026-03-03 11:44:17'),
(1394, 1, -22.42548360, -46.93983000, '2026-03-03 11:46:43'),
(1395, 1, -22.42548360, -46.93983000, '2026-03-03 11:47:13'),
(1396, 1, -22.42548360, -46.93983000, '2026-03-03 11:48:23'),
(1397, 1, -22.42548360, -46.93983000, '2026-03-03 11:48:24'),
(1398, 1, -22.42548360, -46.93983000, '2026-03-03 11:48:55'),
(1399, 1, -22.42548360, -46.93983000, '2026-03-03 11:48:55'),
(1400, 1, -22.42533420, -46.93996510, '2026-03-03 12:51:31'),
(1401, 1, -22.42533420, -46.93996510, '2026-03-03 12:51:32'),
(1402, 1, -22.42533420, -46.93996510, '2026-03-03 12:52:02'),
(1403, 1, -22.42533420, -46.93996510, '2026-03-03 12:58:19'),
(1404, 1, -22.42533420, -46.93996510, '2026-03-03 12:58:20'),
(1405, 1, -22.42535000, -46.93997840, '2026-03-04 14:25:34'),
(1406, 1, -22.42535000, -46.93997840, '2026-03-04 14:25:35'),
(1407, 6, -22.42535000, -46.93997840, '2026-03-04 14:34:25'),
(1408, 6, -22.42535000, -46.93997840, '2026-03-04 14:34:26'),
(1409, 1, -22.42535000, -46.93997840, '2026-03-04 14:35:13'),
(1410, 1, -22.42535000, -46.93997840, '2026-03-04 14:35:13'),
(1411, 1, -22.42529180, -46.93990260, '2026-03-04 20:41:52'),
(1412, 1, -22.42529180, -46.93990260, '2026-03-04 20:41:53'),
(1413, 1, -22.42535850, -46.93981770, '2026-03-04 21:00:24'),
(1414, 1, -22.42535850, -46.93981770, '2026-03-04 21:00:24'),
(1415, 1, -22.42542260, -46.93981040, '2026-03-04 21:12:08'),
(1416, 1, -22.42542260, -46.93981040, '2026-03-04 21:12:08'),
(1417, 1, -22.42534020, -46.93983350, '2026-03-04 21:19:35'),
(1418, 7, -22.42528560, -46.93983940, '2026-03-04 21:20:45'),
(1419, 7, -22.42528560, -46.93983940, '2026-03-04 21:20:45'),
(1420, 7, -22.42529090, -46.93990210, '2026-03-05 18:12:44'),
(1421, 7, -22.42529090, -46.93990210, '2026-03-05 18:12:44'),
(1422, 7, -22.42529140, -46.93977220, '2026-03-05 18:44:31'),
(1423, 7, -22.42529140, -46.93977220, '2026-03-05 18:44:31'),
(1424, 7, -22.42529140, -46.93977220, '2026-03-05 18:57:27'),
(1425, 7, -22.42529140, -46.93977220, '2026-03-05 18:59:52'),
(1426, 7, -22.42529140, -46.93977220, '2026-03-05 18:59:52');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `character_states`
--
ALTER TABLE `character_states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `emotions`
--
ALTER TABLE `emotions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `login_history`
--
ALTER TABLE `login_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `slivi_clothes`
--
ALTER TABLE `slivi_clothes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Índices de tabela `slivi_game_scores`
--
ALTER TABLE `slivi_game_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `slivi_notifications`
--
ALTER TABLE `slivi_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `created_at` (`created_at`);

--
-- Índices de tabela `slivi_objectives_template`
--
ALTER TABLE `slivi_objectives_template`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_obj_wardrobe` (`reward_clothing_id`);

--
-- Índices de tabela `slivi_questions_game`
--
ALTER TABLE `slivi_questions_game`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `slivi_seals_template`
--
ALTER TABLE `slivi_seals_template`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `slivi_speeches`
--
ALTER TABLE `slivi_speeches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `slivi_status`
--
ALTER TABLE `slivi_status`
  ADD PRIMARY KEY (`user_id`);

--
-- Índices de tabela `slivi_user_equipped_clothes`
--
ALTER TABLE `slivi_user_equipped_clothes`
  ADD PRIMARY KEY (`user_id`,`category`),
  ADD KEY `cloth_slug` (`cloth_slug`);

--
-- Índices de tabela `slivi_user_objectives`
--
ALTER TABLE `slivi_user_objectives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slivi_user_objectives_ibfk_1` (`objective_id`),
  ADD KEY `slivi_user` (`user_id`);

--
-- Índices de tabela `slivi_user_seals`
--
ALTER TABLE `slivi_user_seals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `fk_user_seals_template` (`seal_id`);

--
-- Índices de tabela `slivi_user_wardrobe`
--
ALTER TABLE `slivi_user_wardrobe`
  ADD PRIMARY KEY (`user_id`,`cloth_id`),
  ADD KEY `cloth_id` (`cloth_id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `user_locations`
--
ALTER TABLE `user_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `character_states`
--
ALTER TABLE `character_states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de tabela `emotions`
--
ALTER TABLE `emotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT de tabela `foods`
--
ALTER TABLE `foods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `login_history`
--
ALTER TABLE `login_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de tabela `slivi_clothes`
--
ALTER TABLE `slivi_clothes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `slivi_game_scores`
--
ALTER TABLE `slivi_game_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de tabela `slivi_notifications`
--
ALTER TABLE `slivi_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=348;

--
-- AUTO_INCREMENT de tabela `slivi_objectives_template`
--
ALTER TABLE `slivi_objectives_template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT de tabela `slivi_questions_game`
--
ALTER TABLE `slivi_questions_game`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de tabela `slivi_seals_template`
--
ALTER TABLE `slivi_seals_template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de tabela `slivi_speeches`
--
ALTER TABLE `slivi_speeches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de tabela `slivi_user_objectives`
--
ALTER TABLE `slivi_user_objectives`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `slivi_user_seals`
--
ALTER TABLE `slivi_user_seals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `user_locations`
--
ALTER TABLE `user_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1427;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `character_states`
--
ALTER TABLE `character_states`
  ADD CONSTRAINT `character_states_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `emotions`
--
ALTER TABLE `emotions`
  ADD CONSTRAINT `emotions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `login_history`
--
ALTER TABLE `login_history`
  ADD CONSTRAINT `login_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `slivi_game_scores`
--
ALTER TABLE `slivi_game_scores`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `slivi_objectives_template`
--
ALTER TABLE `slivi_objectives_template`
  ADD CONSTRAINT `fk_obj_wardrobe` FOREIGN KEY (`reward_clothing_id`) REFERENCES `slivi_clothes` (`id`);

--
-- Restrições para tabelas `slivi_speeches`
--
ALTER TABLE `slivi_speeches`
  ADD CONSTRAINT `slivi_speeches_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `slivi_user_equipped_clothes`
--
ALTER TABLE `slivi_user_equipped_clothes`
  ADD CONSTRAINT `slivi_user_equipped_clothes_ibfk_1` FOREIGN KEY (`cloth_slug`) REFERENCES `slivi_clothes` (`slug`) ON DELETE CASCADE;

--
-- Restrições para tabelas `slivi_user_objectives`
--
ALTER TABLE `slivi_user_objectives`
  ADD CONSTRAINT `slivi_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `slivi_user_objectives_ibfk_1` FOREIGN KEY (`objective_id`) REFERENCES `slivi_objectives_template` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `slivi_user_seals`
--
ALTER TABLE `slivi_user_seals`
  ADD CONSTRAINT `fk_user_seals_template` FOREIGN KEY (`seal_id`) REFERENCES `slivi_seals_template` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `slivi_user_wardrobe`
--
ALTER TABLE `slivi_user_wardrobe`
  ADD CONSTRAINT `slivi_user_wardrobe_ibfk_1` FOREIGN KEY (`cloth_id`) REFERENCES `slivi_clothes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
