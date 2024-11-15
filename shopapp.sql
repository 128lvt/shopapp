CREATE
DATABASE shopapp;
USE
shopapp;

-- Tạo bảng roles
CREATE TABLE roles
(
    id     INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL
);
ALTER TABLE roles AUTO_INCREMENT = 10000;

-- Tạo bảng users
CREATE TABLE users
(
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    fullname            VARCHAR(100)          DEFAULT '',
    phone_number        VARCHAR(10)  NOT NULL,
    `address`           VARCHAR(200)          DEFAULT '',
    `password`          VARCHAR(100) NOT NULL DEFAULT '',
    created_at          DATETIME              DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME ON UPDATE CURRENT_TIMESTAMP,
    is_active           BIT                   DEFAULT 1,
    facebook_account_id VARCHAR(100)          DEFAULT '',
    google_account_id   VARCHAR(100)          DEFAULT '',
    role_id             INT,
    FOREIGN KEY (role_id) REFERENCES roles (id)
);
ALTER TABLE users AUTO_INCREMENT = 10000;

-- Tạo bảng tokens
CREATE TABLE tokens
(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    token           VARCHAR(255) UNIQUE NOT NULL,
    expiration_date DATETIME            NOT NULL, -- Ngày hết hạn token
    user_id         INT                 NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

ALTER TABLE tokens AUTO_INCREMENT = 10000;

-- Tạo bảng social_accounts
CREATE TABLE social_accounts
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    `provider`  VARCHAR(20)  NOT NULL COMMENT 'Tên nhà social network',
    provider_id VARCHAR(50)  NOT NULL,
    email       VARCHAR(150) NOT NULL COMMENT 'Email tài khoản',
    `name`      VARCHAR(150) NOT NULL COMMENT 'Tên Người dùng',
    user_id     INT,
    FOREIGN KEY (user_id) REFERENCES users (id)
);
ALTER TABLE social_accounts AUTO_INCREMENT = 10000;

-- Tạo bảng categories
CREATE TABLE categories
(
    id     INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd: đồ điện tử'
);
ALTER TABLE categories AUTO_INCREMENT = 10000;

-- Tạo bảng products
CREATE TABLE products
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(350) COMMENT 'Tên sản phẩm',
    price         DECIMAl(20, 6) NOT NULL CHECK (price >= 0),
    `description` LONGTEXT,
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME ON UPDATE CURRENT_TIMESTAMP,
    category_id   INT,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL
);
ALTER TABLE products AUTO_INCREMENT = 10000;

-- Tạo bảng product_variants
CREATE TABLE product_variants
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    `size`     VARCHAR(50),
    color      VARCHAR(50),
    stock      INT DEFAULT 0 CHECK (stock >= 0),
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);
ALTER TABLE product_variants AUTO_INCREMENT = 10000;

-- Tạo bảng product_images
CREATE TABLE product_images
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    image_url  VARCHAR(300),
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);
ALTER TABLE product_images AUTO_INCREMENT = 10000;

-- Tạo bảng orders
CREATE TABLE orders
(
    id               INT PRIMARY KEY AUTO_INCREMENT,
    user_id          INT          NOT NULL,
    fullname         VARCHAR(100) DEFAULT '',
    email            VARCHAR(100) DEFAULT '',
    phone_number     VARCHAR(20)  NOT NULL,
    `address`        VARCHAR(200) NOT NULL,
    note             VARCHAR(100) DEFAULT '',
    order_date       DATETIME     DEFAULT CURRENT_TIMESTAMP,
    `status`         ENUM ('Chờ xác nhận', 'Đang xử lý', 'Đã gửi hàng', 'Đã giao hàng', 'Đã hủy') DEFAULT 'Chờ xác nhận' COMMENT 'Trạng thái đơn hàng',
    total_money      DECIMAL(20, 6) CHECK (total_money >= 0),
    shipping_method  VARCHAR(100),
    shipping_address VARCHAR(200),
    shipping_date    DATE,
    tracking_number  VARCHAR(100),
    payment_method   VARCHAR(100),
    active           BIT          DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users (id)
);
ALTER TABLE orders AUTO_INCREMENT = 10000;

