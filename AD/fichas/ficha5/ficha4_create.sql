-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema data_warehouse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema data_warehouse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `data_warehouse` ;
USE `data_warehouse` ;

-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_TIME`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_TIME` (
  `id_time` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `dia` INT NOT NULL,
  `mes` INT NOT NULL,
  `ano` INT NOT NULL,
  `dia_semana` VARCHAR(45) NOT NULL,
  `semana` INT NOT NULL,
  `util` VARCHAR(1) NOT NULL,
  `feriado` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`id_time`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_COUNTRY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_COUNTRY` (
  `id_country` INT NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_country`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_CITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_CITY` (
  `id_city` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `DIM_COUNTRY_id_country` INT NOT NULL,
  PRIMARY KEY (`id_city`),
  INDEX `fk_DIM_CITY_DIM_COUNTRY1_idx` (`DIM_COUNTRY_id_country` ASC),
  CONSTRAINT `fk_DIM_CITY_DIM_COUNTRY1`
    FOREIGN KEY (`DIM_COUNTRY_id_country`)
    REFERENCES `data_warehouse`.`DIM_COUNTRY` (`id_country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_CUSTOMER` (
  `id_customer` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `DIM_CITY_id_city` INT NOT NULL,
  PRIMARY KEY (`id_customer`),
  INDEX `fk_DIM_CUSTOMER_DIM_CITY1_idx` (`DIM_CITY_id_city` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_STAFF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_STAFF` (
  `id_staff` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `DIM_CITY_id_city` INT NOT NULL,
  PRIMARY KEY (`id_staff`),
  INDEX `fk_DIM_STAFF_DIM_CITY1_idx` (`DIM_CITY_id_city` ASC),
  CONSTRAINT `fk_DIM_STAFF_DIM_CITY1`
    FOREIGN KEY (`DIM_CITY_id_city`)
    REFERENCES `data_warehouse`.`DIM_CITY` (`id_city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_STORE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_STORE` (
  `id_store` INT NOT NULL,
  `DIM_CITY_id_city` INT NOT NULL,
  PRIMARY KEY (`id_store`),
  INDEX `fk_DIM_STORE_DIM_CITY1_idx` (`DIM_CITY_id_city` ASC),
  CONSTRAINT `fk_DIM_STORE_DIM_CITY1`
    FOREIGN KEY (`DIM_CITY_id_city`)
    REFERENCES `data_warehouse`.`DIM_CITY` (`id_city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`FACTS_PAYMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`FACTS_PAYMENT` (
  `id_facts_payment` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(5,2) NOT NULL,
  `daysPayment` INT NOT NULL,
  `DIM_CUSTOMER_id_customer` INT NOT NULL,
  `DIM_STAFF_id_staff` INT NOT NULL,
  `DIM_STORE_id_store` INT NOT NULL,
  `DIM_TIME_id_time` INT NOT NULL,
  PRIMARY KEY (`id_facts_payment`),
  INDEX `fk_FACTS_PAYMENT_DIM_CUSTOMER1_idx` (`DIM_CUSTOMER_id_customer` ASC),
  INDEX `fk_FACTS_PAYMENT_DIM_STAFF1_idx` (`DIM_STAFF_id_staff` ASC),
  INDEX `fk_FACTS_PAYMENT_DIM_STORE1_idx` (`DIM_STORE_id_store` ASC),
  INDEX `fk_FACTS_PAYMENT_DIM_TIME2_idx` (`DIM_TIME_id_time` ASC),
  CONSTRAINT `fk_FACTS_PAYMENT_DIM_CUSTOMER1`
    FOREIGN KEY (`DIM_CUSTOMER_id_customer`)
    REFERENCES `data_warehouse`.`DIM_CUSTOMER` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTS_PAYMENT_DIM_STAFF1`
    FOREIGN KEY (`DIM_STAFF_id_staff`)
    REFERENCES `data_warehouse`.`DIM_STAFF` (`id_staff`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTS_PAYMENT_DIM_STORE1`
    FOREIGN KEY (`DIM_STORE_id_store`)
    REFERENCES `data_warehouse`.`DIM_STORE` (`id_store`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTS_PAYMENT_DIM_TIME2`
    FOREIGN KEY (`DIM_TIME_id_time`)
    REFERENCES `data_warehouse`.`DIM_TIME` (`id_time`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_LANGUAGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_LANGUAGE` (
  `id_language` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_language`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_FILM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_FILM` (
  `id_film` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `length` INT NOT NULL,
  `rating` ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') NOT NULL DEFAULT 'G',
  `rental_duration` INT NOT NULL,
  `rental_rate` DECIMAL(4,2) NOT NULL,
  `replacement_cost` DECIMAL(5,2) NOT NULL,
  `DIM_LANGUAGE_id_language` INT NOT NULL,
  PRIMARY KEY (`id_film`),
  INDEX `fk_DIM_FILM_DIM_LANGUAGE1_idx` (`DIM_LANGUAGE_id_language` ASC),
  CONSTRAINT `fk_DIM_FILM_DIM_LANGUAGE1`
    FOREIGN KEY (`DIM_LANGUAGE_id_language`)
    REFERENCES `data_warehouse`.`DIM_LANGUAGE` (`id_language`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`FACTS_RENTAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`FACTS_RENTAL` (
  `id_facts_rental` INT NOT NULL AUTO_INCREMENT,
  `daysRental` INT NOT NULL,
  `quantity` INT NOT NULL,
  `DIM_STAFF_id_staff` INT NOT NULL,
  `DIM_CUSTOMER_id_customer` INT NOT NULL,
  `DIM_STORE_id_store` INT NOT NULL,
  `DIM_FILM_id_film` INT NOT NULL,
  `DIM_TIME_id_time` INT NOT NULL,
  PRIMARY KEY (`id_facts_rental`),
  INDEX `fk_FACTS_RENTAL_DIM_STAFF1_idx` (`DIM_STAFF_id_staff` ASC),
  INDEX `fk_FACTS_RENTAL_DIM_CUSTOMER1_idx` (`DIM_CUSTOMER_id_customer` ASC),
  INDEX `fk_FACTS_RENTAL_DIM_STORE1_idx` (`DIM_STORE_id_store` ASC),
  INDEX `fk_FACTS_RENTAL_DIM_FILM1_idx` (`DIM_FILM_id_film` ASC),
  INDEX `fk_FACTS_RENTAL_DIM_TIME2_idx` (`DIM_TIME_id_time` ASC),
  CONSTRAINT `fk_FACTS_RENTAL_DIM_STAFF1`
    FOREIGN KEY (`DIM_STAFF_id_staff`)
    REFERENCES `data_warehouse`.`DIM_STAFF` (`id_staff`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTS_RENTAL_DIM_CUSTOMER1`
    FOREIGN KEY (`DIM_CUSTOMER_id_customer`)
    REFERENCES `data_warehouse`.`DIM_CUSTOMER` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTS_RENTAL_DIM_STORE1`
    FOREIGN KEY (`DIM_STORE_id_store`)
    REFERENCES `data_warehouse`.`DIM_STORE` (`id_store`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTS_RENTAL_DIM_FILM1`
    FOREIGN KEY (`DIM_FILM_id_film`)
    REFERENCES `data_warehouse`.`DIM_FILM` (`id_film`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTS_RENTAL_DIM_TIME2`
    FOREIGN KEY (`DIM_TIME_id_time`)
    REFERENCES `data_warehouse`.`DIM_TIME` (`id_time`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_CATEGORY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_CATEGORY` (
  `id_category` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_ACTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_ACTOR` (
  `id_actor` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_actor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_STORE_has_DIM_FILM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_STORE_has_DIM_FILM` (
  `DIM_STORE_id_store` INT NOT NULL,
  `DIM_FILM_id_film` INT NOT NULL,
  PRIMARY KEY (`DIM_STORE_id_store`, `DIM_FILM_id_film`),
  INDEX `fk_DIM_STORE_has_DIM_FILM_DIM_FILM1_idx` (`DIM_FILM_id_film` ASC),
  INDEX `fk_DIM_STORE_has_DIM_FILM_DIM_STORE1_idx` (`DIM_STORE_id_store` ASC),
  CONSTRAINT `fk_DIM_STORE_has_DIM_FILM_DIM_STORE1`
    FOREIGN KEY (`DIM_STORE_id_store`)
    REFERENCES `data_warehouse`.`DIM_STORE` (`id_store`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIM_STORE_has_DIM_FILM_DIM_FILM1`
    FOREIGN KEY (`DIM_FILM_id_film`)
    REFERENCES `data_warehouse`.`DIM_FILM` (`id_film`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_FILM_has_DIM_CATEGORY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_FILM_has_DIM_CATEGORY` (
  `DIM_FILM_id_film` INT NOT NULL,
  `DIM_CATEGORY_id_category` INT NOT NULL,
  PRIMARY KEY (`DIM_FILM_id_film`, `DIM_CATEGORY_id_category`),
  INDEX `fk_DIM_FILM_has_DIM_CATEGORY_DIM_CATEGORY1_idx` (`DIM_CATEGORY_id_category` ASC),
  INDEX `fk_DIM_FILM_has_DIM_CATEGORY_DIM_FILM1_idx` (`DIM_FILM_id_film` ASC),
  CONSTRAINT `fk_DIM_FILM_has_DIM_CATEGORY_DIM_FILM1`
    FOREIGN KEY (`DIM_FILM_id_film`)
    REFERENCES `data_warehouse`.`DIM_FILM` (`id_film`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIM_FILM_has_DIM_CATEGORY_DIM_CATEGORY1`
    FOREIGN KEY (`DIM_CATEGORY_id_category`)
    REFERENCES `data_warehouse`.`DIM_CATEGORY` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `data_warehouse`.`DIM_FILM_has_DIM_ACTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `data_warehouse`.`DIM_FILM_has_DIM_ACTOR` (
  `DIM_FILM_id_film` INT NOT NULL,
  `DIM_ACTOR_id_actor` INT NOT NULL,
  PRIMARY KEY (`DIM_FILM_id_film`, `DIM_ACTOR_id_actor`),
  INDEX `fk_DIM_FILM_has_DIM_ACTOR_DIM_ACTOR1_idx` (`DIM_ACTOR_id_actor` ASC),
  INDEX `fk_DIM_FILM_has_DIM_ACTOR_DIM_FILM1_idx` (`DIM_FILM_id_film` ASC),
  CONSTRAINT `fk_DIM_FILM_has_DIM_ACTOR_DIM_FILM1`
    FOREIGN KEY (`DIM_FILM_id_film`)
    REFERENCES `data_warehouse`.`DIM_FILM` (`id_film`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIM_FILM_has_DIM_ACTOR_DIM_ACTOR1`
    FOREIGN KEY (`DIM_ACTOR_id_actor`)
    REFERENCES `data_warehouse`.`DIM_ACTOR` (`id_actor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
