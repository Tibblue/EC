-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ficha2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ficha2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ficha2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ficha2` ;

-- -----------------------------------------------------
-- Table `ficha2`.`athlete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha2`.`athlete` (
  `id_athlete` INT NOT NULL,
  `name_athlete` TEXT NULL,
  `sex` TEXT NULL,
  PRIMARY KEY (`id_athlete`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha2`.`Game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha2`.`Game` (
  `id_Game` INT NOT NULL,
  `game` TEXT NULL,
  `year` INT NULL,
  `season` TEXT NULL,
  PRIMARY KEY (`id_Game`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha2`.`Medal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha2`.`Medal` (
  `id_Medal` INT NOT NULL,
  `medal` TEXT NULL,
  PRIMARY KEY (`id_Medal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha2`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha2`.`Team` (
  `id_Team` INT NOT NULL,
  `team` TEXT NULL,
  PRIMARY KEY (`id_Team`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha2`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha2`.`Event` (
  `id_Event` INT NOT NULL,
  `event` TEXT NULL,
  PRIMARY KEY (`id_Event`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha2`.`athlete_events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha2`.`athlete_events` (
  `age` INT(11) NULL DEFAULT NULL,
  `id_athlete_events` INT NOT NULL,
  `height` TEXT NULL DEFAULT NULL,
  `weight` TEXT NULL DEFAULT NULL,
  `athlete_id_athlete` INT NOT NULL,
  `Games_id_Games` INT NOT NULL,
  `Medal_id_Medal` INT NOT NULL,
  `Team_id_Team` INT NOT NULL,
  `Event_id_Event` INT NOT NULL,
  INDEX `fk_athlete_events_athlete_idx` (`athlete_id_athlete` ASC),
  INDEX `fk_athlete_events_Games1_idx` (`Games_id_Games` ASC),
  INDEX `fk_athlete_events_Medal1_idx` (`Medal_id_Medal` ASC),
  INDEX `fk_athlete_events_Team1_idx` (`Team_id_Team` ASC),
  INDEX `fk_athlete_events_Event1_idx` (`Event_id_Event` ASC),
  PRIMARY KEY (`id_athlete_events`),
  CONSTRAINT `fk_athlete_events_athlete`
    FOREIGN KEY (`athlete_id_athlete`)
    REFERENCES `ficha2`.`athlete` (`id_athlete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_athlete_events_Games1`
    FOREIGN KEY (`Games_id_Games`)
    REFERENCES `ficha2`.`Game` (`id_Game`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_athlete_events_Medal1`
    FOREIGN KEY (`Medal_id_Medal`)
    REFERENCES `ficha2`.`Medal` (`id_Medal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_athlete_events_Team1`
    FOREIGN KEY (`Team_id_Team`)
    REFERENCES `ficha2`.`Team` (`id_Team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_athlete_events_Event1`
    FOREIGN KEY (`Event_id_Event`)
    REFERENCES `ficha2`.`Event` (`id_Event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ficha2`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha2`.`City` (
  `id_City` INT NOT NULL,
  `city` TEXT NULL,
  PRIMARY KEY (`id_City`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
