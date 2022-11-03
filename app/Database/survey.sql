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
  `cover_art` varchar(255) DEFAULT 'assets/images/survey.jpg',
  `button_text` varchar(32) DEFAULT 'Begin',
  `start_date` datetime NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime DEFAULT NULL,
  `submitted_answers` tinyint(12) unsigned NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `settings` text DEFAULT '{"language":"en","display_image":true,"publicize_result":false,"receive_statistics":true,"allow_skip_question":false,"question_layout":"paginate","allow_multiple_voting":true,"thank_you_text":"Thank you for your voting.","closed_survey_text":"The voting session is now closed. Thank you for your participation.","footer_text":"This voting and award scheme is free of charge."}',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `is_published` enum('0','1') NOT NULL DEFAULT '1',
  `users_logs` text DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys`
--

LOCK TABLES `surveys` WRITE;
/*!40000 ALTER TABLE `surveys` DISABLE KEYS */;
INSERT INTO `surveys` VALUES (1,1,'Ghana Twitter Awards 2022 Voting','ghana-twitter-awards-voting','<div>The board of the Ghana Twitter Awards has finally released the list of nominees for this year’s edition. The Ghana Twitter Awards, also known as the GTAs, is an annual social media awards event in Ghana.<br><br></div><div>The awards are open to all Ghanaian Twitter users who who have active Twitter accounts, good internet etiquette and high recommendations. This year’s edition has seen a record number of nominations with more than 200 entries.<br><br></div>','assets/images/surveys/1.jpg','Begin','2022-11-03 21:01:26','0000-00-00 00:00:00',2,'2022-11-03 21:01:26','{\"publicize_result\":\"0\",\"receive_statistics\":\"1\",\"allow_multiple_voting\":\"0\",\"paginate_question\":\"0\",\"allow_skip_question\":\"0\",\"thank_you_text\":\"<div>Thank you for your voting.\",\"closed_survey_text\":\"<div>The voting session is now closed. Thank you for your participation.\",\"footer_text\":\"<div>This voting and award scheme is free of charge.\"}','1','1','[{\"guid\":\"5010064645373610700053736768136624\"},{\"guid\":\"5010064641060201001011060768136624\"}]',NULL);
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
  `instructions` varchar(1000) DEFAULT NULL,
  `answer_type` varchar(32) DEFAULT 'multiple',
  `options` text DEFAULT NULL,
  `is_required` enum('0','1') NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_by` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys_questions`
--

LOCK TABLES `surveys_questions` WRITE;
/*!40000 ALTER TABLE `surveys_questions` DISABLE KEYS */;
INSERT INTO `surveys_questions` VALUES (1,1,'1','Promising Influencer OTY','','multiple','[\"@Ruf_ayi\",\"@nanaKwameFlex\",\"@fawogyimiiko\",\"@Sark_Lawyer\",\"@akosuaampofowah\",\"@Afia_Dimple\",\"@AddyMavis\",\"@dr_doreeeen\",\"@Berneese_\",\"@ama_serwaaa\",\"@naturewaaa\",\"@akuahwritess\",\"@ama_adoma\"]','0','2022-11-03 21:14:04','1','1'),(2,1,'1','Diaspora Tweep OTY','','multiple','[\"@_papayawgh\",\"@nickirich14\",\"@worldofowusu\",\"@ohemaakaly\",\"@toriious\",\"@dj_backyard\"]','0','2022-11-03 21:14:04','1','1'),(3,1,'1','Football Banter OTY','','multiple','[\"@thatEsselGuy\",\"@Opresii\",\"@MmoaNkoaaa\",\"@the_marcoli_boy\",\"@KayPoissonOne\",\"@AsabereRoland\",\"@ilatif\",\"@founda\",\"@KeleweleJoint\",\"@_gyesi\",\"@the_presider\",\"@_sharyf\",\"@ellyserwaaa\",\"@Teemah433\"]','0','2022-11-03 21:14:04','1','1'),(4,1,'1','Best Punter OTY','','multiple','[\"@fawogyimiiko\",\"@Bonty_Official_\",\"@Opresii\",\"@LilMoGh\",\"@GhanamanTips\",\"@SateSliptips\",\"@enokay69\",\"@iam_presider\",\"@GioPredictor\",\"@GameAnalyst3\",\"@ama_etwepa1\"]','0','2022-11-03 21:14:04','1','1'),(5,1,'1','Sports Influencer OTY','','multiple','[\"Owuraku Ampofo\",\"Benaiah\",\"Fancy Dimaria\",\"Saddick Adams\",\"Kwame Dela\",\"Juliet Bawuah\",\"Yaw Ampofo\"]','0','2022-11-03 21:14:04','1','1'),(6,1,'1','Twitter Space OTY','','multiple','[\"Drive Sneaker Nyame\",\"Vawulence Space\",\"Sports Corner\",\"Find A Match\",\"Kalyjay Space\",\"DNBP\",\"SpacesWithEdwardAsare\"]','0','2022-11-03 21:14:04','1','1'),(7,1,'1','SME (Small and Medium Enterprise) OTY','','multiple','[\"@ForLinkIn\",\"@Shaibu_AB\",\"@thetoosweetguy\",\"@Efo_Edem\",\"@LegonMedikal\",\"@MohPlayInc_\",\"@KwabsGroups\",\"@HazardJerseyHub\",\"@yaa_purple954\",\"@sister_Grr\",\"@ForeverPurple17\"]','0','2022-11-03 21:21:38','1','1'),(8,1,'1','SME (Small and Medium Enterprise) OTY','','multiple','[\"@ForLinkIn\",\"@Shaibu_AB\",\"@thetoosweetguy\",\"@Efo_Edem\",\"@LegonMedikal\",\"@MohPlayInc_\",\"@KwabsGroups\",\"@HazardJerseyHub\",\"@yaa_purple954\",\"@sister_Grr\",\"@ForeverPurple17\"]','0','2022-11-03 21:21:38','0','1'),(9,1,'1','Most Engaging Tweep OTY','','multiple','[\"@Kojo_Bankz99\",\"@Kayjnr10\",\"@adofoasa_\",\"@IzzatElKhawaja\",\"@lawslaw\",\"@Kwame_Oliver\",\"@MmoaNkoaaa\",\"@unrulyking00\",\"@Iamabena\",\"@Ghana_Yesu\",\"@amaadoma\"]','0','2022-11-03 21:21:38','1','1'),(10,1,'1','Most Engaging Celebrity OTY','','multiple','[\"@CAPTAINPLANETGH\",\"@Anita_Akuffo\"]','0','2022-11-03 21:21:38','1','1'),(11,1,'1','Political Influencer OTY','','multiple','[\"@AnnanPerry\",\"@quame_age\",\"@CheEsquire\",\"@GhanaSocialU\"]','0','2022-11-03 21:21:38','1','1'),(12,1,'1','Photographer OTY','','multiple','[\"@__theseyram\",\"@iamwizgh\",\"@Kormla4\",\"@olando_shots\",\"@tysonphoto\",\"@IkeDeModel1\"]','0','2022-11-03 21:21:38','1','1'),(13,1,'1','Artiste Fanbase OTY','','multiple','[\"Sarknation\",\"Bhimnation\",\"Shatta Movement\",\"Blacko Tribe\"]','0','2022-11-03 21:21:38','1','1'),(14,1,'1','Funniest Tweep OTY','','multiple','[\"@KayPoissonOne\",\"@Opresii\",\"@SneakerNyame_\",\"@Jason_gh1\",\"@koboateng\",\"@thatEsselguy\",\"@daddys_girltn\"]','0','2022-11-03 21:21:38','1','1'),(15,1,'1','Influencer OTY','','multiple','[\"@AsieduMends\", \"@SneakerNyame_\", \"@BenopaOnyx1\", \"@Gyaigyimii\", \"@Opresii\", \"@thatEsselguy\", \"@Kayjnr10\", \"@_liptonia\", \"@daddys_girltn\", \"@Efua_ampofoa\", \"@Aboa_Banku1\", \"@the_marcoli_boy\", \"@KayPoissonOne\", \"@Jason_gh1\", \"@ellyserwaaa\", \"@I_Am_Winter\", \"@Ghana_Yesu\", \"@ilatif\", \"@_Sharyf\"]','0','2022-11-03 21:21:38','1','1'),(16,1,'1','Music Promoter OTY','','multiple','[\"@Donsarkcess\",\"@okt_ranking30\",\"@Aboa_Banku1\",\"@the_marcoli_boy\",\"@Ghana_Yesu_\",\"@MmoaNkoaaa\",\"@SneakerNyame_\",\"@unrulyking00\",\"@ama_adoma\"]','0','2022-11-03 21:21:38','1','1'),(17,1,'1','Trend/Promo Team OTY','','multiple','[\"A1 Influencers\",\"Ultimate Trends\",\"SPL\",\"Gigs Fie\"]','0','2022-11-03 21:28:35','1','1'),(18,1,'1','Content Creator OTY:','','multiple','[\"Aboa Banku & Papsy\",\"@davidentertaina\",\"@sdkdele\",\"@thepowderguy1\",\"@ComedianWaris\",\"@madeinghana\",\"@fixondennis\",\"@HeadlessYoutube\",\"@kwadwosheldon\",\"@EvianaGh\",\"@Wode_Maya\",\"@SportsCorner\"]','0','2022-11-03 21:28:35','1','1'),(19,1,'1','Health Influencer OTY:','','multiple','[\"@GeorgeAnagli\",\"@medSaaka\",\"@dr_doreeeen\",\"@officialSilasMD\",\"@kwesi_bimpe\"]','0','2022-11-03 21:28:35','1','1'),(20,1,'1','Tech Brand OTY','','multiple','[\"MohPlay Inc\",\"For LinkIn\"]','0','2022-11-03 21:28:35','1','1'),(21,1,'1','Cryptocurrency Brand OTY','','multiple','[\"@Apkjnr\",\"@KojoForex\",\"@manofserendipty\",\"@efo_phil\",\"@huclark_\",\"@_owula\",\"@leslie_kkay\",\"@joesacky\",\"@B_Bestbrain\",\"@Ghcryptoguy\"]','0','2022-11-03 21:28:35','1','1'),(22,1,'1','Radio/TV Show OTY','','multiple','[\"Date Rush on @tv3_ghana\",\"United Showbiz on @utvghana\",\"Showbiz 360 on @tv3_ghana\",\"National Science & Maths Quiz\",\"Citi CBS on @citi973\",\"Pure Drive on @pure957fm\",\"JOY SMS on @joy997fmDay\",\"Break Hitz – Hitz FM (Andy Dosty)\",\"Entertainment Review – Peace FM (Kwesi Aboagye)\",\"Showbiz A to Z – Joy FM (George Quaye)\",\"For the culture – ABN Radio One (Porfolio and DJ Slim)\",\"Entertainment GH – Neat FM (Ola Michael)\"]','0','2022-11-03 21:28:35','1','1');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys_votes`
--

