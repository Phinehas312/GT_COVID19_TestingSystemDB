-- Phase II Create Table and Insert Statements

-- CREATE TABLE STATEMENTS BELOW
DROP DATABASE IF EXISTS GT_COVID_19_Testing;
CREATE DATABASE IF NOT EXISTS GT_COVID_19_Testing;
USE GT_COVID_19_Testing;

CREATE TABLE Users(
	username varchar(40) not null,
    firstName varchar(40) not null,
    lastName varchar(40) not null,
    email varchar(25) not null,
    userPassword varchar(25) not null,
    primary key (username),
    unique key (firstName, lastName),
    constraint checkPassword check (length(userPassword) >= 8),
    constraint checkEmail check (length(email) >= 5)
)ENGINE=InnoDB;

INSERT INTO Users VALUES  ('jlionel666',  'John',  'Lionel',  'jlionel666@gatech.edu',  'password1'),('mmoss7',  'Mark',  'Moss',  'mmoss7@gatech.edu',  'password2'),
('lchen27',  'Liang',  'Chen',  'lchen27@gatech.edu',  'password3'),('jhilborn97',  'Jack',  'Hilborn',  'jhilborn97@gatech.edu',  'password4'),
('jhilborn98',  'Jake',  'Hilborn',  'jhilborn98@gatech.edu',  'password5'),('ygao10',  'Yuan',  'Gao',  'ygao10@gatech.edu',  'password6'),
('jthomas520',  'James',  'Thomas',  'jthomas520@gatech.edu',  'password7'),('cforte58',  'Connor',  'Forte',  'cforte58@gatech.edu',  'password8'),
('fdavenport49',  'Felicia',  'Devenport',  'fdavenport49@gatech.edu',  'password9'),('hliu88',  'Hang',  'Liu',  'hliu88@gatech.edu',  'password10'),
('akarev16',  'Alex',  'Karev',  'akarev16@gatech.edu',  'password11'),('jdoe381',  'Jane ',  'Doe',  'jdoe381@gatech.edu',  'password12'),
('sstrange11',  'Stephen',  'Strange',  'sstrange11@gatech.edu',  'password13'),('dmcstuffins7',  'Doc',  'Mcstuffins',  'dmcstuffins7@gatech.edu',  'password14'),
('mgrey91',  'Meredith',  'Grey',  'mgrey91@gatech.edu',  'password15'),('pwallace51',  'Penny',  'Wallace',  'pwallace51@gatech.edu',  'password16'),
('jrosario34',  'Jon',  'Rosario',  'jrosario34@gatech.edu',  'password17'),('nshea230',  'Nicholas',  'Shea',  'nshea230@gatech.edu',  'password18'),
('mgeller3',  'Monica ',  'Geller',  'mgeller3@gatech.edu',  'password19'),('rgeller9',  'Ross',  'Geller ',  'rgeller9@gatech.edu',  'password20'),
('jtribbiani27',  'Joey ',  'Tribbiani',  'jtribbiani27@gatech.edu',  'password21'),('pbuffay56',  'Phoebe ',  'Buffay',  'pbuffay56@gatech.edu',  'password22'),
('rgreen97',  'Rachel',  'Green',  'rgreen97@gatech.edu',  'password23'),('cbing101',  'Chandler ',  'Bing',  'cbing101@gatech.edu',  'password24'),
('pbeesly61',  'Pamela',  'Beesly',  'pbeesly61@gatech.edu',  'password25'),('jhalpert75',  'Jim ',  'Halpert',  'jhalpert75@gatech.edu',  'password26'),
('dschrute18',  'Dwight ',  'Schrute',  'dschrute18@gatech.edu',  'password27'),('amartin365',  'Angela ',  'Martin',  'amartin365@gatech.edu',  'password28'),
('omartinez13',  'Oscar',  'Martinez',  'omartinez13@gatech.edu',  'password29'),('mscott845',  'Michael ',  'Scott',  'mscott845@gatech.edu',  'password30'),
('abernard224',  'Andy ',  'Bernard',  'abernard224@gatech.edu',  'password31'),('kkapoor155',  'Kelly ',  'Kapoor',  'kkapoor155@gatech.edu',  'password32'),
('dphilbin81',  'Darryl ',  'Philbin',  'dphilbin81@gatech.edu',  'password33'),('sthefirst1',  'Sofia',  'Thefirst',  'sthefirst1@gatech.edu',  'password34'),
('gburdell1',  'George',  'Burdell',  'gburdell1@gatech.edu',  'password35'),('dsmith102',  'Dani',  'Smith',  'dsmith102@gatech.edu',  'password36'),
('dbrown85',  'David',  'Brown',  'dbrown85@gatech.edu',  'password37'),('dkim99',  'Dave',  'Kim',  'dkim99@gatech.edu',  'password38'),
('tlee984',  'Tom',  'Lee',  'tlee984@gatech.edu',  'password39'),('jpark29',  'Jerry',  'Park',  'jpark29@gatech.edu',  'password40'),
('vneal101',  'Vinay',  'Neal',  'vneal101@gatech.edu',  'password41'),('hpeterson55',  'Haydn',  'Peterson',  'hpeterson55@gatech.edu',  'password42'),
('lpiper20',  'Leroy',  'Piper',  'lpiper20@gatech.edu',  'password43'),('mbob2',  'Mary',  'Bob',  'mbob2@gatech.edu',  'password44'),
('mrees785',  'Marie',  'Rees',  'mrees785@gatech.edu',  'password45'),('wbryant23',  'William',  'Bryant',  'wbryant23@gatech.edu',  'password46'),
('aallman302',  'Aiysha',  'Allman',  'aallman302@gatech.edu',  'password47'),('kweston85',  'Kyle',  'Weston',  'kweston85@gatech.edu',  'password48');

