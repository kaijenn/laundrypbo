/*
 Navicat Premium Data Transfer

 Source Server         : yoga
 Source Server Type    : MySQL
 Source Server Version : 100428 (10.4.28-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : laundry

 Target Server Type    : MySQL
 Target Server Version : 100428 (10.4.28-MariaDB)
 File Encoding         : 65001

 Date: 09/09/2024 09:45:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for jpakaian
-- ----------------------------
DROP TABLE IF EXISTS `jpakaian`;
CREATE TABLE `jpakaian`  (
  `id_jpakaian` int NOT NULL AUTO_INCREMENT,
  `jenis_pakaian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_by` int NULL DEFAULT NULL,
  `update_by` int NULL DEFAULT NULL,
  `delete_by` int NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id_jpakaian`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jpakaian
-- ----------------------------
INSERT INTO `jpakaian` VALUES (1, 'Baju Lengan Panjang', NULL, 1, NULL, NULL, '2024-08-19 18:58:11', NULL);
INSERT INTO `jpakaian` VALUES (2, 'Celana', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jpakaian` VALUES (3, 'Celana Dalam', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jpakaian` VALUES (6, 'Kemeja', 1, 1, NULL, '2024-07-31 09:33:56', '2024-07-31 09:34:01', NULL);
INSERT INTO `jpakaian` VALUES (8, 'Jaket Kulit', 3, 3, NULL, '2024-08-18 19:53:23', '2024-08-18 19:53:34', NULL);

-- ----------------------------
-- Table structure for jpelayanan
-- ----------------------------
DROP TABLE IF EXISTS `jpelayanan`;
CREATE TABLE `jpelayanan`  (
  `id_jpelayanan` int NOT NULL AUTO_INCREMENT,
  `jenis_pelayanan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `create_by` int NULL DEFAULT NULL,
  `update_by` int NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id_jpelayanan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jpelayanan
-- ----------------------------
INSERT INTO `jpelayanan` VALUES (1, 'Cuci Basah', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jpelayanan` VALUES (2, 'Cuci Kering', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jpelayanan` VALUES (3, 'Cuci Basah + Setrika', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jpelayanan` VALUES (4, 'Setrika', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jpelayanan` VALUES (5, 'Cuci Kering + Setrika', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jpelayanan` VALUES (7, 'Cuci Kering Setengah Matang', 1, 1, NULL, '2024-07-31 09:29:00', '2024-07-31 09:29:39', NULL);

-- ----------------------------
-- Table structure for pemesanan
-- ----------------------------
DROP TABLE IF EXISTS `pemesanan`;
CREATE TABLE `pemesanan`  (
  `id_pemesanan` int NOT NULL AUTO_INCREMENT,
  `id_user` int NULL DEFAULT NULL,
  `id_jpakaian` int NULL DEFAULT NULL,
  `berat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `harga` int NULL DEFAULT NULL,
  `id_jpelayanan` int NULL DEFAULT NULL,
  `status` enum('DiKerjakan','DiAntar','Selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kode_pemesanan` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_by` int NULL DEFAULT NULL,
  `update_by` int NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `tipe` enum('Antar & Bayar Nanti','Pickup & Bayar Nanti','Antar & Bayar Langsung','Pickup & Bayar Langsung') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_pemesanan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pemesanan
-- ----------------------------
INSERT INTO `pemesanan` VALUES (78, 38, 2, '1kg', 20000, 4, 'Selesai', 'PS00000003', 1, 1, NULL, '2024-08-14 08:37:04', '2024-08-15 13:39:47', NULL, 'Pickup & Bayar Nanti');
INSERT INTO `pemesanan` VALUES (79, 38, 1, '65555', 2147483647, 2, 'DiKerjakan', 'PS00000004', 1, NULL, NULL, '2024-08-17 14:12:46', NULL, NULL, 'Antar & Bayar Nanti');
INSERT INTO `pemesanan` VALUES (80, 38, 2, '6', 6000, 2, 'Selesai', 'PS00000005', 3, NULL, NULL, '2024-08-17 14:25:34', NULL, '2024-08-17 17:58:45', 'Antar & Bayar Langsung');
INSERT INTO `pemesanan` VALUES (81, 16, 2, '6', 6000, 2, 'DiKerjakan', 'PS00000006', 1, 1, NULL, '2024-08-17 17:05:30', '2024-09-05 18:26:26', NULL, 'Antar & Bayar Nanti');
INSERT INTO `pemesanan` VALUES (82, 38, 1, '1111kg', 12000, 1, 'Selesai', 'PS00000007', 3, NULL, NULL, '2024-08-18 19:49:47', NULL, NULL, 'Pickup & Bayar Langsung');
INSERT INTO `pemesanan` VALUES (83, 17, 3, '111', 111, 3, 'Selesai', 'PS00000008', NULL, NULL, NULL, NULL, NULL, NULL, 'Pickup & Bayar Nanti');
INSERT INTO `pemesanan` VALUES (84, 38, 3, '99999', 99999, 2, NULL, 'PS00000009', NULL, NULL, NULL, NULL, NULL, NULL, 'Pickup & Bayar Langsung');

-- ----------------------------
-- Table structure for pemesanan_backup
-- ----------------------------
DROP TABLE IF EXISTS `pemesanan_backup`;
CREATE TABLE `pemesanan_backup`  (
  `id_pemesanan` int NOT NULL,
  `id_user` int NULL DEFAULT NULL,
  `id_jpakaian` int NULL DEFAULT NULL,
  `berat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `harga` int NULL DEFAULT NULL,
  `id_jpelayanan` int NULL DEFAULT NULL,
  `status` enum('DiKerjakan','DiAntar','Selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kode_pemesanan` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_by` int NULL DEFAULT NULL,
  `update_by` int NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `tipe` enum('Antar & Bayar Nanti','Pickup & Bayar Nanti','Antar & Bayar Langsung','Pickup & Bayar Langsung') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `backup_at` datetime NULL DEFAULT NULL,
  `backup_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_pemesanan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pemesanan_backup
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id_permission` int NOT NULL AUTO_INCREMENT,
  `level` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `menu_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `can_access` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_permission`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 308 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (184, 'Pelanggan', 'dashboard', 1);
INSERT INTO `permissions` VALUES (185, 'Pelanggan', 'pemesanan', 1);
INSERT INTO `permissions` VALUES (186, 'Pelanggan', 'transaksi', 1);
INSERT INTO `permissions` VALUES (277, 'Karyawan', 'dashboard', 1);
INSERT INTO `permissions` VALUES (278, 'Karyawan', 'pemesanan', 1);
INSERT INTO `permissions` VALUES (279, 'Karyawan', 'transaksi', 1);
INSERT INTO `permissions` VALUES (280, 'Karyawan', 'pemesanan_karyawan', 1);
INSERT INTO `permissions` VALUES (281, 'Karyawan', 'transaksi_karyawan', 1);
INSERT INTO `permissions` VALUES (282, 'Karyawan', 'laporan', 1);
INSERT INTO `permissions` VALUES (283, 'Karyawan', 'jenis_paket', 1);
INSERT INTO `permissions` VALUES (284, 'Karyawan', 'jenis_pelayanan', 1);
INSERT INTO `permissions` VALUES (296, 'Admin', 'dashboard', 1);
INSERT INTO `permissions` VALUES (297, 'Admin', 'pemesanan_karyawan', 1);
INSERT INTO `permissions` VALUES (298, 'Admin', 'transaksi_karyawan', 1);
INSERT INTO `permissions` VALUES (299, 'Admin', 'laporan', 1);
INSERT INTO `permissions` VALUES (300, 'Admin', 'jenis_paket', 1);
INSERT INTO `permissions` VALUES (301, 'Admin', 'jenis_pelayanan', 1);
INSERT INTO `permissions` VALUES (302, 'Admin', 'karyawan', 1);
INSERT INTO `permissions` VALUES (303, 'Admin', 'setting', 1);
INSERT INTO `permissions` VALUES (304, 'Admin', 'log_activity', 1);
INSERT INTO `permissions` VALUES (305, 'Admin', 'restore_data', 1);
INSERT INTO `permissions` VALUES (306, 'Admin', 'level', 1);
INSERT INTO `permissions` VALUES (307, 'Admin', 'restore_edit', 1);

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting`  (
  `id_setting` int NOT NULL AUTO_INCREMENT,
  `nama_website` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `logo_website` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tab_icon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `login_icon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `create_by` int NULL DEFAULT NULL,
  `update_by` int NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id_setting`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of setting
-- ----------------------------
INSERT INTO `setting` VALUES (1, 'Family Laundry', '1723985899_55cdf2dcf4b0620cc596.png', '1723985888_04db1c045ed3005418ed.png', '1723985888_506f04d4c8c9cd58967e.png', NULL, 1, NULL, NULL, '2024-08-18 19:58:19', NULL);

-- ----------------------------
-- Table structure for transaksi
-- ----------------------------
DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE `transaksi`  (
  `id_transaksi` int NOT NULL AUTO_INCREMENT,
  `no_transaksi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_nota` datetime NULL DEFAULT NULL,
  `total_harga` int NULL DEFAULT NULL,
  `id_user` int NULL DEFAULT NULL,
  `kode_pemesanan` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bayar` int NULL DEFAULT NULL,
  `kembalian` int NULL DEFAULT NULL,
  `create_by` int NULL DEFAULT NULL,
  `update_by` int NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `pelanggan` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_transaksi`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of transaksi
-- ----------------------------
INSERT INTO `transaksi` VALUES (99, '0124081701', '2024-08-17 14:13:00', 20000, 1, 'PS00000003', 30000000, 29980000, 1, NULL, NULL, '2024-08-17 14:13:04', NULL, NULL, 38);
INSERT INTO `transaksi` VALUES (100, '0124081801', '2024-08-18 19:50:31', 12000, 3, 'PS00000007', 20000, 8000, 3, NULL, NULL, '2024-08-18 19:50:36', NULL, NULL, 38);
INSERT INTO `transaksi` VALUES (101, '0124090801', '2024-09-08 23:03:58', 111, 1, 'PS00000008', 222222, 222111, 1, NULL, NULL, '2024-09-08 23:04:03', NULL, NULL, 17);
INSERT INTO `transaksi` VALUES (102, 'PS00000003', '2024-09-09 09:20:09', 20000, NULL, 'Celana', 30000, 10000, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `transaksi` VALUES (103, 'PS00000003', '2024-09-09 09:29:50', 20000, NULL, 'Celana', 30000, 10000, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `level` enum('Admin','Pelanggan','Karyawan') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nohp` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_by` int NULL DEFAULT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id_user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'c4ca4238a0b923820dcc509a6f75849b', 'admin@gmail.com', 'Admin', '085157206615', 'Batam Centre', '1724067756_c485b53ee6f5a6874d23.png', 1, '2024-08-01 01:17:44');
INSERT INTO `user` VALUES (3, 'karyawan', 'c4ca4238a0b923820dcc509a6f75849b', 'karyawan@gmail.com', 'Karyawan', '0882768281', 'Bengkong', NULL, NULL, NULL);
INSERT INTO `user` VALUES (15, 'Sterling', 'c4ca4238a0b923820dcc509a6f75849b', 'sterling@gmail.com', 'Pelanggan', '08576288191', 'London', NULL, NULL, NULL);
INSERT INTO `user` VALUES (16, 'Ahmad', 'c4ca4238a0b923820dcc509a6f75849b', 'ahmad@gmail.com', 'Pelanggan', '0821997212', 'London', NULL, 16, '2024-08-05 21:29:05');
INSERT INTO `user` VALUES (17, 'Messi2', 'c4ca4238a0b923820dcc509a6f75849b', 'messi2@gmail.com', 'Pelanggan', '911', 'Amerika, Inter Miami Blok M', NULL, NULL, NULL);
INSERT INTO `user` VALUES (18, 'yoga gautama', 'c4ca4238a0b923820dcc509a6f75849b', 'yoga@gmail.com', 'Pelanggan', '08121121212', 'Golden land', NULL, NULL, NULL);
INSERT INTO `user` VALUES (19, 'Tinardo', 'c4ca4238a0b923820dcc509a6f75849b', 'tinardo@gmail.com', 'Karyawan', '0871628819191', 'bengkong', NULL, NULL, NULL);
INSERT INTO `user` VALUES (38, 'Pelanggan', 'c4ca4238a0b923820dcc509a6f75849b', 'pelanggan@gmail.com', 'Pelanggan', '081111111', '1', '1723985483_dc077fc8549c612714eb.jpg', NULL, NULL);
INSERT INTO `user` VALUES (39, 'Elvan Lie', 'c4ca4238a0b923820dcc509a6f75849b', 'elvanlie@gmail.com', 'Karyawan', '0895227473', 'Tiban Dalam', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user_activity
-- ----------------------------
DROP TABLE IF EXISTS `user_activity`;
CREATE TABLE `user_activity`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NULL DEFAULT NULL,
  `menu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 288 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_activity
-- ----------------------------
INSERT INTO `user_activity` VALUES (229, 1, 'Menghapus Activity', NULL, '2024-08-15 14:50:34', '2024-08-15 14:50:34');
INSERT INTO `user_activity` VALUES (230, 1, 'Masuk ke jenis_pelayanan', NULL, '2024-08-15 19:43:32', '2024-08-15 19:43:32');
INSERT INTO `user_activity` VALUES (231, 1, 'Masuk ke dashboard', NULL, '2024-08-15 19:43:46', '2024-08-15 19:43:46');
INSERT INTO `user_activity` VALUES (232, 1, 'Masuk ke Restore Edit', NULL, '2024-08-15 19:43:48', '2024-08-15 19:43:48');
INSERT INTO `user_activity` VALUES (233, 1, 'Masuk ke pemesanan level karyawan', NULL, '2024-08-15 19:43:50', '2024-08-15 19:43:50');
INSERT INTO `user_activity` VALUES (234, 1, 'Masuk ke laporan', NULL, '2024-08-15 19:43:51', '2024-08-15 19:43:51');
INSERT INTO `user_activity` VALUES (235, 38, 'Masuk ke dashboard', NULL, '2024-08-17 14:05:40', '2024-08-17 14:05:40');
INSERT INTO `user_activity` VALUES (236, 38, 'Masuk ke pemesanan', NULL, '2024-08-17 14:05:43', '2024-08-17 14:05:43');
INSERT INTO `user_activity` VALUES (237, 38, 'Masuk ke Level', NULL, '2024-08-17 14:05:48', '2024-08-17 14:05:48');
INSERT INTO `user_activity` VALUES (238, 38, 'Masuk ke transaksi', NULL, '2024-08-17 14:12:18', '2024-08-17 14:12:18');
INSERT INTO `user_activity` VALUES (239, 1, 'Masuk ke Restore', NULL, '2024-08-17 14:12:33', '2024-08-17 14:12:33');
INSERT INTO `user_activity` VALUES (240, 1, 'Masuk ke t_pemesanan', NULL, '2024-08-17 14:12:35', '2024-08-17 14:12:35');
INSERT INTO `user_activity` VALUES (241, 1, 'Menambah Pemesanan', NULL, '2024-08-17 14:12:46', '2024-08-17 14:12:46');
INSERT INTO `user_activity` VALUES (242, 1, 'Menyimpan Data Transaksi', NULL, '2024-08-17 14:13:04', '2024-08-17 14:13:04');
INSERT INTO `user_activity` VALUES (243, 38, 'Print Ulang Nota', NULL, '2024-08-17 14:14:17', '2024-08-17 14:14:17');
INSERT INTO `user_activity` VALUES (244, 1, 'Masuk ke transaksi level karyawan', NULL, '2024-08-17 14:14:53', '2024-08-17 14:14:53');
INSERT INTO `user_activity` VALUES (245, 3, 'Masuk ke dashboard', NULL, '2024-08-17 14:15:05', '2024-08-17 14:15:05');
INSERT INTO `user_activity` VALUES (246, 3, 'Masuk ke pemesanan', NULL, '2024-08-17 14:15:07', '2024-08-17 14:15:07');
INSERT INTO `user_activity` VALUES (247, 3, 'Masuk ke t_pemesanan', NULL, '2024-08-17 14:15:08', '2024-08-17 14:15:08');
INSERT INTO `user_activity` VALUES (248, 3, 'Masuk ke pemesanan level karyawan', NULL, '2024-08-17 14:25:11', '2024-08-17 14:25:11');
INSERT INTO `user_activity` VALUES (249, 3, 'Menambah Pemesanan', NULL, '2024-08-17 14:25:34', '2024-08-17 14:25:34');
INSERT INTO `user_activity` VALUES (250, 3, 'Masuk ke e_pemesanan', NULL, '2024-08-17 14:26:21', '2024-08-17 14:26:21');
INSERT INTO `user_activity` VALUES (251, 3, 'Print Nota', NULL, '2024-08-17 14:30:43', '2024-08-17 14:30:43');
INSERT INTO `user_activity` VALUES (252, 3, 'Masuk ke jenis_paket', NULL, '2024-08-17 14:33:01', '2024-08-17 14:33:01');
INSERT INTO `user_activity` VALUES (253, 3, 'Masuk ke laporan', NULL, '2024-08-17 14:33:02', '2024-08-17 14:33:02');
INSERT INTO `user_activity` VALUES (254, 3, 'Masuk ke transaksi', NULL, '2024-08-17 14:33:04', '2024-08-17 14:33:04');
INSERT INTO `user_activity` VALUES (255, 3, 'Membuat Laporan Excel', NULL, '2024-08-17 14:33:22', '2024-08-17 14:33:22');
INSERT INTO `user_activity` VALUES (256, 3, 'Membuat Laporan Windows Print', NULL, '2024-08-17 14:33:31', '2024-08-17 14:33:31');
INSERT INTO `user_activity` VALUES (257, 3, 'Membuat Laporan PDF', NULL, '2024-08-17 14:33:34', '2024-08-17 14:33:34');
INSERT INTO `user_activity` VALUES (258, 3, 'Masuk ke jenis_pelayanan', NULL, '2024-08-17 15:12:09', '2024-08-17 15:12:09');
INSERT INTO `user_activity` VALUES (259, 1, 'Masuk ke setting', NULL, '2024-08-17 15:15:50', '2024-08-17 15:15:50');
INSERT INTO `user_activity` VALUES (260, 1, 'Masuk ke Level', NULL, '2024-08-17 15:15:52', '2024-08-17 15:15:52');
INSERT INTO `user_activity` VALUES (261, 1, 'Melakukan Setting', NULL, '2024-08-17 15:16:14', '2024-08-17 15:16:14');
INSERT INTO `user_activity` VALUES (262, 1, 'Masuk ke jenis_paket', NULL, '2024-08-17 15:47:31', '2024-08-17 15:47:31');
INSERT INTO `user_activity` VALUES (263, 1, 'Masuk ke karyawan', NULL, '2024-08-17 16:29:58', '2024-08-17 16:29:58');
INSERT INTO `user_activity` VALUES (264, 1, 'Masuk ke detail karyawan', NULL, '2024-08-17 16:30:09', '2024-08-17 16:30:09');
INSERT INTO `user_activity` VALUES (265, 1, 'Masuk ke t_karyawan', NULL, '2024-08-17 16:31:01', '2024-08-17 16:31:01');
INSERT INTO `user_activity` VALUES (266, 1, 'Masuk ke Hak Akses', NULL, '2024-08-17 16:32:52', '2024-08-17 16:32:52');
INSERT INTO `user_activity` VALUES (267, 1, 'Menghapus Pemesanan', NULL, '2024-08-17 17:58:45', '2024-08-17 17:58:45');
INSERT INTO `user_activity` VALUES (268, 1, 'Masuk ke e_pemesanan', NULL, '2024-08-17 18:01:12', '2024-08-17 18:01:12');
INSERT INTO `user_activity` VALUES (269, 1, 'Mengedit Pemesanan', NULL, '2024-08-17 18:01:25', '2024-08-17 18:01:25');
INSERT INTO `user_activity` VALUES (270, 1, 'Masuk ke profile', NULL, '2024-08-17 20:09:32', '2024-08-17 20:09:32');
INSERT INTO `user_activity` VALUES (271, 3, 'Menyimpan Data Transaksi', NULL, '2024-08-18 19:50:36', '2024-08-18 19:50:36');
INSERT INTO `user_activity` VALUES (272, 38, 'Masuk ke profile', NULL, '2024-08-18 19:51:08', '2024-08-18 19:51:08');
INSERT INTO `user_activity` VALUES (273, 38, 'Mengedit Foto', NULL, '2024-08-18 19:51:23', '2024-08-18 19:51:23');
INSERT INTO `user_activity` VALUES (274, 38, 'Mengedit Profile', NULL, '2024-08-18 19:51:41', '2024-08-18 19:51:41');
INSERT INTO `user_activity` VALUES (275, 38, 'Mengubah Password', NULL, '2024-08-18 19:51:44', '2024-08-18 19:51:44');
INSERT INTO `user_activity` VALUES (276, 3, 'Menambah Paket', NULL, '2024-08-18 19:53:23', '2024-08-18 19:53:23');
INSERT INTO `user_activity` VALUES (277, 3, 'Mengedit Paket', NULL, '2024-08-18 19:53:34', '2024-08-18 19:53:34');
INSERT INTO `user_activity` VALUES (278, 3, 'Menambah Pelayanan', NULL, '2024-08-18 19:54:08', '2024-08-18 19:54:08');
INSERT INTO `user_activity` VALUES (279, 3, 'Mengedit Pelayanan', NULL, '2024-08-18 19:54:20', '2024-08-18 19:54:20');
INSERT INTO `user_activity` VALUES (280, 1, 'Merestore Data', NULL, '2024-08-18 19:54:57', '2024-08-18 19:54:57');
INSERT INTO `user_activity` VALUES (281, 1, 'Restore Data Pemesanan', NULL, '2024-08-18 19:55:33', '2024-08-18 19:55:33');
INSERT INTO `user_activity` VALUES (282, 1, 'Menambah Karyawan', NULL, '2024-08-18 19:56:41', '2024-08-18 19:56:41');
INSERT INTO `user_activity` VALUES (283, 1, 'Mengedit Karyawan', NULL, '2024-08-18 19:57:07', '2024-08-18 19:57:07');
INSERT INTO `user_activity` VALUES (284, 1, 'Mengedit Foto', NULL, '2024-08-19 18:42:24', '2024-08-19 18:42:24');
INSERT INTO `user_activity` VALUES (285, 1, 'Mengubah Password', NULL, '2024-08-19 18:52:03', '2024-08-19 18:52:03');
INSERT INTO `user_activity` VALUES (286, 1, 'Mengedit Paket', NULL, '2024-08-19 18:57:53', '2024-08-19 18:57:53');
INSERT INTO `user_activity` VALUES (287, 1, 'Membuat Laporan Windows Print', NULL, '2024-09-07 18:57:12', '2024-09-07 18:57:12');

-- ----------------------------
-- Triggers structure for table transaksi
-- ----------------------------
DROP TRIGGER IF EXISTS `tes`;
delimiter ;;
CREATE TRIGGER `tes` AFTER INSERT ON `transaksi` FOR EACH ROW UPDATE pemesanan
    SET status = 'Selesai'
    WHERE kode_pemesanan = NEW.kode_pemesanan
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
