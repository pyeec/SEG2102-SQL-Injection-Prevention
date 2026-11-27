--PART 2 - IMPLEMENT A DATABASE USING SQL 

--Question 1
DROP TABLE Animals CASCADE CONSTRAINTS;
DROP TABLE MedicalRecords CASCADE CONSTRAINTS;
DROP TABLE BehaviourReports CASCADE CONSTRAINTS;
DROP TABLE Volunteers CASCADE CONSTRAINTS;
DROP TABLE VolunteerActivities CASCADE CONSTRAINTS;
DROP TABLE AdoptionEvents CASCADE CONSTRAINTS;
DROP TABLE EventAssignments CASCADE CONSTRAINTS;
DROP TABLE FosterHomes CASCADE CONSTRAINTS;
DROP TABLE Donations CASCADE CONSTRAINTS;
DROP TABLE Stock CASCADE CONSTRAINTS;
DROP TABLE Adoptions CASCADE CONSTRAINTS;

CREATE TABLE Animals (
    AnimalID INT PRIMARY KEY NOT NULL,
    Species VARCHAR(50) NOT NULL,
    Age NUMBER CHECK (Age BETWEEN 0 AND 30) NOT NULL,
    IntakeDate DATE NOT NULL,
    Adoptable VARCHAR2(3) CHECK (Adoptable IN ('Yes', 'No')) NOT NULL
);

CREATE TABLE MedicalRecords (
    MedicalID INT PRIMARY KEY NOT NULL,
    AnimalID INT NOT NULL,
    VisitDate DATE NOT NULL,
    ImmunizationStatus VARCHAR2(10) CHECK (ImmunizationStatus IN ('Yes', 'No', 'Pending')) NOT NULL,
    DewormingStatus VARCHAR2(10) CHECK (DewormingStatus IN ('Yes', 'No', 'Pending')) NOT NULL,
    SterilizationStatus VARCHAR2(10) CHECK (SterilizationStatus IN ('Yes', 'No', 'Pending')) NOT NULL,
    HealthRating VARCHAR2(10) CHECK (HealthRating IN ('Excellent', 'Good', 'Fair', 'Poor')) NOT NULL,
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

CREATE TABLE BehaviourReports (
    BehaviourID INT PRIMARY KEY NOT NULL,
    AnimalID INT NOT NULL,
    ObservationDate DATE NOT NULL,
    BehaviourStatus VARCHAR2(50) NOT NULL,
    TrainingStatus VARCHAR2(20) CHECK (TrainingStatus IN ('Trained', 'Untrained', 'In Progress')) NOT NULL,
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

CREATE TABLE Volunteers (
    VolunteerID INT PRIMARY KEY NOT NULL,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) NOT NULL,
    Phone VARCHAR2(20) NOT NULL,
    Availability VARCHAR2(20) CHECK (Availability IN ('Weekdays', 'Weekends', 'Nights', 'Flexible')) NOT NULL,
    Skills VARCHAR2(255) NOT NULL,
    Interests VARCHAR2(255) NOT NULL
);

CREATE TABLE VolunteerActivities (
    ActivityID INT PRIMARY KEY NOT NULL,
    VolunteerID INT NOT NULL,
    ActivityType VARCHAR2(100) NOT NULL,
    ActivityDate DATE NOT NULL,
    FOREIGN KEY (VolunteerID) REFERENCES Volunteers(VolunteerID)
);

CREATE TABLE AdoptionEvents (
    EventID INT PRIMARY KEY NOT NULL,
    Name VARCHAR2(100) NOT NULL,
    Venue VARCHAR2(100) NOT NULL,
    EventDate DATE NOT NULL
);

CREATE TABLE EventAssignments (
    AssignmentID INT PRIMARY KEY NOT NULL,
    EventID INT NOT NULL,
    VolunteerID INT NOT NULL,
    AnimalID INT NOT NULL,
    Role VARCHAR2(20) CHECK (Role IN ('Animal Handler', 'Reception', 'Info Desk')) NOT NULL,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID),
    FOREIGN KEY (VolunteerID) REFERENCES Volunteers(VolunteerID),
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
    CONSTRAINT uq_EventAssignment UNIQUE (EventID, VolunteerID, AnimalID)
);