CREATE TABLE Pool(
	poolID int(2) not null,
    poolStatus varchar(8),
    PRIMARY KEY(poolID)
)ENGINE=InnoDB;

INSERT INTO Pool VALUES (1, 'Negative'), (2, 'Positive'), (3, 'Positive'), (4, 'Positive'), (5, 'Negative'), (6, 'Positive'), (7,'Negative'), (8,'Positive'), (9,'Pending'), (10,'Pending'), (11,'Pending'), (12,'Pending'), (13,'Pending');

CREATE TABLE Location(
	 locationName char(4),
     primary key(locationName)
)ENGINE=InnoDB;

INSERT INTO Location VALUES ('East'), ('West');

CREATE TABLE Site(
	siteName varchar(120) not null,
    street varchar(45) not null,
    city varchar(20) not null,
    state char(2) not null,
    Zip char(5) not null,
    locationName char(4) not null,
    primary key(siteName),
    constraint location_siteName foreign key (locationName) 
    references Location(locationName)
)ENGINE=InnoDB;

INSERT INTO Site VALUES 
('Fulton County Board of Health',  '10 Park Place South SE', 'Atlanta',  'GA',  30303,  'East'),
('CCBOH WIC Clinic',  '1895 Phoenix Blvd', 'College Park',  'GA',  30339,  'West'),
('Kennesaw State University ',  '3305 Busbee Drive NW', 'Kennesaw',  'GA',  30144,  'West'),
('Stamps Health Services',  '740 Ferst Drive ', 'Atlanta',  'GA',  30332,  'West'),
('Bobby Dodd Stadium',  '150 Bobby Dodd Way NW', 'Atlanta',  'GA',  30332,  'East'),
('Caddell Building',  '280 Ferst Drive NW', 'Atlanta',  'GA',  30332,  'West'),
('Coda Building',  '760 Spring Street ', 'Atlanta',  'GA',  30332,  'East'),
('GT Catholic Center',  '172 4th St NW', 'Atlanta',  'GA',  30313,  'East'),
('West Village',  '532 8th St NW', 'Atlanta',  'GA',  30318,  'West'),
('GT Connector',  '116 Bobby Dodd Way NW', 'Atlanta',  'GA',  30313,  'East'),
('Curran St Parking Deck',  '564 8th St NW', 'Atlanta',  'GA',  30318,  'West'),
('North Avenue (Centenial Room)',  '120 North Avenue NW', 'Atlanta',  'GA',  30313,  'East');

