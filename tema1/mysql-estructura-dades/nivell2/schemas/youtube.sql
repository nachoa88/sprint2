-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `youtube` ;

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(120) NOT NULL,
  `username` VARCHAR(30) NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  `birth_date` DATE NOT NULL,
  `gender` ENUM('dona', 'home', 'no binari', 'other') NOT NULL,
  `country` VARCHAR(60) NOT NULL,
  `postal_code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;

-- Inserting sample data into `user` table
INSERT INTO `youtube`.`user` (`email`, `username`, `password`, `birth_date`, `gender`, `country`, `postal_code`) VALUES
('user1@example.com', 'user1', 'password1', '1990-01-01', 'dona', 'USA', '12345'),
('user2@example.com', 'user2', 'password2', '1992-03-15', 'home', 'UK', 'SW1A 1AA'),
('user3@example.com', 'user3', 'password3', '1995-07-20', 'no binari', 'Canada', 'V1B 2Y6'),
('user4@example.com', 'user4', 'password4', '1988-05-10', 'other', 'Australia', '2000'),
('user5@example.com', 'user5', 'password5', '1999-12-25', 'dona', 'Germany', '10115');


-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `state` ENUM('pública', 'privada') NOT NULL,
  `date_published` DATE NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_playlist_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserting sample data into `playlist` table
INSERT INTO `youtube`.`playlist` (`name`, `state`, `date_published`, `user_id`) VALUES
('Favorites', 'pública', '2023-01-01', 1),
('Watch Later', 'privada', '2023-01-05', 2),
('Music Mix', 'pública', '2023-01-10', 3),
('Funny Videos', 'pública', '2023-01-15', 4),
('Educational', 'pública', '2023-01-20', 5);


-- -----------------------------------------------------
-- Table `youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(60) NOT NULL,
  `description` TEXT NULL,
  `file_size` BIGINT NOT NULL,
  `file_name` VARCHAR(30) NOT NULL,
  `duration` TIME NOT NULL,
  `thumbnail` VARCHAR(255) NOT NULL,
  `num_of_reproductions` INT NULL,
  `state` ENUM('públic', 'ocult', 'privat') NOT NULL,
  `user_id` INT NOT NULL,
  `date_time_published` DATETIME NOT NULL,
  `playlist_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_video_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_video_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `youtube`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserting sample data into `video` table
INSERT INTO `youtube`.`video` (`title`, `description`, `file_size`, `file_name`, `duration`, `thumbnail`, `num_of_reproductions`, `state`, `user_id`, `date_time_published`, `playlist_id`) VALUES
('Cute Cat Compilation', 'Compilation of cute cats doing funny things.', 50000000, 'cat_compilation.mp4', '00:10:00', 'cat_thumbnail.jpg', 1000000, 'públic', 1, '2023-01-01 12:00:00', 1),
('How to Bake a Cake', 'Step-by-step guide on baking a delicious cake.', 70000000, 'bake_cake.mp4', '00:15:00', 'cake_thumbnail.jpg', 800000, 'públic', 2, '2023-01-05 14:30:00', 2),
('Guitar Tutorial', 'Learn how to play the guitar like a pro.', 60000000, 'guitar_tutorial.mp4', '00:20:00', 'guitar_thumbnail.jpg', 600000, 'públic', 3, '2023-01-10 10:45:00', 3),
('Stand-up Comedy Show', 'Hilarious stand-up comedy routine.', 80000000, 'comedy_show.mp4', '00:25:00', 'comedy_thumbnail.jpg', 900000, 'públic', 4, '2023-01-15 19:00:00', 4),
('Mathematics Lecture', 'In-depth lecture on advanced mathematics.', 90000000, 'math_lecture.mp4', '00:30:00', 'math_thumbnail.jpg', 700000, 'públic', 5, '2023-01-20 08:00:00', 5);


-- -----------------------------------------------------
-- Table `youtube`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`tag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_tag_video1_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_tag_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserting sample data into `tag` table
INSERT INTO `youtube`.`tag` (`name`, `video_id`) VALUES
('Cats', 1),
('Funny', 1),
('Tutorial', 2),
('Baking', 2),
('Music', 3),
('Guitar', 3),
('Comedy', 4),
('Stand-up', 4),
('Education', 5),
('Mathematics', 5);

