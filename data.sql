-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               9.1.0 - MySQL Community Server - GPL
-- Server OS:                    Linux
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping data for table shopapp.categories: ~6 rows (approximately)
REPLACE INTO `categories` (`id`, `name`) VALUES
	(10000, 'Áo Polo'),
	(10001, 'Áo Thun'),
	(10002, 'Áo Khoác'),
	(10003, 'Áo Sơ Mi'),
	(10004, 'Quần Âu'),
	(10005, 'Quần Kaki');

-- Dumping data for table shopapp.orders: ~7 rows (approximately)
REPLACE INTO `orders` (`id`, `user_id`, `fullname`, `email`, `phone_number`, `address`, `note`, `order_date`, `status`, `total_money`, `shipping_method`, `shipping_address`, `shipping_date`, `tracking_number`, `payment_method`, `active`) VALUES
	(10005, 10001, 'user', '124ugust@gmail.com', '0123456789', '123', '', '2023-09-13 23:59:58', 'Chờ xác nhận', 2773902.000000, 'standard', NULL, '2024-11-14', NULL, 'cod', b'1'),
	(10006, 10000, 'dev', 'lvtdragun@gmail.com', '0123456789', 'Long An', '', '2024-11-14 00:00:00', 'Chờ xác nhận', 482473.000000, 'standard', NULL, '2024-11-14', NULL, 'cod', b'1'),
	(10007, 10000, 'dev', '124ugust@gmail.com', '0123456789', 'Long An', 'ĐẸP TRAI', '2024-11-14 00:00:00', 'Chờ xác nhận', 4824730.000000, 'standard', NULL, '2024-11-14', NULL, 'cod', b'1'),
	(10008, 10000, 'dev', 'lvtdragun@gmail.com', '0123456789', 'Long An', '', '2024-11-14 00:00:00', 'Chờ xác nhận', 36060730.000000, 'standard', NULL, '2024-11-14', NULL, 'cod', b'1'),
	(10009, 10000, 'dev', 'lvtdragun@gmail.com', '0123456789', 'Long An', '', '2024-11-14 00:00:00', 'Chờ xác nhận', 839178.000000, 'standard', NULL, '2024-11-14', NULL, 'cod', b'1'),
	(10010, 10000, 'dev', '124ugust@gmail.comccc', '0123456789', 'Long An', '', '2024-11-14 00:00:00', 'Chờ xác nhận', 52704136.000000, 'standard', NULL, '2024-11-14', NULL, 'cod', b'1'),
	(10011, 10004, 'user', '124ugust@gmail.com', '0123456789', 'Long An', '', '2024-11-16 00:00:00', 'Đang giao hàng', 10221478.000000, 'standard', NULL, '2024-11-16', NULL, 'cod', b'1'),
	(10012, 10004, 'user', 'ingame902@gmail.com', '0123456789', 'Long An', '', '2024-11-16 00:00:00', 'Chờ xác nhận', 1680380.000000, 'standard', NULL, '2024-11-16', NULL, 'cod', b'1');

-- Dumping data for table shopapp.order_details: ~8 rows (approximately)
REPLACE INTO `order_details` (`id`, `order_id`, `product_id`, `number_of_products`, `total_money`, `variant_id`) VALUES
	(10006, 10005, 10020, 1, NULL, 10175),
	(10007, 10006, 10017, 1, NULL, 10158),
	(10008, 10007, 10017, 10, NULL, 10154),
	(10009, 10008, 10020, 13, NULL, 10172),
	(10010, 10009, 10001, 6, NULL, 10060),
	(10011, 10010, 10020, 19, NULL, 10176),
	(10012, 10011, 10028, 1, NULL, 10220),
	(10013, 10011, 10027, 1, NULL, 10214),
	(10014, 10012, 10000, 1, NULL, 10054);

