-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 14, 2022 at 05:47 AM
-- Server version: 10.3.36-MariaDB-cll-lve
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ilivete2_survey`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` smallint(12) UNSIGNED DEFAULT NULL,
  `model_name` varchar(32) DEFAULT NULL,
  `model_id` varchar(16) DEFAULT NULL,
  `model_request` varchar(16) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `previous_record` text DEFAULT NULL,
  `current_record` text DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `ip_address` varchar(32) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `state` enum('pending','processed') NOT NULL DEFAULT 'pending',
  `status` enum('0','1') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) UNSIGNED NOT NULL,
  `school_code` varchar(12) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT 'writable/uploads/default_logo.png',
  `address` varchar(255) DEFAULT NULL,
  `country_code` varchar(5) DEFAULT NULL,
  `region_id` varchar(5) DEFAULT NULL,
  `district_id` varchar(5) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `alt_phone` varchar(16) DEFAULT NULL,
  `fee_payment` varchar(5) DEFAULT '20',
  `percentage_share` varchar(3) DEFAULT '10',
  `settings` text DEFAULT NULL,
  `protocol_limit` tinyint(5) UNSIGNED NOT NULL DEFAULT 50,
  `protocol_count` tinyint(5) UNSIGNED NOT NULL DEFAULT 0,
  `created_by` varchar(32) DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('0','1','2') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `school_code`, `name`, `logo`, `address`, `country_code`, `region_id`, `district_id`, `email`, `phone`, `alt_phone`, `fee_payment`, `percentage_share`, `settings`, `protocol_limit`, `protocol_count`, `created_by`, `date_created`, `date_updated`, `status`) VALUES
(1, 'A0001', 'SHS Admission Portal', 'writable/uploads/avatar/1666200614_d797475d1c5defc96385.png', 'Accra', 'GH', '4', '134', 'emmallob14@gmail.com', '0550107770', '0571408340', '20', '10', '{\"school_reopens\":\"\",\"admission_opens\":\"\",\"admission_end\":\"2022-10-12\"}', 50, 0, '1', '2022-09-19 05:13:49', '2022-10-19 17:30:15', '1');

-- --------------------------------------------------------

--
-- Table structure for table `login_history`
--