CREATE TABLE Student(
	username varchar(40) not null,
    housing_type varchar(21) not null,
    locationName char(4) not null,
    primary key (username),
    constraint student_username foreign key (username)
    references Users(username),
    constraint location_name foreign key (locationName)
    references Location(locationName)
)ENGINE=InnoDB;

INSERT INTO Student VALUES  ('mgeller3',  'Off-campus Apartment',  'East'),('rgeller9',  'Student Housing',  'East'),('jtribbiani27',  'Greek Housing',  'West'),('pbuffay56',  'Student Housing',  'East'),('rgreen97',  'Student Housing',  'West'),('cbing101',  'Greek Housing',  'East'),('pbeesly61',  'Student Housing',  'West'),('jhalpert75',  'Student Housing',  'East'),('dschrute18',  'Student Housing',  'East'),('amartin365',  'Greek Housing',  'East'),('omartinez13',  'Student Housing',  'West'),('mscott845',  'Student Housing',  'East'),('abernard224',  'Greek Housing',  'West'),('kkapoor155',  'Greek Housing',  'East'),('dphilbin81',  'Greek Housing',  'West'),('sthefirst1',  'Student Housing',  'West'),('gburdell1',  'Student Housing',  'East'),('dsmith102',  'Greek Housing',  'West'),('dbrown85',  'Off-campus Apartment',  'East'),('dkim99',  'Greek Housing',  'East'),('tlee984',  'Student Housing',  'West'),('jpark29',  'Student Housing',  'East'),('vneal101',  'Student Housing',  'West'),('hpeterson55',  'Greek Housing',  'East'),('lpiper20',  'Student Housing',  'West'),('mbob2',  'Student Housing',  'West'),('mrees785',  'Off-campus House',  'West'),('wbryant23',  'Greek Housing',  'East'),('aallman302',  'Student Housing',  'West'),('kweston85',  'Greek Housing',  'West')  ;

CREATE TABLE Appointment(
	siteName varchar(120) not null,
    apptDate date not null,
    apptTime time(5) not null,
    username varchar(40),
    primary key(siteName, apptDate, apptTime),
    constraint siteName foreign key (siteName) 
    references Site(siteName),
    constraint student_schedules foreign key (username) 
    references Student(username)    
)ENGINE=InnoDB;

