-- Schema rest-api
-- -----------------------------------------------------
-- drop database `rest-api`;
-- -----------------------------------------------------
-- Schema rest-api
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rest-api` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `rest-api`;

-- -----------------------------------------------------
-- Table `rest-api`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest-api`.`roles`
(
    `id`   INT         NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;

USE `rest-api`;

-- -----------------------------------------------------
-- Table `rest-api`.`gift_certificates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest-api`.`gift_certificates`
(
    `id`                INT          NOT NULL AUTO_INCREMENT,
    `name`              VARCHAR(45)  NOT NULL,
    `description`       VARCHAR(255) NULL DEFAULT NULL,
    `price`             INT          NOT NULL,
    `duration`          INT          NOT NULL,
    `create_date`       DATETIME     NULL DEFAULT CURRENT_TIMESTAMP,
    `last_updated_date` DATETIME     NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 10020
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rest-api`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest-api`.`tags`
(
    `id`   INT         NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 1005
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rest-api`.`gift_certificate_has_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest-api`.`gift_certificate_has_tag`
(
    `gift_certificate_id` INT NOT NULL,
    `tag_id`              INT NOT NULL,
    PRIMARY KEY (`gift_certificate_id`, `tag_id`),
    INDEX `fk_gift_certificate_has_tag_tag1` (`tag_id` ASC) VISIBLE,
    CONSTRAINT `fk_gift_certificate_has_tag_gift_certificate`
        FOREIGN KEY (`gift_certificate_id`)
            REFERENCES `rest-api`.`gift_certificates` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_gift_certificate_has_tag_tag1`
        FOREIGN KEY (`tag_id`)
            REFERENCES `rest-api`.`tags` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rest-api`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest-api`.`users`
(
    `id`      INT         NOT NULL AUTO_INCREMENT,
    `name`    VARCHAR(45) NOT NULL,
    `email`    VARCHAR(45) NOT NULL,
    `password`    VARCHAR(45) NOT NULL,
    `role_id` INT         NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_users_roles1_idx` (`role_id` ASC) VISIBLE,
    CONSTRAINT `fk_users_roles1`
        FOREIGN KEY (`role_id`)
            REFERENCES `rest-api`.`roles` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 1001
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rest-api`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest-api`.`orders`
(
    `id`                  INT      NOT NULL AUTO_INCREMENT,
    `user_id`             INT      NOT NULL,
    `gift_certificate_id` INT      NOT NULL,
    `order_date`          DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
    `cost`                INT      NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_user_has_gift_certificate_gift_certificate1_idx` (`gift_certificate_id` ASC) VISIBLE,
    INDEX `fk_user_has_gift_certificate_user_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `fk_user_has_gift_certificate_gift_certificate1`
        FOREIGN KEY (`gift_certificate_id`)
            REFERENCES `rest-api`.`gift_certificates` (`id`),
    CONSTRAINT `fk_user_has_gift_certificate_user`
        FOREIGN KEY (`user_id`)
            REFERENCES `rest-api`.`users` (`id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 103
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;




