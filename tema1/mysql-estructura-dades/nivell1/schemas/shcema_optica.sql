-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- DROP DATABASE IF EXISTS
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `optica`;

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(30) NOT NULL,
  `number` VARCHAR(4) NOT NULL,
  `floor` VARCHAR(3) NULL,
  `door` VARCHAR(5) NULL,
  `city` VARCHAR(30) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  `fax` VARCHAR(20) NULL,
  `nif` VARCHAR(9) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE,
  UNIQUE INDEX `fax_UNIQUE` (`fax` ASC) VISIBLE,
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_supplier_address_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `optica`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `registration_date` DATE NOT NULL,
  `recomended_by_client_id` INT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_client_client1_idx` (`recomended_by_client_id` ASC) VISIBLE,
  INDEX `fk_client_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_client1`
    FOREIGN KEY (`recomended_by_client_id`)
    REFERENCES `optica`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `optica`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  INDEX `fk_brand_supplier1_idx` (`supplier_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_brand_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `optica`.`supplier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `sold_date` DATE NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`glasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand_id` INT NOT NULL,
  `graduation_left` FLOAT NULL,
  `graduation_right` FLOAT NULL,
  `frame_type` ENUM('flotant', 'pasta', 'metàl·lica') NOT NULL,
  `frame_color` VARCHAR(15) NOT NULL,
  `glass_color_left` VARCHAR(15) NULL,
  `glass_color_right` VARCHAR(15) NULL,
  `price` FLOAT NOT NULL,
  `bought_by_client_id` INT NULL,
  `sold_by_employee_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_glasses_brand1_idx` (`brand_id` ASC) VISIBLE,
  INDEX `fk_glasses_client1_idx` (`bought_by_client_id` ASC) VISIBLE,
  INDEX `fk_glasses_employee1_idx` (`sold_by_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_brand1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `optica`.`brand` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_glasses_client1`
    FOREIGN KEY (`bought_by_client_id`)
    REFERENCES `optica`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_glasses_employee1`
    FOREIGN KEY (`sold_by_employee_id`)
    REFERENCES `optica`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserting records into address
INSERT INTO `optica`.`address` (`street`, `number`, `floor`, `door`, `city`, `postal_code`, `country`)
VALUES
('Main St', '123', '1', 'A', 'Barcelona', '08001', 'Spain'),
('High St', '456', '2', 'B', 'Madrid', '28001', 'Spain'),
('Church St', '789', '3', 'C', 'Valencia', '46001', 'Spain'),
('Park St', '321', '4', 'D', 'Seville', '41001', 'Spain'),
('Hill St', '654', '5', 'E', 'Malaga', '29001', 'Spain');

-- Inserting records into supplier
INSERT INTO `optica`.`supplier` (`name`, `telephone`, `fax`, `nif`, `address_id`)
VALUES
('Supplier1', '123456789', '987654321', 'A12345678', 1),
('Supplier2', '234567890', '876543210', 'B23456789', 2),
('Supplier3', '345678901', '765432109', 'C34567890', 3),
('Supplier4', '567890123', '543210987', 'E56789012', 4);

-- Inserting records into client
INSERT INTO `optica`.`client` (`name`, `telephone`, `email`, `registration_date`, `recomended_by_client_id`, `address_id`)
VALUES
('Client1', '123456789', 'client1@example.com', '2022-01-01', NULL, 1),
('Client2', '234567890', 'client2@example.com', '2022-02-01', 1, 2),
('Client3', '345678901', 'client3@example.com', '2022-03-01', 1, 3),
('Client4', '456789012', 'client4@example.com', '2022-04-01', 2, 4),
('Client5', '567890123', 'client5@example.com', '2022-05-01', 2, 5);

-- Inserting records into brand
INSERT INTO `optica`.`brand` (`supplier_id`, `name`)
VALUES
(1, 'Brand1'),
(2, 'Brand2'),
(1, 'Brand3'),
(4, 'Brand4'),
(3, 'Brand5');

-- Inserting records into employee
INSERT INTO `optica`.`employee` (`name`, `sold_date`)
VALUES
('John Doe', '2022-01-01'),
('Jane Smith', '2022-02-01'),
('Alice Johnson', '2022-02-11'),
('Bob Williams', '2022-03-01'),
('John Doe', '2022-03-15'),
('Jane Smith', '2022-03-17'),
('Alice Johnson', '2022-04-01'),
('Bob Williams', '2022-04-21'),
('Charlie Brown', '2022-05-01'),
('Charlie Brown', '2022-05-25');

-- Inserting records into glasses
INSERT INTO `optica`.`glasses` (`brand_id`, `graduation_left`, `graduation_right`, `frame_type`, `frame_color`, `glass_color_left`, `glass_color_right`, `price`, `bought_by_client_id`, `sold_by_employee_id`)
VALUES
(1, 1.5, 1.5, 'flotant', 'black', 'blue', 'blue', 100.0, 1, 1),
(2, 2.0, 2.0, 'pasta', 'red', 'green', 'green', 200.0, 1, 1),
(3, 2.5, 2.5, 'metàl·lica', 'blue', 'red', 'red', 300.0, 2, 2),
(2, 2.5, 2.5, 'pasta', 'green', 'white', 'white', 200.0, 2, 2),
(5, 3.0, 3.0, 'flotant', 'green', 'black', 'black', 400.0, 3, 3),
(1, 3.5, 3.5, 'pasta', 'yellow', 'white', 'white', 500.0, 3, 3),
(5, 2.0, 2.0, 'flotant', 'black', 'blue', 'blue', 150.0, 4, 4),
(3, 2.5, 2.5, 'pasta', 'red', 'green', 'green', 250.0, 4, 4),
(2, 3.0, 3.0, 'metàl·lica', 'blue', 'red', 'red', 350.0, 5, 5),
(5, 3.5, 3.5, 'flotant', 'green', 'black', 'black', 450.0, 5, 5),
(4, 2.5, 2.5, 'flotant', 'black', 'blue', 'blue', 150.0, NULL, NULL),
(4, 3.0, 3.0, 'pasta', 'red', 'green', 'green', 250.0, NULL, NULL);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