INSERT INTO Appointment VALUES
('Fulton County Board of Health',  '2020-09-01',  '8:00',  'mgeller3'),
('Bobby Dodd Stadium',  '2020-09-01',  '9:00',  'rgeller9'),
('Caddell Building',  '2020-09-01',  '10:00',  'jtribbiani27'),
('GT Catholic Center',  '2020-09-01',  '11:00',  'pbuffay56'),
('West Village',  '2020-09-01',  '12:00',  'rgreen97'),
('GT Catholic Center',  '2020-09-01',  '13:00',  'cbing101'),
('West Village',  '2020-09-01',  '14:00',  'pbeesly61'),
('North Avenue (Centenial Room)',  '2020-09-01',  '15:00',  'jhalpert75'),
('North Avenue (Centenial Room)',  '2020-09-01',  '16:00',  'dschrute18'),
('Curran St Parking Deck',  '2020-09-03',  '8:00',  'omartinez13'),
('Bobby Dodd Stadium',  '2020-09-03',  '9:00',  'mscott845'),
('Stamps Health Services',  '2020-09-03',  '10:00',  'abernard224'),
('GT Catholic Center',  '2020-09-03',  '11:00',  'kkapoor155'),
('West Village',  '2020-09-03',  '12:00',  'dphilbin81'),
('Caddell Building',  '2020-09-03',  '13:00',  'sthefirst1'),
('Coda Building',  '2020-09-03',  '14:00',  'gburdell1'),
('Stamps Health Services',  '2020-09-03',  '15:00',  'dsmith102'),
('CCBOH WIC Clinic',  '2020-09-03',  '16:00',  'dbrown85'),
('GT Connector',  '2020-09-03',  '17:00',  'dkim99'),
('Curran St Parking Deck',  '2020-09-04',  '8:00',  'tlee984'),
('GT Connector',  '2020-09-04',  '9:00',  'jpark29'),
('Curran St Parking Deck',  '2020-09-04',  '10:00',  'vneal101'),
('Bobby Dodd Stadium',  '2020-09-04',  '11:00',  'hpeterson55'),
('Caddell Building',  '2020-09-04',  '12:00',  'lpiper20'),
('Stamps Health Services',  '2020-09-04',  '13:00',  'mbob2'),
('Kennesaw State University ',  '2020-09-04',  '14:00',  'mrees785'),
('GT Catholic Center',  '2020-09-04',  '15:00',  'wbryant23'),
('West Village',  '2020-09-04',  '16:00',  'aallman302'),
('West Village',  '2020-09-04',  '17:00',  'kweston85'),
('Fulton County Board of Health',  '2020-09-04',  '8:00',  'mgeller3'),
('Bobby Dodd Stadium',  '2020-09-04',  '9:00',  'rgeller9'),
('Caddell Building',  '2020-09-04',  '10:00',  'jtribbiani27'),
('Bobby Dodd Stadium',  '2020-09-10',  '11:00',  'pbuffay56'),
('Caddell Building',  '2020-09-10',  '12:00',  'rgreen97'),
('GT Catholic Center',  '2020-09-10',  '13:00',  'cbing101'),
('West Village',  '2020-09-10',  '14:00',  'pbeesly61'),
('Coda Building',  '2020-09-10',  '15:00',  'jhalpert75'),
('Coda Building',  '2020-09-10',  '16:00',  'dschrute18'),
('Coda Building',  '2020-09-10',  '17:00',  'amartin365'),
('Stamps Health Services',  '2020-09-10',  '8:00',  'omartinez13'),
('Bobby Dodd Stadium',  '2020-09-10',  '9:00',  'mscott845'),
('West Village',  '2020-09-10',  '10:00',  'abernard224'),
('GT Connector',  '2020-09-10',  '11:00',  'kkapoor155'),
('Curran St Parking Deck',  '2020-09-10',  '12:00',  'dphilbin81'),
('Curran St Parking Deck',  '2020-09-10',  '13:00',  'sthefirst1'),
('North Avenue (Centenial Room)',  '2020-09-10',  '14:00',  'gburdell1'),
('Caddell Building',  '2020-09-10',  '15:00',  'dsmith102'),
('CCBOH WIC Clinic',  '2020-09-10',  '16:00',  'dbrown85'),
('Bobby Dodd Stadium',  '2020-09-10',  '17:00',  'dkim99'),
('West Village',  '2020-09-10',  '8:00',  'tlee984'),
('GT Catholic Center',  '2020-09-10',  '9:00',  'jpark29'),
('Curran St Parking Deck',  '2020-09-13',  '10:00',  'vneal101'),
('Coda Building',  '2020-09-13',  '11:00',  'hpeterson55'),
('Stamps Health Services',  '2020-09-13',  '12:00',  'lpiper20'),
('Curran St Parking Deck',  '2020-09-13',  '13:00',  'mbob2'),
('CCBOH WIC Clinic',  '2020-09-13',  '14:00',  'mrees785'),
('North Avenue (Centenial Room)',  '2020-09-16',  '15:00',  'wbryant23'),
('West Village',  '2020-09-16',  '16:00',  'aallman302'),
('Caddell Building',  '2020-09-16',  '17:00',  'kweston85'),
('Fulton County Board of Health',  '2020-09-16',  '8:00',  NULL),
('CCBOH WIC Clinic',  '2020-09-16',  '9:00',  NULL),
('Kennesaw State University ',  '2020-09-16',  '10:00',  NULL),
('Stamps Health Services',  '2020-09-16',  '11:00',  NULL),
('Bobby Dodd Stadium',  '2020-09-16',  '12:00',  NULL),
('Caddell Building',  '2020-09-16',  '13:00',  NULL),
('Coda Building',  '2020-09-16',  '14:00',  NULL),
('GT Catholic Center',  '2020-09-16',  '15:00',  NULL),
('GT Connector',  '2020-10-01',  '16:00',  NULL),
('Curran St Parking Deck',  '2020-10-01',  '17:00',  NULL),
('North Avenue (Centenial Room)',  '2020-10-01',  '8:00',  NULL),('Fulton County Board of Health',  '2020-10-01',  '9:00',  NULL),
('CCBOH WIC Clinic',  '2020-10-01',  '10:00',  NULL),('Kennesaw State University ',  '2020-10-01',  '11:00',  NULL),
('Stamps Health Services',  '2020-10-01',  '12:00',  NULL),('Bobby Dodd Stadium',  '2020-10-01',  '13:00',  NULL),
('Caddell Building',  '2020-10-02',  '14:00',  NULL),('Coda Building',  '2020-10-02',  '15:00',  NULL),
('GT Catholic Center',  '2020-10-02',  '16:00',  NULL),('West Village',  '2020-10-02',  '17:00',  NULL),
('GT Connector',  '2020-10-02',  '8:00',  NULL),('Curran St Parking Deck',  '2020-10-02',  '9:00',  NULL),
('North Avenue (Centenial Room)',  '2020-10-06',  '10:00',  NULL),('Fulton County Board of Health',  '2020-10-06',  '11:00',  NULL),
('CCBOH WIC Clinic',  '2020-10-06',  '12:00',  NULL),('Kennesaw State University ',  '2020-10-06',  '13:00',  NULL),
('Stamps Health Services',  '2020-10-06',  '14:00',  NULL),('Bobby Dodd Stadium',  '2020-10-07',  '15:00',  NULL),
('Caddell Building',  '2020-10-07',  '16:00',  NULL),('Coda Building',  '2020-10-07',  '17:00',  NULL),
('GT Catholic Center',  '2020-10-07',  '8:00',  NULL),('West Village',  '2020-10-07',  '9:00',  NULL),
('GT Connector',  '2020-10-07',  '10:00',  NULL),('Curran St Parking Deck',  '2020-10-07',  '11:00',  NULL),
('North Avenue (Centenial Room)',  '2020-10-07',  '12:00',  NULL);

