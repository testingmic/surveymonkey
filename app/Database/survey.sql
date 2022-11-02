-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: surveys
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` smallint(12) unsigned DEFAULT NULL,
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
  `status` enum('0','1') DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `item_id` (`model_name`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `school_id` (`client_id`),
  KEY `model_id` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
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
  `protocol_limit` tinyint(5) unsigned NOT NULL DEFAULT 50,
  `protocol_count` tinyint(5) unsigned NOT NULL DEFAULT 0,
  `created_by` varchar(32) DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('0','1','2') DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `phone` (`phone`),
  KEY `alt_phone` (`alt_phone`),
  KEY `status` (`status`),
  KEY `fee_payment` (`fee_payment`),
  KEY `percentage_share` (`percentage_share`),
  KEY `school_code` (`school_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'A0001','SHS Admission Portal','writable/uploads/avatar/1666200614_d797475d1c5defc96385.png','Accra','GH','4','134','emmallob14@gmail.com','0550107770','0571408340','20','10','{\"school_reopens\":\"\",\"admission_opens\":\"\",\"admission_end\":\"2022-10-12\"}',50,0,'1','2022-09-19 05:13:49','2022-10-19 17:30:15','1');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_history`
--

DROP TABLE IF EXISTS `login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` smallint(12) unsigned DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `lastlogin` datetime DEFAULT current_timestamp(),
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school_id` (`client_id`),
  KEY `username` (`username`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_history`
--

LOCK TABLES `login_history` WRITE;
/*!40000 ALTER TABLE `login_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surveys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(12) unsigned DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `cover_art` varchar(255) DEFAULT NULL,
  `button_text` varchar(32) DEFAULT 'Begin',
  `start_date` datetime NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime DEFAULT NULL,
  `submitted_answers` tinyint(12) unsigned NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `settings` text DEFAULT '{"language":"en","display_image":true,"publicize_result":false,"receive_statistics":true,"allow_skip_question":false,"question_layout":"paginate","allow_multiple_voting":true,"thank_you_text":"Thank you for your voting.","closed_survey_text":"The voting session is now closed. Thank you for your participation.","footer_text":"This voting and award scheme is free of charge."}',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys`
--

LOCK TABLES `surveys` WRITE;
/*!40000 ALTER TABLE `surveys` DISABLE KEYS */;
INSERT INTO `surveys` VALUES (1,1,'Ghana Twitter Awards 2022 Voting','ghana-twitter-awards-voting','<p>The board of the Ghana Twitter Awards has finally released the list of nominees for this year’s edition. The Ghana Twitter Awards, also known as the GTAs, is an annual social media awards event in Ghana.</p>\r\n<p>\r\nThe awards are open to all Ghanaian Twitter users who who have active Twitter accounts, good internet etiquette and high recommendations. This year’s edition has seen a record number of nominations with more than 200 entries.</p>','assets/images/surveys/1.jpg','Start Voting','2022-11-01 18:36:33',NULL,6,'2022-11-01 17:28:49','{\"language\":\"en\",\"display_image\":true,\"publicize_result\":false,\"receive_statistics\":true,\"allow_skip_question\":false,\"question_layout\":\"paginate\",\"allow_multiple_voting\":true,\"thank_you_text\":\"Thank you for your voting. See you at the award ceremony on 9th December 2022\",\"closed_survey_text\":\"The voting session is now closed. Thank you for your participation.\",\"footer_text\":\"This voting and award scheme is sponsored by the organizers of the event.\"}','1');
/*!40000 ALTER TABLE `surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys_questions`
--

DROP TABLE IF EXISTS `surveys_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surveys_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(12) unsigned DEFAULT NULL,
  `survey_id` varchar(12) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `answer_type` varchar(32) DEFAULT 'multiple',
  `options` text DEFAULT NULL,
  `is_required` enum('0','1') NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys_questions`
--

LOCK TABLES `surveys_questions` WRITE;
/*!40000 ALTER TABLE `surveys_questions` DISABLE KEYS */;
INSERT INTO `surveys_questions` VALUES (1,1,'1','Promising Influencer OTY','multiple','[\"@Ruf_ayi\",\"@nanaKwameFlex\",\"@fawogyimiiko\",\"@Sark_Lawyer\",\"@AkosuaAmpowah\",\"@Afia_Dimple\"]','1','2022-11-01 17:34:58','1'),(2,1,'1','Best Punter OTY','multiple','[\"@fawogyimiiko\",\"@Bonty_Official_\",\"@Opresii\",\"@LilMoGh\",\"@GhanamanTips\",\"@SateSliptips\",\"@enokay69\",\"@iam_presider\",\"@GioPredictor\",\"@GameAnalyst3\",\"@ama_etwepa1\"]','1','2022-11-01 17:34:58','1'),(3,1,'1','Male Catfish OTY','multiple','[\"@fawogyimiiko\",\"@Bonty_Official_\",\"@Opresii\",\"@LilMoGh\",\"@GhanamanTips\",\"@SateSliptips\",\"@enokay69\",\"@iam_presider\",\"@GioPredictor\",\"@GameAnalyst3\",\"@ama_etwepa1\"]','1','2022-11-01 17:34:58','1'),(4,1,'1','Female Catfish OTY','multiple','[\"@fawogyimiiko\",\"@Bonty_Official_\",\"@Opresii\",\"@LilMoGh\",\"@GhanamanTips\",\"@SateSliptips\",\"@enokay69\",\"@iam_presider\",\"@GioPredictor\",\"@GameAnalyst3\",\"@ama_etwepa1\"]','1','2022-11-01 17:34:58','1'),(5,1,'1','Male Tech Business OTY','multiple','[\"@Ruf_ayi\",\"@nanaKwameFlex\",\"@fawogyimiiko\",\"@Sark_Lawyer\",\"@AkosuaAmpowah\",\"@Afia_Dimple\"]','1','2022-11-01 17:34:58','1'),(6,1,'1','Health Influencer OTY','multiple','[\"@fawogyimiiko\",\"@Bonty_Official_\",\"@Opresii\",\"@LilMoGh\",\"@GhanamanTips\",\"@SateSliptips\",\"@enokay69\",\"@iam_presider\",\"@GioPredictor\",\"@GameAnalyst3\",\"@ama_etwepa1\"]','1','2022-11-01 17:34:58','1');
/*!40000 ALTER TABLE `surveys_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys_votes`
--

DROP TABLE IF EXISTS `surveys_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surveys_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` tinyint(3) unsigned DEFAULT NULL,
  `survey_id` tinyint(3) unsigned DEFAULT NULL,
  `question_id` tinyint(3) unsigned DEFAULT NULL,
  `votes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys_votes`
--

LOCK TABLES `surveys_votes` WRITE;
/*!40000 ALTER TABLE `surveys_votes` DISABLE KEYS */;
INSERT INTO `surveys_votes` VALUES (1,NULL,1,1,'{\"1\":1,\"2\":2,\"5\":2,\"3\":1}'),(2,NULL,1,2,'{\"1\":1,\"2\":1,\"3\":1,\"5\":2,\"7\":1}'),(3,NULL,1,3,'{\"1\":1,\"2\":2,\"8\":1,\"10\":2}'),(4,NULL,1,4,'{\"1\":1,\"2\":1,\"3\":1,\"5\":1,\"8\":1,\"10\":1}'),(5,NULL,1,5,'{\"1\":2,\"2\":2,\"3\":1,\"4\":1}'),(6,NULL,1,6,'{\"1\":1,\"2\":1,\"3\":1,\"7\":1,\"4\":1,\"5\":1}');
/*!40000 ALTER TABLE `surveys_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` smallint(12) unsigned DEFAULT NULL,
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
  `deactivated` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `school_id` (`client_id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `status` (`status`),
  KEY `created_by` (`created_by`),
  KEY `index_number` (`index_number`),
  KEY `group_id` (`group_id`),
  KEY `is_bulk_record` (`is_bulk_record`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,NULL,'0','appuser','app@gmail.com','$2y$10$wKBxJODsgRIjbmiW8Ggxf.mNb4L94Yo4x/V9fVgJhARz6LeGbTpbS','6',NULL,'2022-11-02 10:50:22',NULL,'0',NULL,NULL,'writable/uploads/avatar.png','2022-09-19 05:20:55','2022-11-02 10:50:22','1','0');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (1,'Admin','{\"clients\":{\"monitoring\":1,\"list\":1,\"view\":1,\"update\":1}}'),(2,'User','{\"students\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"events\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"users\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"documents\":{\"list\":1,\"view\":1,\"add\":1},\"classes\":{\"list\":1,\"view\":1,\"add\":1},\"programmes\":{\"list\":1,\"view\":1,\"add\":1},\"subjects\":{\"list\":1,\"view\":1,\"add\":1},\"residence\":{\"list\":1,\"view\":1,\"add\":1},\"configuration\":{\"view\":1,\"add\":1,\"update\":1}}');
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_metadata`
--

DROP TABLE IF EXISTS `users_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_metadata` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` smallint(12) unsigned DEFAULT NULL,
  `user_id` tinyint(14) unsigned DEFAULT NULL,
  `name` char(40) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `status` enum('0','1','2') DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `school_id` (`client_id`),
  KEY `name` (`name`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_metadata`
--

LOCK TABLES `users_metadata` WRITE;
/*!40000 ALTER TABLE `users_metadata` DISABLE KEYS */;
INSERT INTO `users_metadata` VALUES (1,2,1,'permissions','{\"clients\":{\"monitoring\":1,\"list\":1,\"view\":1,\"update\":1}}','1');
/*!40000 ALTER TABLE `users_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_tokens`
--

DROP TABLE IF EXISTS `users_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` smallint(12) unsigned DEFAULT NULL,
  `user_id` varchar(32) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `expired_at` datetime DEFAULT NULL,
  `expiry_timestamp` varchar(16) DEFAULT NULL,
  `status` varchar(12) DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `token` (`token`),
  KEY `school_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_tokens`
--

LOCK TABLES `users_tokens` WRITE;
/*!40000 ALTER TABLE `users_tokens` DISABLE KEYS */;
INSERT INTO `users_tokens` VALUES (1,1,'1','MzphcHB1c2VyOmJHRmV2Y3lrT2ZSQTJneGFIbzVyYmVNa1RFZjN1THFuSmFzd043VTIxcXdIQ1dVU1FFemQ2cElzS09ockJsdHY6MQ==','2022-11-01 17:03:24','2022-11-02 05:03:24','1667365404','inactive'),(2,1,'1','MTphcHB1c2VyOlBHNFQzWVNSTDZJcnduYVZ4NVdManR5QnpKU2F1S3IwUkgyQjkxa21sRmNVa3VaWE9oRWx5TmRWb0tOc3BuUDU6MQ==','2022-11-02 10:50:22','2022-11-02 22:50:21','1667429421','active');
/*!40000 ALTER TABLE `users_tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-02 11:00:04
