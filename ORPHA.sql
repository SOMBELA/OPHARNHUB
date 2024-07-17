DROP DATABASE IF EXISTS ORPHA;
CREATE DATABASE IF NOT EXISTS ORPHA;
USE ORPHA;

CREATE TABLE Orphanage (
    OrphanageID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    password_reset_token VARCHAR(255),
    verification_token VARCHAR(255),
    email VARCHAR(100) NOT NULL UNIQUE,
    auth_key VARCHAR(255),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Role ENUM('Admin', 'Sponsor', 'Orphan'),
    OrphanageID INT,
    status INT,
    created_at INT(11),
    updated_at INT(11),
    FOREIGN KEY (OrphanageID) REFERENCES Orphanage(OrphanageID)
);

CREATE TABLE Orphan(
    OrphanID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female'),
    DateAdmitted DATE,
    OrphanageID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (OrphanageID) REFERENCES Orphanage(OrphanageID)
);

CREATE TABLE OrphanRegistration (
    RegistrationID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female'),
    DateRegistered DATE,
    OrphanageID INT,
    Status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (OrphanageID) REFERENCES Orphanage(OrphanageID)
);

CREATE TABLE Sponsor (
    SponsorID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Phone VARCHAR(20),
    Gender ENUM('Male', 'Female'),
    Email VARCHAR(100),
    RegisteredDate DATE,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Sponsorship (
    SponsorshipID INT PRIMARY KEY AUTO_INCREMENT,
    SponsorID INT,
    OrphanID INT,
    SponsorshipStartDate DATE,
    SponsorshipEndDate DATE,
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(SponsorID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);



CREATE TABLE Donation (
    DonationID INT PRIMARY KEY AUTO_INCREMENT,
    SponsorID INT,
    OrphanageID INT,
    Amount DECIMAL(10, 2),
    DonationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(SponsorID),
    FOREIGN KEY (OrphanageID) REFERENCES Orphanage(OrphanageID)
);

CREATE TABLE HealthRecord (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    OrphanID INT,
    CheckupDate DATE,
    HealthStatus VARCHAR(255),
    Notes TEXT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

CREATE TABLE EducationRecord (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    OrphanID INT,
    SchoolName VARCHAR(255),
    GradeLevel VARCHAR(50),
    PerformanceNotes TEXT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

CREATE TABLE Message (
    MessageID INT PRIMARY KEY AUTO_INCREMENT,
    SenderID INT,
    ReceiverID INT,
    Subject VARCHAR(255),
    MessageText TEXT,
    SentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SenderID) REFERENCES User(UserID),
    FOREIGN KEY (ReceiverID) REFERENCES User(UserID)
);