-- Tạo bảng order_details
CREATE TABLE order_details
(
    id                 INT PRIMARY KEY AUTO_INCREMENT,
    order_id           INT,
    product_id         INT,
    number_of_products INT CHECK (number_of_products > 0),
    total_money        DECIMAL(20, 6),
    variant_id         INT,
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE RESTRICT,
    FOREIGN KEY (variant_id) REFERENCES product_variants (id) ON DELETE RESTRICT
);
ALTER TABLE order_details AUTO_INCREMENT = 10000;

DELIMITER
//

CREATE TRIGGER trg_update_stock_after_insert_order_detail
    AFTER INSERT
    ON order_details
    FOR EACH ROW
BEGIN
    IF NEW.variant_id IS NOT NULL THEN
    UPDATE product_variants
    SET stock = stock - NEW.number_of_products
    WHERE id = NEW.variant_id;

    IF (
    SELECT stock
    FROM product_variants
    WHERE id = NEW.variant_id) < 0 THEN
            SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Số lượng hàng trong kho không đủ';
END IF;
END IF;
END
//

DELIMITER ;

    CREATE
EVENT delete_expired_tokens
ON SCHEDULE EVERY 5 MINUTE
DO
DELETE
FROM tokens
WHERE expiration_date < NOW();

GRANT
EVENT
ON *.* TO 'root'@'localhost';
FLUSH
PRIVILEGES;

ALTER
EVENT delete_expired_tokens ENABLE;

SET
GLOBAL event_scheduler = ON;

SET
GLOBAL time_zone = '+07:00';

SET
time_zone = '+07:00';


CREATE OR REPLACE VIEW top_selling_products_monthly AS
SELECT
    -- Tổng số lượng sản phẩm bán được trong mỗi tháng của năm hiện tại
    YEAR(o.order_date) AS `year`,  -- Cột year sẽ được trả về
    SUM(CASE WHEN MONTH(o.order_date) = 1 THEN od.number_of_products ELSE 0 END) AS January,
    SUM(CASE WHEN MONTH(o.order_date) = 2 THEN od.number_of_products ELSE 0 END) AS February,
    SUM(CASE WHEN MONTH(o.order_date) = 3 THEN od.number_of_products ELSE 0 END) AS March,
    SUM(CASE WHEN MONTH(o.order_date) = 4 THEN od.number_of_products ELSE 0 END) AS April,
    SUM(CASE WHEN MONTH(o.order_date) = 5 THEN od.number_of_products ELSE 0 END) AS May,
    SUM(CASE WHEN MONTH(o.order_date) = 6 THEN od.number_of_products ELSE 0 END) AS June,
    SUM(CASE WHEN MONTH(o.order_date) = 7 THEN od.number_of_products ELSE 0 END) AS July,
    SUM(CASE WHEN MONTH(o.order_date) = 8 THEN od.number_of_products ELSE 0 END) AS August,
    SUM(CASE WHEN MONTH(o.order_date) = 9 THEN od.number_of_products ELSE 0 END) AS September,
    SUM(CASE WHEN MONTH(o.order_date) = 10 THEN od.number_of_products ELSE 0 END) AS October,
    SUM(CASE WHEN MONTH(o.order_date) = 11 THEN od.number_of_products ELSE 0 END) AS November,
    SUM(CASE WHEN MONTH(o.order_date) = 12 THEN od.number_of_products ELSE 0 END) AS December
FROM
    order_details od
    JOIN
    orders o ON od.order_id = o.id
WHERE
    YEAR(o.order_date) = YEAR(CURRENT_DATE())  -- Chỉ lấy đơn hàng của năm hiện tại
GROUP BY
    YEAR(o.order_date)  -- Nhóm theo năm
ORDER BY
    YEAR(o.order_date);  -- Sắp xếp theo năm


