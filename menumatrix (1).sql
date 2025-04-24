-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 24, 2025 at 04:02 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `menumatrix`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `punch_in_time` varchar(20) NOT NULL,
  `punch_out_time` varchar(20) NOT NULL,
  `shift_date` varchar(20) NOT NULL,
  `hours_worked` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`attendance_id`, `employee_id`, `punch_in_time`, `punch_out_time`, `shift_date`, `hours_worked`) VALUES
(3, 7, '04/22/2025 10:51 PM', '04/22/2025 10:51 PM', '04/22/2025', 1),
(14, 7, '1:36 AM', '1:36 AM', '04/24/2025', 1),
(15, 8, '1:37 AM', '1:37 AM', '04/24/2025', 2),
(16, 9, '8:00 AM', '8:00 PM', '04/24/2025', 12);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `loyalty_points` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `name`, `phone`, `email`, `password`, `loyalty_points`) VALUES
(1, 'Rivy Wisteria', '00994573412', 'rivy.wis@gmail.com', 'rivywis123', 0),
(2, 'Aya Ayuzawa', '0048125784', 'ayuzawa.aya@gmail.com', 'ayaayuzawa', 0);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  `shift_time_in` time NOT NULL,
  `shift_time_out` time NOT NULL,
  `salary` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `name`, `password`, `role`, `shift_time_in`, `shift_time_out`, `salary`) VALUES
(2, 'Alyn Julen', 'alynjulen', 'manager', '09:00:00', '17:00:00', 35000),
(5, 'Rhaine Delos', 'rhaine123', 'crewMember', '10:46:00', '19:46:00', 18000),
(6, 'Mateo Abe', 'mateo', 'delivery', '10:00:00', '19:00:00', 15000),
(7, 'Muriel Pacio', '123', 'chef', '22:11:00', '12:09:00', 30000),
(8, 'Konan Kudo', 'kudo', 'supervisor', '05:00:00', '18:00:00', 25000),
(9, 'Shalasaska Shinkawa', '123', 'crewMember', '08:00:00', '20:00:00', 18000);

-- --------------------------------------------------------

--
-- Table structure for table `ingredientusage`
--