-- -----------------------------------------------------
-- Table `youtube`.`channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`channel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `description` TEXT NULL,
  `date_created` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;

-- Inserting sample data into `channel` table
INSERT INTO `youtube`.`channel` (`name`, `description`, `date_created`) VALUES
('Music Channel', 'Channel dedicated to music lovers.', '2023-01-01'),
('Cooking Channel', 'Learn how to cook delicious dishes.', '2023-01-05'),
('Comedy Channel', 'Laugh out loud with our comedy videos.', '2023-01-10'),
('Education Channel', 'Expand your knowledge with educational content.', '2023-01-15'),
('Gaming Channel', 'Watch gaming videos and live streams.', '2023-01-20');


-- -----------------------------------------------------
-- Table `youtube`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`subscription` (
  `user_id` INT NOT NULL,
  `channel_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `channel_id`),
  INDEX `fk_subscription_channel1_idx` (`channel_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscription_channel1`
    FOREIGN KEY (`channel_id`)
    REFERENCES `youtube`.`channel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserting sample data into `subscription` table
INSERT INTO `youtube`.`subscription` (`user_id`, `channel_id`) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1);

-- -----------------------------------------------------
-- Table `youtube`.`video_like_dislike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video_like_dislike` (
  `user_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `type` ENUM('like', 'dislike') NOT NULL,
  `date_time` DATETIME NOT NULL,
  PRIMARY KEY (`user_id`, `video_id`),
  INDEX `fk_like_dislike_video1_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_like_dislike_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_like_dislike_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserting sample data into `video_like_dislike` table
INSERT INTO `youtube`.`video_like_dislike` (`user_id`, `video_id`, `type`, `date_time`) VALUES
(1, 2, 'like', '2023-01-05 12:00:00'),
(2, 3, 'like', '2023-01-10 14:30:00'),
(3, 4, 'like', '2023-01-15 10:45:00'),
(4, 5, 'like', '2023-01-20 19:00:00'),
(5, 1, 'like', '2023-01-01 08:00:00');


-- -----------------------------------------------------
-- Table `youtube`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `date_time_published` DATETIME NOT NULL,
  `video_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_comments_video1_idx` (`video_id` ASC) VISIBLE,
  INDEX `fk_comments_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserting sample data into `comments` table
INSERT INTO `youtube`.`comments` (`text`, `date_time_published`, `video_id`, `user_id`) VALUES
('Great video, I learned a lot!', '2023-01-05 12:30:00', 2, 1),
('Hilarious!', '2023-01-10 15:00:00', 3, 2),
('This helped me understand the topic better.', '2023-01-15 11:00:00', 4, 3),
('Awesome content, keep it up!', '2023-01-20 20:00:00', 5, 4),
('Cute cats!', '2023-01-01 09:00:00', 1, 5);

-- -----------------------------------------------------
-- Table `youtube`.`comment_like_dislike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comment_like_dislike` (
  `video_id` INT NOT NULL,
  `comments_id` INT NOT NULL,
  `type` ENUM('like', 'dislike') NOT NULL,
  `date_time` DATETIME NOT NULL,
  PRIMARY KEY (`video_id`, `comments_id`),
  INDEX `fk_comment_like_dislike_video1_idx` (`video_id` ASC) VISIBLE,
  INDEX `fk_comment_like_dislike_comments1_idx` (`comments_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_like_dislike_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_like_dislike_comments1`
    FOREIGN KEY (`comments_id`)
    REFERENCES `youtube`.`comments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserting sample data into `comment_like_dislike` table
INSERT INTO `youtube`.`comment_like_dislike` (`video_id`, `comments_id`, `type`, `date_time`) VALUES
(2, 1, 'like', '2023-01-05 12:45:00'),
(3, 2, 'like', '2023-01-10 15:15:00'),
(4, 3, 'like', '2023-01-15 11:30:00'),
(5, 4, 'like', '2023-01-20 20:30:00'),
(1, 5, 'like', '2023-01-20 20:30:00');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
