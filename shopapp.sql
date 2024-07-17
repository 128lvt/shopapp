CREATE DATABASE shopapp;

USE shopapp;

-- Tạo bảng users
CREATE TABLE
    users (
        id INT PRIMARY KEY AUTO_INCREMENT,
        fullname VARCHAR(100) DEFAULT '',
        phone_number VARCHAR(10) NOT NULL,
        `address` VARCHAR(200) DEFAULT '',
        `password` VARCHAR(100) NOT NULL DEFAULT '',
        created_at DATETIME,
        updated_at DATETIME,
        is_active TINYINT DEFAULT 1,
        date_of_birth DATE,
        facebook_account_id INT DEFAULT 0,
        google_account_id INT DEFAULT 0
    );

-- Thêm role_id vào bảng users
ALTER TABLE users
ADD COLUMN role_id INT;

-- Tạo bảng roles
CREATE TABLE
    roles (
        id INT PRIMARY KEY AUTO_INCREMENT,
        `name` VARCHAR(20) NOT NULL
    );

-- Tạo khoá ngoại fk_roles_users
ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles (id);

-- Tạo bảng tokens
CREATE TABLE
    tokens (
        id INT PRIMARY KEY AUTO_INCREMENT,
        token VARCHAR(255) UNIQUE NOT NULL,
        token_type VARCHAR(50) NOT NULL,
        expiration_date DATETIME,
        revoked TINYINT (1) NOT NULL,
        expired TINYINT (1) NOT NULL,
        user_id INT, -- Foreign Key
        FOREIGN KEY (user_id) REFERENCES users (id)
    );

-- Tạo bảng social_account
CREATE TABLE
    social_accounts (
        id INT PRIMARY KEY AUTO_INCREMENT,
        `provider` VARCHAR(20) NOT NULL COMMENT 'Tên nhà social network',
        provider_id VARCHAR(50) NOT NULL,
        email VARCHAR(150) NOT NULL COMMENT 'Email tài khoản',
        `name` VARCHAR(150) NOT NULL COMMENT 'Tên Người dùng',
        user_id INT,
        FOREIGN KEY (user_id) REFERENCES users (id)
    );

-- Tạo bảng categories
CREATE TABLE
    categories (
        id INT PRIMARY KEY AUTO_INCREMENT,
        `name` VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd: đồ điện tử'
    );

-- Tạo bảng products
CREATE TABLE
    products (
        id INT PRIMARY KEY AUTO_INCREMENT,
        `name` VARCHAR(350) COMMENT 'Tên sản phẩm',
        price FLOAT NOT NULL CHECK (price >= 0),
        thumbnail VARCHAR(300) DEFAULT '',
        `description` LONGTEXT,
        created_at DATETIME,
        updated_at DATETIME,
        category_id INT,
        FOREIGN KEY (category_id) REFERENCES categories (id)
    );

-- Tạo bảng product_images
CREATE TABLE
    product_images (
        id INT PRIMARY KEY AUTO_INCREMENT,
        product_id INT,
        FOREIGN KEY (product_id) REFERENCES products (id),
        CONSTRAINT fk_product_images_product_id FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE,
        image_url VARCHAR(300)
    );

-- Tạo bảng orders
CREATE TABLE
    orders (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        FOREIGN KEY (user_id) REFERENCES users (id),
        fullname VARCHAR(100) DEFAULT '',
        email VARCHAR(100) DEFAULT '',
        phone_number VARCHAR(20) NOT NULL,
        `address` VARCHAR(200) NOT NULL,
        note VARCHAR(100) DEFAULT '',
        order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
        `status` VARCHAR(20),
        total_money FLOAT CHECK (total_money >= 0)
    );

ALTER TABLE orders
ADD COLUMN shipping_method VARCHAR(100);

ALTER TABLE orders
ADD COLUMN shipping_address VARCHAR(200);

ALTER TABLE orders
ADD COLUMN shipping_date DATE;

ALTER TABLE orders
ADD COLUMN tracking_number VARCHAR(100);

ALTER TABLE orders
ADD COLUMN payment_method VARCHAR(100);

ALTER TABLE orders
ADD COLUMN active TINYINT (1);

-- Status đơn hàng chỉ được phép nhận một số giá trị cụ thể
ALTER TABLE orders MODIFY COLUMN status ENUM (
    'pending',
    'processing',
    'shipped',
    'delivered',
    'cancelled'
) COMMENT 'Trạng thái đơn hàng';

-- Tạo bảng order_details
CREATE TABLE
    order_details (
        id INT PRIMARY KEY AUTO_INCREMENT,
        order_id INT,
        FOREIGN KEY (order_id) REFERENCES orders (id),
        product_id INT,
        FOREIGN KEY (product_id) REFERENCES products (id),
        price FLOAT CHECK (price >= 0),
        number_of_products INT CHECK (number_of_products > 0),
        total_money FLOAT,
        color VARCHAR(20) DEFAULT ''
    );