CREATE TABLE Test(
	testID int(6) not null,
    testStatus varchar(10) not null,
    apptDate date not null,
    apptTime time(5) not null,
	siteName varchar(120) not null,
    poolID int(2) not null,
    PRIMARY KEY(testID, siteName, apptDate, apptTime),
    constraint pool_id foreign key (poolID) references Pool(poolID),
    constraint appointment_name foreign key (siteName, apptDate, apptTime) 
    references Appointment(siteName, apptDate, apptTime) 
)ENGINE=InnoDB;

INSERT INTO Test VALUES 
(100001,  'negative',  '2020-09-01',  '8:00',  'Fulton County Board of Health',  1),
(100002,  'negative',  '2020-09-01',  '9:00',  'Bobby Dodd Stadium',  1),
(100003,  'negative',  '2020-09-01',  '10:00',  'Caddell Building',  1),
(100004,  'negative',  '2020-09-01',  '11:00',  'GT Catholic Center',  1),
(100005,  'negative',  '2020-09-01',  '12:00',  'West Village',  1),
(100006,  'negative',  '2020-09-01',  '13:00',  'GT Catholic Center',  1),
(100007,  'negative',  '2020-09-01',  '14:00',  'West Village',  1),
(100008,  'negative',  '2020-09-01',  '15:00',  'North Avenue (Centenial Room)',  2),
(100009,  'positive',  '2020-09-01',  '16:00',  'North Avenue (Centenial Room)',  2),
(100011,  'negative',  '2020-09-03',  '8:00',  'Curran St Parking Deck',  2),
(100012,  'positive',  '2020-09-03',  '9:00',  'Bobby Dodd Stadium',  2),
(100013,  'positive',  '2020-09-03',  '10:00',  'Stamps Health Services',  2),
(100014,  'negative',  '2020-09-03',  '11:00',  'GT Catholic Center',  2),
(100015,  'negative',  '2020-09-03',  '12:00',  'West Village',  3),
(100016,  'positive',  '2020-09-03',  '13:00',  'Caddell Building',  3),
(100017,  'negative',  '2020-09-03',  '14:00',  'Coda Building',  3),
(100018,  'negative',  '2020-09-03',  '15:00',  'Stamps Health Services',  3),
(100019,  'positive',  '2020-09-03',  '16:00',  'CCBOH WIC Clinic',  3),
(100020,  'negative',  '2020-09-03',  '17:00',  'GT Connector',  4),
(100021,  'negative',  '2020-09-04',  '8:00',  'Curran St Parking Deck',  4),
(100022,  'negative',  '2020-09-04',  '9:00',  'GT Connector',  4),
(100023,  'negative',  '2020-09-04',  '10:00',  'Curran St Parking Deck',  4),
(100024,  'positive',  '2020-09-04',  '11:00',  'Bobby Dodd Stadium',  4),
(100025,  'negative',  '2020-09-04',  '12:00',  'Caddell Building',  5),
(100026,  'negative',  '2020-09-04',  '13:00',  'Stamps Health Services',  5),
(100027,  'negative',  '2020-09-04',  '14:00',  'Kennesaw State University ',  5),
(100028,  'negative',  '2020-09-04',  '15:00',  'GT Catholic Center',  5),
(100029,  'negative',  '2020-09-04',  '16:00',  'West Village',  5),
(100030,  'negative',  '2020-09-04',  '17:00',  'West Village',  5),
(100031,  'positive',  '2020-09-04',  '8:00',  'Fulton County Board of Health',  6),
(100032,  'positive',  '2020-09-04',  '9:00',  'Bobby Dodd Stadium',  6),
(100033,  'negative',  '2020-09-04',  '10:00',  'Caddell Building',  7),
(100034,  'negative',  '2020-09-10',  '11:00',  'Bobby Dodd Stadium',  7),
(100035,  'negative',  '2020-09-10',  '12:00',  'Caddell Building',  7),
(100036,  'negative',  '2020-09-10',  '13:00',  'GT Catholic Center',  7),
(100037,  'negative',  '2020-09-10',  '14:00',  'West Village',  7),
(100038,  'negative',  '2020-09-10',  '15:00',  'Coda Building',  7),
(100039,  'negative',  '2020-09-10',  '16:00',  'Coda Building',  8),
(100040,  'positive',  '2020-09-10',  '17:00',  'Coda Building',  8),
(100041,  'negative',  '2020-09-10',  '8:00',  'Stamps Health Services',  8),
(100042,  'pending',  '2020-09-10',  '9:00',  'Bobby Dodd Stadium',  9),
(100043,  'pending',  '2020-09-10',  '10:00',  'West Village',  9),
(100044,  'pending',  '2020-09-10',  '11:00',  'GT Connector',  9),
(100045,  'pending',  '2020-09-10',  '12:00',  'Curran St Parking Deck',  9),
(100046,  'pending',  '2020-09-10',  '13:00',  'Curran St Parking Deck',  9),
(100047,  'pending',  '2020-09-10',  '14:00',  'North Avenue (Centenial Room)',  9),
(100048,  'pending',  '2020-09-10',  '15:00',  'Caddell Building',  9),
(100049,  'pending',  '2020-09-10',  '16:00',  'CCBOH WIC Clinic',  10),
(100050,  'pending',  '2020-09-10',  '17:00',  'Bobby Dodd Stadium',  11),
(100051,  'pending',  '2020-09-10',  '8:00',  'West Village',  11),
(100052,  'pending',  '2020-09-10',  '9:00',  'GT Catholic Center',  11),
(100053,  'pending',  '2020-09-13',  '10:00',  'Curran St Parking Deck',  11),
(100054,  'pending',  '2020-09-13',  '11:00',  'Coda Building',  11),
(100055,  'pending',  '2020-09-13',  '12:00',  'Stamps Health Services',  12),
(100056,  'pending',  '2020-09-13',  '13:00',  'Curran St Parking Deck',  12),
(100057,  'pending',  '2020-09-13',  '14:00',  'CCBOH WIC Clinic',  12),
(100058,  'pending',  '2020-09-16',  '15:00',  'North Avenue (Centenial Room)',  12),
(100059,  'pending',  '2020-09-16',  '16:00',  'West Village',  13),
(100060,  'pending',  '2020-09-16',  '17:00',  'Caddell Building',  13);

