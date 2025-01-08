-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 07, 2025 at 09:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cranes_management_services_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `agents`
--

CREATE TABLE `agents` (
  `AgentID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `ContactNumber` varchar(15) DEFAULT NULL,
  `CommissionRate` decimal(5,2) NOT NULL CHECK (`CommissionRate` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `agents`
--

INSERT INTO `agents` (`AgentID`, `Name`, `ContactNumber`, `CommissionRate`) VALUES
(1, 'John Doe', '1234567890', 5.00),
(2, 'Jane Smith', '0987654321', 10.00);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `ClientID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `ContactNumber` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Preferences` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`ClientID`, `Name`, `ContactNumber`, `Email`, `Preferences`) VALUES
(1, 'Alice Brown', '1122334455', 'alice@example.com', 'Residential in Kampala'),
(2, 'Bob Green', '5566778899', 'bob@example.com', 'Commercial in Entebbe');

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `PropertyID` int(11) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `City` varchar(100) NOT NULL,
  `Type` varchar(50) NOT NULL CHECK (`Type` in ('Residential','Commercial','Industrial')),
  `Size` int(11) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Status` varchar(20) NOT NULL CHECK (`Status` in ('Available','Sold','Rented'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`PropertyID`, `Address`, `City`, `Type`, `Size`, `Price`, `Status`) VALUES
(1, '123 Main St', 'Kampala', 'Residential', 1200, 250000.00, 'Sold'),
(2, '456 Elm St', 'Kampala', 'Commercial', 5000, 800000.00, 'Sold'),
(3, '789 Pine Rd', 'Kampala', 'Industrial', 15000, 1200000.00, 'Available'),
(4, '101 Oak St', 'Kampala', 'Residential', 1400, 300000.00, 'Rented'),
(5, '202 Maple Ave', 'Entebbe', 'Commercial', 4000, 600000.00, 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `TransactionID` int(11) NOT NULL,
  `PropertyID` int(11) NOT NULL,
  `AgentID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `TransactionType` varchar(10) NOT NULL CHECK (`TransactionType` in ('Buy','Sell','Rent')),
  `Date` date NOT NULL,
  `Amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`TransactionID`, `PropertyID`, `AgentID`, `ClientID`, `TransactionType`, `Date`, `Amount`) VALUES
(1, 1, 1, 1, 'Buy', '2025-01-01', 250000.00),
(2, 2, 2, 2, 'Sell', '2025-01-02', 800000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agents`
--
ALTER TABLE `agents`
  ADD PRIMARY KEY (`AgentID`),
  ADD UNIQUE KEY `ContactNumber` (`ContactNumber`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`ClientID`),
  ADD UNIQUE KEY `ContactNumber` (`ContactNumber`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`PropertyID`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`TransactionID`),
  ADD KEY `FK_PropertyID` (`PropertyID`),
  ADD KEY `FK_AgentID` (`AgentID`),
  ADD KEY `FK_ClientID` (`ClientID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `FK_AgentID` FOREIGN KEY (`AgentID`) REFERENCES `agents` (`AgentID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_ClientID` FOREIGN KEY (`ClientID`) REFERENCES `clients` (`ClientID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_PropertyID` FOREIGN KEY (`PropertyID`) REFERENCES `properties` (`PropertyID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
