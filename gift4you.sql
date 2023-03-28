-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 28, 2023 at 02:29 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gift4you`
--
CREATE DATABASE IF NOT EXISTS `gift4you` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gift4you`;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(5) NOT NULL,
  `category_name` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `in_category`
--

CREATE TABLE `in_category` (
  `category_id` int(5) DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `market`
--

CREATE TABLE `market` (
  `market_id` int(10) NOT NULL,
  `market_picture` longtext DEFAULT NULL,
  `market_name` varchar(100) DEFAULT NULL,
  `market_tel` varchar(10) DEFAULT NULL,
  `market_address` varchar(150) DEFAULT NULL,
  `market_detail` varchar(300) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `market`
--

INSERT INTO `market` (`market_id`, `market_picture`, `market_name`, `market_tel`, `market_address`, `market_detail`, `username`) VALUES
(2, NULL, 'FlowerShop', '0833079911', 'UTCC', 'ขายดอกไม้มาซื้อดิสัส', 'TonMarket');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(10) NOT NULL,
  `picture` longtext DEFAULT NULL,
  `product_price` varchar(100) NOT NULL,
  `product_name` varchar(300) NOT NULL,
  `product_detail` varchar(300) DEFAULT NULL,
  `market_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(10) NOT NULL,
  `market_id` int(10) DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  `review_info` varchar(100) DEFAULT NULL,
  `review_reply` varchar(100) DEFAULT NULL,
  `star` int(1) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `fullname` varchar(150) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `role_id` varchar(1) DEFAULT NULL,
  `user_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `gender`, `fullname`, `email`, `tel`, `role_id`, `user_type`) VALUES
('generaladmin', '123456789', 'ชาย', 'all-admin', 'admin@gmail.com', '0000000000', '1', 'ADMIN'),
('TonHandSome', '123456789', 'ชาย', 'TonHandSomemak', 'ton@gmail.com', '0933333009', '2', 'USER'),
('TonMarket', '12345', 'ชาย', 'Ton Marketplace', 'TonMarket@gmail.con', '0833079911', '3', 'MARKET'),
('TonUser', '123456', 'ชาย', 'TonUser', 'TonUser@gmail.com', '0894996684', '2', 'USER');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `role_id` varchar(1) NOT NULL,
  `role_name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`role_id`, `role_name`) VALUES
('1', 'Admin'),
('2', 'General-User'),
('3', 'Market');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `in_category`
--
ALTER TABLE `in_category`
  ADD KEY `category-id` (`category_id`),
  ADD KEY `product-id` (`product_id`);

--
-- Indexes for table `market`
--
ALTER TABLE `market`
  ADD PRIMARY KEY (`market_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `MarketID` (`market_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `ProductID` (`product_id`),
  ADD KEY `MarketID` (`market_id`),
  ADD KEY `User` (`username`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`),
  ADD KEY `type-id` (`role_id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `market`
--
ALTER TABLE `market`
  MODIFY `market_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `in_category`
--
ALTER TABLE `in_category`
  ADD CONSTRAINT `in_category_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `in_category_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `market`
--
ALTER TABLE `market`
  ADD CONSTRAINT `market_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`market_id`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`market_id`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `review_ibfk_3` FOREIGN KEY (`username`) REFERENCES `user` (`username`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
