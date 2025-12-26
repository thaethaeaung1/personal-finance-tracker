-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: Finance
-- ------------------------------------------------------
-- Server version	8.0.41-google

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `Finance`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `Finance` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `Finance`;

--
-- Table structure for table `Bank_account`
--

DROP TABLE IF EXISTS `Bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bank_account` (
  `Account_id` int NOT NULL,
  `Account_name` varchar(20) DEFAULT NULL,
  `Credit_limit` int DEFAULT NULL,
  PRIMARY KEY (`Account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bank_account`
--

LOCK TABLES `Bank_account` WRITE;
/*!40000 ALTER TABLE `Bank_account` DISABLE KEYS */;
INSERT INTO `Bank_account` VALUES (1,'Checking',0),(2,'Credit Card',2000);
/*!40000 ALTER TABLE `Bank_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categories` (
  `Category_id` int NOT NULL,
  `Category_name` varchar(50) DEFAULT NULL,
  `Category_type` varchar(10) DEFAULT NULL,
  `Budget_per_month` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`Category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categories`
--

LOCK TABLES `Categories` WRITE;
/*!40000 ALTER TABLE `Categories` DISABLE KEYS */;
INSERT INTO `Categories` VALUES (1,'Salary','Income',0.00),(2,'Groceries','Expense',100.00),(3,'Credit Card Refill','Expense',0.00),(4,'Take Out','Expense',50.00),(5,'Entertainment','Expense',30.00),(6,'School Supplies','Expense',20.00);
/*!40000 ALTER TABLE `Categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction` (
  `Transaction_id` int NOT NULL AUTO_INCREMENT,
  `Transaction_date` date NOT NULL DEFAULT (curtime()),
  `Amount` decimal(7,2) NOT NULL,
  `Category_id` int NOT NULL,
  `Account_id` int NOT NULL,
  PRIMARY KEY (`Transaction_id`),
  KEY `Category_id` (`Category_id`),
  KEY `Account_id` (`Account_id`),
  CONSTRAINT `Transaction_ibfk_1` FOREIGN KEY (`Category_id`) REFERENCES `Categories` (`Category_id`),
  CONSTRAINT `Transaction_ibfk_2` FOREIGN KEY (`Account_id`) REFERENCES `Bank_account` (`Account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
INSERT INTO `Transaction` VALUES (1,'2025-10-26',2000.00,1,1),(2,'2025-10-26',-100.00,2,2),(3,'2025-10-17',-400.00,3,1),(4,'2025-11-01',-17.80,4,2),(5,'2026-11-01',-20.24,4,2),(6,'2026-11-02',-26.70,4,2),(7,'2026-10-31',-1360.00,4,2),(8,'2025-11-16',-15.00,2,2),(9,'2025-11-16',-15.00,2,2),(10,'2025-11-16',-1.00,4,2),(11,'2025-11-16',-1.00,4,2),(12,'2025-11-16',0.00,4,2),(13,'2025-11-16',0.00,4,2),(14,'2025-11-16',-1.00,4,2),(15,'2025-11-16',-17.00,5,2),(16,'2025-11-16',-4.00,2,2),(17,'2025-11-16',-11.00,2,2),(18,'2025-12-08',-50.00,4,2),(19,'2025-12-01',200.00,1,1),(20,'2025-12-02',-10.00,2,2),(21,'2025-12-01',-10.00,2,2),(22,'2025-12-02',-200.00,3,1),(23,'2025-12-02',-20.00,4,2),(24,'2025-12-02',-16.00,5,2),(25,'2025-12-03',-5.00,6,2);
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-08 17:57:40
