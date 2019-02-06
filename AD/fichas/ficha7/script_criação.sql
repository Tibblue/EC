-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema medical_costs_dw
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema medical_costs_dw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `medical_costs_dw` DEFAULT CHARACTER SET utf8 ;
USE `medical_costs_dw` ;

-- -----------------------------------------------------
-- Table `medical_costs_dw`.`sex_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical_costs_dw`.`sex_dim` (
  `id_sex` INT NOT NULL,
  `sex` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_sex`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `medical_costs_dw`.`region_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical_costs_dw`.`region_dim` (
  `id_region` INT NOT NULL,
  `region` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_region`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `medical_costs_dw`.`smoker_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical_costs_dw`.`smoker_dim` (
  `id_smoker` INT NOT NULL,
  `smoker` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_smoker`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `medical_costs_dw`.`medical_costs_facts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical_costs_dw`.`medical_costs_facts` (
  `id_fact` INT NOT NULL AUTO_INCREMENT,
  `id_sex` INT NOT NULL,
  `bmi` DECIMAL(6,4) NOT NULL,
  `n_children` INT NOT NULL,
  `id_smoker` INT NOT NULL,
  `id_region` INT NOT NULL,
  `charges` DECIMAL(12,6) NOT NULL,
  `age` INT NOT NULL,
  PRIMARY KEY (`id_fact`),
  INDEX `fk_sex1_idx` (`id_sex` ASC),
  INDEX `fk_region1_idx` (`id_region` ASC),
  INDEX `fk_smoker_idx` (`id_smoker` ASC),
  CONSTRAINT `fk_sex1`
    FOREIGN KEY (`id_sex`)
    REFERENCES `medical_costs_dw`.`sex_dim` (`id_sex`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_region1`
    FOREIGN KEY (`id_region`)
    REFERENCES `medical_costs_dw`.`region_dim` (`id_region`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_smoker`
    FOREIGN KEY (`id_smoker`)
    REFERENCES `medical_costs_dw`.`smoker_dim` (`id_smoker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
