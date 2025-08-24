-- Use the database
use MahilaBachatDB;

-- INSERT INTO MahilaGroups table
INSERT INTO MahilaGroups (GroupName, FormationDate, Location) VALUES
('Shakti Group', '2021-04-10', 'Pune'),
('Ujjwala Mahila Mandal', '2022-01-15', 'Nagpur'),
('Jyoti SHG', '2020-07-05', 'Nashik');

-- INSERT INTO Members table
INSERT INTO Members (Name, Age, Phone, GroupID, JoinDate) VALUES
('Sunita Patil', 35, '9876543210', 1, '2021-05-01'),
('Meena Desai', 29, '9922334455', 1, '2021-06-15'),
('Radha More', NULL, NULL, 2, '2022-02-10'),  -- NULL for missing age and phone
('Komal Pawar', 30, '9988776655', 3, '2020-08-01');

-- INSERT INTO Savings table
INSERT INTO Savings (MemberID, Month, Amount) VALUES
(1, 'January', 500.00),
(2, 'January', 500.00),
(3, 'February', NULL), -- NULL for missed payment
(4, 'January', 600.00);

-- INSERT INTO Loans table
INSERT INTO Loans (MemberID, LoanAmount, IssueDate, RepaymentDate, Status) VALUES
(1, 2000.00, '2023-01-01', '2023-06-01', 'Paid'),
(2, 1500.00, '2023-02-10', '2023-07-10', 'Unpaid'),
(4, 3000.00, '2023-03-15', '2023-09-15', 'Pending');

-- INSERT INTO Staff table
INSERT INTO Staff (Name, Role, AssignedGroupID) VALUES
('Asha Kulkarni', 'Field Officer', 1),
('Rita Shinde', 'Coordinator', 2);

-- UPDATE example
-- Update Radha's age and phone (previously NULL)
set sql_safe_updates=0;
UPDATE Members
SET Age = 31, Phone = '9001122334'
WHERE Name = 'Radha More';

-- DELETE example
-- Delete savings record where amount is NULL (i.e., missed deposit)
DELETE FROM Savings
WHERE Amount IS NULL;

-- INSERT with partial columns (Phone is optional)
INSERT INTO Members (Name, Age, GroupID, JoinDate) VALUES
('Lata Kadam', 28, 2, '2023-01-05');  -- Phone not provided

-- Insert using SELECT
-- Copy a member's info into a new record (as if they rejoined)
INSERT INTO Members (Name, Age, Phone, GroupID, JoinDate)
SELECT Name, Age, Phone, GroupID, '2024-01-01' FROM Members WHERE MemberID = 1;