CREATE TABLE Admins(
	username varchar(40) not null,
    primary key (username),
    constraint admin_Username foreign key (username)
    references Users(username)
)ENGINE=InnoDB;

CREATE TABLE Employee(
	username varchar(40) not null,
    phoneNum bigint(20) not null,
    primary key (username),
    constraint employee_EmpUsername foreign key (username)
    references Users(username)
)ENGINE=InnoDB;

INSERT INTO Employee VALUES ('jhilborn97', 4043802577), ('jhilborn98', 4042201897),('ygao10', 7703928765),('jthomas520', 7705678943),('cforte58',  4708623384),('fdavenport49',  7068201473),('hliu88',  4782809765),('akarev16', 9876543210),('jdoe381', 1237864230),('sstrange11', 6547891234),('dmcstuffins7', 1236549878),('mgrey91', 6458769523),('pwallace51', 3788612907),('jrosario34', 5926384247),('nshea230', 6979064501);


CREATE TABLE Lab_Technician(
	username varchar(40) not null,
    primary key (username),
    constraint employee_TechUsername foreign key (username)
    references Employee(username)
)ENGINE=InnoDB;

CREATE TABLE Site_Tester(
	username varchar(40) not null,
    primary key (username),
    constraint tester_username foreign key (username)
    references Employee(username)
)ENGINE=InnoDB;

