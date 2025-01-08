-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 08, 2025 at 09:18 AM
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
-- Database: `victoria_university_hospital_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `epidemiological_data`
--

CREATE TABLE `epidemiological_data` (
  `Case_ID` int(11) NOT NULL,
  `Location_ID` int(11) DEFAULT NULL,
  `Cases_Per_Thousand_People` int(11) DEFAULT NULL,
  `Record_Date` date DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `health_facility`
--

CREATE TABLE `health_facility` (
  `Facility_ID` int(11) NOT NULL,
  `Facility_Name` varchar(100) DEFAULT NULL,
  `Location_ID` int(11) DEFAULT NULL,
  `Contact_Number` varchar(20) DEFAULT NULL,
  `Facility_Head` varchar(200) DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laboratory_tests_vw`
--

CREATE TABLE `laboratory_tests_vw` (
  `Test_ID` int(11) NOT NULL,
  `Visit_ID` int(11) DEFAULT NULL,
  `Test_Name` varchar(100) DEFAULT NULL,
  `Test_Result` text DEFAULT NULL,
  `Test_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patient_data`
--

CREATE TABLE `patient_data` (
  `Patient_ID` int(11) NOT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `Date_Of_Birth` date DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Contact_Number` varchar(20) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

CREATE TABLE `resource` (
  `Resource_ID` int(11) NOT NULL,
  `Resource_Name` varchar(100) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supply_chain`
--

CREATE TABLE `supply_chain` (
  `Supply_ID` int(11) NOT NULL,
  `Facility_ID` int(11) DEFAULT NULL,
  `Item_Name` varchar(100) DEFAULT NULL,
  `Quantity_Shipped` int(11) DEFAULT NULL,
  `Shipped_By` varchar(100) DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_log`
--

CREATE TABLE `system_log` (
  `Log_ID` int(11) NOT NULL,
  `Activity_Date` date DEFAULT NULL,
  `Activity_Description` text DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `treatment`
--

CREATE TABLE `treatment` (
  `Treatment_ID` int(11) NOT NULL,
  `Visit_ID` int(11) DEFAULT NULL,
  `Treatment_Name` varchar(100) DEFAULT NULL,
  `Treatment_Description` text DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `Role_ID` int(11) NOT NULL,
  `Role_Name` varchar(50) DEFAULT NULL,
  `Permissions` text DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visit_record`
--

CREATE TABLE `visit_record` (
  `Visit_ID` int(11) NOT NULL,
  `Patient_ID` int(11) DEFAULT NULL,
  `Visit_Date` date DEFAULT NULL,
  `Diagnosis` text DEFAULT NULL,
  `Treatment_Notes` text DEFAULT NULL,
  `Update_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `epidemiological_data`
--
ALTER TABLE `epidemiological_data`
  ADD PRIMARY KEY (`Case_ID`);

--
-- Indexes for table `health_facility`
--
ALTER TABLE `health_facility`
  ADD PRIMARY KEY (`Facility_ID`);

--
-- Indexes for table `laboratory_tests_vw`
--
ALTER TABLE `laboratory_tests_vw`
  ADD PRIMARY KEY (`Test_ID`),
  ADD KEY `Visit_ID` (`Visit_ID`);

--
-- Indexes for table `patient_data`
--
ALTER TABLE `patient_data`
  ADD PRIMARY KEY (`Patient_ID`);

--
-- Indexes for table `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`Resource_ID`);

--
-- Indexes for table `supply_chain`
--
ALTER TABLE `supply_chain`
  ADD PRIMARY KEY (`Supply_ID`),
  ADD KEY `Facility_ID` (`Facility_ID`);

--
-- Indexes for table `system_log`
--
ALTER TABLE `system_log`
  ADD PRIMARY KEY (`Log_ID`);

--
-- Indexes for table `treatment`
--
ALTER TABLE `treatment`
  ADD PRIMARY KEY (`Treatment_ID`),
  ADD KEY `Visit_ID` (`Visit_ID`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`Role_ID`);

--
-- Indexes for table `visit_record`
--
ALTER TABLE `visit_record`
  ADD PRIMARY KEY (`Visit_ID`),
  ADD KEY `Patient_ID` (`Patient_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `laboratory_tests_vw`
--
ALTER TABLE `laboratory_tests_vw`
  ADD CONSTRAINT `laboratory_tests_vw_ibfk_1` FOREIGN KEY (`Visit_ID`) REFERENCES `visit_record` (`Visit_ID`);

--
-- Constraints for table `supply_chain`
--
ALTER TABLE `supply_chain`
  ADD CONSTRAINT `supply_chain_ibfk_1` FOREIGN KEY (`Facility_ID`) REFERENCES `health_facility` (`Facility_ID`);

--
-- Constraints for table `treatment`
--
ALTER TABLE `treatment`
  ADD CONSTRAINT `treatment_ibfk_1` FOREIGN KEY (`Visit_ID`) REFERENCES `visit_record` (`Visit_ID`);

--
-- Constraints for table `visit_record`
--
ALTER TABLE `visit_record`
  ADD CONSTRAINT `visit_record_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient_data` (`Patient_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
