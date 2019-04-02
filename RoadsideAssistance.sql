SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;



 -- All Tables have been given a prefix of ra_ 
 
 -- Arranged the weak entities so they are dropped first.
DROP TABLE IF EXISTS ra_Customer;
DROP TABLE IF EXISTS ra_Login;
DROP TABLE IF EXISTS ra_Requests;
DROP TABLE IF EXISTS ra_User;

-- NOTE: Strong Entities are thought to be: User, Requests, Roles. Correct?
-- NOTE: Weak Entities are thought to be: Login, Customer. Correct?

-- Creating strong entities first 
CREATE TABLE IF NOT EXISTS `ra_User` (
  `UserID` int(11) NOT NULL,
  `FirstName` varchar(30) NOT NULL,  -- This was changed from 'First' to 'FirstName' due to being a reserved word
  `LastName` varchar(30) NOT NULL,   -- This was changed from 'First' to 'LastName' due to being a reserved word
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `ra_User` (`UserID`, `FirstName`, `LastName`) VALUES
(1, 'Chris', 'Burr'),
(2, 'Nina', 'Fig'),
(3, 'Brent', 'Gaff'),
(4, 'Tain', 'Anders'),
(5, 'Bruce', 'Wayne'),
(6, 'Robin', 'Dent'),
(7, 'Jess', 'Cassidy'),
(8, 'Alfred', 'Hugh'),
(9, 'Leia', 'Organa'),
(10, 'Leon', 'Portman'),
(11, 'Nancy', 'Fancy'),
(12, 'Billy', 'Ferrman'),
(13, 'Jon', 'Berg'),
(14, 'Carlos', 'Pey'),
(15, 'Andy', 'Lane'),
(16, 'Wilhelm', 'Kleiner'),
(17, 'Leroy', 'Jenkins'),
(18, 'Harry', 'Rigin'),
(19, 'Cyril', 'Figgis'),
(20, 'Ron', 'Gosh'),
(21, 'Greg', 'Stein'),
(22, 'Ted', 'Dead'),
(23, 'Tatiana', 'Rical'),
(24, 'Nigel', 'Harn'),
(25, 'Ian', 'Pine'),
(26, 'Colby', 'Bren'),
(27, 'Rena', 'Darn'),
(28, 'Natalia', 'Yung'),
(29, 'Pam', 'Green'),
(30, 'Kristine', 'Lutz'),
(31, 'Liam', 'Mitchel'),
(32, 'Chim', 'Richalds');

CREATE TABLE IF NOT EXISTS `ra_Requests` (
  `RequestID` int(11) NOT NULL AUTO_INCREMENT,
  `UserIdfk` int(11) NOT NULL,
  `Problem` varchar(120) NOT NULL,
  `Latitude` double NOT NULL,
  `Longitude` double NOT NULL,
  `TimeLogged` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- This was changed from 'Timestamp' to 'TimeLogged' due to being a reserved word
  `Status` varchar(50) NOT NULL,
  `LastChanged` timestamp NOT NULL,
  PRIMARY KEY (`RequestID`),
  CONSTRAINT FK1_Requests              -- Creating a constraint for the foreign key 
                       FOREIGN KEY (UserIDfk) REFERENCES ra_User(UserID)   -- foreign key references primary key in other table
                       ON DELETE RESTRICT
		               ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER $$
CREATE trigger timeUpdateTrig
before UPDATE on ra_Requests
for each row 
begin
set new.LastChanged = current_timestamp;
end$$
DELIMITER ;

INSERT INTO `ra_Requests`(`UserIdfk`, `Problem`, `Latitude`, `Longitude`, `Status`) VALUES 
(1,'Flat Tire',2.343543,3.535343,'Closed'),
(1,'Locked Out',2.343543,4.535343,'Closed'),
(2,'Flat Tire',1.343543,3.535343,'Closed'),
(3,'Dead Battery',3.343543,3.535343,'Closed'),
(4,'Flat Tire',4.343543,3.535343,'Closed'),
(5,'Out of Gas',5.343543,3.535343,'Closed'),
(5,'Flat Tire',6.343543,3.535343,'Closed'),
(6,'Flat Tire',7.343543,3.535343,'Closed'),
(7,'Dead Battery',8.343543,3.535343,'Closed'),
(8,'Flat Tire',9.343543,3.535343,'Closed'),
(9,'Flat Tire',2.343543,1.535343,'Closed'),
(10,'Dead Battery',2.343543,2.535343,'Closed'),
(11,'Flat Tire',2.343543,5.535343,'Closed'),
(12,'Out of Gas',2.343543,6.535343,'Closed'),
(13,'Locked Out',2.343543,7.535343,'Closed'),
(14,'Dead Battery',2.343543,8.535343,'Closed'),
(15,'Flat Tire',2.343543,9.535343,'Closed'),
(16,'Out of Gas',2.3435,3.5353,'Closed'),
(17,'Flat Tire',2.3543,3.5343,'Closed'),
(18,'Dead Battery',2.3443,3.5343,'Closed'),
(19,'Flat Tire',3.3435,3.535343,'Closed'),
(20,'Flat Tire',4.343543,3.5353,'Closed'),
(21,'Out of Gas',5.3435,3.535343,'Closed'),
(22,'Flat Tire',6.343543,3.5353,'Closed'),
(23,'Locked Out',7.3435,3.535343,'Closed'),
(24,'Dead Battery',8.343543,3.5353,'Closed'),
(25,'Flat Tire',9.3435,3.535343,'Closed'),
(26,'Flat Tire',2.343543,4.5353,'Closed'),
(27,'Out of Gas',2.343543,5.5,'Closed'),
(28,'Flat Tire',2.3,6.535343,'Closed'),
(29,'Flat Tire',2.343543,7.53,'Closed'),
(30,'Locked Out',2.34,8.535343,'Closed'),
(30,'Locked Out',2.343543,9.43,'Closed'),
(7,'Flat Tire',2.3,3.5,'Open'),
(13,'Flat Tire',2.3,3.3,'Open'),
(26,'Dead Battery',2.33,3.53,'Open');



-- Weak entities are created last  
CREATE TABLE IF NOT EXISTS `ra_Login` (
  `UserIDfk` int(11) NOT NULL,
  `Password` varchar(25) NOT NULL,
 
  CONSTRAINT FK1_Login              -- Creating a constraint for the foreign key 
                       FOREIGN KEY (UserIDfk) REFERENCES ra_User(UserID)   -- foreign key references primary key in other table
                       ON DELETE RESTRICT
		               ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `ra_Login`(`UserIDfk`, `Password`) VALUES 
(1,'BestPassa'),
(2,'BestPassb'),
(3,'BestPassc'),
(4,'BestPassd'),
(5,'BestPasse'),
(6,'BestPassf'),
(7,'BestPassg'),
(8,'BestPassh'),
(9,'BestPassi'),
(10,'BestPassj'),
(11,'BestPassk'),
(12,'BestPassl'),
(13,'BestPassm'),
(14,'BestPassn'),
(15,'BestPasso'),
(16,'BestPassp'),
(17,'BestPassq'),
(18,'BestPassr'),
(19,'BestPasss'),
(20,'BestPasst'),
(21,'BestPassu'),
(22,'BestPassv'),
(23,'BestPassw'),
(24,'BestPassx'),
(25,'BestPassy'),
(26,'BestPassz'),
(27,'BestPasszz'),
(28,'BestPasszzz'),
(29,'BestPasszzzz'),
(30,'BestPasszzzzz'),
(31,'BestPasszzzzzz'),
(32,'BestPasszzzzzzz');

        
CREATE TABLE IF NOT EXISTS `ra_Customer` (
  `UserIDfk` int(11) NOT NULL,
  `Email` varchar(80) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Address` varchar(120) NOT NULL,
  `Role` varchar(60) NOT NULL,  -- Roles can be Customer, admin, or responder --
 
   CONSTRAINT FK1_Customer              -- Creating a constraint for the foreign key 
                       FOREIGN KEY (UserIDfk) REFERENCES ra_User(UserID)   -- foreign key references primary key in other table
                       ON DELETE RESTRICT
		               ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `ra_Customer`(`UserIDfk`, `Email`, `Phone`, `Address`, `Role`)
VALUES 
(1,'bestemail1@gmail.com','760-1111-111','1111 Home San Diego CA','Customer'),
(2,'bestemail2@gmail.com','760-2111-211','2222 Home San Diego CA','Customer'),
(3,'bestemail3@gmail.com','760-3111-311','3333 Home San Diego CA','Customer'),
(4,'bestemail4@gmail.com','760-4111-411','444 Home San Diego CA','Customer'),
(5,'bestemail5@gmail.com','760-5111-511','555 Home San Diego CA','Customer'),
(6,'bestemail6@gmail.com','760-6111-611','666 Home San Diego CA','Customer'),
(7,'bestemail7@gmail.com','760-7111-711','777 Home San Diego CA','Customer'),
(8,'bestemail8@gmail.com','760-8111-811','888 Home San Diego CA','Customer'),
(9,'bestemail9@gmail.com','760-9111-911','999 Home San Diego CA','Customer'),
(10,'bestemail10@gmail.com','760-2211-122','1111 Apartment San Diego CA','Customer'),
(11,'bestemail11@gmail.com','760-3311-133','1122 Apartment San Diego CA','Customer'),
(12,'bestemail12@gmail.com','760-4411-144','2211 Apartment San Diego CA','Customer'),
(13,'bestemail13@gmail.com','760-5511-555','3333 Apartment San Diego CA','Customer'),
(14,'bestemail14@gmail.com','760-6611-166','1144 Apartment San Diego CA','Customer'),
(15,'bestemail15@gmail.com','760-7711-177','1551 Apartment San Diego CA','Customer'),
(16,'bestemail16@gmail.com','760-8811-188','1661 Apartment San Diego CA','Customer'),
(17,'bestemail17@gmail.com','760-9911-199','1771 Apartment San Diego CA','Customer'),
(18,'bestemail18@gmail.com','760-1122-121','881 Apartment San Diego CA','Customer'),
(19,'bestemail19@gmail.com','760-1133-131','1191 Apartment San Diego CA','Customer'),
(20,'bestemail20@gmail.com','760-1144-141','1991 Home San Diego CA','Customer'),
(21,'bestemail21@gmail.com','760-1155-151','123 Home San Diego CA','Customer'),
(22,'bestemail22@gmail.com','760-1166-161','234 Home San Diego CA','Customer'),
(23,'bestemail23@gmail.com','760-1177-171','567 Home San Diego CA','Customer'),
(24,'bestemail24@gmail.com','760-1188-181','678 Home San Diego CA','Customer'),
(25,'bestemail25@gmail.com','760-1199-191','789 Home San Diego CA','Customer'),
(26,'bestemail26@gmail.com','858-1111-111','4567 Home San Diego CA','Customer'),
(27,'bestemail27@gmail.com','858-1221-111','987 Home San Diego CA','Customer'),
(28,'bestemail28@gmail.com','858-1331-111','754 Home San Diego CA','Customer'),
(29,'bestemail29@gmail.com','858-1441-111','654 Home San Diego CA','Customer'),
(30,'bestemail30@gmail.com','858-1551-111','543 Home San Diego CA','Customer'),
(31,'bestemail31@gmail.com','858-1661-111','432 Home San Diego CA','Admin'),
(32,'bestemail32@gmail.com','858-1771-111','6746 Home San Diego CA','Responder');




/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