-- Dumping data for table shopapp.products: ~30 rows (approximately)
REPLACE INTO `products` (`id`, `name`, `price`, `description`, `created_at`, `updated_at`, `category_id`) VALUES
	(10000, 'Synergistic Cotton Bag', 1680380.000000, 'Sint dolores beatae sit voluptates eos dolorem.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10002),
	(10001, 'Gorgeous Iron Hat', 139863.000000, 'Nulla adipisci veniam corrupti sint laudantium quae sint.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10004),
	(10002, 'Synergistic Silk Keyboard', 2220981.000000, 'Rerum nulla aperiam itaque aut voluptas beatae et.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10004),
	(10003, 'Incredible Steel Plate', 7115084.000000, 'Quas excepturi itaque fuga.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10001),
	(10004, 'Durable Iron Pants', 1797460.000000, 'Magni sint ducimus at nostrum et.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10001),
	(10005, 'Rustic Steel Table', 3690944.000000, 'Placeat tenetur qui tempore a necessitatibus necessitatibus quos.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10001),
	(10006, 'Aerodynamic Marble Car', 7720163.000000, 'Laudantium quasi velit ipsam recusandae omnis dolorem.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10000),
	(10007, 'Practical Rubber Bag', 1443843.000000, 'Sit culpa non consectetur amet alias.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10004),
	(10008, 'Intelligent Paper Lamp', 8579705.000000, 'Expedita incidunt non.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10004),
	(10009, 'Mediocre Wooden Keyboard', 5710411.000000, 'Ut dolorem et illum sit dolorum sunt iure.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10002),
	(10010, 'Ergonomic Plastic Shoes', 8438572.000000, 'Vel in facilis minus ducimus quo animi.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10002),
	(10011, 'Enormous Steel Chair', 7589061.000000, 'Quibusdam sit facilis praesentium ut.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10004),
	(10012, 'Intelligent Aluminum Bag', 4227943.000000, 'Vitae tempora neque facere non repellendus.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10001),
	(10013, 'Ergonomic Cotton Bench', 2480507.000000, 'Et dicta iste veniam et.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10004),
	(10014, 'Awesome Bronze Bottle', 4214179.000000, 'Natus reiciendis vel pariatur qui qui.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10001),
	(10015, 'Enormous Leather Keyboard', 5375205.000000, 'Voluptatum quidem omnis aliquid et occaecati aut.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10000),
	(10016, 'Lightweight Rubber Bottle', 3424652.000000, 'Qui recusandae aut.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10002),
	(10017, 'Aerodynamic Wool Bench', 482473.000000, 'Laboriosam nam quibusdam modi dolor quasi.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10002),
	(10018, 'Durable Rubber Wallet', 2186084.000000, 'Voluptates omnis veniam qui facere.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10004),
	(10019, 'Practical Silk Hat', 293346.000000, 'Quo qui asperiores rerum recusandae dolor tenetur at.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10004),
	(10020, 'Aerodynamic Granite Pants', 2773902.000000, 'Quo tempora unde placeat qui.', '2024-11-13 21:33:52', '2024-11-13 21:33:52', 10002),
	(10021, 'Heavy Duty Bronze Bottle', 1093142.000000, 'Delectus numquam incidunt reprehenderit.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10003),
	(10022, 'Rustic Paper Bag', 4303095.000000, 'Sequi voluptates in.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10001),
	(10023, 'Rustic Wool Pants', 7402870.000000, 'Quae dolorum quod ea impedit sunt quibusdam repellendus.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10003),
	(10024, 'Lightweight Cotton Clock', 1049849.000000, 'Vero odio error.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10003),
	(10025, 'Aerodynamic Bronze Watch', 2757405.000000, 'Pariatur quibusdam iure explicabo fugit quo.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10004),
	(10026, 'Small Silk Car', 7926475.000000, 'Modi ea esse.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10004),
	(10027, 'Incredible Bronze Shoes', 7468277.000000, 'Dolorem hic eligendi itaque.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10003),
	(10028, 'Gorgeous Wool Coat', 2753201.000000, 'Facere ut dolores asperiores.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10004),
	(10029, 'Intelligent Wooden Wallet', 3810479.000000, 'Et dolorem non.', '2024-11-13 21:33:53', '2024-11-13 21:33:53', 10002),
	(10030, 'IPad Pro 2023', 100000.000000, 'This is a test', '2024-11-14 18:08:49', '2024-11-14 18:08:49', 10001);

-- Dumping data for table shopapp.product_images: ~30 rows (approximately)
REPLACE INTO `product_images` (`id`, `product_id`, `image_url`) VALUES
	(10000, 10000, '88447db4-c461-4601-9b0a-e2f318af57c7_001.jpg'),
	(10001, 10001, '8ee28732-dc71-4926-881e-366c3e488787_002.jpg'),
	(10002, 10002, '5e5cc098-b99f-499c-b293-a69c03327fe0_003.jpg'),
	(10003, 10003, '6b134654-33a1-4b1c-bf70-8e99526d71e7_004.jpg'),
	(10004, 10004, 'ad7e5b10-7245-4316-a3e7-d69316a777e7_005.jpg'),
	(10005, 10005, 'fef7cf5f-b864-4535-ade4-d5ce325bfc74_006.jpg'),
	(10006, 10006, 'e129f6c9-5db0-4a0a-a5c6-035aac7b0060_007.jpg'),
	(10007, 10007, 'cdb82328-be0e-4095-8376-ee3384765141_008.jpg'),
	(10008, 10008, '866fa0e8-25ca-47d4-81ff-ecfdde65f112_009.jpg'),
	(10009, 10009, '74603a2f-db3a-403b-b55c-a59947976870_010.jpg'),
	(10010, 10010, '062ae314-0c48-4024-97df-e5c4c3a863f0_011.jpg'),
	(10011, 10011, '76172308-113a-4f7e-8c23-f65315571c13_012.jpg'),
	(10012, 10012, 'ba720daa-ee7e-48d4-8958-15d492616eba_013.jpg'),
	(10013, 10013, '7b7d886f-22be-467f-92c4-b38c6504e829_014.jpg'),
	(10014, 10014, 'a6921156-ba0d-455c-b811-d0af99000907_015.jpg'),
	(10015, 10015, '369f962b-2dfb-4bc2-af1b-cc5119487a5e_016.jpg'),
	(10016, 10016, 'e713c06a-950b-47db-8a7b-391d1fd58511_017.jpg'),
	(10017, 10017, '9139973e-d7a7-4118-82ad-9ef6484821cf_019.jpg'),
	(10018, 10018, 'a8555cec-0195-4ec1-bf1f-abd6c19e246a_020.jpg'),
	(10019, 10019, 'db1ae7ee-0571-4abd-9c8e-debfcf89b4a7_021.jpg'),
	(10020, 10020, 'dc9fc103-5c53-456a-abfe-13903f25f7d1_024.jpg'),
	(10021, 10029, 'f10d9ef9-8794-4bb1-a415-df57f5b6169c_026.jpg'),
	(10022, 10028, 'bc79cc3d-b829-43fe-9815-e46d962ef75f_036.jpg'),
	(10023, 10027, '28a2ba22-8070-43d9-8079-1f14c6a443c2_044.jpg'),
	(10024, 10026, '199ec19b-e3d0-4616-8847-573c90ebda53_051.jpg'),
	(10025, 10025, 'd2506e89-78da-4d54-bf8e-50526b8f41e1_115.jpg'),
	(10026, 10024, 'd409c3ca-fbb6-4557-ab15-10c9927e5244_122.jpg'),
	(10027, 10023, '71547c23-3644-4803-a4db-932bfbbea54e_094.jpg'),
	(10028, 10022, '49b9bf20-1248-42a1-9eea-d4b3f454abf9_046.jpg'),
	(10029, 10021, '2a5b0fb8-2675-4615-a730-f84a63cf9894_110.jpg'),
	(10030, 10030, '4932f3cf-39c6-4c26-8243-47590615563e_125.jpg');

-- Dumping data for table shopapp.product_variants: ~183 rows (approximately)
REPLACE INTO `product_variants` (`id`, `product_id`, `size`, `color`, `stock`) VALUES
	(10049, 10000, 'S', 'Đen', 100),
	(10050, 10000, 'M', 'Đen', 100),
	(10051, 10000, 'M', 'Trắng', 100),
	(10052, 10000, 'S', 'Trắng', 100),
	(10053, 10000, 'M', 'Trắng', 100),
	(10054, 10000, 'L', 'Trắng', 99),
	(10055, 10000, 'S', 'Đen', 100),
	(10056, 10000, 'M', 'Đen', 100),
	(10057, 10000, 'L', 'Đen', 100),
	(10058, 10001, 'S', 'Trắng', 100),
	(10059, 10001, 'M', 'Trắng', 100),
	(10060, 10001, 'L', 'Trắng', 94),
	(10061, 10001, 'S', 'Đen', 100),
	(10062, 10001, 'M', 'Đen', 100),
	(10063, 10001, 'L', 'Đen', 100),
	(10064, 10002, 'S', 'Trắng', 100),
	(10065, 10002, 'M', 'Trắng', 100),
	(10066, 10002, 'L', 'Trắng', 100),
	(10067, 10002, 'S', 'Đen', 100),
	(10068, 10002, 'M', 'Đen', 100),
	(10069, 10002, 'L', 'Đen', 100),
	(10070, 10003, 'S', 'Trắng', 100),
	(10071, 10003, 'M', 'Trắng', 100),
	(10072, 10003, 'L', 'Trắng', 100),
	(10073, 10003, 'S', 'Đen', 100),
	(10074, 10003, 'M', 'Đen', 100),
	(10075, 10003, 'L', 'Đen', 100),
	(10076, 10004, 'S', 'Trắng', 100),
	(10077, 10004, 'M', 'Trắng', 100),
	(10078, 10004, 'L', 'Trắng', 100),
	(10079, 10004, 'S', 'Đen', 100),
	(10080, 10004, 'M', 'Đen', 100),
	(10081, 10004, 'L', 'Đen', 100),
	(10082, 10005, 'S', 'Trắng', 100),
	(10083, 10005, 'M', 'Trắng', 100),
	(10084, 10005, 'L', 'Trắng', 100),
	(10085, 10005, 'S', 'Đen', 100),
	(10086, 10005, 'M', 'Đen', 100),
	(10087, 10005, 'L', 'Đen', 100),
	(10088, 10006, 'S', 'Trắng', 100),
	(10089, 10006, 'M', 'Trắng', 100),
	(10090, 10006, 'L', 'Trắng', 100),
	(10091, 10006, 'S', 'Đen', 100),
	(10092, 10006, 'M', 'Đen', 100),
	(10093, 10006, 'L', 'Đen', 100),
	(10094, 10007, 'S', 'Trắng', 100),
	(10095, 10007, 'M', 'Trắng', 100),
	(10096, 10007, 'L', 'Trắng', 100),
	(10097, 10007, 'S', 'Đen', 100),
	(10098, 10007, 'M', 'Đen', 100),
	(10099, 10007, 'L', 'Đen', 100),
	(10100, 10008, 'S', 'Trắng', 100),
	(10101, 10008, 'M', 'Trắng', 100),
	(10102, 10008, 'L', 'Trắng', 100),
	(10103, 10008, 'S', 'Đen', 100),
	(10104, 10008, 'M', 'Đen', 100),
	(10105, 10008, 'L', 'Đen', 100),
	(10106, 10009, 'S', 'Trắng', 100),
	(10107, 10009, 'M', 'Trắng', 100),
	(10108, 10009, 'L', 'Trắng', 100),
	(10109, 10009, 'S', 'Đen', 100),
	(10110, 10009, 'M', 'Đen', 100),
	(10111, 10009, 'L', 'Đen', 100),
	(10112, 10010, 'S', 'Trắng', 100),
	(10113, 10010, 'M', 'Trắng', 100),
	(10114, 10010, 'L', 'Trắng', 100),
	(10115, 10010, 'S', 'Đen', 100),
	(10116, 10010, 'M', 'Đen', 100),
	(10117, 10010, 'L', 'Đen', 100),
	(10118, 10011, 'S', 'Trắng', 100),
	(10119, 10011, 'M', 'Trắng', 100),
	(10120, 10011, 'L', 'Trắng', 100),
	(10121, 10011, 'S', 'Đen', 100),
	(10122, 10011, 'M', 'Đen', 100),
	(10123, 10011, 'L', 'Đen', 100),
	(10124, 10012, 'S', 'Trắng', 100),
	(10125, 10012, 'M', 'Trắng', 100),
	(10126, 10012, 'L', 'Trắng', 100),
	(10127, 10012, 'S', 'Đen', 100),
	(10128, 10012, 'M', 'Đen', 100),
	(10129, 10012, 'L', 'Đen', 100),
	(10130, 10013, 'S', 'Trắng', 100),
	(10131, 10013, 'M', 'Trắng', 100),
	(10132, 10013, 'L', 'Trắng', 100),
	(10133, 10013, 'S', 'Đen', 100),
	(10134, 10013, 'M', 'Đen', 100),
	(10135, 10013, 'L', 'Đen', 100),
	(10136, 10014, 'S', 'Trắng', 100),
	(10137, 10014, 'M', 'Trắng', 100),
	(10138, 10014, 'L', 'Trắng', 100),
	(10139, 10014, 'S', 'Đen', 100),
	(10140, 10014, 'M', 'Đen', 100),
	(10141, 10014, 'L', 'Đen', 100),
	(10142, 10015, 'S', 'Trắng', 100),
	(10143, 10015, 'M', 'Trắng', 100),
	(10144, 10015, 'L', 'Trắng', 100),
	(10145, 10015, 'S', 'Đen', 100),
	(10146, 10015, 'M', 'Đen', 100),
	(10147, 10015, 'L', 'Đen', 100),
	(10148, 10016, 'S', 'Trắng', 100),
	(10149, 10016, 'M', 'Trắng', 100),
	(10150, 10016, 'L', 'Trắng', 100),
	(10151, 10016, 'S', 'Đen', 100),
	(10152, 10016, 'M', 'Đen', 100),
	(10153, 10016, 'L', 'Đen', 100),
	(10154, 10017, 'S', 'Trắng', 90),
	(10155, 10017, 'M', 'Trắng', 100),
	(10156, 10017, 'L', 'Trắng', 100),
	(10157, 10017, 'S', 'Đen', 100),
	(10158, 10017, 'M', 'Đen', 99),
	(10159, 10017, 'L', 'Đen', 100),
	(10160, 10018, 'S', 'Trắng', 100),
	(10161, 10018, 'M', 'Trắng', 100),
	(10162, 10018, 'L', 'Trắng', 100),
	(10163, 10018, 'S', 'Đen', 100),
	(10164, 10018, 'M', 'Đen', 100),
	(10165, 10018, 'L', 'Đen', 100),
	(10166, 10019, 'S', 'Trắng', 100),
	(10167, 10019, 'M', 'Trắng', 100),
	(10168, 10019, 'L', 'Trắng', 100),
	(10169, 10019, 'S', 'Đen', 100),
	(10170, 10019, 'M', 'Đen', 100),
	(10171, 10019, 'L', 'Đen', 100),
	(10172, 10020, 'S', 'Trắng', 87),
	(10173, 10020, 'M', 'Trắng', 100),
	(10174, 10020, 'L', 'Trắng', 100),
	(10175, 10020, 'S', 'Đen', 100),
	(10176, 10020, 'M', 'Đen', 81),
	(10177, 10020, 'L', 'Đen', 100),
	(10178, 10021, 'S', 'Trắng', 100),
	(10179, 10021, 'M', 'Trắng', 100),
	(10180, 10021, 'L', 'Trắng', 100),
	(10181, 10021, 'S', 'Đen', 100),
	(10182, 10021, 'M', 'Đen', 100),
	(10183, 10021, 'L', 'Đen', 100),
	(10184, 10022, 'S', 'Trắng', 100),
	(10185, 10022, 'M', 'Trắng', 100),
	(10186, 10022, 'L', 'Trắng', 100),
	(10187, 10022, 'S', 'Đen', 100),
	(10188, 10022, 'M', 'Đen', 100),
	(10189, 10022, 'L', 'Đen', 100),
	(10190, 10023, 'S', 'Trắng', 100),
	(10191, 10023, 'M', 'Trắng', 100),
	(10192, 10023, 'L', 'Trắng', 100),
	(10193, 10023, 'S', 'Đen', 100),
	(10194, 10023, 'M', 'Đen', 100),
	(10195, 10023, 'L', 'Đen', 100),
	(10196, 10024, 'S', 'Trắng', 100),
	(10197, 10024, 'M', 'Trắng', 100),
	(10198, 10024, 'L', 'Trắng', 100),
	(10199, 10024, 'S', 'Đen', 100),
	(10200, 10024, 'M', 'Đen', 100),
	(10201, 10024, 'L', 'Đen', 100),
	(10202, 10025, 'S', 'Trắng', 100),
	(10203, 10025, 'M', 'Trắng', 100),
	(10204, 10025, 'L', 'Trắng', 100),
	(10205, 10025, 'S', 'Đen', 100),
	(10206, 10025, 'M', 'Đen', 100),
	(10207, 10025, 'L', 'Đen', 100),
	(10208, 10026, 'S', 'Trắng', 100),
	(10209, 10026, 'M', 'Trắng', 100),
	(10210, 10026, 'L', 'Trắng', 100),
	(10211, 10026, 'S', 'Đen', 100),
	(10212, 10026, 'M', 'Đen', 100),
	(10213, 10026, 'L', 'Đen', 100),
	(10214, 10027, 'S', 'Trắng', 99),
	(10215, 10027, 'M', 'Trắng', 100),
	(10216, 10027, 'L', 'Trắng', 100),
	(10217, 10027, 'S', 'Đen', 100),
	(10218, 10027, 'M', 'Đen', 100),
	(10219, 10027, 'L', 'Đen', 100),
	(10220, 10028, 'S', 'Trắng', 99),
	(10221, 10028, 'M', 'Trắng', 100),
	(10222, 10028, 'L', 'Trắng', 100),
	(10223, 10028, 'S', 'Đen', 100),
	(10224, 10028, 'M', 'Đen', 100),
	(10225, 10028, 'L', 'Đen', 100),
	(10226, 10029, 'S', 'Trắng', 100),
	(10227, 10029, 'M', 'Trắng', 100),
	(10228, 10029, 'L', 'Trắng', 100),
	(10229, 10029, 'S', 'Đen', 100),
	(10230, 10029, 'M', 'Đen', 100),
	(10231, 10029, 'L', 'Đen', 100);

-- Dumping data for table shopapp.roles: ~3 rows (approximately)
REPLACE INTO `roles` (`id`, `name`) VALUES
	(10000, 'dev'),
	(10001, 'admin'),
	(10002, 'user');

-- Dumping data for table shopapp.social_accounts: ~0 rows (approximately)

-- Dumping data for table shopapp.tokens: ~1 rows (approximately)

-- Dumping data for table shopapp.users: ~8 rows (approximately)
REPLACE INTO `users` (`id`, `fullname`, `email`, `address`, `password`, `created_at`, `updated_at`, `is_active`, `facebook_account_id`, `google_account_id`, `role_id`) VALUES
	(10000, 'dev', '123', 'VietNam', '$2a$10$PlgEyrxTz7NOMRI6SLh65udwD.SLvgiAGc6uowE1dWDa83z7oP6hK', '2024-11-13 21:31:28', '2024-11-13 21:31:28', b'1', NULL, NULL, 10000),
	(10001, 'user', '000', 'VietNam', '$2a$10$rZ2e6GD8tAXWO9NW4DdkE.p4pkAGoDANaeSbIEfQ4YD56PRTNKY6.', '2024-11-14 20:06:44', '2024-11-14 13:07:22', b'1', NULL, NULL, 10002),
	(10002, 'user', '111', 'VietNam', '$2a$10$hU230BMkH7lu9i6ltmGVPeVR9JzFeoEvJIeGGmblyZPdK5r.EvdYK', '2024-11-14 20:19:01', '2024-11-14 20:19:01', b'1', NULL, NULL, 10002),
	(10003, 'user', 'lvt@gmail.com', 'VietNam', '$2a$10$knZWmgfWyJy.BSvqARhRmeNbY0fjRZ3s1dofFAZA2s8.BfRtPIlE.', '2024-11-15 16:34:00', '2024-11-15 16:34:00', b'1', NULL, NULL, 10002),
	(10004, 'user', '124ugust@gmail.com', 'VietNam', '$2a$10$kJlhwgZ/3dXouowjNSe3xuBISYirhDIYLPppfXVAc4cKSIS8rhOZe', '2024-11-15 17:21:58', '2024-11-15 20:32:42', b'1', NULL, NULL, 10002),
	(10005, 'user', '1111@gmail.com', 'VietNam', '$2a$10$piZE2Als0TJbYybOyZ6fwOtfNa29oh41EmMOOoRQmyzXzkKVS3dMO', '2024-11-15 19:09:39', '2024-11-15 19:09:39', b'1', NULL, NULL, 10002),
	(10006, 'user', '11211@gmail.com', 'VietNam', '$2a$10$pDsfu0CWnIIYWbi81/cnounOgrbMgEUtX4cHx5qouKrhY0uyq2VNK', '2024-11-15 19:50:23', '2024-11-15 19:50:23', b'1', NULL, NULL, 10002),
	(10007, NULL, 'ingame902@gmail.com', NULL, '$2a$10$927FwPZbWF.G0Q1g3/uS.udFiqVk3IDxJYa/DMLcsJGsTG16yNhJG', '2024-11-15 19:53:09', '2024-11-15 19:53:09', b'1', NULL, NULL, 10002);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
