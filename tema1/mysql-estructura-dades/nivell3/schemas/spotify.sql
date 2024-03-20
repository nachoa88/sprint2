-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `spotify` ;

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  `username` VARCHAR(40) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `gender` ENUM('dona', 'home', 'no binari', 'altre') NOT NULL,
  `country` VARCHAR(80) NOT NULL,
  `postal_code` VARCHAR(20) NOT NULL,
  `type` ENUM('prèmium', 'free') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;

-- Insert fake data into `user` table
INSERT INTO `spotify`.`user` (`email`, `password`, `username`, `date_of_birth`, `gender`, `country`, `postal_code`, `type`) VALUES
('john.doe@example.com', 'password123', 'johndoe', '1990-05-15', 'home', 'United States', '12345', 'prèmium'),
('jane.smith@example.com', 'pass456', 'janesmith', '1988-08-25', 'dona', 'Canada', 'V1B 2Y6', 'free'),
('alex.jackson@example.com', 'securePwd', 'alexjackson', '1995-02-10', 'no binari', 'United Kingdom', 'SW1A 1AA', 'prèmium');

-- -----------------------------------------------------
-- Table `spotify`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscription` (
  `user_id` INT NOT NULL,
  `subscription_date` DATE NOT NULL,
  `renovation_date` DATE NOT NULL,
  `payment_method` ENUM('PayPal', 'Targeta de crèdit') NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_subscription_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `subscription` table
INSERT INTO `spotify`.`subscription` (`user_id`, `subscription_date`, `renovation_date`, `payment_method`) VALUES
(1, '2023-01-01', '2023-02-01', 'PayPal'),
(2, '2023-01-05', '2023-02-05', 'Targeta de crèdit'),
(3, '2023-01-10', '2023-02-10', 'PayPal');

-- -----------------------------------------------------
-- Table `spotify`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`payment` (
  `order_number` INT NOT NULL,
  `payment_date` DATE NOT NULL,
  `total_payed` FLOAT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`order_number`),
  UNIQUE INDEX `order_number_UNIQUE` (`order_number` ASC) VISIBLE,
  INDEX `fk_payment_subscription1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_subscription1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`subscription` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `payment` table
INSERT INTO `spotify`.`payment` (`order_number`, `payment_date`, `total_payed`, `user_id`) VALUES
(1001, '2023-01-01', 9.99, 1),
(1002, '2023-01-05', 0.0, 2),
(1003, '2023-01-10', 14.99, 3);

