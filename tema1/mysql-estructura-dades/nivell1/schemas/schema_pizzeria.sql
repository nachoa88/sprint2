-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizzeria` ;

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `surname` VARCHAR(20) NOT NULL,
  `address` VARCHAR(30) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `locality` VARCHAR(20) NOT NULL,
  `province` VARCHAR(20) NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE,
  UNIQUE INDEX `address_UNIQUE` (`address` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`store` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `locality` VARCHAR(20) NOT NULL,
  `province` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `date_time` DATETIME NOT NULL,
  `type` ENUM('repartiment a domicili', 'per a recollir en botiga') NOT NULL,
  `total_price` FLOAT NOT NULL,
  `store_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_order_client_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_order_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `pizzeria`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `pizzeria`.`store` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_type` ENUM('pizzes', 'hamburgueses', 'begudes') NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `description` VARCHAR(80) NOT NULL,
  `image` BLOB NULL,
  `price` FLOAT NOT NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_product_order1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_category_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizzeria`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_pizza_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `pizzeria`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`worker` (
  `id` VARCHAR(45) NOT NULL,
  `store_id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `surname` VARCHAR(20) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  `type` ENUM('cuiner', 'repartidor') NOT NULL,
  INDEX `fk_worker_store1_idx` (`store_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE,
  CONSTRAINT `fk_worker_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `pizzeria`.`store` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`delivery_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`delivery_order` (
  `order_id` INT NOT NULL,
  `worker_id` VARCHAR(45) NOT NULL,
  `date_time_delivered` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`, `worker_id`),
  INDEX `fk_delibery_order_worker1_idx` (`worker_id` ASC) VISIBLE,
  CONSTRAINT `fk_delibery_order_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delibery_order_worker1`
    FOREIGN KEY (`worker_id`)
    REFERENCES `pizzeria`.`worker` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Inserting records into client
INSERT INTO `pizzeria`.`client` (`name`, `surname`, `address`, `postal_code`, `locality`, `province`, `telephone`)
VALUES
('John', 'Doe', '123 Main St', '12345', 'Barcelona', 'Barcelona', '1234567890'),
('Jane', 'Smith', '456 Pine St', '67890', 'Madrid', 'Madrid', '0987654321'),
('Mark', 'Taylor', '789 Maple St', '23456', 'Valencia', 'Valencia', '2345678901'),
('Emily', 'Johnson', '321 Cedar St', '98765', 'Seville', 'Seville', '1098765432');

-- Inserting records into store
INSERT INTO `pizzeria`.`store` (`address`, `postal_code`, `locality`, `province`)
VALUES
('789 Oak St', '11223', 'Barcelona', 'Barcelona'),
('321 Elm St', '77689', 'Madrid', 'Madrid'),
('654 Willow St', '33445', 'Valencia', 'Valencia'),
('987 Birch St', '99876', 'Seville', 'Seville');

-- Inserting records into order
INSERT INTO `pizzeria`.`order` (`client_id`, `date_time`, `type`, `total_price`, `store_id`)
VALUES
(1, NOW(), 'repartiment a domicili', 20.0, 1),
(2, NOW(), 'per a recollir en botiga', 15.0, 2),
(3, NOW(), 'repartiment a domicili', 25.0, 3),
(4, NOW(), 'repartiment a domicili', 30.0, 4);

-- Inserting records into product
INSERT INTO `pizzeria`.`product` (`product_type`, `name`, `description`, `price`, `order_id`)
VALUES
('pizzes', 'Margherita', 'Tomato, mozzarella, basil', 10.0, 1),
('begudes', 'Coca Cola', 'Refreshing soft drink', 2.5, 1),
('begudes', 'Coca Cola', 'Refreshing soft drink', 2.5, 1),
('pizzes', 'Margherita', 'Tomato, mozzarella, basil', 10.0, 2),
('begudes', 'Pepsi', 'Refreshing soft drink', 2.5, 2),
('pizzes', 'Pepperoni', 'Tomato, mozzarella, pepperoni', 12.5, 3),
('begudes', 'Fanta', 'Refreshing soft drink', 2.5, 3),
('pizzes', 'Vegetarian', 'Tomato, mozzarella, mixed vegetables', 15.0, 4),
('begudes', 'Sprite', 'Refreshing soft drink', 2.5, 4);

-- Inserting records into category
INSERT INTO `pizzeria`.`category` (`name`, `product_id`)
VALUES
('Pizza', 1),
('Drinks', 2),
('Drinks', 3),
('Pizza', 5),
('Drinks', 6),
('Pizza', 7),
('Drinks', 8);

-- Inserting records into pizza
INSERT INTO `pizzeria`.`pizza` (`category_id`)
VALUES
(1),
(3),
(4);

-- Inserting records into worker
INSERT INTO `pizzeria`.`worker` (`id`, `store_id`, `name`, `surname`, `nif`, `telephone`, `type`)
VALUES
('1', 1, 'Bob', 'Brown', 'A12345678', '1234567890', 'cuiner'),
('2', 2, 'Alice', 'Green', 'B23456789', '0987654321', 'repartidor');

-- Inserting records into delivery_order
INSERT INTO `pizzeria`.`delivery_order` (`order_id`, `worker_id`, `date_time_delivered`)
VALUES
(1, '2', NOW()),
(3, '2', NOW()),
(4, '2', NOW());



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
