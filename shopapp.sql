CREATE DATABASE shopapp;
USE shopapp;

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
    token_type      VARCHAR(50)         NOT NULL,
    expiration_date DATETIME,
    revoked         TINYINT(1) NOT NULL,
    expired         TINYINT(1) NOT NULL,
    user_id         INT,
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
    price         DECIMAl(20,6) NOT NULL CHECK (price >= 0),
    `description` LONGTEXT,
    created_at    DATETIME     DEFAULT CURRENT_TIMESTAMP,
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
    `status`         ENUM ('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending' COMMENT 'Trạng thái đơn hàng',
    total_money      DECIMAL(20,6) CHECK (total_money >= 0),
    shipping_method  VARCHAR(100),
    shipping_address VARCHAR(200),
    shipping_date    DATE,
    tracking_number  VARCHAR(100),
    payment_method   VARCHAR(100),
    active           BIT DEFAULT 1,
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
    total_money        DECIMAL(20,6),
    variant_id         INT,
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE RESTRICT,
    FOREIGN KEY (variant_id) REFERENCES product_variants (id) ON DELETE RESTRICT
);
ALTER TABLE order_details AUTO_INCREMENT = 10000;