INSERT INTO Site_Tester VALUES  ('akarev16'),('jdoe381'),('sstrange11'),('dmcstuffins7'),('mgrey91'),('pwallace51'),('jrosario34'),('nshea230')  ;


  CREATE TABLE Works_In(
  	siteName1 varchar(120),
	username varchar(40),
    primary key (username),
    constraint site_tester_username foreign key (username)
    references Site_Tester(username)
    )ENGINE=InnoDB;
    
INSERT INTO Works_In VALUES
('Fulton County Board of Health, CCBOH WIC Clinic, Kennesaw State University, Stamps Health Services',  'akarev16'),
('Curran St Parking Deck, North Avenue (Centenial Room), Fulton County Board of Health, CCBOH WIC Clinic',  'jdoe381'),
('Coda Building, GT Catholic Center, West Village, GT Connector, Curran St Parking Deck, North Avenue (Centenial Room)',  'sstrange11'),
('Bobby Dodd Stadium, Caddell Building, Coda Building, GT Catholic Center, West Village, GT Connector',  'dmcstuffins7'),
('Kennesaw State University, Stamps Health Services, Bobby Dodd Stadium, Caddell Building',  'mgrey91'),('Coda Building',  'pwallace51');

CREATE TABLE poolProcess(
	username varchar(40) not null,
    poolID int(2),
    processDate date, 
    primary key (username, poolID),
    constraint Technician_poolUsername foreign key (username)
    references Lab_Technician(username),
    constraint process_poolID foreign key (poolID)
    references Pool(poolID)
)ENGINE=InnoDB;

-- INSERT STATEMENTS BELOW

INSERT INTO Admins VALUES   ('jlionel666'),('mmoss7'),('lchen27') ;

INSERT INTO Lab_Technician VALUES ('jhilborn97'),('jhilborn98'),('ygao10'),('jthomas520'),('cforte58'),('fdavenport49'),('hliu88') ;

INSERT INTO poolProcess VALUES ('jhilborn97',  1,  '9/2/20'),
('jhilborn98',  2,  '2020-09-04'),('ygao10',  3,  '9/6/20'),
('jthomas520',  4,  '9/5/20'),('fdavenport49',  5,  '9/7/20'),
('hliu88',  6,  '9/5/20'),('cforte58',  7,  '9/11/20'),('ygao10',  8,  '9/11/20');

select * from works_in;
