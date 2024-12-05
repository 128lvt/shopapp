-- Tạo database với charset utf8mb4 và collate Vietnamese
DROP
DATABASE IF EXISTS `shopapp`;

CREATE
DATABASE `shopapp`
/*!40100 DEFAULT CHARACTER SET utf8mb4 */
/*!40100 COLLATE utf8mb4_vietnamese_ci */;

USE
`shopapp`;

-- Bảng roles
CREATE TABLE `roles`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `roles` AUTO_INCREMENT = 10000;

-- Bảng users
CREATE TABLE `users`
(
    `id`                  INT PRIMARY KEY AUTO_INCREMENT,
    `fullname`            VARCHAR(100)          DEFAULT '',
    `email`               VARCHAR(100) NOT NULL,
    `address`             VARCHAR(200)          DEFAULT '',
    `password`            VARCHAR(100) NOT NULL DEFAULT '',
    `created_at`          TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    `updated_at`          TIMESTAMP             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_active`           TINYINT(1) DEFAULT 1,
    `facebook_account_id` VARCHAR(100)          DEFAULT '',
    `google_account_id`   VARCHAR(100)          DEFAULT '',
    `role_id`             INT,
    CONSTRAINT `fk_users_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `users` AUTO_INCREMENT = 10000;

-- Bảng tokens
CREATE TABLE `tokens`
(
    `id`              INT PRIMARY KEY AUTO_INCREMENT,
    `token`           VARCHAR(255) NOT NULL,
    `expiration_date` TIMESTAMP    NOT NULL,
    `user_id`         INT          NOT NULL,
    CONSTRAINT `fk_tokens_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    UNIQUE INDEX `idx_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `tokens` AUTO_INCREMENT = 10000;

-- Bảng social_accounts
CREATE TABLE `social_accounts`
(
    `id`          INT PRIMARY KEY AUTO_INCREMENT,
    `provider`    VARCHAR(20)  NOT NULL COMMENT 'Tên nhà social network',
    `provider_id` VARCHAR(50)  NOT NULL,
    `email`       VARCHAR(150) NOT NULL COMMENT 'Email tài khoản',
    `name`        VARCHAR(150) NOT NULL COMMENT 'Tên Người dùng',
    `user_id`     INT,
    CONSTRAINT `fk_social_accounts_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    UNIQUE INDEX `idx_provider_id` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `social_accounts` AUTO_INCREMENT = 10000;

-- Bảng categories
CREATE TABLE `categories`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd: đồ điện tử'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `categories` AUTO_INCREMENT = 10000;

-- Bảng products
CREATE TABLE `products`
(
    `id`          INT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(350)   NOT NULL COMMENT 'Tên sản phẩm',
    `price`       DECIMAL(16, 2) NOT NULL,
    `description` LONGTEXT,
    `created_at`  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `category_id` INT,
    CONSTRAINT `check_price` CHECK (`price` >= 0),
    CONSTRAINT `fk_products_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `products` AUTO_INCREMENT = 10000;

-- Bảng product_variants
CREATE TABLE `product_variants`
(
    `id`         INT PRIMARY KEY AUTO_INCREMENT,
    `product_id` INT NOT NULL,
    `size`       VARCHAR(50),
    `color`      VARCHAR(50),
    `stock`      INT DEFAULT 0,
    CONSTRAINT `check_stock` CHECK (`stock` >= 0),
    CONSTRAINT `fk_variants_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `product_variants` AUTO_INCREMENT = 10000;

-- Bảng product_images
CREATE TABLE `product_images`
(
    `id`         INT PRIMARY KEY AUTO_INCREMENT,
    `product_id` INT          NOT NULL,
    `image_url`  VARCHAR(300) NOT NULL,
    CONSTRAINT `fk_images_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `product_images` AUTO_INCREMENT = 10000;

-- Bảng orders
CREATE TABLE `orders`
(
    `id`               INT PRIMARY KEY AUTO_INCREMENT,
    `user_id`          INT            NOT NULL,
    `fullname`         VARCHAR(100) DEFAULT '',
    `email`            VARCHAR(100) DEFAULT '',
    `phone_number`     VARCHAR(20)    NOT NULL,
    `address`          VARCHAR(200)   NOT NULL,
    `note`             VARCHAR(100) DEFAULT '',
    `order_date`       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    `status`           ENUM('Chờ xác nhận', 'Đang xử lý', 'Đang giao hàng', 'Đã giao hàng', 'Đã hủy')
    DEFAULT 'Chờ xác nhận',
    `total_money`      DECIMAL(16, 2) NOT NULL,
    `shipping_method`  VARCHAR(100),
    `shipping_address` VARCHAR(200),
    `shipping_date`    DATE,
    `tracking_number`  VARCHAR(100),
    `payment_method`   VARCHAR(100),
    `payment_status`   ENUM('Đã thanh toán', 'Chưa thanh toán','COD') DEFAULT 'COD',
    `active`           TINYINT(1) DEFAULT 1,
    CONSTRAINT `check_total_money` CHECK (`total_money` >= 0),
    CONSTRAINT `fk_orders_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `orders` AUTO_INCREMENT = 10000;

-- Bảng order_details
CREATE TABLE `order_details`
(
    `id`                 INT PRIMARY KEY AUTO_INCREMENT,
    `order_id`           INT NOT NULL,
    `product_id`         INT NOT NULL,
    `number_of_products` INT NOT NULL,
    `variant_id`         INT,
    CONSTRAINT `check_number_of_products` CHECK (`number_of_products` > 0),
    CONSTRAINT `fk_details_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
    CONSTRAINT `fk_details_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
    CONSTRAINT `fk_details_variants` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER TABLE `order_details` AUTO_INCREMENT = 10000;

DELIMITER
//

CREATE TRIGGER `after_insert_order_details`
    AFTER INSERT
    ON `order_details`
    FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Kiểm tra nếu variant_id không null
    IF NEW.variant_id IS NOT NULL THEN
        -- Lấy số lượng tồn kho hiện tại
    SELECT stock
    INTO current_stock
    FROM product_variants
    WHERE id = NEW.variant_id;

    -- Kiểm tra nếu tồn kho không đủ
    IF current_stock < NEW.number_of_products THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock available';
    ELSE
            -- Cập nhật tồn kho
    UPDATE product_variants
    SET stock = stock - NEW.number_of_products
    WHERE id = NEW.variant_id;
END IF;
END IF;
END
//

DELIMITER ;

-- Event xóa token hết hạn
CREATE
EVENT IF NOT EXISTS `delete_expired_tokens`
ON SCHEDULE EVERY 5 MINUTE
DO
DELETE
FROM `tokens`
WHERE `expiration_date` < NOW();

-- View thống kê
CREATE
OR REPLACE VIEW `top_selling_products_monthly` AS
SELECT
    YEAR (`o`.`order_date`) AS `year`, SUM (IF(MONTH (`o`.`order_date`) = 1, `od`.`number_of_products`, 0)) AS January, SUM (IF(MONTH (`o`.`order_date`) = 2, `od`.`number_of_products`, 0)) AS February, SUM (IF(MONTH (`o`.`order_date`) = 3, `od`.`number_of_products`, 0)) AS March, SUM (IF(MONTH (`o`.`order_date`) = 4, `od`.`number_of_products`, 0)) AS April, SUM (IF(MONTH (`o`.`order_date`) = 5, `od`.`number_of_products`, 0)) AS May, SUM (IF(MONTH (`o`.`order_date`) = 6, `od`.`number_of_products`, 0)) AS June, SUM (IF(MONTH (`o`.`order_date`) = 7, `od`.`number_of_products`, 0)) AS July, SUM (IF(MONTH (`o`.`order_date`) = 8, `od`.`number_of_products`, 0)) AS August, SUM (IF(MONTH (`o`.`order_date`) = 9, `od`.`number_of_products`, 0)) AS September, SUM (IF(MONTH (`o`.`order_date`) = 10, `od`.`number_of_products`, 0)) AS October, SUM (IF(MONTH (`o`.`order_date`) = 11, `od`.`number_of_products`, 0)) AS November, SUM (IF(MONTH (`o`.`order_date`) = 12, `od`.`number_of_products`, 0)) AS December
FROM `order_details` `od`
    JOIN `orders` `o`
ON `od`.`order_id` = `o`.`id`
WHERE YEAR (`o`.`order_date`) = YEAR (CURRENT_DATE)
GROUP BY YEAR (`o`.`order_date`)
ORDER BY YEAR (`o`.`order_date`);

CREATE
OR REPLACE VIEW `top_selling_categories` AS
SELECT `c`.`name`                     AS `category_name`,
       SUM(`od`.`number_of_products`) AS `total_sold`
FROM `order_details` `od`
         JOIN `products` `p` ON `od`.`product_id` = `p`.`id`
         JOIN `categories` `c` ON `p`.`category_id` = `c`.`id`
         JOIN `orders` `o` ON `od`.`order_id` = `o`.`id`
WHERE YEAR (`o`.`order_date`) = YEAR (CURDATE())
GROUP BY `c`.`name`
ORDER BY `total_sold` DESC;

-- Set timezone and event scheduler
SET
GLOBAL event_scheduler = ON;
SET
GLOBAL time_zone = '+07:00';
SET
time_zone = '+07:00';

-- Grant privileges
UPDATE mysql.user
SET Host = '%'
WHERE User = 'root'
  AND Host = 'localhost';
FLUSH
PRIVILEGES;

-- Enable event
ALTER
EVENT `delete_expired_tokens` ENABLE;