-- -----------------------------------------------------
-- Table `spotify`.`paypal_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal_payment` (
  `payment_order_number` INT NOT NULL,
  `paypal_username` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`payment_order_number`),
  CONSTRAINT `fk_paypal_payment_payment1`
    FOREIGN KEY (`payment_order_number`)
    REFERENCES `spotify`.`payment` (`order_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `paypal_payment` table
INSERT INTO `spotify`.`paypal_payment` (`payment_order_number`, `paypal_username`) VALUES
(1001, 'john_doe_paypal'),
(1003, 'alex_jackson_paypal');


-- -----------------------------------------------------
-- Table `spotify`.`credit_card_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`credit_card_payment` (
  `payment_order_number` INT NOT NULL,
  `card_number` VARCHAR(19) NOT NULL,
  `expiration_year` YEAR NOT NULL,
  `expiration_month` TINYINT NOT NULL,
  `ccv` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`payment_order_number`),
  CONSTRAINT `fk_credit_card_payment_payment1`
    FOREIGN KEY (`payment_order_number`)
    REFERENCES `spotify`.`payment` (`order_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `credit_card_payment` table
INSERT INTO `spotify`.`credit_card_payment` (`payment_order_number`, `card_number`, `expiration_year`, `expiration_month`, `ccv`) VALUES
(1002, '1234567890123456', '2025', 12, '123'),
(1003, '9876543210987654', '2026', 6, '456');

-- -----------------------------------------------------
-- Table `spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(120) NOT NULL,
  `user_id` INT NOT NULL,
  `state` ENUM('active', 'deleted') NOT NULL,
  `creation_date` DATE NOT NULL,
  `deletion_date` DATE NULL,
  `is_shared` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_playlist_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `playlist` table
INSERT INTO `spotify`.`playlist` (`title`, `user_id`, `state`, `creation_date`, `deletion_date`, `is_shared`) VALUES
('Top Hits', 1, 'active', '2023-01-01', NULL, 1),
('Chill Mix', 2, 'deleted', '2023-01-05', '2023-08-05', 0),
('Workout Jams', 3, 'active', '2023-01-10', NULL, 1);


-- -----------------------------------------------------
-- Table `spotify`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `picture` BLOB NULL,
  `related_to_artist_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_artist_artist1_idx` (`related_to_artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artist_artist1`
    FOREIGN KEY (`related_to_artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `artist` table
INSERT INTO `spotify`.`artist` (`name`, `picture`, `related_to_artist_id`) VALUES
('Michael Jackson', NULL, 0),
('Adele', NULL, 0),
('Ed Sheeran', NULL, 0);

-- -----------------------------------------------------
-- Table `spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `artist_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `year` YEAR NOT NULL,
  `portrait` BLOB NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_album_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `album` table
INSERT INTO `spotify`.`album` (`artist_id`, `title`, `year`, `portrait`) VALUES
(1, 'Thriller', 1982, 'Picture1'),
(2, '21', 2011, 'Picture2'),
(3, '÷', 2017, 'Picture3');


-- -----------------------------------------------------
-- Table `spotify`.`song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`song` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `album_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `num_reproductions` INT NULL,
  `duration` TIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_song_album1_idx` (`album_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_song_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_song_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `song` table
INSERT INTO `spotify`.`song` (`album_id`, `artist_id`, `title`, `num_reproductions`, `duration`) VALUES
(1, 1, 'Billie Jean', 100000, '00:04:54'),
(1, 1, 'Thriller', 95000, '00:05:57'),
(2, 2, 'Rolling in the Deep', 120000, '00:03:49'),
(3, 3, 'Shape of You', 150000, '00:03:53');

-- -----------------------------------------------------
-- Table `spotify`.`follow_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`follow_artist` (
  `user_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `artist_id`),
  INDEX `fk_follow_artist_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_follow_artist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_follow_artist_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `follow_artist` table
INSERT INTO `spotify`.`follow_artist` (`user_id`, `artist_id`) VALUES
(1, 1),
(2, 2),
(3, 3);


-- -----------------------------------------------------
-- Table `spotify`.`marked_favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`marked_favorite` (
  `user_id` INT NOT NULL,
  `artist_id` INT NULL,
  `album_id` INT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_artist_has_album_album1_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_artist_has_album_artist1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_artist_has_album_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_artist_has_album_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artist_has_album_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artist_has_album_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `marked_favorite` table
INSERT INTO `spotify`.`marked_favorite` (`user_id`, `artist_id`, `album_id`) VALUES
(1, 1, NULL),
(2, NULL, 2),
(3, NULL, 3);

-- -----------------------------------------------------
-- Table `spotify`.`playlist_has_song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_has_song` (
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  `date_added` DATE NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `song_id`),
  INDEX `fk_playlist_has_song_song1_idx` (`song_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_song_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_song_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_song_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_has_song_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_has_song_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert fake data into `playlist_has_song` table
INSERT INTO `spotify`.`playlist_has_song` (`playlist_id`, `song_id`, `date_added`, `user_id`) VALUES
(1, 1, '2023-01-01', 1),
(1, 2, '2023-01-01', 1),
(2, 3, '2023-01-05', 2),
(2, 4, '2023-01-05', 2),
(3, 1, '2023-01-10', 3),
(3, 2, '2023-01-10', 3),
(3, 3, '2023-01-10', 3);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
