-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 23, 2020 at 11:05 PM
-- Server version: 5.7.29-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `myflaskapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `itemid` varchar(11) NOT NULL,
  `itemname` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rents`
--

CREATE TABLE `rents` (
  `id` int(11) NOT NULL,
  `title` varchar(225) DEFAULT NULL,
  `seller` varchar(225) DEFAULT NULL,
  `body` text,
  `img` varchar(255) NOT NULL DEFAULT 'img',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rents`
--

INSERT INTO `rents` (`id`, `title`, `seller`, `body`, `img`, `create_date`) VALUES
(14, 'test', 'test', '<p><span style=\"font-size:20px\"><strong>123</strong></span></p>\r\n\r\n<p>&nbsp;</p>\r\n', 'RqQcI8sNPkbAOw.jpeg', '2020-04-20 09:49:10'),
(21, 'Canon 800D', 'test', '<p>Canon 800D</p>\r\n\r\n<p>Detail: 90%new</p>\r\n\r\n<p>Rent : $200/day</p>\r\n\r\n<p>Contacat : tommy +852 98765432 / tommy123@gmail.com</p>\r\n', 'ZEJZR-456oFaCA.jpeg', '2020-04-20 14:58:28'),
(23, 'test', 'test', '<p>test</p>\r\n', 'W0P0ljy9oVRNmA', '2020-04-22 06:55:36'),
(24, 'Nissan Tiida 1.5 Auto', 'test', '<p><span style=\"font-size:18px\">1500cc&nbsp;</span></p>\r\n\r\n<p><span style=\"font-size:18px\">$300</span></p>\r\n', 'Q82vFcsUWw4Ruw.jpeg', '2020-04-22 06:58:15'),
(25, 'GOPRO Hero 6 Black Edition', 'tommyyan', '<h1>GOPRO Hero 6 Black Edition</h1>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><span style=\"font-size:20px\">$70/day</span></p>\r\n\r\n<p><span style=\"font-size:20px\">$350/week</span></p>\r\n', '1Bo474OmO0LThQ.jpg', '2020-04-22 11:08:54'),
(26, 'IPAD MINI 5', 'admin', '<h1>Rent! I PAD MINI 5</h1>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><span style=\"font-size:22px\">$300/month</span></p>\r\n', 'XNFsW0O9BCefkA.jpg', '2020-04-22 11:13:55'),
(27, 'Samsung Tv', 'test', '<p>tv</p>\r\n', 'kV0XYPNYoF45iQ.jpeg', '2020-04-22 11:16:38'),
(28, 'iPhone XR 128 gb', 'test', '<p>rent</p>\r\n', 'RZfiL3c_zTXyIg.jpg', '2020-04-22 11:17:51'),
(29, 'DJI phantom drone', 'test', '<p>dji</p>\r\n', 'Kua-5vg8hsCeIg.jpg', '2020-04-22 11:31:36'),
(31, 'test', 'test', '<p>test</p>\r\n', 'DgVy4Vzi09-m5g.jpeg', '2020-04-23 09:15:53');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`, `register_date`) VALUES
(1, 'tommy yan', 'jackychan87898@gmail.com', 'jacky chen', '$5$rounds=535000$EotGeiz9Oqddopy/$3Y3hPNNVTtb95hO042k8h8S8FYOtp6wL0GbKOv7WX3.', '2020-04-18 16:19:37'),
(2, 'kelcin', 'jackychan87898@gmail.com', 'tommyan', '$5$rounds=535000$3aP7CCYk8XTfWiXR$3Fs.2kflXRJ1NsWTffk25WvG2EZPV1bRZCaAAU.SCY9', '2020-04-18 16:53:54'),
(3, 'tommy yan', 'jackychan87898@gmail.com', 'tommyan', '$5$rounds=535000$d7LItnH3pCy7lFiB$OWisFb/xbL/GVa4eFLuHRoak4CUXlhq8ldVkwfibi6D', '2020-04-19 06:21:30'),
(4, 'test', 'test@gmail.com', 'test', '$5$rounds=535000$FYMckX4Hw01v/lVp$CwWVWDsKZpsJvpLsd4V4ER1/eeJC3KpYU/fdeW7Nps5', '2020-04-19 08:40:45'),
(5, 'admin', 'admin@gmail.com', 'admin', '$5$rounds=535000$ASjJFmO1E1dbMqTp$UGDyXRNlc4u6kifX/1dEFZNjGwblErMT4mkIekllfB7', '2020-04-19 10:49:50'),
(6, 'jacky', 'jacky@gmail.com', 'jacky', '$5$rounds=535000$0gh9Quw4bHm2LAuX$SSaNoGswLQHAHOyUJk2/g.z6dXOYJHT8ZZ1DiK.AQ11', '2020-04-20 11:08:29'),
(7, 'test', 'test@gmail.com', 'test', '$5$rounds=535000$R6hSUbsiTyklf9Am$YVoMZuYl2/TpGZ296xx/fWdhxXtdxAPbtikPOA07aG1', '2020-04-20 14:50:06'),
(8, 'tommy yan', 'asd@gmail.com', 'tommyyan', '$5$rounds=535000$LP1VI570iBn0omzQ$cdFAC0h9LPkyLCRn.vbCS/W1JUiLQQfTM6.JhlgBmg/', '2020-04-22 06:42:32'),
(9, '123', '123@gmail.com', '1234', '$5$rounds=535000$Ojbk0N5Wsy9mfYNP$FoSjBqExqBygN.QsMV475KeHpKr3C/Nt0hieFdj5JM2', '2020-04-23 08:51:31'),
(10, 'reflectivereport', 'rep@gmail.com', 'reflective', '$5$rounds=535000$1zmtrYg0r7Y9Rcd.$LT/nhpr.qI6c02Q6e6GrY3SFdBT/2gebr3yR8n5xiD0', '2020-04-23 10:53:22'),
(11, 'test', 'test@gmail.com', 'test', '$5$rounds=535000$4CV3.VhIExD7degu$mNGJYq5ro9J0ZuPJ3LYo.Cu7O2EGrJy/jy1CBzpS31.', '2020-04-23 13:43:01'),
(12, 'test', 'test@gmail.com', 'test', '$5$rounds=535000$bD7a8N1HfkpIGbmc$Xz1LfwV8nK9BfObnqxRz8RbjRMpoYO5cbVt4eTHH8yA', '2020-04-23 13:45:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD UNIQUE KEY `itemid` (`itemid`);

--
-- Indexes for table `rents`
--
ALTER TABLE `rents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rents`
--
ALTER TABLE `rents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
