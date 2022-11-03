ALTER TABLE `surveys`  ADD `created_by` VARCHAR(32) NULL DEFAULT NULL  AFTER `users_logs`;
ALTER TABLE `surveys_questions`  ADD `created_by` VARCHAR(32) NULL DEFAULT NULL  AFTER `status`;
ALTER TABLE `surveys` CHANGE `cover_art` `cover_art` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'assets/images/survey.jpg';
