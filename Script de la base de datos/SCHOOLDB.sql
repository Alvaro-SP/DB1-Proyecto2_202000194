-- MySQL Script generated by MySQL Workbench
-- Fri Oct 14 22:42:28 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DBSCHOOL
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DBSCHOOL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DBSCHOOL` DEFAULT CHARACTER SET utf8 ;
USE `DBSCHOOL` ;

-- -----------------------------------------------------
-- Table `DBSCHOOL`.`CARRERA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`CARRERA` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`CURSO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`CURSO` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `creditos_necesarios` INT NOT NULL,
  `creditos_otorga` INT NOT NULL,
  `carrera` INT NOT NULL,
  `obligatorio` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_table1_CARRERA_idx` (`carrera` ASC) VISIBLE,
  CONSTRAINT `fk_table1_CARRERA`
    FOREIGN KEY (`carrera`)
    REFERENCES `DBSCHOOL`.`CARRERA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`ESTUDIANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`ESTUDIANTE` (
  `carnet` INT NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATETIME NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `dpi` BIGINT NOT NULL,
  `carrera` INT NOT NULL,
  `fechacreacion` DATETIME NOT NULL,
  `creditos` INT NOT NULL,
  PRIMARY KEY (`carnet`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`DOCENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`DOCENTE` (
  `registro_siif` INT NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATETIME NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `dpi` BIGINT NOT NULL,
  `fechacreacion` DATETIME NOT NULL,
  PRIMARY KEY (`registro_siif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`HABILITADOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`HABILITADOS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo_curso` INT NOT NULL,
  `ciclo` VARCHAR(45) NOT NULL,
  `seccion` VARCHAR(45) NOT NULL,
  `docente` INT NOT NULL,
  `cupo_maximo` INT NOT NULL,
  `anio` INT NOT NULL,
  `cant_estudiantes` INT NOT NULL,
  `cupos_disponibles` INT NOT NULL,
  `dia` INT NOT NULL,
  `horario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_HABILITADOS_DOCENTE1_idx` (`docente` ASC) VISIBLE,
  INDEX `fk_HABILITADOS_CURSO1_idx` (`codigo_curso` ASC) VISIBLE,
  CONSTRAINT `fk_HABILITADOS_DOCENTE1`
    FOREIGN KEY (`docente`)
    REFERENCES `DBSCHOOL`.`DOCENTE` (`registro_siif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HABILITADOS_CURSO1`
    FOREIGN KEY (`codigo_curso`)
    REFERENCES `DBSCHOOL`.`CURSO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`ASIGNADOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`ASIGNADOS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_curso_habilitado` INT NOT NULL,
  `carnet` INT NOT NULL,
  `boolasignado` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ASIGNADOS_ESTUDIANTE_idx` (`carnet` ASC) VISIBLE,
  INDEX `fk_ASIGNADOS_HABILITADOS1_idx` (`id_curso_habilitado` ASC) VISIBLE,
  CONSTRAINT `fk_ASIGNADOS_HABILITADOS1`
    FOREIGN KEY (`id_curso_habilitado`)
    REFERENCES `DBSCHOOL`.`HABILITADOS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASIGNADOS_ESTUDIANTE`
    FOREIGN KEY (`carnet`)
    REFERENCES `DBSCHOOL`.`ESTUDIANTE` (`carnet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`NOTAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`NOTAS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_curso_habilitado` INT NOT NULL,
  `carnet` INT NOT NULL,
  `nota` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_NOTAS_ESTUDIANTE1_idx` (`carnet` ASC) VISIBLE,
  INDEX `fk_NOTAS_HABILITADOS1_idx` (`id_curso_habilitado` ASC) VISIBLE,
  CONSTRAINT `fk_NOTAS_ESTUDIANTE1`
    FOREIGN KEY (`carnet`)
    REFERENCES `DBSCHOOL`.`ESTUDIANTE` (`carnet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NOTAS_HABILITADOS1`
    FOREIGN KEY (`id_curso_habilitado`)
    REFERENCES `DBSCHOOL`.`HABILITADOS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`ACTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`ACTA` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_curso_habilitado` INT NOT NULL,
  `fechayhora` DATETIME NOT NULL,
  `HABILITADOS_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ACTA_HABILITADOS1_idx` (`id_curso_habilitado` ASC) VISIBLE,
  CONSTRAINT `fk_ACTA_HABILITADOS1`
    FOREIGN KEY (`id_curso_habilitado`)
    REFERENCES `DBSCHOOL`.`HABILITADOS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`DESASIGNADOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`DESASIGNADOS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_curso_habilitado` INT NOT NULL,
  `cantidad_total` INT NOT NULL,
  `cantidad_desasignados` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`HISTORIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`HISTORIAL` (
  `fecha` DATETIME NOT NULL,
  `descripcion` TEXT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fecha`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBSCHOOL`.`HORARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBSCHOOL`.`HORARIO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_curso_habilitado` INT NOT NULL,
  `dia` INT NOT NULL,
  `horario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_HORARIO_HABILITADOS1_idx` (`id_curso_habilitado` ASC) VISIBLE,
  CONSTRAINT `fk_HORARIO_HABILITADOS1`
    FOREIGN KEY (`id_curso_habilitado`)
    REFERENCES `DBSCHOOL`.`HABILITADOS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
