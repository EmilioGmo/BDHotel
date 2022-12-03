/*
 Navicat Premium Data Transfer

 Source Server         : Hotel
 Source Server Type    : MySQL
 Source Server Version : 100425 (10.4.25-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : hotel

 Target Server Type    : MySQL
 Target Server Version : 100425 (10.4.25-MariaDB)
 File Encoding         : 65001

 Date: 03/12/2022 14:14:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acompañantes
-- ----------------------------
DROP TABLE IF EXISTS `acompañantes`;
CREATE TABLE `acompañantes`  (
  `acompa_id` int NOT NULL AUTO_INCREMENT,
  `acompa_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `acompa_ape_pat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `acompa_ape_mat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `acompa_fecha_nac` date NOT NULL,
  `fkacompa_client` int NOT NULL,
  PRIMARY KEY (`acompa_id`) USING BTREE,
  INDEX `fkacompa_client`(`fkacompa_client` ASC) USING BTREE,
  CONSTRAINT `acompañantes_ibfk_1` FOREIGN KEY (`fkacompa_client`) REFERENCES `clientes` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acompañantes
-- ----------------------------

-- ----------------------------
-- Table structure for caja
-- ----------------------------
DROP TABLE IF EXISTS `caja`;
CREATE TABLE `caja`  (
  `caja_id` int NOT NULL AUTO_INCREMENT,
  `caja_fecha` datetime NOT NULL,
  `caja_subtotal` float NOT NULL,
  `caja_iva` float NOT NULL,
  `caja_descuento` float NULL DEFAULT NULL,
  `caja_total` float NOT NULL,
  PRIMARY KEY (`caja_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of caja
-- ----------------------------

-- ----------------------------
-- Table structure for cajadetalle
-- ----------------------------
DROP TABLE IF EXISTS `cajadetalle`;
CREATE TABLE `cajadetalle`  (
  `detalle_id` int NOT NULL AUTO_INCREMENT,
  `fkcaja_detalle` int NOT NULL,
  `fkprodu_detalle` int NOT NULL,
  `detalle_descuento` float NULL DEFAULT NULL,
  `detalle_subtotal` float NOT NULL,
  PRIMARY KEY (`detalle_id`) USING BTREE,
  INDEX `fkcaja_detalle`(`fkcaja_detalle` ASC) USING BTREE,
  INDEX `fkprodu_detalle`(`fkprodu_detalle` ASC) USING BTREE,
  CONSTRAINT `cajadetalle_ibfk_1` FOREIGN KEY (`fkcaja_detalle`) REFERENCES `caja` (`caja_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cajadetalle_ibfk_2` FOREIGN KEY (`fkprodu_detalle`) REFERENCES `productos` (`produc_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cajadetalle
-- ----------------------------

-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes`  (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `client_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `client_ape-pat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `client_ape_mat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `client_fecha_nac` date NOT NULL,
  `client_numero` int NOT NULL,
  `fk_client_user` int NOT NULL,
  PRIMARY KEY (`client_id`) USING BTREE,
  INDEX `fk_client_user`(`fk_client_user` ASC) USING BTREE,
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`fk_client_user`) REFERENCES `usuarios` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clientes
-- ----------------------------

-- ----------------------------
-- Table structure for empleados
-- ----------------------------
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados`  (
  `emple_id` int NOT NULL AUTO_INCREMENT,
  `emple_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `emple_ape_pat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `emple_ape_mat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `emple_fecha_nac` date NOT NULL,
  `emple_fecha_alta` date NOT NULL,
  `emple_fecha_baja` date NULL DEFAULT NULL,
  `fkemple_user` int NOT NULL,
  PRIMARY KEY (`emple_id`) USING BTREE,
  INDEX `fkemple_user`(`fkemple_user` ASC) USING BTREE,
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`fkemple_user`) REFERENCES `usuarios` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empleados
-- ----------------------------

-- ----------------------------
-- Table structure for habitaciones
-- ----------------------------
DROP TABLE IF EXISTS `habitaciones`;
CREATE TABLE `habitaciones`  (
  `habi_id` int NOT NULL AUTO_INCREMENT,
  `habi_clave` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'unique',
  `habi_activo` int NOT NULL COMMENT 'default1',
  `habi_ocupado` int NOT NULL COMMENT 'default0',
  `fkhabi_tipo` int NOT NULL,
  PRIMARY KEY (`habi_id`) USING BTREE,
  UNIQUE INDEX `habi_clave`(`habi_clave` ASC) USING BTREE,
  INDEX `fkhabi_tipo`(`fkhabi_tipo` ASC) USING BTREE,
  CONSTRAINT `habitaciones_ibfk_1` FOREIGN KEY (`fkhabi_tipo`) REFERENCES `tipohabitacion` (`tipohabi_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of habitaciones
-- ----------------------------

-- ----------------------------
-- Table structure for permisos
-- ----------------------------
DROP TABLE IF EXISTS `permisos`;
CREATE TABLE `permisos`  (
  `permi_id` int NOT NULL AUTO_INCREMENT,
  `permi_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`permi_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permisos
-- ----------------------------

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos`  (
  `produc_id` int NOT NULL AUTO_INCREMENT,
  `produc_nombre` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `produc_precio` float NOT NULL,
  PRIMARY KEY (`produc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productos
-- ----------------------------

-- ----------------------------
-- Table structure for reservaciones
-- ----------------------------
DROP TABLE IF EXISTS `reservaciones`;
CREATE TABLE `reservaciones`  (
  `reserva_id` int NOT NULL AUTO_INCREMENT,
  `fkreserva_client` int NOT NULL,
  `fkreserva_habi` int NOT NULL,
  `reserva_fecha_llegada` datetime NOT NULL,
  `reserva_fecha_salida` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`reserva_id`) USING BTREE,
  INDEX `fkreserva_client`(`fkreserva_client` ASC) USING BTREE,
  INDEX `fkreserva_habi`(`fkreserva_habi` ASC) USING BTREE,
  CONSTRAINT `reservaciones_ibfk_1` FOREIGN KEY (`fkreserva_client`) REFERENCES `clientes` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `reservaciones_ibfk_2` FOREIGN KEY (`fkreserva_habi`) REFERENCES `habitaciones` (`habi_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservaciones
-- ----------------------------

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol`  (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fkrol_permi` int NULL DEFAULT NULL,
  PRIMARY KEY (`rol_id`) USING BTREE,
  INDEX `fkrol_permi`(`fkrol_permi` ASC) USING BTREE,
  CONSTRAINT `rol_ibfk_1` FOREIGN KEY (`fkrol_permi`) REFERENCES `permisos` (`permi_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rol
-- ----------------------------

-- ----------------------------
-- Table structure for tarjetaempleados
-- ----------------------------
DROP TABLE IF EXISTS `tarjetaempleados`;
CREATE TABLE `tarjetaempleados`  (
  `tarjeemple_id` int NOT NULL AUTO_INCREMENT,
  `tarjeclient_numero` int NOT NULL COMMENT 'unique',
  `fktarjeemple_emple` int NOT NULL,
  PRIMARY KEY (`tarjeemple_id`) USING BTREE,
  UNIQUE INDEX `tarjeclient_numero`(`tarjeclient_numero` ASC) USING BTREE,
  INDEX `fktarjeemple_emple`(`fktarjeemple_emple` ASC) USING BTREE,
  CONSTRAINT `tarjetaempleados_ibfk_1` FOREIGN KEY (`fktarjeemple_emple`) REFERENCES `empleados` (`emple_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tarjetaempleados
-- ----------------------------

-- ----------------------------
-- Table structure for tarjetasclientes
-- ----------------------------
DROP TABLE IF EXISTS `tarjetasclientes`;
CREATE TABLE `tarjetasclientes`  (
  `tarjeclient_id` int NOT NULL AUTO_INCREMENT,
  `tarjeclient_numero` int NOT NULL COMMENT 'unique',
  `tarjeclient_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tarjeclient_ape_pat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tarjeclient_ape_mat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tarjeclient_fecha_nacimiento` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tarjeclient_cvv` int NOT NULL,
  `fktarjeclient_client` int NOT NULL,
  PRIMARY KEY (`tarjeclient_id`) USING BTREE,
  UNIQUE INDEX `tarjeclient_numero`(`tarjeclient_numero` ASC) USING BTREE,
  INDEX `fktarjeclient_client`(`fktarjeclient_client` ASC) USING BTREE,
  CONSTRAINT `tarjetasclientes_ibfk_1` FOREIGN KEY (`fktarjeclient_client`) REFERENCES `clientes` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tarjetasclientes
-- ----------------------------

-- ----------------------------
-- Table structure for tipohabitacion
-- ----------------------------
DROP TABLE IF EXISTS `tipohabitacion`;
CREATE TABLE `tipohabitacion`  (
  `tipohabi_id` int NOT NULL AUTO_INCREMENT,
  `tipohabi_tipo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`tipohabi_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipohabitacion
-- ----------------------------

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_correo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fk_user_rol` int NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `fk_user_rol`(`fk_user_rol` ASC) USING BTREE,
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`fk_user_rol`) REFERENCES `rol` (`rol_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuarios
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
