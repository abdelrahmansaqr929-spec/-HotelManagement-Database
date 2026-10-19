CREATE DATABASE HotelManagementDB;
GO

USE HotelManagementDB;
GO

CREATE TABLE Hotels (
    HotelId INT PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    StarRating INT,
    ContactNumber VARCHAR(50),
    ManageId INT UNIQUE
);

CREATE TABLE Staff (
    StaffId INT PRIMARY KEY,
    FullName VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    HotelId INT,
    FOREIGN KEY (HotelId) REFERENCES Hotels(HotelId)
);

ALTER TABLE Hotels 
ADD CONSTRAINT FK_Hotels_Staff FOREIGN KEY (ManageId) REFERENCES Staff(StaffId);

CREATE TABLE Services (
    ServiceId INT PRIMARY KEY,
    ServiceName VARCHAR(50),
    Charge DECIMAL(10, 2),
    RequestDate DATETIME,
    StaffId INT,
    FOREIGN KEY (StaffId) REFERENCES Staff(StaffId)
);

CREATE TABLE Rooms (
    RoomNumber INT PRIMARY KEY,
    RoomType VARCHAR(50),
    Capacity INT,
    DailyRate DECIMAL(10, 2),
    Availability VARCHAR(50),
    HotelId INT,
    FOREIGN KEY (HotelId) REFERENCES Hotels(HotelId)
);

CREATE TABLE Amenities (
    RoomNumber INT,
    Amenity VARCHAR(50),
    PRIMARY KEY (RoomNumber, Amenity),
    FOREIGN KEY (RoomNumber) REFERENCES Rooms(RoomNumber)
);

CREATE TABLE Guests (
    GuestId INT PRIMARY KEY,
    FullName VARCHAR(100),
    Nationality VARCHAR(50),
    PassportNumber VARCHAR(50),
    DateOfBirth DATE
);

CREATE TABLE Guest_Contact_Details (
    GuestId INT,
    Detail VARCHAR(100),
    PRIMARY KEY (GuestId, Detail),
    FOREIGN KEY (GuestId) REFERENCES Guests(GuestId)
);

CREATE TABLE Reservations (
    ReservationId INT PRIMARY KEY,
    BookingDate DATETIME,
    CheckInDate DATETIME,
    CheckOutDate DATETIME,
    ReservationStatus VARCHAR(50),
    TotalPrice DECIMAL(10, 2),
    NumberOfAdults INT,
    NumberOfChildren INT
);

CREATE TABLE Reservations_Rooms (
    ReservationId INT,
    RoomNumber INT,
    PRIMARY KEY (ReservationId, RoomNumber),
    FOREIGN KEY (ReservationId) REFERENCES Reservations(ReservationId),
    FOREIGN KEY (RoomNumber) REFERENCES Rooms(RoomNumber)
);

CREATE TABLE Reservations_Guest (
    ReservationId INT,
    GuestId INT,
    PRIMARY KEY (ReservationId, GuestId),
    FOREIGN KEY (ReservationId) REFERENCES Reservations(ReservationId),
    FOREIGN KEY (GuestId) REFERENCES Guests(GuestId)
);

CREATE TABLE ReservationService (
    ServiceId INT,
    ReservationId INT,
    PRIMARY KEY (ServiceId, ReservationId),
    FOREIGN KEY (ServiceId) REFERENCES Services(ServiceId),
    FOREIGN KEY (ReservationId) REFERENCES Reservations(ReservationId)
);

CREATE TABLE Payments (
    PaymentId INT PRIMARY KEY,
    Method VARCHAR(50),
    Date DATETIME,
    Amount DECIMAL(10, 2),
    ConfirmationNumber VARCHAR(50)
);

CREATE TABLE Reservations_Payment (
    ReservationId INT,
    PaymentId INT,
    PRIMARY KEY (ReservationId, PaymentId),
    FOREIGN KEY (ReservationId) REFERENCES Reservations(ReservationId),
    FOREIGN KEY (PaymentId) REFERENCES Payments(PaymentId)
);