LOCK TABLES `surveys_votes` WRITE;
/*!40000 ALTER TABLE `surveys_votes` DISABLE KEYS */;
INSERT INTO `surveys_votes` VALUES (1,NULL,1,1,'{\"12\":1,\"11\":1}'),(2,NULL,1,2,'{\"2\":2}'),(3,NULL,1,3,'{\"1\":1,\"13\":1}'),(4,NULL,1,4,'{\"2\":1,\"4\":1}'),(5,NULL,1,5,'{\"1\":1,\"6\":1}'),(6,NULL,1,6,'{\"1\":1,\"5\":1}'),(7,NULL,1,7,'{\"2\":1,\"7\":1}'),(8,NULL,1,8,'{\"2\":1}'),(9,NULL,1,9,'{\"4\":1,\"10\":1}'),(10,NULL,1,10,'{\"2\":1,\"1\":1}'),(11,NULL,1,11,'{\"1\":1,\"2\":1}'),(12,NULL,1,12,'{\"1\":1,\"5\":1}'),(13,NULL,1,13,'{\"1\":1,\"3\":1}'),(14,NULL,1,14,'{\"5\":1,\"3\":1}'),(15,NULL,1,15,'{\"15\":1,\"7\":1}'),(16,NULL,1,16,'{\"7\":1,\"skipped\":1}'),(17,NULL,1,17,'{\"1\":1,\"3\":1}'),(18,NULL,1,18,'{\"3\":2}'),(19,NULL,1,19,'{\"4\":1,\"5\":1}'),(20,NULL,1,20,'{\"1\":2}'),(21,NULL,1,21,'{\"7\":1,\"6\":1}'),(22,NULL,1,22,'{\"7\":1,\"8\":1}');
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
INSERT INTO `users` VALUES (1,1,NULL,'0','appuser','app@gmail.com','$2y$10$wKBxJODsgRIjbmiW8Ggxf.mNb4L94Yo4x/V9fVgJhARz6LeGbTpbS','6',NULL,'2022-11-03 21:59:39',NULL,'0',NULL,NULL,'writable/uploads/avatar.png','2022-09-19 05:20:55','2022-11-03 21:59:39','1','0');
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
INSERT INTO `users_groups` VALUES (1,'Admin','{\"clients\":{\"monitoring\":1,\"list\":1,\"view\":1,\"update\":1},\"surveys\":{\"update\":1,\"view\":1,\"delete\":1,\"add\":1},\"questions\":{\"update\":1,\"view\":1,\"delete\":1,\"add\":1}}'),(2,'User','{\"students\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"events\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"users\":{\"list\":1,\"view\":1,\"add\":1,\"update\":1},\"documents\":{\"list\":1,\"view\":1,\"add\":1},\"classes\":{\"list\":1,\"view\":1,\"add\":1},\"programmes\":{\"list\":1,\"view\":1,\"add\":1},\"subjects\":{\"list\":1,\"view\":1,\"add\":1},\"residence\":{\"list\":1,\"view\":1,\"add\":1},\"configuration\":{\"view\":1,\"add\":1,\"update\":1}}');
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
INSERT INTO `users_metadata` VALUES (1,1,1,'permissions','{\"clients\":{\"monitoring\":1,\"list\":1,\"view\":1,\"update\":1},\"surveys\":{\"update\":1,\"view\":1,\"delete\":1,\"add\":1},\"questions\":{\"update\":1,\"view\":1,\"delete\":1,\"add\":1}}','1');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_tokens`
--

LOCK TABLES `users_tokens` WRITE;
/*!40000 ALTER TABLE `users_tokens` DISABLE KEYS */;
INSERT INTO `users_tokens` VALUES (1,1,'1','MzphcHB1c2VyOmJHRmV2Y3lrT2ZSQTJneGFIbzVyYmVNa1RFZjN1THFuSmFzd043VTIxcXdIQ1dVU1FFemQ2cElzS09ockJsdHY6MQ==','2022-11-01 17:03:24','2022-11-02 05:03:24','1667365404','inactive'),(2,1,'1','MTphcHB1c2VyOlBHNFQzWVNSTDZJcnduYVZ4NVdManR5QnpKU2F1S3IwUkgyQjkxa21sRmNVa3VaWE9oRWx5TmRWb0tOc3BuUDU6MQ==','2022-11-02 10:50:22','2022-11-02 22:50:21','1667429421','inactive'),(3,1,'1','MTphcHB1c2VyOlBScU04UGZubzM1RHRycVdrZkE0cHdwRzd0MEJzTE5DWTFXUzI0SnpqSmQ5N0V4c3JDWmhieGxLbG5hZE84VXU6MQ==','2022-11-02 22:58:12','2022-11-03 10:58:12','1667473092','inactive'),(4,1,'1','MTphcHB1c2VyOkpUUXRRVmhvRmhMWHlHM0VDNTMwQlJNanVteERJY1psajEyS1NmNG53TVp2OUhVRmdUZXVPU3N3NDVsbkxzb3A6MQ==','2022-11-03 13:02:08','2022-11-04 01:02:08','1667523728','active');
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

-- Dump completed on 2022-11-03 22:03:54
