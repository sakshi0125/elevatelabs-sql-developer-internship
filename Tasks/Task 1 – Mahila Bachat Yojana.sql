create database MahilaBachatDB;
use MahilaBachatDB;
-- 1. Groups Table
CREATE TABLE MahilaGroups (
    GroupID INT AUTO_INCREMENT PRIMARY KEY,
    GroupName VARCHAR(100),
    FormationDate DATE,
    Location VARCHAR(100)
);

-- 2. Members Table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Phone VARCHAR(15),
    GroupID INT,
    JoinDate DATE,
    FOREIGN KEY (GroupID) REFERENCES MahilaGroups(GroupID)
);

-- 3. Savings Table
CREATE TABLE Savings (
    SavingID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    Month VARCHAR(20),
    Amount DECIMAL(10,2),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- 4. Loans Table
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    LoanAmount DECIMAL(10,2),
    IssueDate DATE,
    RepaymentDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- 5. Staff Table
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    AssignedGroupID INT,
    FOREIGN KEY (AssignedGroupID) REFERENCES MahilaGroups(GroupID)
);
select * from staff;