CREATE TABLE Stock (
    StockItemID INT PRIMARY KEY NOT NULL,
    ItemType VARCHAR2(100) NOT NULL,
    Quantity NUMBER DEFAULT 0 CHECK (Quantity >= 0) NOT NULL
);

CREATE TABLE FosterHomes (
    FosterID INT PRIMARY KEY NOT NULL,
    AnimalID INT NOT NULL,
    VolunteerID INT NOT NULL,
    StockItemID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (VolunteerID) REFERENCES Volunteers(VolunteerID),
    FOREIGN KEY (StockItemID) REFERENCES Stock(StockItemID)
);

CREATE TABLE Donations (
    DonationID INT PRIMARY KEY NOT NULL,
    EventID INT NOT NULL,
    DonorName VARCHAR2(100) NOT NULL,
    DonationType VARCHAR2(10) CHECK (DonationType IN ('Cash', 'In-kind')) NOT NULL,
    Amount NUMBER CHECK (Amount > 0) NOT NULL,
    DonationDate DATE NOT NULL,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

CREATE TABLE Adoptions (
    AdoptionID INT PRIMARY KEY NOT NULL,
    AnimalID INT NOT NULL,
    AdopterName VARCHAR2(100) NOT NULL,
    Contact VARCHAR2(50) NOT NULL,
    AdoptionDate DATE NOT NULL,
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);


--Question 2
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (1, 'Dog', 3, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (2, 'Cat', 2, TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (3, 'Rabbit', 1, TO_DATE('2023-07-10', 'YYYY-MM-DD'), 'No');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (4, 'Dog', 5, TO_DATE('2023-03-05', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (5, 'Cat', 4, TO_DATE('2023-04-20', 'YYYY-MM-DD'), 'No');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (6, 'Parrot', 2, TO_DATE('2023-08-18', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (7, 'Hamster', 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (8, 'Dog', 7, TO_DATE('2023-10-03', 'YYYY-MM-DD'), 'No');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (9, 'Cat', 6, TO_DATE('2023-11-25', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (10, 'Rabbit', 2, TO_DATE('2023-12-12', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (11, 'Dog', 8, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'No');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (12, 'Cat', 1, TO_DATE('2022-02-22', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (13, 'Bird', 3, TO_DATE('2022-03-17', 'YYYY-MM-DD'), 'Yes');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (14, 'Ferret', 2, TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'No');
INSERT INTO Animals (AnimalID, Species, Age, IntakeDate, Adoptable) VALUES (15, 'Turtle', 10, TO_DATE('2022-05-05', 'YYYY-MM-DD'), 'Yes');

INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (1, 5, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'Yes', 'Yes', 'Yes', 'Excellent');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (2, 12, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Yes', 'No', 'Pending', 'Good');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (3, 3, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Pending', 'Pending', 'No', 'Fair');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (4, 9, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Yes', 'Yes', 'Yes', 'Excellent');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (5, 1, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 'No', 'Yes', 'No', 'Poor');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (6, 14, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'Yes', 'Yes', 'Pending', 'Good');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (7, 7, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Pending', 'No', 'No', 'Fair');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (8, 10, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Yes', 'Yes', 'Yes', 'Good');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (9, 2, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'No', 'No', 'No', 'Poor');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (10, 15, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Yes', 'Pending', 'Yes', 'Excellent');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (11, 6, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Pending', 'Pending', 'Pending', 'Fair');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (12, 4, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Yes', 'Yes', 'Yes', 'Excellent');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (13, 13, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 'No', 'Yes', 'No', 'Good');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (14, 11, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Yes', 'No', 'Pending', 'Fair');
INSERT INTO MedicalRecords (MedicalID, AnimalID, VisitDate, ImmunizationStatus, DewormingStatus, SterilizationStatus, HealthRating) VALUES (15, 8, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Yes', 'Yes', 'Yes', 'Excellent');

INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (1, 3, TO_DATE('2024-01-08', 'YYYY-MM-DD'), 'Calm and friendly', 'Trained');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (2, 11, TO_DATE('2024-01-12', 'YYYY-MM-DD'), 'Aggressive when hungry', 'Untrained');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (3, 6, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Loves playing with toys', 'In Progress');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (4, 14, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Easily startled by noise', 'Trained');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (5, 1, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 'Gentle and quiet', 'Untrained');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (6, 9, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Energetic and social', 'In Progress');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (7, 12, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 'Tends to chew furniture', 'Untrained');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (8, 7, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'Very obedient to commands', 'Trained');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (9, 2, TO_DATE('2024-02-14', 'YYYY-MM-DD'), 'Fearful in new environments', 'In Progress');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (10, 15, TO_DATE('2024-02-18', 'YYYY-MM-DD'), 'Friendly with other animals', 'Trained');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (11, 5, TO_DATE('2024-02-21', 'YYYY-MM-DD'), 'Distracted during training', 'Untrained');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (12, 8, TO_DATE('2024-02-25', 'YYYY-MM-DD'), 'Highly food motivated', 'In Progress');
INSERT INTO BehaviourReports (BehaviourID, AnimalID, ObservationDate, BehaviourStatus, TrainingStatus) VALUES (13, 10, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Needs socialization', 'Untrained');

INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (1, 'Alice Tan', 'alice.tan@example.com', '012-3456789', 'Weekdays', 'Animal care, Cleaning', 'Dogs, Cats');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (2, 'Brian Lee', 'brian.lee@example.com', '013-4567890', 'Weekends', 'Fundraising, Social Media', 'Events, Publicity');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (3, 'Carmen Ong', 'carmen.ong@example.com', '014-5678901', 'Nights', 'Veterinary Assistance', 'Health care');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (4, 'Daniel Lim', 'daniel.lim@example.com', '015-6789012', 'Flexible', 'Training, Walking dogs', 'Dogs');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (5, 'Emily Chong', 'emily.chong@example.com', '016-7890123', 'Weekdays', 'Grooming', 'Cats, Rabbits');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (6, 'Farah Aziz', 'farah.aziz@example.com', '017-8901234', 'Weekends', 'Photography', 'Publicity');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (7, 'George Koh', 'george.koh@example.com', '018-9012345', 'Nights', 'Admin, Records', 'Office work');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (8, 'Hannah Goh', 'hannah.goh@example.com', '019-0123456', 'Flexible', 'Shelter Maintenance', 'Logistics');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (9, 'Ivan Teh', 'ivan.teh@example.com', '010-1234567', 'Weekends', 'Transportation', 'Animal rescue');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (10, 'Jasmine Ng', 'jasmine.ng@example.com', '011-2345678', 'Weekdays', 'Design, Posters', 'Awareness campaigns');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (11, 'Kevin Yip', 'kevin.yip@example.com', '012-3456790', 'Flexible', 'Social Media', 'Public relations');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (12, 'Lily Wong', 'lily.wong@example.com', '013-4567801', 'Nights', 'Feeding, Bathing', 'Kittens, Puppies');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (13, 'Marcus Lee', 'marcus.lee@example.com', '014-5678912', 'Weekends', 'Event Setup', 'Adoption drives');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (14, 'Nina Tan', 'nina.tan@example.com', '015-6789023', 'Weekdays', 'Reception', 'Visitor Management');
INSERT INTO Volunteers (VolunteerID, Name, Email, Phone, Availability, Skills, Interests) VALUES (15, 'Oscar Lim', 'oscar.lim@example.com', '016-7890134', 'Flexible', 'IT Support', 'Database Management');

INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (1, 8, 'Animal Feeding', TO_DATE('2024-06-01', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (2, 3, 'Fundraising Booth', TO_DATE('2024-06-03', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (3, 14, 'Health Check Assistance', TO_DATE('2024-06-05', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (4, 1, 'Dog Walking', TO_DATE('2024-06-07', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (5, 10, 'Cat Grooming', TO_DATE('2024-06-08', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (6, 5, 'Event Photography', TO_DATE('2024-06-10', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (7, 12, 'Data Entry', TO_DATE('2024-06-11', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (8, 2, 'Facility Cleaning', TO_DATE('2024-06-12', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (9, 9, 'Animal Transport', TO_DATE('2024-06-13', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (10, 15, 'Poster Design', TO_DATE('2024-06-14', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (11, 4, 'Social Media Post', TO_DATE('2024-06-15', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (12, 13, 'Pet Bathing', TO_DATE('2024-06-16', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (13, 6, 'Event Setup', TO_DATE('2024-06-17', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (14, 7, 'Reception Desk', TO_DATE('2024-06-18', 'YYYY-MM-DD'));
INSERT INTO VolunteerActivities (ActivityID, VolunteerID, ActivityType, ActivityDate) VALUES (15, 11, 'Database Maintenance', TO_DATE('2024-06-19', 'YYYY-MM-DD'));

INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (1, 'Summer Pet Fair', 'City Park Pavilion', TO_DATE('2024-06-01', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (2, 'Paws and Play', 'Downtown Mall', TO_DATE('2024-06-03', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (3, 'Adopt-A-Friend Day', 'Community Hall A', TO_DATE('2024-06-05', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (4, 'Furry Friends Fest', 'Zoo Garden Area', TO_DATE('2024-06-07', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (5, 'Pet Connect Weekend', 'Riverbank Shelter', TO_DATE('2024-06-10', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (6, 'Animal Awareness Carnival', 'Sunrise Plaza', TO_DATE('2024-06-12', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (7, 'Shelter Love Day', 'Greenfield Park', TO_DATE('2024-06-14', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (8, 'Rescue and Rehome Expo', 'Animal Hall', TO_DATE('2024-06-15', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (9, 'Puppy Palooza', 'Dog Park Pavilion', TO_DATE('2024-06-17', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (10, 'Meow Mania', 'Pet Central Venue', TO_DATE('2024-06-18', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (11, 'Adopt & Smile', 'Town Convention Center', TO_DATE('2024-06-20', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (12, 'Forever Home Fair', 'Sunshine Pet Zone', TO_DATE('2024-06-21', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (13, 'Rescue Rally', 'Community Plaza', TO_DATE('2024-06-22', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (14, 'Happy Tails Fest', 'Downtown Square', TO_DATE('2024-06-24', 'YYYY-MM-DD'));
INSERT INTO AdoptionEvents (EventID, Name, Venue, EventDate) VALUES (15, 'Animal Meet & Greet', 'Southside Shelter Grounds', TO_DATE('2024-06-25', 'YYYY-MM-DD'));

INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (1, 3, 5, 8, 'Animal Handler');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (2, 7, 1, 3, 'Reception');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (3, 2, 9, 12, 'Info Desk');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (4, 5, 3, 10, 'Animal Handler');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (5, 8, 2, 4, 'Reception');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (6, 1, 7, 11, 'Info Desk');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (7, 6, 4, 2, 'Animal Handler');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (8, 4, 10, 5, 'Reception');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (9, 9, 6, 9, 'Info Desk');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (10, 10, 12, 1, 'Animal Handler');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (11, 12, 15, 7, 'Reception');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (12, 14, 8, 6, 'Animal Handler');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (13, 13, 13, 15, 'Info Desk');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (14, 11, 11, 13, 'Reception');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (15, 15, 14, 14, 'Animal Handler');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (16, 7, 14, 14, 'Info Desk');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (17, 4, 9, 5, 'Reception');
INSERT INTO EventAssignments (AssignmentID, EventID, VolunteerID, AnimalID, Role) VALUES (18, 12, 4, 8, 'Animal Handler');

INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (1, 'Dry Dog Food', 120);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (2, 'Wet Cat Food', 80);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (3, 'Pet Shampoo', 50);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (4, 'Leashes', 200);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (5, 'Cat Toys', 75);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (6, 'Dog Beds', 30);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (7, 'Litter Boxes', 40);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (8, 'Water Bowls', 95);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (9, 'Blankets', 60);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (10, 'Training Pads', 150);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (11, 'First Aid Kits', 25);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (12, 'Cleaning Supplies', 45);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (13, 'Pet Carriers', 20);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (14, 'Grooming Brushes', 70);
INSERT INTO Stock (StockItemID, ItemType, Quantity) VALUES (15, 'Tick & Flea Spray', 35);

INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (1, 3, 7, 5, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2025-02-15', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (2, 11, 2, 1, TO_DATE('2025-01-05', 'YYYY-MM-DD'), NULL);
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (3, 5, 10, 7, TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2025-01-20', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (4, 9, 1, 3, TO_DATE('2025-02-01', 'YYYY-MM-DD'), NULL);
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (5, 15, 4, 12, TO_DATE('2024-10-12', 'YYYY-MM-DD'), TO_DATE('2024-12-30', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (6, 2, 14, 6, TO_DATE('2025-03-01', 'YYYY-MM-DD'), NULL);
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (7, 10, 6, 4, TO_DATE('2024-08-25', 'YYYY-MM-DD'), TO_DATE('2024-11-25', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (8, 7, 12, 9, TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2025-01-10', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (9, 4, 9, 8, TO_DATE('2025-01-18', 'YYYY-MM-DD'), NULL);
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (10, 6, 15, 2, TO_DATE('2025-02-05', 'YYYY-MM-DD'), TO_DATE('2025-04-01', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (11, 1, 13, 13, TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (12, 14, 5, 10, TO_DATE('2025-01-01', 'YYYY-MM-DD'), NULL);
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (13, 8, 11, 11, TO_DATE('2024-12-25', 'YYYY-MM-DD'), TO_DATE('2025-03-01', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (14, 12, 8, 14, TO_DATE('2025-02-10', 'YYYY-MM-DD'), TO_DATE('2025-04-20', 'YYYY-MM-DD'));
INSERT INTO FosterHomes (FosterID, AnimalID, VolunteerID, StockItemID, StartDate, EndDate) VALUES (15, 13, 3, 15, TO_DATE('2025-03-15', 'YYYY-MM-DD'), NULL);

INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (1, 3, 'Alice Tan', 'Cash', 200.00, TO_DATE('2024-06-01', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (2, 7, 'Benjamin Lee', 'In-kind', 1.00, TO_DATE('2024-06-02', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (3, 1, 'Catherine Ng', 'Cash', 150.50, TO_DATE('2024-06-03', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (4, 5, 'Darren Wong', 'In-kind', 1.00, TO_DATE('2024-06-04', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (5, 2, 'Emily Lim', 'Cash', 320.75, TO_DATE('2024-06-05', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (6, 10, 'Farah Hassan', 'In-kind', 1.00, TO_DATE('2024-06-06', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (7, 6, 'Goh Wei Ming', 'Cash', 90.00, TO_DATE('2024-06-07', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (8, 9, 'Hannah Teo', 'In-kind', 1.00, TO_DATE('2024-06-08', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (9, 4, 'Isaac Yeo', 'Cash', 110.10, TO_DATE('2024-06-09', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (10, 8, 'Jasmine Ong', 'In-kind', 1.00, TO_DATE('2024-06-10', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (11, 11, 'Kelvin Sim', 'Cash', 500.00, TO_DATE('2024-06-11', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (12, 12, 'Lim Mei Yee', 'In-kind', 1.00, TO_DATE('2024-06-12', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (13, 13, 'Muhammad Rizal', 'Cash', 45.25, TO_DATE('2024-06-13', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (14, 14, 'Natalie Chia', 'In-kind', 1.00, TO_DATE('2024-06-14', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (15, 15, 'Ong Chee Kiat', 'Cash', 275.00, TO_DATE('2024-06-15', 'YYYY-MM-DD'));
INSERT INTO Donations (DonationID, EventID, DonorName, DonationType, Amount, DonationDate) VALUES (16, 5, 'Brandon Sia', 'In-kind', 50.00, TO_DATE('2025-06-02', 'YYYY-MM-DD'));

INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (1, 4, 'Liam Tan', 'liam.tan@example.com', TO_DATE('2023-05-12', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (2, 1, 'Sophia Lim', 'sophia.lim@example.com', TO_DATE('2023-06-15', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (3, 9, 'Daniel Wong', 'daniel.wong@example.com', TO_DATE('2023-07-01', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (4, 5, 'Chloe Lee', 'chloe.lee@example.com', TO_DATE('2023-07-18', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (5, 10, 'Lucas Ng', 'lucas.ng@example.com', TO_DATE('2023-08-05', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (6, 8, 'Emily Tan', 'emily.tan@example.com', TO_DATE('2023-08-19', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (7, 6, 'Ethan Chua', 'ethan.chua@example.com', TO_DATE('2023-09-02', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (8, 12, 'Isabelle Chan', 'isabelle.chan@example.com', TO_DATE('2023-09-12', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (9, 7, 'Nathan Yeo', 'nathan.yeo@example.com', TO_DATE('2023-10-03', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (10, 3, 'Hannah Tay', 'hannah.tay@example.com', TO_DATE('2023-10-21', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (11, 11, 'Aiden Goh', 'aiden.goh@example.com', TO_DATE('2023-11-09', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (12, 14, 'Zoe Teo', 'zoe.teo@example.com', TO_DATE('2023-11-20', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (13, 13, 'Ryan Sim', 'ryan.sim@example.com', TO_DATE('2023-12-01', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (14, 15, 'Grace Tan', 'grace.tan@example.com', TO_DATE('2023-12-14', 'YYYY-MM-DD'));
INSERT INTO Adoptions (AdoptionID, AnimalID, AdopterName, Contact, AdoptionDate) VALUES (15, 2, 'Caleb Ong', 'caleb.ong@example.com', TO_DATE('2024-01-03', 'YYYY-MM-DD'));


--Question 3 
--3(a)
-- Display all the animals along with their behavior report details (Behavior Report ID and Training Status). Animals without behavior reports must also be included.
SELECT a.AnimalID AS "Animal ID", a.Age AS "Age", br.BehaviourID AS "Behaviour Report ID", br.TrainingStatus AS "Animal Training Status"
FROM Animals a
LEFT JOIN BehaviourReports br ON a.AnimalID = br.AnimalID
ORDER BY a.AnimalID;

--3(b)
--For each adoption event, display the event name, the total amount of donation received in the event, the number of volunteers assigned to the event, and a combined list of volunteer names in that event.
SELECT ae.Name AS "Event Name", SUM(d.Amount) AS "Event Total Donation", COUNT(ea.VolunteerID) AS "Total Number of Volunteers", LISTAGG(v.Name, ' & ') WITHIN GROUP (ORDER BY v.Name) AS "Volunteer Names"
FROM AdoptionEvents ae
JOIN Donations d ON ae.EventID = d.EventID
JOIN EventAssignments ea ON ae.EventID = ea.EventID
JOIN Volunteers v ON ea.VolunteerID = v.VolunteerID
GROUP BY ae.Name
ORDER BY "Event Total Donation";

--3(c)
-- Display the donations made by donors whose names start with 'B' and show how many months ago each donation was made.
SELECT DonorName AS "Donor Name", DonationDate AS "Date of Donation", ROUND(MONTHS_BETWEEN(SYSDATE,DonationDate)) AS "Months Since Donation Occured"
FROM Donations
WHERE DonorName LIKE 'B%'
ORDER BY "Months Since Donation Occured";

--3(d)
-- List all the medical records of animals where either the immunization status or deworming status is 'Yes', and the overall health rating is 'Excellent'.
SELECT AnimalID AS "Animal ID", ImmunizationStatus AS "Immunization Status", DewormingStatus AS "Deworming Status", HealthRating AS "Overall Health Rating"
FROM MedicalRecords
WHERE (ImmunizationStatus = 'Yes' OR DewormingStatus = 'Yes') AND HealthRating = 'Excellent';

--3(e)
-- Display each animal's ID, species and age, along with its health rating from the medical record and its training status from the behavior report. 
-- Only include animals whose age is greater than the average age of all animals.
SELECT a.AnimalID AS "Animal ID", a.Age AS "Age", a.Species AS "Species",
       (SELECT md.HealthRating 
        FROM MedicalRecords md 
        WHERE md.AnimalID = a.AnimalID) AS "Health Rating",
       (SELECT br.TrainingStatus 
        FROM BehaviourReports br 
        WHERE br.AnimalID = a.AnimalID) AS "Training Status"
FROM Animals a
WHERE a.Age > (SELECT AVG(Age) FROM Animals);

--3(f)
-- List the animals that have been in the sanctuary for over a year and have received the most positive health check ratings for health studies.
-- List the animals that have a intake date of more than one year and have an 'Excellent' health rating from their medical records, order by the latest intake date
SELECT a.AnimalID AS "Animal ID", a.Species AS "Species", a.IntakeDate AS "Intake Date", ROUND(MONTHS_BETWEEN(SYSDATE, a.IntakeDate)) AS "Months Since in Sanctuary", md.HealthRating AS "Health Rating"
FROM Animals a
JOIN MedicalRecords md ON a.AnimalID = md.AnimalID
WHERE MONTHS_BETWEEN(SYSDATE, a.IntakeDate) > 12 AND md.HealthRating = 'Excellent'
ORDER BY a.IntakeDate DESC;

/*
Justification for Question 3 (a-f)
Question 3(a)
The query displays all animal's animal id and animal age, with their behaviour report
This includes displaying animals that don't have behaviour reports
LEFT JOIN acts as the outer join, hence ensuring all animals appear even if they don't have a behaviour report
There will be 4 columns returned
ORDER BY animal id organizes the output for clarity

Question 3(b)
The query summarizes adoption event details
It shows the event name, sum of total donations, count number of volunteers and concatenate the list of name of volunteers
SUM is used for calculating total donations
COUNT is used for counting volunteers assigned
LISTAGG concatenates the volunteer names into a single string
GROUP BY ensures the grouping is by event

Question 3(c)
The query displays donations from donors whose name starts with 'B' and calculates how many months ago the donation occured
LIKE '%B' filters donor's name starting with 'B'
MONTHS_BETWEEN calculates the months between the months since donation from now SYSDATE
ROUND rounds the months to whole months

Question 3(d)
The query displays the medical records for animals that are either (immunized OR dewormed) AND have an overall health rating of Excellent
The bracket is used to check the immunized OR dewormed status 
AND ensures best health condition

Question 3(e)
The query lists animals whose age is greater than average age of all animals, including their health rating and training status with the use to subqueries
Two subqueries is used to get HealthRating from MedicalRecords and TrainingStatus from BehaviourRecords for each animals
One subquery for getting animal's age greater than average age of all animals

Questions 3(f)
The query lists the animals that have a intake date of more than one year and have an 'Excellent' health rating from their medical records
MONTHS_BETWEEN calculates the months between the months since intake date to SYSDATE, > 12 checks for sanctuary being more than 1 year
AND md.HealthRating = 'Excellent' filters animals in excellent health
ROUND is used for readability in the displayed table
ORDER BY the latest intake date for clarity
*/
