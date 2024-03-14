-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