CREATE TABLE `login_history` (
  `id` int(11) UNSIGNED NOT NULL,
  `client_id` smallint(12) UNSIGNED DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `lastlogin` datetime DEFAULT current_timestamp(),
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login_history`
--

INSERT INTO `login_history` (`id`, `client_id`, `username`, `lastlogin`, `ip_address`, `user_agent`, `user_id`) VALUES
(1, 1, 'emmallob14', '2022-11-04 11:42:23', '154.160.4.164', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(2, 1, 'emmallob14', '2022-11-04 17:17:36', '154.160.22.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(3, 1, 'emmallob14', '2022-11-04 19:40:41', '154.160.23.133', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(4, 1, 'emmallob14', '2022-11-04 22:54:43', '154.160.23.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(5, 1, 'emmallob14', '2022-11-04 22:54:45', '154.160.23.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(6, 1, 'emmallob14', '2022-11-04 22:54:47', '154.160.23.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(7, 1, 'emmallob14', '2022-11-04 23:45:46', '154.160.23.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(8, 1, 'emmallob14', '2022-11-05 07:29:38', '154.160.23.133', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(9, 1, 'emmallob14', '2022-11-05 11:06:43', '154.160.4.175', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(10, 1, 'emmallob14', '2022-11-05 11:53:06', '154.160.18.241', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(11, 1, 'emmallob14', '2022-11-05 13:06:06', '154.160.18.241', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(12, 1, 'emmallob14', '2022-11-05 15:20:35', '154.160.18.241', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(13, 1, 'emmallob14', '2022-11-05 19:17:12', '154.160.10.71', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(14, 1, 'emmallob14', '2022-11-05 23:13:18', '154.160.26.160', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(15, 1, 'emmallob14', '2022-11-06 00:04:38', '154.160.4.222', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(16, 1, 'emmallob14', '2022-11-06 00:08:41', '154.160.6.229', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(17, 1, 'emmallob14', '2022-11-06 06:55:47', '154.160.4.222', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(18, 1, 'emmallob14', '2022-11-06 10:29:59', '154.160.6.229', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(19, 1, 'emmallob14', '2022-11-06 12:23:56', '154.160.16.211', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(20, 1, 'emmallob14', '2022-11-06 13:48:35', '154.160.3.104', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(21, 1, 'emmallob14', '2022-11-06 15:18:06', '154.160.22.50', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(22, 1, 'emmallob14', '2022-11-06 17:06:19', '154.160.17.65', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(23, 1, 'emmallob14', '2022-11-06 22:55:04', '154.160.19.225', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(24, 1, 'emmallob14', '2022-11-07 03:57:22', '154.160.26.163', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(25, 1, 'emmallob14', '2022-11-07 06:32:50', '154.160.26.163', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(26, 1, 'emmallob14', '2022-11-07 09:12:52', '154.160.26.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(27, 1, 'emmallob14', '2022-11-07 11:50:59', '154.160.26.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(28, 1, 'emmallob14', '2022-11-07 12:58:55', '154.160.2.221', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(29, 1, 'emmallob14', '2022-11-07 17:49:53', '154.160.7.245', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(30, 1, 'emmallob14', '2022-11-07 19:35:31', '154.160.7.245', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(31, 1, 'emmallob14', '2022-11-07 23:24:53', '154.160.5.245', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(32, 1, 'emmallob14', '2022-11-08 01:41:43', '154.160.7.245', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Mobile Safari/537.36', '2'),
(33, 1, 'emmallob14', '2022-11-08 11:12:03', '154.160.5.245', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(34, 1, 'emmallob14', '2022-11-08 17:59:24', '154.160.2.230', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(35, 1, 'emmallob14', '2022-11-08 18:16:29', '154.160.20.66', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(36, 1, 'emmallob14', '2022-11-08 23:54:43', '154.160.21.179', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(37, 1, 'emmallob14', '2022-11-09 00:33:15', '154.160.10.254', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(38, 1, 'emmallob14', '2022-11-09 06:07:26', '154.160.10.254', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(39, 1, 'emmallob14', '2022-11-09 09:02:57', '154.160.10.254', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(40, 1, 'emmallob14', '2022-11-09 11:35:04', '154.160.5.2', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(41, 1, 'emmallob14', '2022-11-09 19:06:06', '154.160.20.59', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(42, 1, 'emmallob14', '2022-11-09 20:35:59', '154.160.5.201', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(43, 1, 'emmallob14', '2022-11-10 00:20:03', '154.160.23.225', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(44, 1, 'emmallob14', '2022-11-10 00:21:37', '154.160.5.69', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(45, 1, 'emmallob14', '2022-11-10 11:47:45', '69.167.12.90', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(46, 1, 'emmallob14', '2022-11-10 21:08:08', '154.160.26.96', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(47, 1, 'emmallob14', '2022-11-11 10:58:54', '154.160.14.139', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(48, 1, 'emmallob14', '2022-11-11 23:35:33', '154.160.11.232', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(49, 1, 'emmallob14', '2022-11-12 00:51:52', '154.160.4.237', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(50, 1, 'emmallob14', '2022-11-12 11:25:54', '154.160.19.212', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(51, 1, 'emmallob14', '2022-11-12 12:17:06', '154.160.4.237', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(52, 1, 'emmallob14', '2022-11-12 15:06:31', '154.160.1.214', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(53, 1, 'emmallob14', '2022-11-12 18:58:25', '154.160.7.33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(54, 1, 'emmallob14', '2022-11-13 13:34:38', '154.160.18.12', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', '2'),
(55, 1, 'emmallob14', '2022-11-13 17:50:34', '154.160.2.175', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(56, 1, 'emmallob14', '2022-11-14 03:43:48', '154.160.22.39', 'Mozilla/5.0 (Linux; Android 10; ONEPLUS A5000) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36', '2'),
(57, 1, 'emmallob14', '2022-11-14 05:28:35', '154.160.11.253', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2'),
(58, 1, 'emmallob14', '2022-11-14 05:40:08', '154.160.11.253', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '2');

-- --------------------------------------------------------

--
-- Table structure for table `surveys`
--

CREATE TABLE `surveys` (
  `id` int(11) NOT NULL,
  `client_id` int(12) UNSIGNED DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `cover_art` varchar(255) DEFAULT 'assets/images/survey.jpg',
  `button_text` varchar(32) DEFAULT 'Begin',
  `start_date` datetime NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime DEFAULT NULL,
  `submitted_answers` varchar(12) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `settings` text DEFAULT '{"language":"en","display_image":true,"publicize_result":false,"receive_statistics":true,"allow_skip_question":false,"question_layout":"paginate","allow_multiple_voting":true,"thank_you_text":"Thank you for your voting.","closed_survey_text":"The voting session is now closed. Thank you for your participation.","footer_text":"This voting and award scheme is free of charge."}',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `is_published` enum('0','1') NOT NULL DEFAULT '1',
  `users_logs` text DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `surveys`
--

INSERT INTO `surveys` (`id`, `client_id`, `title`, `slug`, `description`, `cover_art`, `button_text`, `start_date`, `end_date`, `submitted_answers`, `date_created`, `date_updated`, `settings`, `status`, `is_published`, `users_logs`, `created_by`) VALUES
(1, 1, 'Ghana Twitter Awards 2022 Voting', 'ghana-twitter-awards-voting', '<div>The board of the Ghana Twitter Awards has finally released the list of nominees for this year’s edition. The Ghana Twitter Awards, also known as the GTAs, is an annual social media awards event in Ghana.<br><br></div><div>The awards are open to all Ghanaian Twitter users who who have active Twitter accounts, good internet etiquette and high recommendations. This year’s edition has seen a record number of nominations with more than 200 entries.<br></div>', 'assets/images/surveys/1.jpg', 'Begin Voting', '2022-11-03 21:01:26', '0000-00-00 00:00:00', '2989', '2022-11-03 21:01:26', '2022-11-14 05:21:44', '{\"publicize_result\":\"0\",\"receive_statistics\":\"1\",\"allow_multiple_voting\":\"0\",\"paginate_question\":\"0\",\"allow_skip_question\":\"0\",\"thank_you_text\":\"<p>Thank you for your voting.</p><p>We hope to see you on the 9th December, 2022 at the Accra Metropolitan Assembly hall (AMA) for the main event.</p>\",\"closed_survey_text\":\"<div>The voting session is now closed. Thank you for your participation.</div>\",\"footer_text\":\"<div>This voting and award scheme is free of charge.</div>\"}', '1', '1', '[{\"guid\":\"MepRmTWePsI2NfOFXIjI\"},{\"guid\":\"XShnSo4uM2NGlgFMFHok\"},{\"guid\":\"PYD32AUqgRSvVcB8bOm5\"},{\"guid\":\"50101537361060005373690642424\"},{\"guid\":\"1UedrHPG8X1svAk6n4RO\"},{\"guid\":\"HDvWdq8OM4oRSN9jwZTR\"},{\"guid\":\"6z07AM8fepcdxQ8li61e\"},{\"guid\":\"yUm4szy0EqaZ85ipMqjV\"},{\"guid\":\"tcNEwF7hTLZiZgt17xZR\"},{\"guid\":\"StlarS1PiFNpM2FvAVTm\"},{\"guid\":\"cdXSl8KzhIZO3PH10Rr8\"},{\"guid\":\"kjLEgZcKErDeCK26a28P\"},{\"guid\":\"XZT7cZyS8gKqyBD8XW06\"},{\"guid\":\"eUbA7R2pcpUgq2QPuJ2q\"},{\"guid\":\"Wgl3mOvv8NhgscTgQRmO\"},{\"guid\":\"MFjbUC5NlYRlmSQ2vld7\"},{\"guid\":\"SzsEyxgr5sQ19XbrRwOG\"},{\"guid\":\"cUR4ycmJPxS6UT2NIGR9\"},{\"guid\":\"EyNINH3nqZlesyJJQ6mJ\"},{\"guid\":\"L3lWpSe8xuUcEKdqM912\"},{\"guid\":\"g1e1iqMBSHVXfl0GpofJ\"},{\"guid\":\"nmELNamJ9ZPTOyecisbo\"},{\"guid\":\"vGldsg3P25iC98zTdR7c\"},{\"guid\":\"0t77YMe8cqece6i3hMBO\"},{\"guid\":\"EVCFzHnokIjZzHAhBYDC\"},{\"guid\":\"u13TXdcseZ7lwUw0oM73\"},{\"guid\":\"Tiyp8C86kHvYjeNRTgGX\"},{\"guid\":\"SKqXXwXnhbHz1BUgrP4Y\"},{\"guid\":\"Zcrnwe1lZqeV9tRwe1Qs\"},{\"guid\":\"6MsWp9tkmN1CDD9MuqMv\"},{\"guid\":\"WQkYZ8w7WGcKpS3inO24\"},{\"guid\":\"j28MYvlPzWfuCpIHWjJX\"},{\"guid\":\"2AF4Hd6HYWPeDD8HHGPh\"},{\"guid\":\"501114121021500153736105051951365373611491541224\"},{\"guid\":\"ljr18fcNvM4trm7MMewc\"},{\"guid\":\"YHXD4RSHlkxcqVqjh2D9\"},{\"guid\":\"0OiGAx7P0gYInEwU7JQn\"},{\"guid\":\"Ss6er9t40ZuZSF1FAwXE\"},{\"guid\":\"501071190711020537369904844585373611480036024\"},{\"guid\":\"BlsbhCPiMU2oEGboXIxC\"},{\"guid\":\"ADmUS52nRyAVmo11v6ZU\"},{\"guid\":\"1mL0yIu1KhQS4mkDyyBU\"},{\"guid\":\"3ynq3emakxzrOwAiibjg\"},{\"guid\":\"vzG5b4Ki616YgHJ8Nf3h\"},{\"guid\":\"cfrvye9Ko2361yzhARu0\"},{\"guid\":\"5012235537361020005373691841224\"},{\"guid\":\"pbxOosI40SolvrlhIgsU\"},{\"guid\":\"d2n0rtDAj03Mq0xAYBqe\"},{\"guid\":\"BUKUod1Kcy4aZJdYP7RI\"},{\"guid\":\"33raZ2Q8fSYiEafYxM2p\"},{\"guid\":\"2MZ47VfLPIjGMeh1LcdM\"},{\"guid\":\"ZQgSYSeViZMzwhcn9mDO\"},{\"guid\":\"AZIwx7u4idDQaxTyIgZB\"},{\"guid\":\"b9mAyg2cXFdcrUraN0rv\"},{\"guid\":\"EYyftyuwC3B9e2DxISPV\"},{\"guid\":\"2VE01CNUaTWqCrTK5ZYG\"},{\"guid\":\"gKZvS4kNXjRiTIgs6nff\"},{\"guid\":\"jalHfAkhtRLSiVFp0wb0\"},{\"guid\":\"3JwmoBw2xn5b0gJ2Nh82\"},{\"guid\":\"wZ2uz1TpAAFdbuPB4AEa\"},{\"guid\":\"I31pmwaPC2aAuXhlzSbQ\"},{\"guid\":\"8ysOZUx1j8MMjFTq3yMr\"},{\"guid\":\"8n116UVwZepo8HvD5Kae\"},{\"guid\":\"RqzMImiKw4xYcsEyaPLk\"},{\"guid\":\"cjwAt5crdJgTy3GAGEdZ\"},{\"guid\":\"D7khSVu3sg4cHQUokubI\"},{\"guid\":\"OCpGhVygAH7JokQfVZhF\"},{\"guid\":\"U9u7AlTvrgUoe6D3u43z\"},{\"guid\":\"501221081111537361070005373687339324\"},{\"guid\":\"FvIOpwXT64vsBM0z4xZ3\"},{\"guid\":\"w3Ov1S6shAYsZvzgegJ4\"},{\"guid\":\"cLZ6M9H5VkaTVO9WqwxC\"},{\"guid\":\"caYgiRAT9r0H3VmFj7cZ\"},{\"guid\":\"AHnu3CZE8wdNaGoJaIQ5\"},{\"guid\":\"H3skyIRFwb0Xmxfd5yLB\"},{\"guid\":\"atKJUTJPjIZnUzSdklh2\"},{\"guid\":\"XImcuSGq2lqDcStVVyj6\"},{\"guid\":\"5BLfQ372atQdBpEFdQXs\"},{\"guid\":\"RWV0Vc3FPwKprl2MmiPA\"},{\"guid\":\"NYUlBSDNAD3zGKKKQYAV\"},{\"guid\":\"lt0wye17jNPCoMtQYFpi\"},{\"guid\":\"EVtqIAUxIkypULq8AHXa\"},{\"guid\":\"qQZmlQlWnWPBLGxaI7iC\"},{\"guid\":\"5UAS3CysgPADdQNEiPpA\"},{\"guid\":\"ZkP5VUJYzqlehKifLypR\"},{\"guid\":\"eUPnIcvOElxAoohToKTV\"},{\"guid\":\"501561605115156115148604189641432\"},{\"guid\":\"5qnOV6QurUJWlA8jtEfT\"},{\"guid\":\"dAUq1J1JWmZY4Pv4rG8Z\"},{\"guid\":\"GYhbf8rtzDJdrZuZB7fY\"},{\"guid\":\"L0S1vSIwHMHALqZHlis9\"},{\"guid\":\"cO72u1FIR03bU6cqz0Zd\"},{\"guid\":\"MgehXiy1ZDv9Zlr7otZO\"},{\"guid\":\"Q9SWAOBhNjCJJOxgoObH\"},{\"guid\":\"LhRgkuiNqHzL5W5ecywu\"},{\"guid\":\"A1skfPAMIJYocFfnyTfU\"},{\"guid\":\"uL1bsPQH5Ns6cBEiPhTx\"},{\"guid\":\"6NbfOy6wyWjJlOPmm0OA\"},{\"guid\":\"vdvp7ln5iRNAwPHH0jK6\"},{\"guid\":\"J8N0keQD1EHavdb491kZ\"},{\"guid\":\"NPaAZv6WPKYMI0Ak6bZY\"},{\"guid\":\"nqGs3ZO2hI6TVbfpSxJA\"},{\"guid\":\"5015560511515515148604173641432\"},{\"guid\":\"5010064645373610700053736768136624\"},{\"guid\":\"s9wwl9olSDe6y0uFj0CP\"},{\"guid\":\"Ay67mbxTwawC7hBigIB1\"},{\"guid\":\"WCnFXoIjioLfTiN5vi5R\"},{\"guid\":\"501256605115121215148604166737532\"},{\"guid\":\"pWjvLRUBoWYuSloVgqdt\"},{\"guid\":\"VZfkd2RarrVjNay6L6MF\"},{\"guid\":\"4vSDhruLI2pkjhJwBaQy\"},{\"guid\":\"CqAmRQTdYuF9TDw1R4Wl\"},{\"guid\":\"28WvtdgmYUWj6wO0K3l1\"},{\"guid\":\"XWM1Wl4aD8jc7odvqBzI\"},{\"guid\":\"aWlVHxorQIykpRR8djFs\"},{\"guid\":\"CJYr8W4O7GXTG9Ou8blb\"},{\"guid\":\"VGSMYWYMt4jLWnhk8fDZ\"},{\"guid\":\"8BjzhYdNGvrhCcSHGQOv\"},{\"guid\":\"UisHW9VX3Rv73cotf35h\"},{\"guid\":\"ksnscasVZTep9tDxylKv\"},{\"guid\":\"501020063537361070005373680036024\"},{\"guid\":\"ElNyON90ROsR9ynfkC8U\"},{\"guid\":\"sDbBD8WwVZiw3Cie5Kjn\"},{\"guid\":\"mV4cJ7Jd1afv8uAciMDy\"},{\"guid\":\"XpjqhB1pqSCFrGGARCU8\"},{\"guid\":\"uENaBs5pQdEvveRJOR7S\"},{\"guid\":\"OOnxHPD6FvvwjmKKeDpQ\"},{\"guid\":\"GLQ6guMAxjPyipnfLibw\"},{\"guid\":\"3JtuTaag5Id79N1clSnD\"},{\"guid\":\"K1aGgWdCfRiTsejWzBSW\"},{\"guid\":\"tOxDiFaiDiLPvnBP7UzI\"},{\"guid\":\"jeJIWfzd60PdKg0xvChR\"},{\"guid\":\"4BsxcWXMWFygx1ZwYpSe\"},{\"guid\":\"Mgqx124Pq2p3a2v0gKFN\"},{\"guid\":\"dJNLGE8uBRFDyxnIHLXF\"},{\"guid\":\"KofsqRXZQWcPb1hzjgBk\"},{\"guid\":\"YE7RU8QJIjQCzKFV0a4K\"},{\"guid\":\"XBrQHGUNCegBJFr8icJT\"},{\"guid\":\"CBQ8QVnDmFxhTK0jfWWf\"},{\"guid\":\"S81tHhCdwUfHVr9CPoZ1\"},{\"guid\":\"fBQ8xC1veGwYIGLKCCkw\"},{\"guid\":\"4vEyQjS0tla2Lix46Gu4\"},{\"guid\":\"xmr7FWeILqDAaZgtdYGM\"},{\"guid\":\"Zj9fOnMiBHhZ5owJln0R\"},{\"guid\":\"dcHDOd14fn6KaCvUW0AX\"},{\"guid\":\"cdtg8bwDgruUeyZbVnFy\"},{\"guid\":\"Sn5RkMmtwkrpkeu6L9bh\"},{\"guid\":\"9IfFB42f8Pkcw9ygpOKn\"},{\"guid\":\"TyN9ks7jYj2xNGTNsayh\"},{\"guid\":\"KRuHEPl55l8lVgb6YVVR\"},{\"guid\":\"x41v5IVII1V7lFdCpvRu\"},{\"guid\":\"HDt5YK3m8NE9hxCAXZg3\"},{\"guid\":\"cPkcybN4SWSjnO64qI7L\"},{\"guid\":\"1CIDUP9AIbD34xXb7EuN\"},{\"guid\":\"CdJPZ6Cvr7DWmQiQOklj\"},{\"guid\":\"BqwhKgRgg6FOECv0OMFm\"},{\"guid\":\"DW1orHTMvZGjfsCJJmZB\"},{\"guid\":\"9Csd2YJo8stQNFYRfhsW\"},{\"guid\":\"yk0QXjuNsKSZsCzhnHYW\"},{\"guid\":\"1Ez59fyUNCEI8zPlxmuy\"},{\"guid\":\"2ibJ09hUKcB62JPXYl1x\"},{\"guid\":\"HtDA4olXf3wx9GzDcE59\"},{\"guid\":\"ghPNw6jD605ikxGBgcwI\"},{\"guid\":\"UDjJK6Z7qzEtzTBUSUJ8\"},{\"guid\":\"faw7CunvWJ8bBszlf87w\"},{\"guid\":\"i6nhxjqK9ozPwIfHgmxt\"},{\"guid\":\"FbjZpLaCWXOjVgp4eGbg\"},{\"guid\":\"Tn9s7llac8W6EhZFXUVB\"},{\"guid\":\"6i3YgAgqRvQB4bM4M455\"},{\"guid\":\"upatvdGFn8ei3ACWxOPc\"},{\"guid\":\"SFIXFLib2HqbLCJ3h65N\"},{\"guid\":\"6CkiHTizVyahni8Bxclg\"},{\"guid\":\"5e3PSdWudNNekNjRRzYI\"},{\"guid\":\"XqjlPnAYBJAm0GMEnxsM\"},{\"guid\":\"4aDQKdP91Izmgb0F9RCA\"},{\"guid\":\"GdqoRHWkJGxnBNVThHTY\"},{\"guid\":\"DIvDTaSfFfsokWIL1xAf\"},{\"guid\":\"1pdj3eAZCG279UwoaSl8\"},{\"guid\":\"U9eMK97OEbxltoUAQR0R\"},{\"guid\":\"q6VD7eCCtL7112rSE9ZZ\"},{\"guid\":\"hFDiX09sQ3wwMAWmEY4c\"},{\"guid\":\"NJYnLtS6QWT4ucCpqMyU\"},{\"guid\":\"0mzbHlTOcmiC9DMPHaWa\"},{\"guid\":\"HmZRnbdSbokKNWCdKwKb\"},{\"guid\":\"e2jkTJ7lzdGrLl2EsXjB\"},{\"guid\":\"EpNKP265KMN8PiT85QBi\"},{\"guid\":\"nFPprNNcKj1jzAQVlg2R\"},{\"guid\":\"4FjEvwiX6XmqKuH7U8qw\"},{\"guid\":\"7AVnbGHf5TO80JHNW4gg\"},{\"guid\":\"7Sd8u1C8Ln2a8ccenm7p\"},{\"guid\":\"GQtn8IpNuIRYlvuzbpUO\"},{\"guid\":\"ZOIGa81DNwNX12ebIY2n\"},{\"guid\":\"qiG73PtZbQu8tKbBOeDg\"},{\"guid\":\"KDFvgGgqbvjBHJpy9pYT\"},{\"guid\":\"OXfCaeup7s4iHN64Bdj2\"},{\"guid\":\"M32C9hf6BQmocGAYoi6e\"},{\"guid\":\"tXEBHiY27W8aEFwe38uu\"},{\"guid\":\"JEl4eOGSD8dVyV4CooQy\"},{\"guid\":\"DmNHriJ9yAkWtptqMdQf\"},{\"guid\":\"jNUuboswrvQqYzVliGof\"},{\"guid\":\"sNXHR5oYJlLm7cYN8Ph0\"},{\"guid\":\"JzO4eCHS47de3xPqYMB8\"},{\"guid\":\"iIwJ2bZioJt3k11zX9lL\"},{\"guid\":\"VqAHu1mjZTbgCv5HXnxy\"},{\"guid\":\"KawsiqL7TgXoH3qPPLpo\"},{\"guid\":\"ILKK9A5dQk6xbI2Yh7hR\"},{\"guid\":\"OPudqERLb9iR6Smcszvj\"},{\"guid\":\"WNE8HKKHXZ5hX1leHSyF\"},{\"guid\":\"50810650537361070005373680036024\"},{\"guid\":\"RnKBRvm9AB3yKukuoGZf\"},{\"guid\":\"8znfd1LrVwy4gviQeTCb\"},{\"guid\":\"VF4NTJkAia7NtH0ziRfj\"},{\"guid\":\"Q1RzZML39Zvi6tnoERHE\"},{\"guid\":\"31DJNUIY6z9h0liESWJ9\"},{\"guid\":\"dC1dUHgPYLxMGCpVYoSB\"},{\"guid\":\"ttuOXFghHRauczqepzyx\"},{\"guid\":\"mdDbUvbcZzbrV5S8DICj\"},{\"guid\":\"WPrpU4UNSVsZ1Nm9WB25\"},{\"guid\":\"XsGgw132VXJFCBsu7TUK\"},{\"guid\":\"Lx6GHxNEw2UFYbKdUWDG\"},{\"guid\":\"E3FYZII1HQnfjzuG3tEw\"},{\"guid\":\"mKOokTBDRm56fu6cZG5R\"},{\"guid\":\"wEBcUjkckJh0k0759oih\"},{\"guid\":\"XnOS6tpgWeYphTMyN3Fq\"},{\"guid\":\"SHjO7aLn9cuEQR8NLciw\"},{\"guid\":\"5012225537361050005373691541224\"},{\"guid\":\"WCPRCBa3s1MSLmS4N1sl\"},{\"guid\":\"vAU3xBVqgCGJHz6a3jpe\"},{\"guid\":\"GrBp8MkUx88bVSdpOU2R\"},{\"guid\":\"plwT8YI8VwNdXg5tb34H\"},{\"guid\":\"XaIIeFDvaSD4ssqMFl2T\"},{\"guid\":\"FgIG8Zx14ZT7PhN3MgwQ\"},{\"guid\":\"NVbxTrqEp6slbaYckeXj\"},{\"guid\":\"7HZzA7UImlUhknYOG9Vf\"},{\"guid\":\"5012537361070005373685438524\"},{\"guid\":\"MZfctykHGfWX2H1abT0t\"},{\"guid\":\"5NQNBTfPFZPpVI2m1gqN\"},{\"guid\":\"W6Gl3Lzi3Qja44T2iNLI\"},{\"guid\":\"A0mh4XQd3fepKyXwsCiN\"},{\"guid\":\"PahJLFO8jvDX2HRfEy6H\"},{\"guid\":\"IwbuxG8pA4z4BFb1m9Iy\"},{\"guid\":\"qsBeTDyGcOHyNeauey96\"},{\"guid\":\"A3ynvntM3wfrGyWt1eIg\"},{\"guid\":\"KfexAQf5lESlYEKugvNA\"},{\"guid\":\"yzEPTAq4hpQgEQKYWqwT\"},{\"guid\":\"B7Z3QYd1gKeE6i4S1LOn\"},{\"guid\":\"sUEflf2dvWjqW9LcJ0DV\"},{\"guid\":\"9dv4GbTTS0K8MFU1Hy2W\"},{\"guid\":\"JXYNEKu003jCYoKqnFFl\"},{\"guid\":\"Pw5RSLp88evrUyqQiohd\"},{\"guid\":\"oVwPL6GCnX0D8hwxRsPr\"},{\"guid\":\"VFN65ktfRzv4GK66x0OF\"},{\"guid\":\"cAgY6fMCocDQztr7xIJm\"},{\"guid\":\"Ivldk1E6f4wJ9adhCauw\"},{\"guid\":\"zH1HeLtLcQyZgruKfqiB\"},{\"guid\":\"Z4KH097a2wMd5AaOm06W\"},{\"guid\":\"JWYmYVCeziq4HG1XOjQC\"},{\"guid\":\"0OzZqAP1nWKAdG9SxpCI\"},{\"guid\":\"QmZao0V2iZFVOpAPm2rn\"},{\"guid\":\"70r3vuGSPvyO4LciQve1\"},{\"guid\":\"h6tBvCxC3EOZc9jS7i04\"},{\"guid\":\"GjP73wFkkJc6DM6Hs5cK\"},{\"guid\":\"RMC78IYOYNXP0ItSPI2X\"},{\"guid\":\"uqfgzRJ1vk6aL58djkYX\"},{\"guid\":\"NPCY4uraa35iwHq5hUHA\"},{\"guid\":\"3Y9ViRpXU38WE5lJC4nt\"},{\"guid\":\"ZIGSD3yeE50WfXxIsotj\"},{\"guid\":\"TRRPkbDqcLfpnPglVTgd\"},{\"guid\":\"CfOdwPJIFNS869nxjY55\"},{\"guid\":\"508107537369504638745373672036024\"},{\"guid\":\"Rq2nH5USKPzoOeyG6ESJ\"},{\"guid\":\"mKuuAer0ycrqaQRtmlap\"},{\"guid\":\"8bnnV4cRXltuf86gFMQv\"},{\"guid\":\"ZUkaWcptvTE6WAiVnZ0b\"},{\"guid\":\"x4tHYSFDme8N5YeWcfun\"},{\"guid\":\"JBWVb9htc6DHadCPEETH\"},{\"guid\":\"vbC74QXxBTAcxUiUa6Cx\"},{\"guid\":\"IJpbUpNdn4HhvBmdaTNS\"},{\"guid\":\"6yKzjpHvewSqZfxrP2vc\"},{\"guid\":\"WBE8yS9AziCXm4Dd9moZ\"},{\"guid\":\"NWEeBv0pT4zmG9F1NBUJ\"},{\"guid\":\"qCrBAx05ziZHDjnWHTNa\"},{\"guid\":\"mnWCWEX3A9VDABT8QE3i\"},{\"guid\":\"dEGPepqBYtIoHRUZbAsa\"},{\"guid\":\"8LFQgZ7wc9I0MpKWIYS7\"},{\"guid\":\"aMaTnaZL4ZQr0ly8ezVg\"},{\"guid\":\"OHI51zIBa95JONmFE9cn\"},{\"guid\":\"yXVoaUyXrcaZZIFHVgK5\"},{\"guid\":\"9vrQTEb7QQPPAeQgwGj4\"},{\"guid\":\"FeScLdW4y9cAHJtdIK9T\"},{\"guid\":\"xoe24YVfOEr8RZHZTDMX\"},{\"guid\":\"qJxyUOqqURlQtSOM4jtN\"},{\"guid\":\"7oinAxJMtNUGrvRI7ctE\"},{\"guid\":\"oEyZjgqZaxs1efGTC5id\"},{\"guid\":\"iYlKFP0E7nKzsGp9WOO5\"},{\"guid\":\"eE6PujzIIIxVLLQb83FI\"},{\"guid\":\"LTbJpWTEvbWfpJYcaE4o\"},{\"guid\":\"fvfPKhaUZEka46D6SD9f\"},{\"guid\":\"ABGdilDfDaDOCum7DW5c\"},{\"guid\":\"iiQKDSoOqExC53sgS7IZ\"},{\"guid\":\"L0dAGGlq8mUVx2ig65l3\"},{\"guid\":\"lVqACSzZxdtYGDetO22y\"},{\"guid\":\"50810650537369304577825373680036024\"},{\"guid\":\"pnrVp6mKw5Ma0NOpOCJx\"},{\"guid\":\"5010655537368003987995373680036024\"},{\"guid\":\"aV0dLregHTWuZB2dFOR4\"},{\"guid\":\"0bNeNN3hNY0pL9v3aQQ1\"},{\"guid\":\"29SBRaBC0McjVyIP3cxL\"},{\"guid\":\"fU3tZByk8TMv8mzz39Ia\"},{\"guid\":\"je7068okW6MClAN7aqJH\"},{\"guid\":\"kZgFwaxuXdLuQPDzH0Hj\"},{\"guid\":\"rExrmIoOMMPfT3gne40F\"},{\"guid\":\"fFbZOHjtYoN3FmavXj7q\"},{\"guid\":\"X6lJSsGtWSfP1J14PHEd\"},{\"guid\":\"EgruKYdtPLkIL5NXrgp7\"},{\"guid\":\"jsb84VSVr2ETPv7vJoxg\"},{\"guid\":\"J5YJQlLNhuVdmIyj0daL\"},{\"guid\":\"nF5pDQpruwGBkkSVmpli\"},{\"guid\":\"6kkxbqPryKQrDU5UJP7Q\"},{\"guid\":\"6q5M2W62BSxAbLpBdPwD\"},{\"guid\":\"hXh6ZnE8p7t2B9eWTVgo\"},{\"guid\":\"gIqHPFtIm1TGDlSvA8Em\"},{\"guid\":\"5UNUpAfdL9tiP2IicXFD\"},{\"guid\":\"d9ILnYaI6z94MgnXPX9C\"},{\"guid\":\"EaIa623XIUjpyWvXZaaP\"},{\"guid\":\"aQL2VdIxdpG8whdWb0hI\"},{\"guid\":\"XnpDxlZ5MKwMuLDGTQ1i\"},{\"guid\":\"7ksrkl2hV3ltWiC3CzPu\"},{\"guid\":\"gg3mzGN65bDW364MLqQg\"},{\"guid\":\"50107537361070005373680036024\"},{\"guid\":\"V0eCEx9Cfvj08oegQ389\"},{\"guid\":\"JHJVvRXLUIUEvzZJJGic\"},{\"guid\":\"zMWKErz8j3fuhDRLIcHT\"},{\"guid\":\"5012612108120165373610004896885373611080036024\"},{\"guid\":\"ZG1B0b78z7T95aWKkKvQ\"},{\"guid\":\"wWZiiJVxNP5q40y8LZVX\"},{\"guid\":\"HDW1McFN8j025nOZatfw\"},{\"guid\":\"TwOLW0xpyOglYXivgiec\"},{\"guid\":\"amDfqoicVcAjO2JUf1C5\"},{\"guid\":\"50107537361050005373680036024\"},{\"guid\":\"CASoydf6CeLI490gNXtV\"},{\"guid\":\"pvKJq53IOAtvwnQoUAAC\"},{\"guid\":\"DGFF6I77tjWhOV6Pxjko\"},{\"guid\":\"QthWbM7MPeHeuKt51qrY\"},{\"guid\":\"0xfaspsCvk6ZVilmJ5Lu\"},{\"guid\":\"zQhwa0rlVX3pLFmkWYzG\"},{\"guid\":\"kKnYRQeVIDq71xkxAdib\"},{\"guid\":\"yVdv1bOfhVJkc50JoLmX\"},{\"guid\":\"Biotcd7NEsnTjGzXvhGz\"},{\"guid\":\"QHR27RKGUwUHwhh3YdPk\"},{\"guid\":\"GLk09wprS54QaJLOK5vs\"},{\"guid\":\"xUrIfer2EC9Lx85x0AbZ\"},{\"guid\":\"dRNMpIpInJYe4Nsaybjd\"},{\"guid\":\"yLIyP4NgYedgKfy38dMD\"},{\"guid\":\"OfzxfVNaBxWZOvW4WCyk\"},{\"guid\":\"UcTJFfURY2Ajn4asAmHx\"},{\"guid\":\"MOD4sI9YquunOfFQ3mCT\"},{\"guid\":\"5010657537361060005373680036024\"},{\"guid\":\"QvTCOYsAfbzBi5QueD8K\"},{\"guid\":\"501211553736190102050051255373689241224\"},{\"guid\":\"WocMV1hox50s0158MxuB\"},{\"guid\":\"5016060511516015148604181237532\"},{\"guid\":\"5ekLVM9AdHcfVmtFgS8k\"},{\"guid\":\"SnH8hoTyn9eitYCVrNEr\"},{\"guid\":\"qdGLnH9g0LX4dOiCq7aD\"},{\"guid\":\"RyJtoY12JfoDJawAhfw3\"},{\"guid\":\"Uz4RwGNdpMKWD50feYfu\"},{\"guid\":\"iHa01aZhjWc0c7f0JfJf\"},{\"guid\":\"HxwJkuN9LPSPWI2rhbKF\"},{\"guid\":\"509650537361050005373680036024\"},{\"guid\":\"hVuUmXpulxnEhtv4s2p7\"},{\"guid\":\"H2xyQ0Bo5xdvDwgIFjyk\"},{\"guid\":\"m9YHDNu0zbt0cuIOn1UJ\"},{\"guid\":\"AN1Y88W8rRbXIFFAB8vB\"},{\"guid\":\"7u4Xc4l0A4gwIT4MvRma\"},{\"guid\":\"nKGYR4CSYoIt9CDDq7Wk\"},{\"guid\":\"OhnT83OSGFHN6o5NYFnF\"},{\"guid\":\"509390537361060005373664036024\"},{\"guid\":\"2wzfakEAUjKa2h2Ii16S\"},{\"guid\":\"qLUJzckRhY6U8Hm48wRw\"},{\"guid\":\"HAFsVFFs2kLl1Lhsawn1\"},{\"guid\":\"9RwhxtPWPKCz0xsMgXiN\"},{\"guid\":\"Qis0dD1l25f7C1bEnJxd\"},{\"guid\":\"5RbnVHgj9xHmzKOzKxw2\"},{\"guid\":\"kqcYJOVzESXgDCgmZGRn\"},{\"guid\":\"kiiEbaAqBoe6gOlIs29f\"},{\"guid\":\"6hvm8cvhrxkXfiu0jOiF\"},{\"guid\":\"508102605373670035381105373664036024\"},{\"guid\":\"pVYN2vYrdWHBiNuXyctE\"},{\"guid\":\"jterGm5YK0pZ2MPca9v4\"},{\"guid\":\"aEaUdzkfM6jqUFs8yCQA\"},{\"guid\":\"8f7p01OncwdDE78C9cBP\"},{\"guid\":\"5012115537361070005373689241224\"},{\"guid\":\"Bovo6mchbJRIJJH3GSJd\"},{\"guid\":\"guWnq5lyxDSeCMGpmqK7\"},{\"guid\":\"pEfcbLIs2Cny7ZNy40os\"},{\"guid\":\"rYX5R8PDOdHfU117I66K\"},{\"guid\":\"5012135537361809904844885373685738424\"},{\"guid\":\"4v6sUoYEsSEoIHIYWN3K\"},{\"guid\":\"5010064645373610700053736864153624\"},{\"guid\":\"qFao9gm6q9mN15xkaXsy\"},{\"guid\":\"zVgWtSNXrNgY2fy5PNz1\"},{\"guid\":\"cI8nT9ssdCBNPLzRqIcQ\"},{\"guid\":\"9aOclLVKx9Ssa8v2TrZG\"},{\"guid\":\"iMYGT57Q4cMyOSvetURU\"},{\"guid\":\"cQOtpjQpauBa3n9A7B8g\"},{\"guid\":\"sHFHMtZTZwnGUhZDJ9cZ\"},{\"guid\":\"gWjVKBJNwoAZ0NBu1NNc\"},{\"guid\":\"7jQHEPm4jwswX8gdfkD8\"},{\"guid\":\"vyGVSzJUB8AnNUiEA3Cj\"},{\"guid\":\"XkpSChMg35bqsMxLE0d6\"},{\"guid\":\"HK4OFKUGqqpNLVzJVtXt\"},{\"guid\":\"2bn9jbz3CqSi6BT4SiFD\"},{\"guid\":\"ipNOzWqAe4MuCqf02KeU\"},{\"guid\":\"gIvcoJ6p6rLTLs3LklTW\"},{\"guid\":\"TQpsGB4wtLMKRAkRoctF\"},{\"guid\":\"WJb9sTbQAObDoFEQb8lE\"},{\"guid\":\"tEugR8YwFEu6rUSJrwEh\"},{\"guid\":\"TZGi9XvwFYCNAks20sZ2\"},{\"guid\":\"5010711907110205373698047581015373611480036024\"},{\"guid\":\"JKUdlxKe5E1OFwGsMLvA\"},{\"guid\":\"iQogO7wAcToEq6nEFrti\"},{\"guid\":\"IwF7RrmULPxnf3RMPpxz\"},{\"guid\":\"38qy7wdBFlmAfb6eLI65\"},{\"guid\":\"MBYAycnIXrUuAMQ9TI7G\"},{\"guid\":\"50143605115140215148604173641432\"},{\"guid\":\"fiinaseBc0It4vNITs8q\"},{\"guid\":\"n3WUV2iRQ6vsRdcBRT1u\"},{\"guid\":\"IPcxSR0gkYNzqUJ90rYt\"},{\"guid\":\"704kegiSq3pre64nRPsV\"},{\"guid\":\"mdZRnUmv6gOfpcu1GlRS\"},{\"guid\":\"qn3Y87zQnjRuldXVQ1HS\"},{\"guid\":\"nO5AJ34ZL4exnnpKmKQe\"},{\"guid\":\"VbipZIuJtqPsjYAouQdW\"},{\"guid\":\"sFHMDDNKhXGIBaDN2jh3\"},{\"guid\":\"QuQ9Z5alENKD59BzLFJ6\"},{\"guid\":\"50117537361070005373680336024\"},{\"guid\":\"rRwXXhOFVpBmYBNqB9yV\"},{\"guid\":\"hNpPD2CWtKIWrBshXD8j\"},{\"guid\":\"5HF3dRTLixtAxomI3kAZ\"},{\"guid\":\"5011305537361809904844885373689241224\"},{\"guid\":\"N94gwR02MzfgefqLJKv2\"},{\"guid\":\"asoxXEcgw7z6Bw1V2Nun\"},{\"guid\":\"3sqJA9Yx4qWGOANvf2Sh\"},{\"guid\":\"66Wr0P6UycdKn21jFxXN\"},{\"guid\":\"sQNSKBC31N3BsZOKra6w\"},{\"guid\":\"9UN2sdWYXT4vFNclYE8M\"},{\"guid\":\"DuxkfDpRegJ8SfJOOXhW\"},{\"guid\":\"1i3gWa0dD7C8MIHu88hS\"},{\"guid\":\"euPVR5QtCnI826QcBKRQ\"},{\"guid\":\"FnbE1IFFVsBTp0OcRoR4\"},{\"guid\":\"TuHGTomqjCQ0dwbb845p\"},{\"guid\":\"0OucvXVZYUUAL7bketWt\"},{\"guid\":\"pYoBmtWQUGXx8A06Prqz\"},{\"guid\":\"0agq4VG6cQwL1FgyMhwI\"},{\"guid\":\"myW2wWPqDfVivYBMFvNn\"},{\"guid\":\"dLMgHyPvhUHkrsmnt0ly\"},{\"guid\":\"25pZTLpUc7gXNdlBrt1N\"},{\"guid\":\"LhFbeS9titML4ljTVsLd\"},{\"guid\":\"HbP9gbBniGFhpaoILx3o\"},{\"guid\":\"CqlAHZzgqzSiZ8b3uY2g\"},{\"guid\":\"508102606537361070530491537369964036024\"},{\"guid\":\"fEUgEdfFXvMNeC647Vj2\"},{\"guid\":\"zRd5LJGvpgcrIcQQtwIb\"},{\"guid\":\"dWuY2vfoTuYGUyXq8KsD\"},{\"guid\":\"50106125373688043241815373691842424\"},{\"guid\":\"00au13ghcJYXlnyCvbub\"},{\"guid\":\"G3DDUwGH5j6Byp6hzbzU\"},{\"guid\":\"LjzhPjRkM9z3gwo4ruJ4\"},{\"guid\":\"xRuWMUJDv3VevpPEB5br\"},{\"guid\":\"iATaadWGaJyAvgpFRGNK\"},{\"guid\":\"FrmAbFtLT8lJxiDCfAOb\"},{\"guid\":\"6u7z7KJRDifXMSBO5WpO\"},{\"guid\":\"KBLP6OKC8vlS8tCNcQho\"},{\"guid\":\"9VlYFUmCMiFi2mhFlTXj\"},{\"guid\":\"E2fznkzO5r8BS4xmI4h2\"},{\"guid\":\"n0NTR4kzFo6cnJbr98hO\"},{\"guid\":\"0FXf4jCuhPqqlw8JSHIB\"},{\"guid\":\"509409537361070005373689241224\"},{\"guid\":\"50105002537361040005373672036024\"},{\"guid\":\"PwfZOIzLOre3ZOksRmYu\"},{\"guid\":\"GkIsu7RthmNCp8tg7yWT\"},{\"guid\":\"5lsj53cXo1HkjKjEHLaq\"},{\"guid\":\"5081075373670035381105373675036024\"},{\"guid\":\"yuo91iFrrStfAKW5leZP\"},{\"guid\":\"cMPtvDdXAIGNDfl87EV6\"},{\"guid\":\"9789B2FyBagBOgeQeqit\"},{\"guid\":\"5081025373670035381105373664032024\"},{\"guid\":\"nkwc2J6MOHwVp0MFPkMI\"},{\"guid\":\"kd9bmQB3WUB0d3vFwrpr\"},{\"guid\":\"MK5sLGiPa1W0Bjwy4yxC\"},{\"guid\":\"gRkZnm4RQJmiapUyCq8P\"},{\"guid\":\"rS07XS8uikqIz1hvUI4K\"},{\"guid\":\"DAsZ9tztrjrwnN9IoZoy\"},{\"guid\":\"REk9s2zpcAdb5q5ID3dY\"},{\"guid\":\"8PeVoSVuj4OUqjlXWuEi\"},{\"guid\":\"YS5mmEgHLqmIjEWVo5Ps\"},{\"guid\":\"5080093016537364069034971005373662322546099964036024\"},{\"guid\":\"5011032537361060005373680036024\"},{\"guid\":\"zEiHvs1TykVqBF8YmBi6\"},{\"guid\":\"XaZnpF4AU8eyNOO7lxwD\"},{\"guid\":\"SfmODZEMMZgXMovLPSw5\"},{\"guid\":\"xNO3kDRfdFX1IJxi16n4\"},{\"guid\":\"Hj3U9j6XDDd8LQISRRCE\"},{\"guid\":\"0bHRYTGLslOFNI2fvsYh\"},{\"guid\":\"gRWqH61N6EpGUqJVulFA\"},{\"guid\":\"0dEXe9nTlZobuLY4vWHc\"},{\"guid\":\"50157605115156215148604166737532\"},{\"guid\":\"KNsbEgAdBPyqfXaPqAwq\"},{\"guid\":\"25ocs5rBP3rAN4D3Ar58\"},{\"guid\":\"b1r3T83FnboeODAbmK5d\"},{\"guid\":\"IJ06MKdP5ajPjbwlJ71C\"},{\"guid\":\"2FkAkue4XuSRT0BHhII0\"},{\"guid\":\"cyh66Y3YbvvAMpRaWDzp\"},{\"guid\":\"5012991537361030005373680036024\"},{\"guid\":\"P0lO9ayHIhA4jR7NNmK7\"},{\"guid\":\"O5trgfIP1XZ7Rt908Col\"},{\"guid\":\"oiBhNtvmgwcE5RJ6MFql\"},{\"guid\":\"FQopDH4B4pCfjfmNUvI1\"},{\"guid\":\"RiIXZtxDhINun0JA4CNa\"},{\"guid\":\"TOCP3wKtggDC7P3OC6pA\"},{\"guid\":\"BbhzvrB3GSzQObf3Yoy5\"},{\"guid\":\"LU6PtYUpkqeicIrVaZkQ\"},{\"guid\":\"0Rg6WCa00E9VzLWx8vAN\"},{\"guid\":\"501471605115141215148604166737532\"},{\"guid\":\"bwtlGLS6rQunr8j7p3uN\"},{\"guid\":\"5012025537369904844885373671232024\"},{\"guid\":\"x7IcYerllSYwYyNYYKNA\"},{\"guid\":\"NcatJzeBrFDPYCJ0LhRQ\"},{\"guid\":\"50105537361040005373680036024\"},{\"guid\":\"9e0rD6OSfwgynoCjoeuV\"},{\"guid\":\"ZMuz47orK8sTJBso5mo4\"},{\"guid\":\"50101575373610500053736910451677900144030\"},{\"guid\":\"5010657537361070005373680036024\"},{\"guid\":\"GwYH6inQn9gRPaKnAHSE\"},{\"guid\":\"kJ5efzSozrOTVGuVmMwZ\"},{\"guid\":\"LZSoVAYjlcpwI7cM4qxo\"},{\"guid\":\"50102185537361070005373680036024\"},{\"guid\":\"508107537361070005373675036024\"},{\"guid\":\"GJTydT5liIrATXoaN4Pz\"},{\"guid\":\"7TdR12vTOHKc2h4sMBuL\"},{\"guid\":\"ni9AaOorTQbwcUZ8msCN\"},{\"guid\":\"uXb5mxCiE5L29SyeQxse\"},{\"guid\":\"NMGyPbU0TmxPVI74Uozx\"},{\"guid\":\"yjeVQHRKslueo2vecWcK\"},{\"guid\":\"20J1vfmEdoOlGh0rbwde\"},{\"guid\":\"pfBwMHVQHfijvqqMyfzZ\"},{\"guid\":\"zOl0B6K3kjgXVS93eNTE\"},{\"guid\":\"1xluT5Fxz43uKUEv1pWe\"},{\"guid\":\"Agamddy7pq5wPPSkNDqo\"},{\"guid\":\"mbmqZR4NWd141GysEAaK\"},{\"guid\":\"S6NTvnX679gsXVMLqjuq\"},{\"guid\":\"95dFOhpe5S6dN3c0bd3a\"},{\"guid\":\"5010657537361040005373671232024\"},{\"guid\":\"OQLVa33yUhWuFI1xOm9V\"},{\"guid\":\"emcGdd9mo8zpz61HxRc4\"},{\"guid\":\"I50BQE1ApPxPbfBdkA50\"},{\"guid\":\"Ni2qwbwAJUeYYFYeELYj\"},{\"guid\":\"J36L4ytQT4xEBSEZYBkT\"},{\"guid\":\"WIIgcoNxMYVOKVcM0A8v\"},{\"guid\":\"wdnSpjzNEHYISWDufEkl\"},{\"guid\":\"tB5cqR6XGYkyR9EeuPzA\"},{\"guid\":\"CuxN804q90N45pBHpj5T\"},{\"guid\":\"UA4C9IiYmNdzIZwTw93o\"},{\"guid\":\"vxzOltXSqT11aIL7mTC2\"},{\"guid\":\"50108537361070005373680036024\"},{\"guid\":\"POqohq2b2za6RIk0ShvG\"},{\"guid\":\"SmS3wx9v3Ex6STyx01yu\"},{\"guid\":\"IxwwQyw9ndW3slnFvgeo\"},{\"guid\":\"501213553736190102050051255373691841224\"},{\"guid\":\"Z12zdGgKOyKFE2RrHS9g\"},{\"guid\":\"A6b4NUjdBiV826FqMlBz\"},{\"guid\":\"I5A2Y5xwPg1tBSmMqQak\"},{\"guid\":\"9Dtkvkvj9xW7NOounKkd\"},{\"guid\":\"50154160511515415148604173641432\"},{\"guid\":\"CBd2PNPJInxs6uoQLJ30\"},{\"guid\":\"bN1MPOGtTJXBksmclKKV\"},{\"guid\":\"S5huD48w42Kq322VWMdF\"},{\"guid\":\"xPeiKublVrzfKfX0Udi2\"},{\"guid\":\"17OkH1sA1QhjVu6o6cNy\"},{\"guid\":\"FIHNAO7R7pw4XFe5vfDR\"},{\"guid\":\"5e56Gchoo3iYu8o0PwUO\"},{\"guid\":\"WxnhXMGX5fZjzhwYIOfB\"},{\"guid\":\"50709280537361030005373673241224\"},{\"guid\":\"Vj10J8VTQ9A0HkwpngxU\"},{\"guid\":\"52v3xSckBTPDt3BnhWdl\"},{\"guid\":\"5096505373696046641045373680036024\"},{\"guid\":\"50100646453736107000537361080192024\"},{\"guid\":\"xkWEppQ24b92aJzzJjVS\"},{\"guid\":\"5011505537361070005373678036024\"},{\"guid\":\"1aUbiLjNlgcpLeZ3FZh5\"},{\"guid\":\"p4w2DugZQ93Z5E34fhbj\"},{\"guid\":\"JlxTe7Ez63S24AC9cOwY\"},{\"guid\":\"6BQRbCGicRjnuNXt7VMX\"},{\"guid\":\"f6jMLtCelnd6bHZ8hQD1\"},{\"guid\":\"kGfC6QLjS7xoigwIzPbT\"},{\"guid\":\"QPwbT89gurwd3NDxsRD6\"},{\"guid\":\"6vbkmgEkqfNN1tvFHr2I\"},{\"guid\":\"wCy8wzWvu8W5BV2vWcWb\"},{\"guid\":\"9dTL1yqGoOhHa1EHI8Oj\"},{\"guid\":\"U8t1gibh1XjLyMFfUEUe\"},{\"guid\":\"jClgCSkgZGoiXdBBvU1H\"},{\"guid\":\"NEYjkCh1vtElHAQFAcNi\"},{\"guid\":\"5012135537361070005373685738424\"},{\"guid\":\"6jciWriZNFWaY681Q2lM\"},{\"guid\":\"zKQ5SDbhNW6M2bB8tfgm\"},{\"guid\":\"SHKoKqxEmgANO3iA6mUI\"},{\"guid\":\"eLNvIhU1MotzbQkkCwmy\"},{\"guid\":\"oYryhbYSbf2MvFYtONrV\"},{\"guid\":\"cKGINejFNqhVgM6fXqHz\"},{\"guid\":\"eZt1AUQtbycFm7IXXOGM\"},{\"guid\":\"50985373691044721645373677436024\"},{\"guid\":\"WTEBRqLtgPcnwMSZ8wbH\"},{\"guid\":\"MvBnznOenG27rFxTAYrN\"},{\"guid\":\"Nd8RvVTCwvdDcvDWSA80\"},{\"guid\":\"sTi2U0egtB9l8ELUIFBk\"},{\"guid\":\"R0ITEFEcr5kbyFtGzjyt\"},{\"guid\":\"WneU7ZBWKcq1TphfkM6m\"},{\"guid\":\"Rsqd6V98PU77xsLcYd7u\"},{\"guid\":\"5096002537361020005373678036024\"},{\"guid\":\"6a7YKetKsOWUjEmWqQZ5\"},{\"guid\":\"fgl92zzDm7VrNgYZFUTw\"},{\"guid\":\"Ed3mRMnDeD7LLIVg5Jro\"},{\"guid\":\"AvchgNEYauxTkZ0ueNZP\"},{\"guid\":\"fZBlnZDLAsjBIIh8ZbnI\"},{\"guid\":\"JX67sQDxP9Dg4w4VZhMX\"},{\"guid\":\"UZgk7psqaYTlaI9LLc8c\"},{\"guid\":\"5010400537361050005373673241224\"},{\"guid\":\"Wz8o2uZGYowTMATMgM1v\"},{\"guid\":\"eID6pG6FVNOyx08q3km8\"},{\"guid\":\"50961180610011537364010705304915373632600139764032024\"},{\"guid\":\"QTW1YmTppQKMoRQ5SQXb\"},{\"guid\":\"508102110195373640700353811053736312001010364032024\"},{\"guid\":\"501120712007200125373640106052491265373632501410889241224\"},{\"guid\":\"5010680119071102053736401020500578537364376001210882036024\"},{\"guid\":\"5010711907110205373640800398799537364286004811280036024\"},{\"guid\":\"sCEjV1az5qeMwjEl6pwu\"},{\"guid\":\"yBdObeJgWbvupVXHJ3NY\"},{\"guid\":\"ZeI5ngNBzMXikAwuCK2d\"},{\"guid\":\"7POELewP9KacrB25F9Hr\"},{\"guid\":\"H7Sdcfrt0Q1Q5Gzohhdi\"},{\"guid\":\"iqs20paceMcjpY7hEClC\"},{\"guid\":\"bVsNWTk1XTQH5WaJ56n5\"},{\"guid\":\"uEZBOJWZRAHhGSxGzjoe\"},{\"guid\":\"501065711907110205373640106052491265373632501410880036024\"},{\"guid\":\"klyUcaoeJbXBCzH2Q9uf\"},{\"guid\":\"501426051151892811422566737532\"},{\"guid\":\"TePGd1aGhJNKomJcLEgP\"},{\"guid\":\"XYPvVEC2g0D9VjTXlv1u\"},{\"guid\":\"50150160511515015148604166737532\"},{\"guid\":\"5016160511516115148604189641432\"},{\"guid\":\"kvjpPat2Llc8dvmbBRIT\"},{\"guid\":\"l1uyzLmOfuP9YJ5M1eyQ\"},{\"guid\":\"5011107120072001253736408704280141537364362002710986941224\"},{\"guid\":\"jbxaL9mjfLsLTp2wJTKb\"},{\"guid\":\"FxD9KT18wgAFmXmUJB3R\"},{\"guid\":\"NTUN0LSzzUKXDgEqh12L\"},{\"guid\":\"yaCfBWujmiVqtiWBQgw5\"},{\"guid\":\"cQ3nnupcXZ9lxfPhiQHq\"},{\"guid\":\"dcWUPrPrwGF8KhfqKNKZ\"},{\"guid\":\"s9IusIfrkwLx5JKrIH77\"},{\"guid\":\"50107119071102053736408003987995373632501410880036024\"},{\"guid\":\"MuziGqfJCeH6L8rRZqIW\"},{\"guid\":\"46d6lGl2FjIzgX2fPr4A\"},{\"guid\":\"3osZumVUgww9DG0U4Af2\"},{\"guid\":\"ZSRHUTalt6woA1HB5OJy\"},{\"guid\":\"YvDohTMZnOsGS6WltmwV\"},{\"guid\":\"5015260511515215148604166737532\"},{\"guid\":\"xUcYHsbPxCk9MNmWLyuz\"},{\"guid\":\"S33n2xY6sXyTs9SI4muz\"},{\"guid\":\"dOveq4IHE4rL613Hisiq\"},{\"guid\":\"NL7YfRQHgXMWUsjIsmKk\"},{\"guid\":\"sgWekspx7roSGKzVTZtN\"},{\"guid\":\"XKln0fZ965hXHN0YvE68\"},{\"guid\":\"W96or21wgrDSTfwK6c7K\"},{\"guid\":\"BK3wF3zYa0ufCCYYfoa6\"},{\"guid\":\"NXgdd3f60itdvfzVNOuy\"},{\"guid\":\"ThXtgT2MJzu4j4co9xz9\"},{\"guid\":\"33Dhy9ghfwC7rtBLfiuM\"},{\"guid\":\"hbVoJ5LELTXemoV5nB0p\"},{\"guid\":\"rfnH18GxFTbjzrnIQzsI\"},{\"guid\":\"1A5G9M3IQKLotYHtFJH0\"},{\"guid\":\"60tWIooDezcJ6BieaIkz\"},{\"guid\":\"6IJvZCuTcJf44MZmopS5\"},{\"guid\":\"YWsqdyGZQPq6FrvLjqmV\"},{\"guid\":\"MQmYYRjd7JJBRm1ostkC\"},{\"guid\":\"MPOzjyEiSvlhCDAHZDCg\"},{\"guid\":\"507129712485373640860424019853736320001210848085424\"},{\"guid\":\"cRQm1yfjSs1HXweXJLdg\"},{\"guid\":\"6wWmbnQCNxC200zFeK8F\"},{\"guid\":\"oLTx2CaO687VJ9pkcqSR\"},{\"guid\":\"UVRzVxk6Vpm8As5qpWs6\"},{\"guid\":\"tuqTPHKbKV0CDQr63Ven\"},{\"guid\":\"YOmpWmuQsfk6U5eJFHv5\"},{\"guid\":\"IQshON5DEoZ1fh0BAGee\"},{\"guid\":\"2StLGORP2K5hMoFtEp6m\"},{\"guid\":\"kuOm567v40bglR3tfsB9\"},{\"guid\":\"oPbcfiIaoHzfuzgg9uMj\"},{\"guid\":\"fbxeTdI8YxxUKRGzRSJP\"},{\"guid\":\"H91uqIlGISyYhLuV5zJv\"},{\"guid\":\"5081055537364010705304915373632600139772036024\"},{\"guid\":\"ayhuKQHK1LnKfjEGlY4j\"},{\"guid\":\"5060132729537364010605249126537364391103710464036024\"},{\"guid\":\"50810162171019012537364070035381105373632501410857032024\"},{\"guid\":\"5011212010050015373640100048968853736321001311378036024\"},{\"guid\":\"cORljdhTd8kL1SSnbyHm\"},{\"guid\":\"vxs07LHsCjbXA9zWijzO\"},{\"guid\":\"xYmxZKyPoYhzyPG6Zuij\"},{\"guid\":\"iG4DkSlyYfDUtax0khhX\"},{\"guid\":\"5010811907110205373640106052491265373632600189780036024\"},{\"guid\":\"o0b5ZnFHwwUvu2t6g7Wr\"},{\"guid\":\"KSsFuPtitwszvUuzzxC2\"},{\"guid\":\"50960041180610011537364079039451165373632200611064032024\"},{\"guid\":\"50107119071102053736401050519579537364384102911180036024\"},{\"guid\":\"rklpM2W1di6RbTeUldp1\"},{\"guid\":\"5016160511520821051613573641432\"},{\"guid\":\"4CIK8vGSGLqE973AO4HM\"},{\"guid\":\"DJ5sZtqX9ZsXh494UnI2\"},{\"guid\":\"6RfpDYlGWwuGpFKbZkZB\"},{\"guid\":\"lj5rGfnEyzgG9kb4m4fL\"},{\"guid\":\"5010064537361060005373692000768136624\"},{\"guid\":\"xRPN4GOZWgVtjKijwB36\"},{\"guid\":\"501171200720011537369704692985373610580336024\"},{\"guid\":\"nOht8T9QghXmVqW9jrHX\"},{\"guid\":\"yp4QxgOHY3dsOLYJnsoX\"},{\"guid\":\"G0P32a0qTB4JkaXp4aTt\"},{\"guid\":\"BLWt3iAHPfQYlQmN125A\"},{\"guid\":\"NKLubGfMlR63sEzsbgfC\"},{\"guid\":\"seXpj1SJHjKmPPHNbxKx\"},{\"guid\":\"vWM4IuFtJ8RS0gM4fZLD\"},{\"guid\":\"sIDIiLeVJsilvmwFj3aA\"},{\"guid\":\"50112537369704692985373678036024\"},{\"guid\":\"jco7gk1I3HoItTHFWnxT\"},{\"guid\":\"501081190711020537364010705304915373632600139782036024\"},{\"guid\":\"OA0tcpNLQ09cft3Ui3AF\"},{\"guid\":\"5010710119122200253736409704692985373632600179789241224\"},{\"guid\":\"sygkxBtUdFpf1oTM1Bk1\"},{\"guid\":\"5010657537361050005373680036024\"},{\"guid\":\"3xABk6HDHTgjeG6oW66A\"},{\"guid\":\"mQU30Us29XoGY6wwMCLG\"},{\"guid\":\"NXxZAd9D1riIz6rUqT5R\"},{\"guid\":\"sBr6wZHSnDnIxYpBDfPi\"},{\"guid\":\"DB9DqRkVhydFd5nwI2An\"},{\"guid\":\"501221753736190102050051255373691541224\"},{\"guid\":\"jDFkMENWdeOrvlooxRqR\"},{\"guid\":\"501203712108120165373640990484488537364385003211491541224\"},{\"guid\":\"AraDPYToayD5lBM9hRO3\"},{\"guid\":\"aYHCwPOC4B1HO7m3V2Te\"},{\"guid\":\"6tWg8tvePv8q794j2NKC\"},{\"guid\":\"U0GlkQrMjFRLVV93gwzb\"},{\"guid\":\"R9gZROSyXkdJ9lfdO6Dh\"},{\"guid\":\"heNupv6bVgtqYUFfHMdV\"},{\"guid\":\"zKVJ4wvdRTanKzYTS0i0\"},{\"guid\":\"BSxxgrD9BJgIhNazo96d\"},{\"guid\":\"naNj7djO1idBg6be9A2y\"},{\"guid\":\"0KenxZC8dcbK452GGKAs\"},{\"guid\":\"5HyXf6pupAtuuBbxlfEA\"},{\"guid\":\"mfNiTByTUFFnuorllh3e\"},{\"guid\":\"nnqBCOWPMArbkLmwElxb\"},{\"guid\":\"Aigo186w5yLAPWfVbaDq\"},{\"guid\":\"50107119071102053736409104472120537364325003617080036024\"},{\"guid\":\"9J9nWgeie0evQJMJWZuI\"},{\"guid\":\"wbs7nmKcABoUV4q1fqWN\"},{\"guid\":\"kgufjNXYWqPS1RG8K2Rc\"},{\"guid\":\"htTKXWEqswyy0RbZkEog\"},{\"guid\":\"VJMdqjxCXcFbUzg2T6Fk\"},{\"guid\":\"oFW2jQ9f9xK5Tc1Ku2rA\"},{\"guid\":\"QILldQlnjJxUaomCG1tz\"},{\"guid\":\"ESsLqbng9Zx3mVIm5hfS\"},{\"guid\":\"o19r5q4UfdAWSgQnCuJl\"},{\"guid\":\"50106119071102053736105051951365373611182036024\"},{\"guid\":\"gY3W1xoEZUdYyhK4gSlh\"},{\"guid\":\"U756y6JRrD0sNw5VzYn1\"},{\"guid\":\"5096537361070005373664032024\"},{\"guid\":\"ILsT84JPZfbNoP1BXwdi\"},{\"guid\":\"50110155373610004896795373681138524\"},{\"guid\":\"PpgsqJyToBZkAhB6kO31\"},{\"guid\":\"VaHAWbQCsArkE8jigLl5\"},{\"guid\":\"UB27WmNpIeoJMxQg9fcO\"},{\"guid\":\"DeHQSJLkdqclzYeenuYy\"},{\"guid\":\"vKkYJ0ruH4XwFXsW6ZMI\"},{\"guid\":\"RFZy28qJyAnrMyIGZ5ey\"},{\"guid\":\"ZgkmPpEcIsWQof9NHG8v\"},{\"guid\":\"MvoX1Zn8UWlfgnbKv4UF\"},{\"guid\":\"X5wwMOLQZ1aaG9RcujQi\"},{\"guid\":\"5vOSfD3hfoA1EVTVOijX\"},{\"guid\":\"ZDwpbXRfP710iDgX40Wi\"},{\"guid\":\"DSfRqGO9FQ4m5zHj8YBh\"},{\"guid\":\"f2vCFPsCLxJbNJgIQ137\"},{\"guid\":\"zJYs8be5cN5UfVYEJEIL\"},{\"guid\":\"HvxKxNFc2qq7uk0iWo8y\"},{\"guid\":\"5010811907110205373640106052491265373632600139780036024\"},{\"guid\":\"Zoz7FRyaqEdrLppDWR6O\"},{\"guid\":\"dxtFleRPRu1qwc5yS3ej\"},{\"guid\":\"2bsKF1mXJ2Ui92vFLf8j\"},{\"guid\":\"6dYAakMlQ3LhNPtMZ6Lx\"},{\"guid\":\"C1NFqVgDFsZ1DxsOo1QN\"},{\"guid\":\"TzWgcjekNvXsJjYYZoVg\"},{\"guid\":\"5ztG8ouHSRIbLAvf3EbJ\"},{\"guid\":\"5099501180610011537364069034971005373684641224\"},{\"guid\":\"PFc0SGrcn9pNDW2A36i8\"},{\"guid\":\"NrssQV32CWriEaoEMK31\"},{\"guid\":\"rOK3HTEZuUfrBBkS0ZpX\"},{\"guid\":\"5081002537369704692985373657032024\"},{\"guid\":\"VGN4teBKe2lYIQpUoLq9\"},{\"guid\":\"50115537361070005373680636024\"},{\"guid\":\"5012135537361050005373685738424\"},{\"guid\":\"EFeeKO2qCjBdYFg7g1DW\"},{\"guid\":\"IKVLVI6RIBcenVwvlETI\"},{\"guid\":\"3A5gzC4Wa61ZE1NRRG4G\"},{\"guid\":\"50160360511516015148604189641432\"},{\"guid\":\"z88mhNpNOotRZ7l0XUep\"},{\"guid\":\"ihw2raVdU07ztUcRrRHC\"},{\"guid\":\"WWE3jJh0aLyvc7i0TIHL\"},{\"guid\":\"509295373679039451165373691842424\"},{\"guid\":\"QVdQfdKIrtWUxTz2iwCI\"},{\"guid\":\"50107537368904389725373680036024\"},{\"guid\":\"Q6brB3rrYyIVU3gtkgJk\"},{\"guid\":\"PshgYwLwXX9pqYOCmyMp\"},{\"guid\":\"Yw63BVGyRyAkQkckJYNZ\"},{\"guid\":\"2X7I3y7otLdHqCtUxXrL\"},{\"guid\":\"i3j2GBcd8MXfqq5rMhPd\"},{\"guid\":\"Y6aj2VGKQ98FsSOf8kxG\"},{\"guid\":\"dy0XNpQQTJycpHY6LEGq\"},{\"guid\":\"50106571190711020537364010305060715373632501410880036024\"},{\"guid\":\"ABXoFAKQ6Uxcv7nwbi6w\"},{\"guid\":\"dQJ9qCIcu3ovm685kANZ\"},{\"guid\":\"g2bhNmPNzfeVyoOO5Sym\"},{\"guid\":\"DbfHRGNPFJj2Peq3LBrU\"},{\"guid\":\"50810711019537364010004896795373632500410875036024\"},{\"guid\":\"eOwkMMB616d8HyCguYqE\"},{\"guid\":\"appJylVMqNhrT7AY1bvp\"},{\"guid\":\"krD79oWE38uA4rDqWpOM\"},{\"guid\":\"VD0fiCnslFIVlj55q9r7\"},{\"guid\":\"BxULw3R7tWfkDlEdoIQB\"},{\"guid\":\"6q94MAG9uWVMoMo8fOsa\"},{\"guid\":\"GwSfxlCpdO5wFVZUbMay\"},{\"guid\":\"iHPs5Na3qSxo3fEmRKMF\"},{\"guid\":\"YCMZI7lLRlez09cgiMto\"},{\"guid\":\"Gx4rWdIwGMDo8XJOAkf1\"},{\"guid\":\"501165373693045776253736118852224\"},{\"guid\":\"nL0XhrxxFULuLEIOtS70\"},{\"guid\":\"1Rf4n5SThJZmXe5Icj4L\"},{\"guid\":\"ZFD1TD8PLF7k1tZPJocS\"},{\"guid\":\"TYGKlM9E77xCTZRuKFxn\"},{\"guid\":\"5qyF89UGUgO4HWnXToFn\"},{\"guid\":\"501006464537361030506011453736768136624\"},{\"guid\":\"nIOChyIuYItlFe4xBoSx\"},{\"guid\":\"USJPUryzZQ1o5GIMSiRz\"},{\"guid\":\"pPWUs7ORoE3WMsOBLu8y\"},{\"guid\":\"50116615373690044302105373680636024\"},{\"guid\":\"Unllcdbvb9jEFgWPgdQB\"},{\"guid\":\"5YAAF5CyaPUTa584nfdo\"},{\"guid\":\"QVakglWLYfopZHe1VUyN\"},{\"guid\":\"77q79cL8Pz2RT5Hhtlx5\"},{\"guid\":\"5011305537361070005373678036024\"},{\"guid\":\"CJ7xpfjPXq4hvXUnYsLT\"},{\"guid\":\"nxeGLbBGrplbSztW0mGp\"},{\"guid\":\"ppFI65vXXl58k11DkLsq\"},{\"guid\":\"V2ZG0zcSuHara17e4tVP\"},{\"guid\":\"TgfkNkYtOUxRWpWJbQmd\"},{\"guid\":\"9pDfWMCql97FSTxBo8iJ\"},{\"guid\":\"N5WUlgrFgacTR6jy558f\"},{\"guid\":\"qNb9vpKFfVkpPVdTkPOc\"},{\"guid\":\"VislLX6WFsJbZ4Brx069\"},{\"guid\":\"Voz7kXSTCFnAR0yBeWN5\"},{\"guid\":\"fmxHoY2mrEtEOBXDMdjm\"},{\"guid\":\"X5OeUwYfCU4z0HIXwKhl\"},{\"guid\":\"3Tl74Lb5YW2JwwJ3S9Yu\"},{\"guid\":\"5Iv5YQGZoZI2z9YaWHKp\"},{\"guid\":\"dGiUzxFGERrJYDYpDGB8\"},{\"guid\":\"GM08IfR1HdLJENmLfIZS\"},{\"guid\":\"nlHhMDflX4eDn4NAa1lX\"},{\"guid\":\"FccZtQ8OeHnWTsZ2s7U1\"},{\"guid\":\"PUr96BcsLRmXwYS69qZi\"},{\"guid\":\"s4D7kCDgOPBMLAkbixdn\"},{\"guid\":\"5010657537368003987995373680036024\"},{\"guid\":\"5081065011019537364096046649253736260380036024\"},{\"guid\":\"NxJBSIt773prXhcRGE4X\"},{\"guid\":\"qfyyZVoTe593gbbRZMsb\"},{\"guid\":\"RNAZaafL9o6ihF65fiX3\"},{\"guid\":\"50100131190711020537364094046068553736318001610574036024\"},{\"guid\":\"vWmmNXMebo0Q77u6Gtf6\"},{\"guid\":\"dTGa0wmY6FuhKJz9nDFN\"},{\"guid\":\"501021190711020537369004430825373611478036024\"},{\"guid\":\"LtDaf5mqGYWM5utshpI5\"},{\"guid\":\"zTYRlberW5I23ASKk5BR\"},{\"guid\":\"501141200720011537364010205005125537364391103710480036024\"},{\"guid\":\"fwRyyKOnEuTmIK4UV0sA\"},{\"guid\":\"Qg6iJDFQowSAFUwVYTjj\"},{\"guid\":\"VaH81p4yUDGRmcpWFl2Q\"},{\"guid\":\"5011107120072001253736401060524912653736271581138524\"},{\"guid\":\"yGdq3HVUMsJJWicyfLO4\"},{\"guid\":\"Ebor56YeTlH608R8vzy8\"},{\"guid\":\"UeiyYZtj3v6zRpfCmAK8\"},{\"guid\":\"nT3OZCIBwRh8fCjkDt6K\"},{\"guid\":\"508006001170623032537364070035381105373620221050601042156821682341224\"},{\"guid\":\"MLy10K7mRfqEZnmd9hTO\"},{\"guid\":\"wVxF5fvF83YExgY2K4EN\"},{\"guid\":\"1iWwUoKOs61TSzeuhsog\"},{\"guid\":\"deCrAyN9HaPJCr1nmvrD\"},{\"guid\":\"llmVrGSUQZxpX8YU0JwG\"},{\"guid\":\"Uq1bCdKPxERjB7fIV2sA\"},{\"guid\":\"yU4EHsqX4EmkBg6dqiGb\"},{\"guid\":\"hSNcEXWbNgPBFmooCBnM\"},{\"guid\":\"etbRbLt7d358ttwc9Pkv\"},{\"guid\":\"MuOwa2Dh1QneyLfDIMVA\"},{\"guid\":\"xOtE7jpxrPsux4kWqSDw\"},{\"guid\":\"qbKchoGWEr8pP71CSj7s\"},{\"guid\":\"quHUXUxjprxbbIAk0W6c\"},{\"guid\":\"507031090537364064032821375373632600179773241224\"},{\"guid\":\"h53edH2tz8FGn2bpbFhc\"},{\"guid\":\"0j8uvXRnNGlVudaAYCKh\"},{\"guid\":\"gF431wzV1uwSKNGY7Zco\"},{\"guid\":\"vtfhcRBHiwBdcL1SObQH\"},{\"guid\":\"s0h6Dd9SJnzqNPyPAHfl\"},{\"guid\":\"5012127537361070005373691541224\"},{\"guid\":\"GAxkEP5JRGCxzOZkeZ1w\"},{\"guid\":\"50116537361060005373680036024\"},{\"guid\":\"S82SutGLdtnh0msW2TxM\"},{\"guid\":\"OCaATnV4wCMky0qdN5bL\"},{\"guid\":\"50100646453736101049514153736768136624\"},{\"guid\":\"laHx3yf0JShTkPH7NY12\"},{\"guid\":\"8hW1nuxNNr1PEajuKcNl\"},{\"guid\":\"xYaED5mIBEoM2XMn8XJr\"},{\"guid\":\"gClw5lJknCbaRxibeSoE\"},{\"guid\":\"Qq7lQsMs1lhweqIi0kl4\"},{\"guid\":\"jRnb6glyKZgchUzXoWJv\"},{\"guid\":\"5OTxFpKtUF46iE6UgVxU\"},{\"guid\":\"etjhpD5wspawqMXGS0rp\"},{\"guid\":\"2pTlsMXYL0SBfjwumhxU\"},{\"guid\":\"vqUk9odt47R5mIaAFwDt\"},{\"guid\":\"cUMNFyvFJj6ZRXAebCNv\"},{\"guid\":\"5010165373685041831015373667037724\"},{\"guid\":\"IQrxRrPv4cnjfKowvui1\"},{\"guid\":\"DlETyppgI8ZBf27gNi5S\"},{\"guid\":\"50108537361010005373680036024\"},{\"guid\":\"oIYuOFx3CMms6SK3654O\"},{\"guid\":\"5011037537361040005373685438524\"},{\"guid\":\"5016260511516115148604181237532\"},{\"guid\":\"9QRNMXd0IEh06jcc6nIj\"},{\"guid\":\"xiJeV20jYmfifsieAaAq\"},{\"guid\":\"a0437T6FcZF7CGVCxumm\"},{\"guid\":\"m0CMiqkxM6AZRZy6w64I\"},{\"guid\":\"5011665537369404606855373680636024\"},{\"guid\":\"50111071200720012537364010605249126537364390002710586941224\"},{\"guid\":\"GwJOEyAS5BJEFDo7sUeG\"},{\"guid\":\"54GwRZwBaxooX0sNVDQt\"},{\"guid\":\"5016160511516115148604166737532\"},{\"guid\":\"84W3N9ZXihc0fuF0cEls\"},{\"guid\":\"5011512007200115373640940460685537364389004211180636024\"},{\"guid\":\"yFWASdhbFlP0kGcpZqmz\"},{\"guid\":\"ihZ61DR14NXdryxaP46p\"},{\"guid\":\"VpwHGlUx02hjmrEbb03z\"},{\"guid\":\"508003131537366803440915373672036024\"},{\"guid\":\"501050061190711020537364010405112975373664022546263557032024\"},{\"guid\":\"NFYWln43iv4Odg7PSRZw\"},{\"guid\":\"501255605115121215148604166737532\"},{\"guid\":\"FToeXVKFj6HJf0yMOc89\"},{\"guid\":\"pQWGvPDf5VFq8oEb7KXr\"},{\"guid\":\"o3irGzzGlj3uad9kV9E1\"},{\"guid\":\"50146605115141115148604184439032\"},{\"guid\":\"509653537369304577825373680036024\"},{\"guid\":\"Vt6kpq3OZUZ0j7uuXi23\"},{\"guid\":\"EpMcwS8g7ZtqDNzCbvrj\"},{\"guid\":\"em1p2gE0HAWxzksEf9dB\"},{\"guid\":\"qh0wnV9LUNObDxrfvvQJ\"},{\"guid\":\"50107537361060005373691842424\"},{\"guid\":\"Scj5QpWI3HZwMsB6Jdsl\"},{\"guid\":\"WCe9zUprEVfiqHrN4N5u\"},{\"guid\":\"Gzr0Zdt7rN5c6e1x6R6r\"},{\"guid\":\"hZebfJbePANb6VDDPEXR\"},{\"guid\":\"Pxk6dwOZGph9xbVfpPNZ\"},{\"guid\":\"6dnl4f1qwghHrDT323Xt\"},{\"guid\":\"ltzKLjFUurff29yPRh0K\"},{\"guid\":\"F4S7E65GtBqvvuhIaD5C\"},{\"guid\":\"50122040537369404606715373687339324\"},{\"guid\":\"3DCxI7r23Mlwwfut10bz\"},{\"guid\":\"50106575373610004896885373680036024\"},{\"guid\":\"5012125537361020005373685438524\"},{\"guid\":\"Uzgeyk6XiSTlwfQFZ4f6\"},{\"guid\":\"501003537361070005373676036024\"},{\"guid\":\"AXdQJhTY8BQlVMBujsz0\"},{\"guid\":\"6tNX9JwC6Bxk1uhuOuvv\"},{\"guid\":\"5010711907110205373640800398799537362022109040102194821680036024\"},{\"guid\":\"5012125537361030005373685438524\"},{\"guid\":\"7Q7B4UBf5EX8o6iMJG8F\"},{\"guid\":\"IMsKVIC1svHDMxSpZUdn\"},{\"guid\":\"gmX5bYacLhCNWeGlpqIu\"},{\"guid\":\"50108537369904844735373680036024\"},{\"guid\":\"996nWPdgHS45wMgkRUSb\"},{\"guid\":\"cuTmDbn2aL8s2VWDfLTb\"},{\"guid\":\"wyzI1ES4cZtx7fq2aPGp\"},{\"guid\":\"cCE98sdEjXgj0uId7XPn\"},{\"guid\":\"PVcBTA8DsNd3yWa9N9cQ\"},{\"guid\":\"Dd84Jopd7CgjMjClgTNt\"},{\"guid\":\"eoyvzvMbcSOriyLPswos\"},{\"guid\":\"qa9hAOsssT0kLei2WBy4\"},{\"guid\":\"50116120072001153736409304577625373622070110227180036024\"},{\"guid\":\"MBOWf5Y4ksOr9Em4p0S1\"},{\"guid\":\"5012125121081201653736409604664104537362022504040102544821691541224\"},{\"guid\":\"rGimukbwM9P0gw4LfLx7\"}]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `surveys_questions`
--

CREATE TABLE `surveys_questions` (
  `id` int(11) NOT NULL,
  `client_id` int(12) UNSIGNED DEFAULT NULL,
  `survey_id` varchar(12) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `instructions` varchar(1000) DEFAULT NULL,
  `answer_type` varchar(32) DEFAULT 'multiple',
  `options` text DEFAULT NULL,
  `is_required` enum('0','1') NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `surveys_questions`
--

INSERT INTO `surveys_questions` (`id`, `client_id`, `survey_id`, `title`, `instructions`, `answer_type`, `options`, `is_required`, `date_created`, `status`, `created_by`) VALUES
(1, 1, '1', 'Promising Influencer OTY', '', 'multiple', '[\"@Ruf_ayi\",\"@nanaKwameFlex\",\"@fawogyimiiko\",\"@Sark_Lawyer\",\"@akosuaampofowah\",\"@Afia_Dimple\",\"@AddyMavis\",\"@dr_doreeeen\",\"@Berneese_\",\"@ama_serwaaa\",\"@naturewaaa\",\"@akuahwritess\",\"@ama_adoma\"]', '0', '2022-11-03 21:14:04', '1', '1'),
(2, 1, '1', 'Diaspora Tweep OTY', '', 'multiple', '[\"@_papayawgh\",\"@nickirich14\",\"@worldofowusu\",\"@ohemaakaly\",\"@toriious\",\"@dj_backyard\"]', '0', '2022-11-03 21:14:04', '1', '1'),
(3, 1, '1', 'Football Banter OTY', '', 'multiple', '[\"@thatEsselGuy\",\"@Opresii\",\"@MmoaNkoaaa\",\"@the_marcoli_boy\",\"@KayPoissonOne\",\"@AsabereRoland\",\"@ilatif\",\"@founda\",\"@KeleweleJoint\",\"@_gyesi\",\"@the_presider\",\"@_sharyf\",\"@ellyserwaaa\",\"@Teemah433\"]', '0', '2022-11-03 21:14:04', '1', '1'),
(4, 1, '1', 'Best Punter OTY', '', 'multiple', '[\"@fawogyimiiko\",\"@Bonty_Official_\",\"@Opresii\",\"@LilMoGh\",\"@GhanamanTips\",\"@safesliptips\",\"@enokay69\",\"@iam_presider\",\"@GioPredictor\",\"@GameAnalyst3\",\"@ama_etwepa1\"]', '0', '2022-11-03 21:14:04', '1', '1'),
(5, 1, '1', 'Sports Influencer OTY', '', 'multiple', '[\"Owuraku Ampofo\",\"Benaiah\",\"Fancy Dimaria\",\"Saddick Adams\",\"Kwame Dela\",\"Juliet Bawuah\",\"Yaw Ampofo\"]', '0', '2022-11-03 21:14:04', '1', '1'),
(6, 1, '1', 'Twitter Space OTY', '', 'multiple', '[\"Drive Sneaker Nyame\",\"Vawulence Space\",\"Sports Corner\",\"Find A Match\",\"Kalyjay Space\",\"DNBP\",\"SpacesWithEdwardAsare\"]', '0', '2022-11-03 21:14:04', '1', '1'),
(7, 1, '1', 'SME (Small and Medium Enterprise) OTY', '', 'multiple', '[\"@ForLinkIn\",\"@Shaibu_AB\",\"@thetoosweetguy\",\"@Efo_Edem\",\"@LegonMedikal\",\"@MohPlayInc_\",\"@KwabsGroups\",\"@HazardJerseyHub\",\"@yaa_purple954\",\"@sister_Grr\",\"@ForeverPurple17\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(8, 1, '1', 'SME (Small and Medium Enterprise) OTY', '', 'multiple', '[\"@ForLinkIn\",\"@Shaibu_AB\",\"@thetoosweetguy\",\"@Efo_Edem\",\"@LegonMedikal\",\"@MohPlayInc_\",\"@KwabsGroups\",\"@HazardJerseyHub\",\"@yaa_purple954\",\"@sister_Grr\",\"@ForeverPurple17\"]', '0', '2022-11-03 21:21:38', '0', '1'),
(9, 1, '1', 'Most Engaging Tweep OTY', '', 'multiple', '[\"@Kojo_Bankz99\",\"@Kayjnr10\",\"@adofoasa_\",\"@IzzatElKhawaja\",\"@lawslaw\",\"@Kwame_Oliver\",\"@MmoaNkoaaa\",\"@unrulyking00\",\"@Iamabena\",\"@Ghana_Yesu\",\"@amaadoma\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(10, 1, '1', 'Most Engaging Celebrity OTY', '', 'multiple', '[\"@CAPTAINPLANETGH\",\"@Anita_Akuffo\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(11, 1, '1', 'Political Influencer OTY', '', 'multiple', '[\"@AnnanPerry\",\"@quame_age\",\"@CheEsquire\",\"@GhanaSocialU\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(12, 1, '1', 'Photographer OTY', '', 'multiple', '[\"@__theseyram\",\"@iamwizgh\",\"@Kormla4\",\"@olando_shots\",\"@tysonphoto\",\"@IkeDeModel1\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(13, 1, '1', 'Artiste Fanbase OTY', '', 'multiple', '[\"Sarknation\",\"Bhimnation\",\"Shatta Movement\",\"Blacko Tribe\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(14, 1, '1', 'Funniest Tweep OTY', '', 'multiple', '[\"@KayPoissonOne\",\"@Opresii\",\"@SneakerNyame_\",\"@Jason_gh1\",\"@koboateng\",\"@thatEsselguy\",\"@daddys_girltn\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(15, 1, '1', 'Influencer OTY', '', 'multiple', '[\"@AsieduMends\", \"@SneakerNyame_\", \"@BenopaOnyx1\", \"@Gyaigyimii\", \"@Opresii\", \"@thatEsselguy\", \"@Kayjnr10\", \"@_liptonia\", \"@daddys_girltn\", \"@Efua_ampofoa\", \"@Aboa_Banku1\", \"@the_marcoli_boy\", \"@KayPoissonOne\", \"@Jason_gh1\", \"@ellyserwaaa\", \"@I_Am_Winter\", \"@Ghana_Yesu\", \"@ilatif\", \"@_Sharyf\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(16, 1, '1', 'Music Promoter OTY', '', 'multiple', '[\"@Donsarkcess\",\"@okt_ranking30\",\"@Aboa_Banku1\",\"@the_marcoli_boy\",\"@Ghana_Yesu_\",\"@MmoaNkoaaa\",\"@SneakerNyame_\",\"@unrulyking00\",\"@ama_adoma\"]', '0', '2022-11-03 21:21:38', '1', '1'),
(17, 1, '1', 'Trend/Promo Team OTY', '', 'multiple', '[\"A1 Influencers\",\"Ultimate Trends\",\"SPL\",\"Gigs Fie\"]', '0', '2022-11-03 21:28:35', '1', '1'),
(18, 1, '1', 'Content Creator OTY:', '', 'multiple', '[\"Aboa Banku & Papsy\",\"@davidentertaina\",\"@sdkdele\",\"@thepowderguy1\",\"@ComedianWaris\",\"@madeinghana\",\"@fixondennis\",\"@HeadlessYoutube\",\"@kwadwosheldon\",\"@EvianaGh\",\"@Wode_Maya\",\"@SportsCorner\"]', '0', '2022-11-03 21:28:35', '1', '1'),
(19, 1, '1', 'Health Influencer OTY:', '', 'multiple', '[\"@GeorgeAnagli\",\"@medSaaka\",\"@dr_doreeeen\",\"@officialSilasMD\",\"@kwesi_bimpe\"]', '0', '2022-11-03 21:28:35', '1', '1'),
(20, 1, '1', 'Tech Brand OTY', '', 'multiple', '[\"MohPlay Inc\",\"For LinkIn\",\"Zeepay\",\"Kumasi Hive\"]', '0', '2022-11-03 21:28:35', '1', '1'),
(21, 1, '1', 'Cryptocurrency / Forex Brand OTY', '', 'multiple', '[\"@Apkjnr\",\"@KojoForex\",\"@manofserendipty\",\"@efo_phil\",\"@huclark_\",\"@_owula\",\"@leslie_kkay\",\"@joesacky\",\"@B_Bestbrain\",\"@Ghcryptoguy\",\"@Binanceafrica\",\"@bitsika\"]', '0', '2022-11-03 21:28:35', '1', '1'),
(22, 1, '1', 'Radio/TV Show OTY', '', 'multiple', '[\"Date Rush on @tv3_ghana\",\"United Showbiz on @utvghana\",\"Showbiz 360 on @tv3_ghana\",\"National Science & Maths Quiz\",\"Citi CBS on @citi973\",\"Pure Drive on @pure957fm\",\"JOY SMS on @joy997fmDay\",\"Break Hitz – Hitz FM (Andy Dosty)\",\"Entertainment Review – Peace FM (Kwesi Aboagye)\",\"Showbiz A to Z – Joy FM (George Quaye)\",\"For the culture – ABN Radio One (Porfolio and DJ Slim)\",\"Entertainment GH – Neat FM (Ola Michael)\"]', '0', '2022-11-03 21:28:35', '1', '1'),
(23, 1, '1', 'Brand OTY', '', 'multiple', '[\"Caveman Watches\",\"Jumia Ghana\",\"MTN Ghana\",\"Glovo\"]', '0', '2022-11-03 21:28:35', '1', '1'),
(24, 1, '1', 'Personality Brand OTY', '', 'multiple', '[\"Anthony Dzamefe\",\"Cynthia Quarcoo\",\"Bernard Avle\",\"Gary Al Smith\",\"Ivy Barley\",\"Juliet Bawuah\",\"Bright Simons\"]', '0', '2022-11-03 21:28:35', '1', '1');

-- --------------------------------------------------------

--
-- Table structure for table `surveys_votes`
--

CREATE TABLE `surveys_votes` (
  `id` int(11) NOT NULL,
  `client_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `survey_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `question_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `votes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `surveys_votes`
--

INSERT INTO `surveys_votes` (`id`, `client_id`, `survey_id`, `question_id`, `votes`) VALUES
(1, NULL, 1, 1, '{\"4\":206,\"1\":78,\"9\":163,\"12\":212,\"13\":179,\"7\":101,\"skipped\":940,\"10\":186,\"8\":182,\"6\":340,\"2\":192,\"11\":26,\"3\":141,\"5\":60}'),
(2, NULL, 1, 2, '{\"1\":317,\"2\":221,\"skipped\":1297,\"6\":535,\"4\":269,\"5\":171,\"3\":195}'),
(3, NULL, 1, 3, '{\"2\":662,\"1\":329,\"5\":194,\"11\":124,\"10\":32,\"14\":102,\"3\":64,\"4\":82,\"8\":40,\"skipped\":1005,\"13\":65,\"7\":126,\"12\":57,\"6\":50,\"9\":71}'),
(4, NULL, 1, 4, '{\"skipped\":529,\"5\":534,\"8\":58,\"3\":492,\"1\":84,\"4\":826,\"11\":88,\"7\":100,\"10\":91,\"9\":124,\"2\":54,\"6\":21}'),
(5, NULL, 1, 5, '{\"1\":479,\"5\":225,\"7\":132,\"3\":112,\"6\":380,\"skipped\":733,\"4\":900,\"2\":39}'),
(6, NULL, 1, 6, '{\"5\":912,\"3\":241,\"1\":565,\"skipped\":824,\"2\":232,\"4\":75,\"7\":90,\"6\":61}'),
(7, NULL, 1, 7, '{\"6\":122,\"10\":87,\"2\":345,\"11\":163,\"skipped\":1153,\"3\":134,\"8\":226,\"9\":146,\"4\":231,\"5\":176,\"1\":101,\"7\":116}'),
(8, NULL, 1, 9, '{\"6\":228,\"9\":60,\"2\":277,\"5\":210,\"1\":60,\"skipped\":1091,\"8\":82,\"4\":167,\"10\":523,\"11\":124,\"7\":102,\"3\":76}'),
(9, NULL, 1, 10, '{\"1\":824,\"2\":1361,\"skipped\":814}'),
(10, NULL, 1, 11, '{\"4\":503,\"2\":521,\"skipped\":1297,\"1\":564,\"3\":114}'),
(11, NULL, 1, 12, '{\"1\":1126,\"3\":171,\"skipped\":1130,\"2\":111,\"6\":118,\"4\":252,\"5\":91}'),
(12, NULL, 1, 13, '{\"3\":369,\"4\":836,\"1\":741,\"skipped\":633,\"2\":420}'),
(13, NULL, 1, 14, '{\"3\":509,\"6\":225,\"2\":623,\"5\":155,\"skipped\":919,\"7\":111,\"1\":296,\"4\":157}'),
(14, NULL, 1, 15, '{\"4\":890,\"6\":66,\"1\":140,\"19\":38,\"2\":213,\"5\":183,\"9\":24,\"skipped\":811,\"3\":37,\"16\":41,\"7\":86,\"12\":26,\"17\":135,\"11\":44,\"10\":59,\"8\":24,\"13\":61,\"15\":46,\"14\":31,\"18\":40}'),
(15, NULL, 1, 16, '{\"7\":726,\"1\":438,\"2\":72,\"3\":164,\"skipped\":1012,\"8\":92,\"5\":222,\"9\":142,\"4\":74,\"6\":53}'),
(16, NULL, 1, 17, '{\"skipped\":1431,\"2\":463,\"1\":759,\"4\":164,\"3\":178}'),
(17, NULL, 1, 18, '{\"11\":265,\"12\":118,\"8\":93,\"3\":771,\"9\":535,\"4\":89,\"2\":27,\"skipped\":722,\"1\":116,\"6\":76,\"7\":30,\"5\":131,\"10\":21}'),
(18, NULL, 1, 19, '{\"1\":504,\"4\":225,\"skipped\":1238,\"3\":765,\"2\":100,\"5\":162}'),
(19, NULL, 1, 20, '{\"4\":227,\"1\":359,\"3\":905,\"2\":307,\"skipped\":1196}'),
(20, NULL, 1, 21, '{\"11\":205,\"5\":46,\"7\":226,\"12\":291,\"skipped\":1280,\"2\":394,\"8\":44,\"1\":79,\"10\":176,\"9\":43,\"4\":73,\"6\":78,\"3\":56}'),
(21, NULL, 1, 22, '{\"5\":138,\"2\":376,\"4\":705,\"1\":580,\"skipped\":741,\"6\":60,\"3\":97,\"7\":46,\"9\":35,\"12\":32,\"8\":88,\"10\":38,\"11\":55}'),
(22, NULL, 1, 23, '{\"1\":506,\"2\":516,\"skipped\":842,\"4\":386,\"3\":741}'),
(23, NULL, 1, 24, '{\"1\":149,\"6\":807,\"3\":445,\"4\":429,\"skipped\":890,\"2\":59,\"7\":103,\"5\":109}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `client_id` smallint(12) UNSIGNED DEFAULT NULL,
  `index_number` char(32) DEFAULT NULL,
  `is_bulk_record` enum('0','1') NOT NULL DEFAULT '0',
  `username` char(32) DEFAULT NULL,
  `email` char(64) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `group_id` char(5) DEFAULT NULL,
  `created_by` char(32) DEFAULT NULL,
  `last_login` datetime NOT NULL DEFAULT current_timestamp(),
  `programme_id` varchar(12) DEFAULT NULL,
  `is_protocol` enum('0','1') NOT NULL DEFAULT '0',
  `recovercontact` char(13) DEFAULT NULL,
  `class_id` char(12) DEFAULT NULL,
  `avatar` char(255) DEFAULT 'writable/uploads/avatar.png',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('0','1','2') DEFAULT '1',
  `deactivated` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `client_id`, `index_number`, `is_bulk_record`, `username`, `email`, `password`, `group_id`, `created_by`, `last_login`, `programme_id`, `is_protocol`, `recovercontact`, `class_id`, `avatar`, `date_created`, `date_updated`, `status`, `deactivated`) VALUES
(1, 1, NULL, '0', 'appuser', 'app@gmail.com', '$2y$10$wKBxJODsgRIjbmiW8Ggxf.mNb4L94Yo4x/V9fVgJhARz6LeGbTpbS', '1', NULL, '2022-11-04 11:35:19', NULL, '0', NULL, NULL, 'writable/uploads/avatar.png', '2022-09-19 05:20:55', '2022-11-04 11:36:51', '1', '0'),
(2, 1, NULL, '0', 'emmallob14', 'emmallob14@gmail.com', '$2y$10$wKBxJODsgRIjbmiW8Ggxf.mNb4L94Yo4x/V9fVgJhARz6LeGbTpbS', '1', NULL, '2022-11-14 05:46:11', NULL, '0', NULL, NULL, 'writable/uploads/avatar.png', '2022-09-19 05:20:55', '2022-11-14 05:46:11', '1', '0');

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE `users_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `permissions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_groups`
--

INSERT INTO `users_groups` (`id`, `name`, `permissions`) VALUES
(1, 'Admin', '{\"clients\":{\"monitoring\":1,\"list\":1,\"view\":1,\"update\":1},\"surveys\":{\"update\":1,\"view\":1,\"delete\":1,\"add\":1},\"questions\":{\"update\":1,\"view\":1,\"delete\":1,\"add\":1}}'),
(2, 'User', '{\"students\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"events\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"users\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"documents\":{\"list\":1,\"view\":1,\"add\":1},\"classes\":{\"list\":1,\"view\":1,\"add\":1},\"programmes\":{\"list\":1,\"view\":1,\"add\":1},\"subjects\":{\"list\":1,\"view\":1,\"add\":1},\"residence\":{\"list\":1,\"view\":1,\"add\":1},\"configuration\":{\"view\":1,\"add\":1,\"update\":1}}');

-- --------------------------------------------------------

--
-- Table structure for table `users_metadata`
--

CREATE TABLE `users_metadata` (
  `id` int(11) UNSIGNED NOT NULL,
  `client_id` smallint(12) UNSIGNED DEFAULT NULL,
  `user_id` tinyint(14) UNSIGNED DEFAULT NULL,
  `name` char(40) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `status` enum('0','1','2') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_metadata`
--

INSERT INTO `users_metadata` (`id`, `client_id`, `user_id`, `name`, `value`, `status`) VALUES
(1, 1, 1, 'permissions', '{\"clients\":{\"monitoring\":1,\"list\":1,\"view\":1},\"surveys\":{\"view\":1},\"questions\":{\"view\":1}}', '1'),
(2, 1, 2, 'permissions', '{\"clients\":{\"monitoring\":1,\"list\":1,\"view\":1,\"update\":1},\"surveys\":{\"update\":1,\"view\":1,\"delete\":1,\"add\":1},\"questions\":{\"update\":1,\"view\":1,\"delete\":1,\"add\":1}}', '1'),
(3, 1, 2, 'fullname', 'Emmanuel Obeng', '1');

-- --------------------------------------------------------

--
-- Table structure for table `users_tokens`
--

CREATE TABLE `users_tokens` (
  `id` int(11) NOT NULL,
  `client_id` smallint(12) UNSIGNED DEFAULT NULL,
  `user_id` varchar(32) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `expired_at` datetime DEFAULT NULL,
  `expiry_timestamp` varchar(16) DEFAULT NULL,
  `status` varchar(12) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_tokens`
--

INSERT INTO `users_tokens` (`id`, `client_id`, `user_id`, `token`, `created_at`, `expired_at`, `expiry_timestamp`, `status`) VALUES
(1, 1, '1', 'MzphcHB1c2VyOmJHRmV2Y3lrT2ZSQTJneGFIbzVyYmVNa1RFZjN1THFuSmFzd043VTIxcXdIQ1dVU1FFemQ2cElzS09ockJsdHY6MQ==', '2022-11-01 17:03:24', '2022-11-02 05:03:24', '1667365404', 'inactive'),
(2, 1, '1', 'MTphcHB1c2VyOlBHNFQzWVNSTDZJcnduYVZ4NVdManR5QnpKU2F1S3IwUkgyQjkxa21sRmNVa3VaWE9oRWx5TmRWb0tOc3BuUDU6MQ==', '2022-11-02 10:50:22', '2022-11-02 22:50:21', '1667429421', 'inactive'),
(3, 1, '1', 'MTphcHB1c2VyOlBScU04UGZubzM1RHRycVdrZkE0cHdwRzd0MEJzTE5DWTFXUzI0SnpqSmQ5N0V4c3JDWmhieGxLbG5hZE84VXU6MQ==', '2022-11-02 22:58:12', '2022-11-03 10:58:12', '1667473092', 'inactive'),
(4, 1, '1', 'MTphcHB1c2VyOkpUUXRRVmhvRmhMWHlHM0VDNTMwQlJNanVteERJY1psajEyS1NmNG53TVp2OUhVRmdUZXVPU3N3NDVsbkxzb3A6MQ==', '2022-11-03 13:02:08', '2022-11-04 01:02:08', '1667523728', 'active'),
(5, 1, '1', 'MTphcHB1c2VyOnh1ekJhQ2M1Zmh5dngyTlZRWEFmR0h0OFBiV1k0amtlSUphNDBNb0xvQjNuNzA2U1l1cHF3bGl2OGtESUVRRjE6MQ==', '2022-11-04 04:38:33', '2022-11-04 16:38:33', '1667579913', 'active'),
(6, 1, '2', 'MjplbW1hbGxvYjE0OlpFZzlMRWt1WmxoRG5DRzBpbFhndkhpTlBlQW54elljeHo4MXdLTGpPSGNYMWZCV3ZVcXBrYjVkeTdlSnIwNDY6MQ==', '2022-11-04 11:42:23', '2022-11-04 23:42:23', '1667605343', 'active'),
(7, 1, '2', 'MjplbW1hbGxvYjE0OmVOR2NxTURvSTB6NXByUlZnZU5KanRsWDZvUkhDQTRtQUc0dnd3N2RDVXNCRXBZckZXellMOVphWGZrZFNtMFQ6MQ==', '2022-11-04 23:45:46', '2022-11-05 11:45:46', '1667648746', 'active'),
(8, 1, '2', 'MjplbW1hbGxvYjE0OlRLdmFSRXJRejY3UkdPakJlN2o0Q2I4MzVwQnJXMEp0eEwwbXExQ2l1OTZXdWJub1VNdDNBSmRIRlptUFZmWWQ6MQ==', '2022-11-05 11:53:06', '2022-11-05 23:53:06', '1667692386', 'active'),
(9, 1, '2', 'MjplbW1hbGxvYjE0OkVnNmtzRzZPN1JvcklIaTlER0NmZFp1MktkWjR0YlNCcFVnaFBYU3k5TGgxQWFIQkxzUUkwUWlYV05DZXlEeEo6MQ==', '2022-11-06 00:04:38', '2022-11-06 12:04:38', '1667736278', 'active'),
(10, 1, '2', 'MjplbW1hbGxvYjE0Om51aGxwZFV2UEdGajR4MmRPajBBbTV3STlVb0tySFBxQnozN2FSOGlUZkdRM2xzQk5WTnc5Z1d1RVprSzFZemk6MQ==', '2022-11-06 12:23:56', '2022-11-07 00:23:56', '1667780636', 'active'),
(11, 1, '2', 'MjplbW1hbGxvYjE0Ok9LMFFTOW9TdjlYVWJXcW5Mc0FUSDJ0emNHb1BUSXgxSnNwNFBJaDBLdWI4eWZIeFZ1RFpoRWVDanBkTndWRHQ6MQ==', '2022-11-07 03:57:22', '2022-11-07 15:57:22', '1667836642', 'active'),
(12, 1, '2', 'MjplbW1hbGxvYjE0OkRFUWhXcjFXNmZWdHhTYlo3S3VJZEY1bmRYUmt2b29sQnRDSmNFakxpd084YjMwcE4wa3kzcnVmbUt5OGpZTTc6MQ==', '2022-11-07 17:49:53', '2022-11-08 05:49:53', '1667886593', 'active'),
(13, 1, '2', 'MjplbW1hbGxvYjE0OjZkRmtvTUoycHVVbVpPMnhubkk3WGJ4RXJoT3djOHpobEVzbE5lTGE4UHM5cUNRdXBNNUlRQjRLanplVG9MdEQ6MQ==', '2022-11-08 11:12:03', '2022-11-08 23:12:03', '1667949123', 'active'),
(14, 1, '2', 'MjplbW1hbGxvYjE0OlBZTEt0SUtRVm4yVnpjWkR2T3VVQVMxbE5nRDVrSHAwQzhrQTFYaTlHZFlGcUN2YTRSaXFyY29kTzBNNXdUWEI6MQ==', '2022-11-08 23:54:43', '2022-11-09 11:54:43', '1667994883', 'active'),
(15, 1, '2', 'MjplbW1hbGxvYjE0OmUyNmd6MXRQY09qZFhKTXh1NjVsbTNSU1hEUjI5SDE0N3VoeElWRXNHbnZzdHFBcmlXYUJUTXAwcFVIRlA0OUs6MQ==', '2022-11-09 19:06:06', '2022-11-10 07:06:06', '1668063966', 'active'),
(16, 1, '2', 'MjplbW1hbGxvYjE0OkFna29VRWNwaVp0NlFlRFdxNVkwM215dUVZN05lZHBic2NDT3FLTUp6emdBaFdQR2FqZjhMVTRiOEhPVlBUOWE6MQ==', '2022-11-10 11:47:45', '2022-11-10 23:47:45', '1668124065', 'active'),
(17, 1, '2', 'MjplbW1hbGxvYjE0OnZWU0VBUnFxWkVOMDM5MTNXZVBnYnA3UXAwTk1rc2ltcnV4dHlvWDFrc0h6SWQ4Rnl0b2pINU9UaENBVnV3QmY6MQ==', '2022-11-11 10:58:54', '2022-11-11 22:58:54', '1668207534', 'active'),
(18, 1, '2', 'MjplbW1hbGxvYjE0Okd0dlI5eUZzSTlzVmRlU21iZlo2M0poTzV0VTdDTVQ0MWxIS3hRSFFyQWNxQkJuRVJUb3plWXVPMUt3eEVrYzg6MQ==', '2022-11-11 23:35:33', '2022-11-12 11:35:33', '1668252933', 'active'),
(19, 1, '2', 'MjplbW1hbGxvYjE0OkF5SHhXUjNJZXNnaDRmV1RDaUZaRG50OHd1WUdZdjAxdFYwNzZieG9MOGtLZFZlNnpLUXpIbjJibGFjOU41ak86MQ==', '2022-11-12 12:17:06', '2022-11-13 00:17:06', '1668298626', 'active'),
(20, 1, '2', 'MjplbW1hbGxvYjE0OkRZU2toSTB1NkJ5a3Znc1VSNkJBRmk1Z1ZleDk5S3I3OGNUYkw0MnozekNRT3FUdUtmWnd3YUowVVZYWFliUFo6MQ==', '2022-11-13 13:34:38', '2022-11-14 01:34:38', '1668389678', 'active'),
(21, 1, '2', 'MjplbW1hbGxvYjE0OnR0eXVkUTc2QWY4b25VaFNLS1Z2VEp1SE1VbDBJeHNaZ0Jka0VpOFdxckxQOVM0NnpjOVdocXgxRnpsR083c1A6MQ==', '2022-11-14 03:43:48', '2022-11-14 15:43:48', '1668440628', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`model_name`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`),
  ADD KEY `school_id` (`client_id`),
  ADD KEY `model_id` (`model_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone` (`phone`),
  ADD KEY `alt_phone` (`alt_phone`),
  ADD KEY `status` (`status`),
  ADD KEY `fee_payment` (`fee_payment`),
  ADD KEY `percentage_share` (`percentage_share`),
  ADD KEY `school_code` (`school_code`);

--
-- Indexes for table `login_history`
--
ALTER TABLE `login_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`client_id`),
  ADD KEY `username` (`username`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `surveys`
--
ALTER TABLE `surveys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `surveys_questions`
--
ALTER TABLE `surveys_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `surveys_votes`
--
ALTER TABLE `surveys_votes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`client_id`),
  ADD KEY `username` (`username`),
  ADD KEY `email` (`email`),
  ADD KEY `status` (`status`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `index_number` (`index_number`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `is_bulk_record` (`is_bulk_record`);

--
-- Indexes for table `users_groups`
--
ALTER TABLE `users_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_metadata`
--
ALTER TABLE `users_metadata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`client_id`),
  ADD KEY `name` (`name`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users_tokens`
--
ALTER TABLE `users_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`),
  ADD KEY `token` (`token`),
  ADD KEY `school_id` (`client_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `login_history`
--
ALTER TABLE `login_history`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `surveys`
--
ALTER TABLE `surveys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `surveys_questions`
--
ALTER TABLE `surveys_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `surveys_votes`
--
ALTER TABLE `surveys_votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users_groups`
--
ALTER TABLE `users_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users_metadata`
--
ALTER TABLE `users_metadata`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users_tokens`
--
ALTER TABLE `users_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
