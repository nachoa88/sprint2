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


-- -----------------------------------------------------
-- Table `spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `year` YEAR NOT NULL,
  `portrait` BLOB NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


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


-- -----------------------------------------------------
-- Table `spotify`.`album_has_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`album_has_artist` (
  `album_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`album_id`, `artist_id`),
  INDEX `fk_album_has_artist_artist1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_album_has_artist_album1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_has_artist_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_album_has_artist_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
