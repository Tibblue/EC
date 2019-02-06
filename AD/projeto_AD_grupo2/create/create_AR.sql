-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema area_AR
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema area_AR
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `area_AR` DEFAULT CHARACTER SET utf8 ;
USE `area_AR` ;

-- -----------------------------------------------------
-- Table `area_AR`.`dim_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_AR`.`dim_customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_c` INT NOT NULL,
  `company` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `job_title` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `area_AR`.`dim_supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_AR`.`dim_supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_su` INT NOT NULL,
  `company` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `area_AR`.`dim_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_AR`.`dim_local` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `last_update` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `area_AR`.`dim_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_AR`.`dim_time` (
  `id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `day` INT NOT NULL,
  `month` INT NOT NULL,
  `year` INT NOT NULL,
  `week_day` VARCHAR(45) NOT NULL,
  `week` INT NOT NULL,
  `work_day` CHAR NOT NULL,
  `holiday` CHAR NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `area_AR`.`dim_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_AR`.`dim_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_p` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  `standard_cost` DECIMAL(19,4) NOT NULL,
  `discontinued` TINYINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `area_AR`.`dim_shipper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_AR`.`dim_shipper` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_sh` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `area_AR`.`dim_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_AR`.`dim_employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_e` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `company` VARCHAR(45) NOT NULL,
  `job_title` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `area_AR`.`sales_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_AR`.`sales_fact` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `quantity` DECIMAL NOT NULL,
  `total_price` DECIMAL NOT NULL,
  `discount` DOUBLE NOT NULL,
  `preparation_time` INT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  `dim_product_id` INT NOT NULL,
  `dim_shipper_id` INT NOT NULL,
  `dim_supplier_id` INT NOT NULL,
  `dim_employee_id` INT NOT NULL,
  `dim_customer_id` INT NOT NULL,
  `order_date` INT NOT NULL,
  `shipped_date` INT NOT NULL,
  `payment_date` INT NOT NULL,
  `customer_local` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sales_fact_dim_product_idx` (`dim_product_id` ASC),
  INDEX `fk_sales_fact_dim_shipper1_idx` (`dim_shipper_id` ASC),
  INDEX `fk_sales_fact_dim_supplier1_idx` (`dim_supplier_id` ASC),
  INDEX `fk_sales_fact_dim_employee1_idx` (`dim_employee_id` ASC),
  INDEX `fk_sales_fact_dim_customer1_idx` (`dim_customer_id` ASC),
  INDEX `fk_sales_fact_dim_time1_idx` (`order_date` ASC),
  INDEX `fk_sales_fact_dim_time2_idx` (`shipped_date` ASC),
  INDEX `fk_sales_fact_dim_time3_idx` (`payment_date` ASC),
  INDEX `fk_sales_fact_dim_local1_idx` (`customer_local` ASC),
  CONSTRAINT `fk_sales_fact_dim_product`
    FOREIGN KEY (`dim_product_id`)
    REFERENCES `area_AR`.`dim_product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_dim_shipper1`
    FOREIGN KEY (`dim_shipper_id`)
    REFERENCES `area_AR`.`dim_shipper` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_dim_supplier1`
    FOREIGN KEY (`dim_supplier_id`)
    REFERENCES `area_AR`.`dim_supplier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_dim_employee1`
    FOREIGN KEY (`dim_employee_id`)
    REFERENCES `area_AR`.`dim_employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_dim_customer1`
    FOREIGN KEY (`dim_customer_id`)
    REFERENCES `area_AR`.`dim_customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_dim_time1`
    FOREIGN KEY (`order_date`)
    REFERENCES `area_AR`.`dim_time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_dim_time2`
    FOREIGN KEY (`shipped_date`)
    REFERENCES `area_AR`.`dim_time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_dim_time3`
    FOREIGN KEY (`payment_date`)
    REFERENCES `area_AR`.`dim_time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_dim_local1`
    FOREIGN KEY (`customer_local`)
    REFERENCES `area_AR`.`dim_local` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
