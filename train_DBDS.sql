CREATE DATABASE  IF NOT EXISTS `dbdsproject` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbdsproject`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: dbdsproject
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `Booking_ID` int NOT NULL AUTO_INCREMENT,
  `Customer_ID` int DEFAULT NULL,
  `Schedule_ID` int DEFAULT NULL,
  `booking_Date` date DEFAULT NULL,
  `Total_Fare` decimal(10,2) DEFAULT NULL,
  `travel_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`Booking_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Schedule_ID` (`Schedule_ID`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`Schedule_ID`) REFERENCES `schedule` (`Schedule_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,2,15,'2024-12-02',60.00,'2024-12-06 10:00:00'),(2,3,13,'2024-12-03',70.00,'2024-12-07 07:00:00'),(3,4,67,'2024-12-04',75.50,'2024-12-08 12:30:00'),(4,5,89,'2024-12-05',52.50,'2024-12-09 19:30:00'),(5,6,129,'2024-12-06',60.00,'2024-12-10 20:30:00'),(6,7,112,'2024-12-07',75.00,'2024-12-11 17:00:00'),(7,8,113,'2024-12-08',120.00,'2024-12-12 19:30:00'),(8,9,123,'2024-12-09',55.00,'2024-12-13 14:30:00'),(9,10,87,'2024-12-10',120.00,'2024-12-14 14:00:00'),(10,11,88,'2024-12-11',85.00,'2024-12-15 13:00:00'),(11,12,64,'2024-12-12',60.00,'2024-12-16 17:30:00'),(12,13,125,'2024-12-13',150.00,'2024-12-17 19:30:00'),(13,14,55,'2024-12-14',65.00,'2024-12-18 08:30:00'),(14,15,45,'2024-12-15',90.00,'2024-12-19 11:30:00'),(15,16,50,'2024-12-16',60.00,'2024-12-20 14:30:00'),(16,17,32,'2024-12-17',60.00,'2024-12-21 13:00:00'),(17,18,37,'2024-12-18',80.00,'2024-12-22 18:00:00'),(18,19,48,'2024-12-19',120.00,'2024-12-23 14:30:00'),(19,20,28,'2024-12-20',40.00,'2024-12-24 09:00:00'),(20,21,34,'2024-12-21',70.00,'2024-12-25 15:00:00'),(21,22,44,'2024-12-22',70.00,'2024-12-26 10:30:00'),(22,23,49,'2024-12-23',85.00,'2024-12-27 15:30:00'),(23,24,126,'2024-12-24',105.00,'2024-12-28 19:30:00'),(24,25,18,'2024-12-25',110.00,'2024-12-29 14:00:00'),(25,2,15,'2024-12-02',60.00,'2024-12-06 10:00:00'),(26,3,13,'2024-12-03',70.00,'2024-12-07 07:00:00'),(27,4,67,'2024-12-04',75.50,'2024-12-08 12:30:00'),(28,5,89,'2024-12-05',52.50,'2024-12-09 19:30:00'),(29,6,129,'2024-12-06',60.00,'2024-12-10 20:30:00'),(30,7,112,'2024-12-07',75.00,'2024-12-11 17:00:00'),(31,8,113,'2024-12-08',120.00,'2024-12-12 19:30:00'),(32,9,123,'2024-12-09',55.00,'2024-12-13 14:30:00'),(33,10,87,'2024-12-10',120.00,'2024-12-14 14:00:00'),(34,11,88,'2024-12-11',85.00,'2024-12-15 13:00:00'),(35,12,64,'2024-12-12',60.00,'2024-12-16 17:30:00'),(36,13,125,'2024-12-13',150.00,'2024-12-17 19:30:00'),(37,14,55,'2024-12-14',65.00,'2024-12-18 08:30:00'),(38,15,45,'2024-12-15',90.00,'2024-12-19 11:30:00'),(39,16,50,'2024-12-16',60.00,'2024-12-20 14:30:00'),(40,17,32,'2024-12-17',60.00,'2024-12-21 13:00:00'),(41,18,37,'2024-12-18',80.00,'2024-12-22 18:00:00'),(42,19,48,'2024-12-19',120.00,'2024-12-23 14:30:00'),(43,20,28,'2024-12-20',40.00,'2024-12-24 09:00:00'),(44,21,34,'2024-12-21',70.00,'2024-12-25 15:00:00'),(45,22,44,'2024-12-22',70.00,'2024-12-26 10:30:00'),(46,23,49,'2024-12-23',85.00,'2024-12-27 15:30:00'),(47,24,126,'2024-12-24',105.00,'2024-12-28 19:30:00'),(48,25,18,'2024-12-25',110.00,'2024-12-29 14:00:00');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_support`
--

DROP TABLE IF EXISTS `customer_support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_support` (
  `ticket_no` int NOT NULL AUTO_INCREMENT,
  `question` varchar(500) DEFAULT NULL,
  `answer` varchar(500) DEFAULT 'Please give the customer support team 3 to 5 days to answer the question',
  `customer_id` int DEFAULT NULL,
  `customer_rep_id` int DEFAULT NULL,
  PRIMARY KEY (`ticket_no`),
  KEY `customer_id` (`customer_id`),
  KEY `customer_rep_id` (`customer_rep_id`),
  CONSTRAINT `customer_support_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`Customer_ID`),
  CONSTRAINT `customer_support_ibfk_2` FOREIGN KEY (`customer_rep_id`) REFERENCES `employee` (`Employee_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_support`
--

LOCK TABLES `customer_support` WRITE;
/*!40000 ALTER TABLE `customer_support` DISABLE KEYS */;
INSERT INTO `customer_support` VALUES (1,'I missed my train and left my luggage at the station. What should I do?','Contact the station lost and found immediately. Provide your ticket details and a description of your luggage. Most stations have a lost and found office where you can retrieve your belongings within 24-48 hours.',44,3),(2,'How can I track down my lost luggage after missing my train?','First, file a lost property report with the train station. Contact the train company\'s customer service with your ticket number, travel date, and luggage description. Most railways have a centralized lost property system to help reunite passengers with their belongings.',42,4),(3,'I left my suitcase on the train I missed. Who can help me find it?','Immediately contact the train company\'s customer service. Provide them with your original ticket details, train number, and a detailed description of your luggage. They can check their lost property database and guide you on retrieval.',32,5),(4,'What compensation is available if I lose my luggage when missing a train?','Compensation varies by railway company. Typically, you can file a claim for lost luggage. Keep all your travel documents and file a report within 24 hours of the incident. Some insurance policies and train company policies provide partial reimbursement for lost items.',23,4),(5,'How long do train stations keep lost luggage?','Most train stations and railway companies keep lost luggage for 30 to 90 days. After this period, unclaimed items may be donated or disposed of. It\'s crucial to start your search as soon as possible and provide detailed information about your luggage.',32,3),(6,'I missed my train and my important documents were in my luggage. What steps should I take?','First, file a police report. Contact the train station\'s lost and found immediately. Inform your embassy or consulate if international travel documents are missing. Keep copies of all communications and reports for potential reimbursement or replacement.',29,4),(7,'Can I retrieve my luggage if I missed the train at a different station?','Yes, most railway networks have an interconnected lost property system. Contact the station where you believe you left your luggage and provide detailed information. They can coordinate with other stations to help you locate and retrieve your belongings.',22,3),(46,'test 1','testing 1',23,3),(47,'test 2','testing 2',23,3),(48,'test 3','testing 3',23,3);
/*!40000 ALTER TABLE `customer_support` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `Customer_ID` int NOT NULL AUTO_INCREMENT,
  `Last_Name` varchar(50) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `pass` varchar(50) NOT NULL,
  `DOB` date DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Customer_ID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'test','admin','admin@test','adminpassword','2019-06-15',0),(2,'Smith','John','john.smith','password123','1995-03-22',0),(3,'Doe','Jane','jane.doe','securepass','2005-11-07',0),(4,'Brown','Michael','mike.brown','pass4567','1978-02-12',0),(5,'Johnson','Emily','emily.johnson','mypassword','1965-08-19',1),(6,'Williams','Chris','chris.williams','123secure','2001-01-30',0),(7,'Jones','Sarah','sarah.jones','sarah2024','1983-05-04',0),(8,'Garcia','Carlos','carlos.garcia','garcia!123','2017-12-15',0),(9,'Martinez','Laura','laura.martinez','laura12345','1990-07-01',0),(10,'Davis','Daniel','daniel.davis','davispass','1988-09-22',0),(11,'Lopez','Ana','ana.lopez','ana!secure','1993-11-13',0),(12,'Taylor','James','james.taylor','taylorrocks','2010-03-18',0),(13,'Thomas','Sophia','sophia.thomas','sophia2023','1998-06-25',0),(14,'Anderson','Liam','liam.anderson','liam!pass','1975-10-10',0),(15,'Moore','Olivia','olivia.moore','olivia456','2008-05-05',0),(16,'Jackson','Noah','noah.jackson','noahpass2024','1969-03-01',0),(17,'White','Ava','ava.white','ava!secure','2015-09-03',0),(18,'Harris','Lucas','lucas.harris','lucaspassword','2003-12-12',0),(19,'Clark','Mia','mia.clark','miapass123','1985-04-09',0),(20,'Lewis','Ethan','ethan.lewis','ethan!secure','2013-02-21',0),(21,'Robinson','Isabella','isabella.robinson','isa2024','2007-11-29',0),(22,'Walker','Elijah','elijah.walker','walkersecure','1980-01-06',0),(23,'Hall','Emma','emma.hall','emma12345','1997-07-30',0),(24,'Allen','Mason','mason.allen','masonpassword','1999-09-14',0),(25,'Young','Sophia','sophia.young','sophia!safe','2018-05-22',0),(26,'King','Oliver','oliver.king','king123pass','1974-11-11',0),(27,'Scott','Benjamin','benjamin.scott','benjamin!pass','2009-10-17',0),(28,'Adams','Victoria','victoria.adams','victoria2024','1982-12-03',0),(29,'Mitchell','Zachary','zachary.mitchell','zachsecure','1992-08-21',0),(30,'Perez','Natalie','natalie.perez','natalie123','1986-10-05',0),(31,'Roberts','Jack','jack.roberts','jack@2024','2004-06-30',0),(32,'Turner','Grace','grace.turner','gracesecret','1991-05-13',0),(33,'Phillips','Henry','henry.phillips','henrysafe','2000-03-25',0),(34,'Campbell','Ella','ella.campbell','ellapass','1994-07-07',0),(35,'Parker','Sebastian','sebastian.parker','sebas!456','2006-02-17',0),(36,'Evans','Chloe','chloe.evans','chloe12345','1980-08-22',0),(37,'Edwards','Alexander','alexander.edwards','alexsafe!','2016-11-06',0),(38,'Collins','Lily','lily.collins','lily2024','2011-04-02',0),(39,'Stewart','Samuel','samuel.stewart','samuel@safe','1996-09-18',0),(40,'Sanchez','Amelia','amelia.sanchez','amelia123','1999-01-27',0),(41,'Morris','Aiden','aiden.morris','aidenpass','1989-06-10',0),(42,'Rogers','Mila','mila.rogers','milapassword','2002-03-11',0),(43,'Reed','Jacob','jacob.reed','jacobsecure','2014-01-24',0),(44,'Cook','Charlotte','charlotte.cook','charlotte!secure','1973-12-14',0),(45,'Morgan','William','william.morgan','william456','1987-02-16',0),(46,'Bell','Hannah','hannah.bell','hannah!pass','2012-08-26',0),(47,'Murphy','Matthew','matthew.murphy','matthew2024','1981-05-09',0),(48,'Bailey','Ella','ella.bailey','ellapass123','2004-09-28',0),(49,'Rivera','Daniel','daniel.rivera','daniel!safe','1995-07-11',0),(50,'Cooper','Avery','avery.cooper','avery2023','2006-01-15',0),(51,'Richardson','Logan','logan.richardson','loganpass2024','1984-09-04',0),(52,'aithal','vilas','vilas.aithal','password','1998-12-04',0);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `Employee_ID` int NOT NULL AUTO_INCREMENT,
  `SSN` char(9) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Pass` varchar(50) NOT NULL,
  `e_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`),
  UNIQUE KEY `SSN` (`SSN`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'123456789','Smith','Jaden','Jaden.smith','password123','admin'),(2,'101112131','Doe','Ryan','Ryan.doe','securepass','admin'),(3,'151617181','Brown','Mitchell','Mitchell.brown','pass4567','cust_rep'),(4,'202122232','Cranson','Emily','emily.cranson','mypassword','cust_rep'),(5,'252627282','Williams','Sam','Sam.williams','123secure','cust_rep');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `Schedule_ID` int NOT NULL AUTO_INCREMENT,
  `Train_ID` int DEFAULT NULL,
  `Transit_Line` varchar(100) DEFAULT NULL,
  `Origin` varchar(50) DEFAULT NULL,
  `Destination` varchar(50) DEFAULT NULL,
  `Departure_Time` time DEFAULT NULL,
  `Arrival_Time` time DEFAULT NULL,
  `Fare` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Schedule_ID`),
  KEY `Train_ID` (`Train_ID`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`Train_ID`) REFERENCES `train` (`Train_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (1,1001,'Northern Express','New York','Washington','08:00:00','11:00:00',120.00),(2,1002,'Midwest Flyer','Chicago','Detroit','09:00:00','11:30:00',75.50),(3,1003,'Pacific Rail','Los Angeles','San Diego','10:00:00','12:00:00',50.00),(4,1004,'Southern Breeze','San Francisco','Sacramento','13:00:00','15:00:00',65.00),(5,1005,'Northern Express','New York','Boston','14:00:00','18:00:00',130.00),(6,1006,'Midwest Flyer','Dallas','Houston','06:00:00','09:00:00',80.00),(7,1007,'Pacific Rail','Seattle','Portland','07:30:00','10:30:00',90.00),(8,1008,'Southern Breeze','Atlanta','Orlando','10:00:00','14:00:00',100.00),(9,1009,'Northern Express','Phoenix','Las Vegas','08:30:00','12:30:00',110.00),(10,1010,'Midwest Flyer','Denver','Salt Lake City','09:30:00','13:30:00',95.00),(11,1011,'Pacific Rail','Boston','Philadelphia','15:00:00','18:00:00',85.00),(12,1012,'Southern Breeze','Miami','Tampa','16:00:00','20:00:00',75.00),(13,1013,'Northern Express','Chicago','St. Louis','07:00:00','11:00:00',70.00),(14,1014,'Midwest Flyer','Las Vegas','Reno','08:30:00','12:30:00',100.00),(15,1015,'Pacific Rail','New Orleans','Baton Rouge','10:00:00','12:00:00',60.00),(16,1016,'Southern Breeze','Austin','San Antonio','12:00:00','14:30:00',50.00),(17,1017,'Northern Express','Los Angeles','San Francisco','13:00:00','18:00:00',150.00),(18,1018,'Midwest Flyer','Philadelphia','New York','14:00:00','17:00:00',110.00),(19,1019,'Pacific Rail','Dallas','Fort Worth','06:30:00','08:00:00',40.00),(20,1020,'Southern Breeze','Houston','Austin','09:00:00','11:30:00',60.00),(21,1021,'Northern Express','Denver','Boulder','11:00:00','12:00:00',30.00),(22,1022,'Midwest Flyer','Seattle','Spokane','07:00:00','13:00:00',120.00),(23,1023,'Pacific Rail','Orlando','Jacksonville','08:00:00','12:00:00',85.00),(24,1024,'Southern Breeze','Atlanta','Charlotte','14:30:00','18:30:00',105.00),(25,1025,'Northern Express','Phoenix','Tucson','09:30:00','11:30:00',50.00),(26,1026,'Northern Express','Buffalo','Cleveland','07:00:00','10:00:00',85.00),(27,1027,'Midwest Flyer','Indianapolis','Columbus','08:30:00','11:00:00',70.00),(28,1028,'Pacific Rail','San Jose','San Francisco','09:00:00','10:00:00',40.00),(29,1029,'Southern Breeze','Jackson','Memphis','10:00:00','13:00:00',90.00),(30,1030,'Northern Express','Pittsburgh','Erie','11:00:00','13:30:00',75.00),(31,1031,'Midwest Flyer','Milwaukee','Minneapolis','12:00:00','16:00:00',115.00),(32,1032,'Pacific Rail','Fresno','Bakersfield','13:00:00','15:00:00',60.00),(33,1033,'Southern Breeze','Raleigh','Richmond','14:30:00','17:30:00',85.00),(34,1034,'Northern Express','Albany','Hartford','15:00:00','17:00:00',70.00),(35,1035,'Midwest Flyer','Kansas City','Omaha','16:00:00','19:00:00',95.00),(36,1036,'Pacific Rail','Sacramento','Reno','17:00:00','20:00:00',110.00),(37,1037,'Southern Breeze','Charleston','Savannah','18:00:00','21:00:00',80.00),(38,1038,'Northern Express','Newark','Trenton','19:30:00','21:30:00',45.00),(39,1039,'Midwest Flyer','St. Paul','Des Moines','20:00:00','23:30:00',100.00),(40,1040,'Pacific Rail','Santa Barbara','Los Angeles','06:00:00','09:00:00',75.00),(41,1041,'Southern Breeze','Birmingham','Montgomery','07:00:00','09:30:00',55.00),(42,1042,'Northern Express','Rochester','Syracuse','08:00:00','09:45:00',65.00),(43,1043,'Midwest Flyer','Cincinnati','Louisville','09:00:00','11:30:00',80.00),(44,1044,'Pacific Rail','Portland','Eugene','10:30:00','12:45:00',70.00),(45,1045,'Southern Breeze','Tallahassee','Mobile','11:30:00','14:30:00',90.00),(46,1046,'Northern Express','Providence','Boston','12:30:00','14:00:00',50.00),(47,1047,'Midwest Flyer','Topeka','Wichita','13:30:00','16:00:00',75.00),(48,1048,'Pacific Rail','Long Beach','San Diego','14:30:00','18:30:00',120.00),(49,1049,'Southern Breeze','Charlotte','Columbia','15:30:00','18:00:00',85.00),(50,1050,'Northern Express','New Haven','Stamford','16:30:00','18:30:00',60.00),(51,1051,'Midwest Flyer','Detroit','Cleveland','17:30:00','20:00:00',70.00),(52,1052,'Pacific Rail','San Bernardino','Palm Springs','18:30:00','20:30:00',65.00),(53,1053,'Southern Breeze','Savannah','Jacksonville','19:00:00','21:30:00',75.00),(54,1054,'Northern Express','Buffalo','Toronto','07:30:00','10:30:00',95.00),(55,1055,'Midwest Flyer','St. Louis','Springfield','08:30:00','11:30:00',65.00),(56,1056,'Pacific Rail','Oakland','Fresno','09:30:00','12:30:00',110.00),(57,1057,'Southern Breeze','Orlando','Tampa','10:30:00','12:30:00',45.00),(58,1058,'Northern Express','Philadelphia','Newark','11:30:00','13:30:00',55.00),(59,1059,'Midwest Flyer','Minneapolis','Madison','12:30:00','15:30:00',95.00),(60,1060,'Pacific Rail','San Francisco','Los Angeles','13:30:00','18:30:00',150.00),(61,1061,'Southern Breeze','Atlanta','Montgomery','14:30:00','18:30:00',105.00),(62,1062,'Northern Express','Boston','Albany','15:30:00','18:30:00',75.00),(63,1063,'Midwest Flyer','Chicago','Indianapolis','16:30:00','19:00:00',65.00),(64,1064,'Pacific Rail','Los Angeles','San Diego','17:30:00','19:30:00',60.00),(65,1065,'Southern Breeze','Raleigh','Charlotte','18:30:00','20:30:00',70.00),(66,1001,'Northern Express','Washington','New York','12:00:00','04:00:00',120.00),(67,1002,'Midwest Flyer','Detroit','Chicago','12:30:00','03:30:00',75.50),(68,1003,'Pacific Rail','San Diego','Los Angeles','13:00:00','03:00:00',50.00),(69,1004,'Southern Breeze','Sacramento','San Francisco','16:00:00','03:00:00',65.00),(70,1005,'Northern Express','Boston','New York','19:00:00','05:00:00',130.00),(71,1006,'Midwest Flyer','Houston','Dallas','10:00:00','04:00:00',80.00),(72,1007,'Pacific Rail','Portland','Seattle','11:30:00','04:00:00',90.00),(73,1008,'Southern Breeze','Orlando','Atlanta','15:00:00','05:00:00',100.00),(74,1009,'Northern Express','Las Vegas','Phoenix','13:30:00','05:00:00',110.00),(75,1010,'Midwest Flyer','Salt Lake City','Denver','14:30:00','05:00:00',95.00),(76,1011,'Pacific Rail','Philadelphia','Boston','19:00:00','04:00:00',85.00),(77,1012,'Southern Breeze','Tampa','Miami','21:00:00','05:00:00',75.00),(78,1013,'Northern Express','St. Louis','Chicago','12:00:00','05:00:00',70.00),(79,1014,'Midwest Flyer','Reno','Las Vegas','13:30:00','05:00:00',100.00),(80,1015,'Pacific Rail','Baton Rouge','New Orleans','13:00:00','03:00:00',60.00),(81,1016,'Southern Breeze','San Antonio','Austin','15:30:00','03:30:00',50.00),(82,1017,'Northern Express','San Francisco','Los Angeles','19:00:00','06:00:00',150.00),(83,1018,'Midwest Flyer','New York','Philadelphia','18:00:00','04:00:00',110.00),(84,1019,'Pacific Rail','Fort Worth','Dallas','09:00:00','02:30:00',40.00),(85,1020,'Southern Breeze','Austin','Houston','12:30:00','03:30:00',60.00),(86,1021,'Northern Express','Boulder','Denver','13:00:00','02:00:00',30.00),(87,1022,'Midwest Flyer','Spokane','Seattle','14:00:00','07:00:00',120.00),(88,1023,'Pacific Rail','Jacksonville','Orlando','13:00:00','05:00:00',85.00),(89,1024,'Southern Breeze','Charlotte','Atlanta','19:30:00','05:00:00',105.00),(90,1025,'Northern Express','Tucson','Phoenix','12:30:00','03:00:00',50.00),(91,1026,'Northern Express','Cleveland','Buffalo','11:00:00','04:00:00',85.00),(92,1027,'Midwest Flyer','Columbus','Indianapolis','12:00:00','03:30:00',70.00),(93,1028,'Pacific Rail','San Francisco','San Jose','11:00:00','02:00:00',40.00),(94,1029,'Southern Breeze','Memphis','Jackson','14:00:00','04:00:00',90.00),(95,1030,'Northern Express','Erie','Pittsburgh','14:30:00','03:30:00',75.00),(96,1031,'Midwest Flyer','Minneapolis','Milwaukee','17:00:00','05:00:00',115.00),(97,1032,'Pacific Rail','Bakersfield','Fresno','16:00:00','03:00:00',60.00),(98,1033,'Southern Breeze','Richmond','Raleigh','18:30:00','04:00:00',85.00),(99,1034,'Northern Express','Hartford','Albany','18:00:00','03:00:00',70.00),(100,1035,'Midwest Flyer','Omaha','Kansas City','20:00:00','04:00:00',95.00),(101,1036,'Pacific Rail','Reno','Sacramento','21:00:00','04:00:00',110.00),(102,1037,'Southern Breeze','Savannah','Charleston','22:00:00','04:00:00',80.00),(103,1038,'Northern Express','Trenton','Newark','22:30:00','03:00:00',45.00),(104,1039,'Midwest Flyer','Des Moines','St. Paul','24:30:00','04:30:00',100.00),(105,1040,'Pacific Rail','Los Angeles','Santa Barbara','10:00:00','04:00:00',75.00),(106,1041,'Southern Breeze','Montgomery','Birmingham','10:30:00','03:30:00',55.00),(107,1042,'Northern Express','Syracuse','Rochester','10:45:00','02:45:00',65.00),(108,1043,'Midwest Flyer','Louisville','Cincinnati','12:30:00','03:30:00',80.00),(109,1044,'Pacific Rail','Eugene','Portland','13:45:00','03:15:00',70.00),(110,1045,'Southern Breeze','Mobile','Tallahassee','15:30:00','04:00:00',90.00),(111,1046,'Northern Express','Boston','Providence','15:00:00','02:30:00',50.00),(112,1047,'Midwest Flyer','Wichita','Topeka','17:00:00','03:30:00',75.00),(113,1048,'Pacific Rail','San Diego','Long Beach','19:30:00','05:00:00',120.00),(114,1049,'Southern Breeze','Columbia','Charlotte','19:00:00','03:30:00',85.00),(115,1050,'Northern Express','Stamford','New Haven','19:30:00','03:00:00',60.00),(116,1051,'Midwest Flyer','Cleveland','Detroit','21:00:00','03:30:00',70.00),(117,1052,'Pacific Rail','Palm Springs','San Bernardino','21:30:00','03:00:00',65.00),(118,1053,'Southern Breeze','Jacksonville','Savannah','22:30:00','03:30:00',75.00),(119,1054,'Northern Express','Toronto','Buffalo','11:30:00','04:00:00',95.00),(120,1055,'Midwest Flyer','Springfield','St. Louis','12:30:00','04:00:00',65.00),(121,1056,'Pacific Rail','Fresno','Oakland','13:30:00','04:00:00',110.00),(122,1057,'Southern Breeze','Tampa','Orlando','13:30:00','03:00:00',45.00),(123,1058,'Northern Express','Newark','Philadelphia','14:30:00','03:00:00',55.00),(124,1059,'Midwest Flyer','Madison','Minneapolis','16:30:00','04:00:00',95.00),(125,1060,'Pacific Rail','Los Angeles','San Francisco','19:30:00','06:00:00',150.00),(126,1061,'Southern Breeze','Montgomery','Atlanta','19:30:00','05:00:00',105.00),(127,1062,'Northern Express','Albany','Boston','19:30:00','04:00:00',75.00),(128,1063,'Midwest Flyer','Indianapolis','Chicago','20:00:00','03:30:00',65.00),(129,1064,'Pacific Rail','San Diego','Los Angeles','20:30:00','03:00:00',60.00),(130,1065,'Southern Breeze','Charlotte','Raleigh','21:30:00','03:00:00',70.00);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `Train_ID` int NOT NULL,
  `Train_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Train_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (1001,'train_1'),(1002,'train_2'),(1003,'train_3'),(1004,'train_4'),(1005,'train_5'),(1006,'train_6'),(1007,'train_7'),(1008,'train_8'),(1009,'train_9'),(1010,'train_10'),(1011,'train_11'),(1012,'train_12'),(1013,'train_13'),(1014,'train_14'),(1015,'train_15'),(1016,'train_16'),(1017,'train_17'),(1018,'train_18'),(1019,'train_19'),(1020,'train_20'),(1021,'train_21'),(1022,'train_22'),(1023,'train_23'),(1024,'train_24'),(1025,'train_25'),(1026,'train_26'),(1027,'train_27'),(1028,'train_28'),(1029,'train_29'),(1030,'train_30'),(1031,'train_31'),(1032,'train_32'),(1033,'train_33'),(1034,'train_34'),(1035,'train_35'),(1036,'train_36'),(1037,'train_37'),(1038,'train_38'),(1039,'train_39'),(1040,'train_40'),(1041,'train_41'),(1042,'train_42'),(1043,'train_43'),(1044,'train_44'),(1045,'train_45'),(1046,'train_46'),(1047,'train_47'),(1048,'train_48'),(1049,'train_49'),(1050,'train_50'),(1051,'train_51'),(1052,'train_52'),(1053,'train_53'),(1054,'train_54'),(1055,'train_55'),(1056,'train_56'),(1057,'train_57'),(1058,'train_58'),(1059,'train_59'),(1060,'train_60'),(1061,'train_61'),(1062,'train_62'),(1063,'train_63'),(1064,'train_64'),(1065,'train_65');
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-11 13:53:27