CREATE TABLE `ingredientusage` (
  `menu_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `item_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `tags` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `exp_date` date NOT NULL,
  `acquisition date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`item_id`, `name`, `tags`, `status`, `exp_date`, `acquisition date`) VALUES
(2, 'Shirt', 'dair', 'available', '2025-04-29', '2025-04-14');

-- --------------------------------------------------------

--
-- Table structure for table `menuitem`
--

CREATE TABLE `menuitem` (
  `menu_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(100) NOT NULL,
  `availability` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menuitem`
--

INSERT INTO `menuitem` (`menu_id`, `name`, `description`, `price`, `category`, `availability`) VALUES
(1, 'banana', 'tdsg', '12.00', 'fruit', 1),
(2, 'banana', '123', '12.00', 'fruit', 0),
(3, 'd', 'd', '1.00', 'd', 1),
(4, 'Spaghetti', 'Spag', '12.00', 'Pasta', 0);

-- --------------------------------------------------------

--
-- Table structure for table `menuitemorder`
--

CREATE TABLE `menuitemorder` (
  `menu_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `orderDate` date NOT NULL,
  `totalAmount` double NOT NULL,
  `status` varchar(50) NOT NULL,
  `payment_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(10) NOT NULL,
  `totalAmount` double NOT NULL,
  `amountPaid` double NOT NULL,
  `customer_id` int(10) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tablemanagement`
--

CREATE TABLE `tablemanagement` (
  `table_id` int(11) NOT NULL,
  `table number` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `status` varchar(20) NOT NULL,
  `customer_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `table_id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'available',
  `customer_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tables`
--

INSERT INTO `tables` (`table_id`, `table_number`, `date_time`, `status`, `customer_id`) VALUES
(7, 1, '2025-04-21 08:40:00', 'occupied', 2);

-- --------------------------------------------------------

--
-- Table structure for table `totalexpenses`
--

CREATE TABLE `totalexpenses` (
  `expense_ID` int(11) NOT NULL,
  `expense_type` varchar(100) NOT NULL,
  `amount` double NOT NULL,
  `date` varchar(20) NOT NULL,
  `category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `totalexpenses`
--

INSERT INTO `totalexpenses` (`expense_ID`, `expense_type`, `amount`, `date`, `category`) VALUES
(8, 'Burger Buns 1 pack', 200, '04/23/2025', 'Food'),
(9, 'Burger', 315.5, '04/23/2025', 'Food'),
(10, 'Burger', 315.5, '04/23/2025', 'Food'),
(14, 'Chicken 5kg', 900, '04/23/2025', 'Food'),
(15, 'Paper Bag 3 packs', 150, '04/23/2025', 'Supplies'),
(16, '1', 0.01, '04/24/2025', 'Food'),
(17, 'Salary', 1, '04/24/2025', 'Utilities');

-- --------------------------------------------------------

--
-- Table structure for table `totalexpensesemployee`
--

CREATE TABLE `totalexpensesemployee` (
  `employee_id` int(10) NOT NULL,
  `expense_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `fkAttendanceEmployeeID` (`employee_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indexes for table `ingredientusage`
--
ALTER TABLE `ingredientusage`
  ADD PRIMARY KEY (`menu_id`,`item_id`),
  ADD KEY `FKinventory` (`item_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `menuitem`
--
ALTER TABLE `menuitem`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `menuitemorder`
--
ALTER TABLE `menuitemorder`
  ADD PRIMARY KEY (`menu_id`,`order_id`),
  ADD KEY `fkMenuItemOrderorder_id` (`order_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fkOrdersPaymentID` (`payment_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fkPaymentCustomerID` (`customer_id`),
  ADD KEY `fkPaymentOrderID` (`order_id`);

--
-- Indexes for table `tablemanagement`
--
ALTER TABLE `tablemanagement`
  ADD PRIMARY KEY (`table_id`),
  ADD KEY `fkTableCustomerID` (`customer_id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`table_id`),
  ADD KEY `fkTableCustomer_id` (`customer_id`);

--
-- Indexes for table `totalexpenses`
--
ALTER TABLE `totalexpenses`
  ADD PRIMARY KEY (`expense_ID`);

--
-- Indexes for table `totalexpensesemployee`
--
ALTER TABLE `totalexpensesemployee`
  ADD PRIMARY KEY (`employee_id`,`expense_id`),
  ADD KEY `fkTotalExpenseEmployeeExpenseID` (`expense_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menuitem`
--
ALTER TABLE `menuitem`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tablemanagement`
--
ALTER TABLE `tablemanagement`
  MODIFY `table_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `table_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `totalexpenses`
--
ALTER TABLE `totalexpenses`
  MODIFY `expense_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `fkAttendanceEmployeeID` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`);

--
-- Constraints for table `ingredientusage`
--
ALTER TABLE `ingredientusage`
  ADD CONSTRAINT `FKinventory` FOREIGN KEY (`item_id`) REFERENCES `inventory` (`item_id`),
  ADD CONSTRAINT `FKmenu` FOREIGN KEY (`menu_id`) REFERENCES `menuitem` (`menu_id`);

--
-- Constraints for table `menuitemorder`
--
ALTER TABLE `menuitemorder`
  ADD CONSTRAINT `fkMenuItemOrdermenu_id` FOREIGN KEY (`menu_id`) REFERENCES `menuitem` (`menu_id`),
  ADD CONSTRAINT `fkMenuItemOrderorder_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fkOrdersPaymentID` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fkPaymentCustomerID` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `fkPaymentOrderID` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `tablemanagement`
--
ALTER TABLE `tablemanagement`
  ADD CONSTRAINT `fkTableCustomerID` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `tables`
--
ALTER TABLE `tables`
  ADD CONSTRAINT `fkTableCustomer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `totalexpensesemployee`
--
ALTER TABLE `totalexpensesemployee`
  ADD CONSTRAINT `fkTotalExpenseEmployeeEmployeeID` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `fkTotalExpenseEmployeeExpenseID` FOREIGN KEY (`expense_id`) REFERENCES `totalexpenses` (`expense_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
