----------------   CAREERHUB, THE JOB BOARD-------------------

--1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”. 
CREATE DATABASE IF NOT EXISTS CAREERHUB;
USE CAREERHUB;

--2. Create tables for Companies, Jobs, Applicants and Applications.  
--3. Define appropriate primary keys, foreign keys, and constraints.  
--4. Ensure the script handles potential errors, such as if the database or tables already exist. 
CREATE TABLE IF NOT EXISTS Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(255),
    Location VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Jobs (
    JobID INT PRIMARY KEY,
    CompanyID INT,
    JobTitle VARCHAR(255),
    JobDescription TEXT,
    JobLocation VARCHAR(255),
    Salary DECIMAL(10, 2),
    JobType VARCHAR(50),
    PostedDate DATETIME,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE IF NOT EXISTS Applicants (
    ApplicantID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Resume TEXT
);

CREATE TABLE  IF NOT EXISTS Applications (
    ApplicationID INT PRIMARY KEY,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME,
    CoverLetter TEXT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);
-- Inserting sample data into Companies table
INSERT INTO Companies (CompanyID, CompanyName, Location) VALUES
(1, 'ABC Ltd', 'Hyderabad'),
(2, 'XYZ Ltd', 'Bangalore'),
(3, 'MNO Ltd', 'Chennai'),
(4, 'DEV Ltd', 'Hyderabad');

-- Inserting sample data into Jobs table
INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1, 1, 'Software Developer', 'Developing software applications', 'Hyderabad', 80000.00, 'Full-time', '2024-03-08 09:00:00'),
(2, 2, 'Data Analyst', 'Analyzing data and generating reports', 'Bangalore', 70000.00, 'Part-time', '2024-03-07 12:30:00'),
(3, 3, 'Network Engineer', 'Designing and implementing network solutions', 'Chennai', 90000.00, 'Contract', '2024-03-06 15:45:00'),
(4, 4, 'UX/UI Designer', 'Creating user-friendly interfaces', 'Hyderabad', 75000.00, 'Full-time', '2024-03-05 10:00:00');

-- Inserting sample data into Applicants table
INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume) VALUES
(1, 'roronoa', 'zoro', 'onepiece@email.com', '123-456-7890', 'Resume 1'),
(2, 'luffy', 'monkey d', 'isreal@email.com', '987-654-3210', 'Resume 2'),
(3, 'Sanji', 'Usopp', 'Easternblue@email.com', '555-123-4567', 'Resume 3'),
(4, 'Nami', 'Brook', '5thgear@email.com', '777-888-9999', 'Resume 4');

-- Inserting sample data into Applications table
INSERT INTO Applications (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(1, 1, 1, '2024-03-09 10:15:00', 'Cover letter for Software Developer'),
(2, 2, 1, '2024-03-08 11:30:00', 'Cover letter for Data Analyst'),
(3, 3, 2, '2024-03-07 14:45:00', 'Cover letter for Network Engineer'),
(4, 4, 3, '2024-03-06 09:30:00', 'Cover letter for UX/UI Designer');
INSERT INTO Applications (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(5, 2, 1, '2024-03-09 10:15:00', 'Cover letter for Software Developer'),
(6, 3, 1, '2024-03-08 11:30:00', 'Cover letter for Data Analyst'),
(7, 4, 2, '2024-03-07 14:45:00', 'Cover letter for Network Engineer'),
(8, 4, 3, '2024-03-06 09:30:00', 'Cover letter for UX/UI Designer');


--5. Write an SQL query to count the number of applications received for each job listing in the "Jobs" table. 
--Display the job title and the corresponding application count. Ensure that it lists all jobs, even if they have no applications. 
SELECT J.JobTitle, COUNT(APS.ApplicantID) AS COUNTOFAPPLICATIONS
FROM APPLICATIONS APS
RIGHT JOIN JOBS J ON J.JobID = APS.JobID
GROUP BY J.JobTitle;

--6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary range. Allow parameters for the minimum and maximum salary values. 
--Display the job title, company name, location, and salary for each matching job. 
SELECT J.JOBTITLE, C.COMPANYNAME , C.LOCATION, J.Salary  FROM JOBS J
JOIN Companies C ON C.CompanyID = J.CompanyID
WHERE Salary BETWEEN 75000 AND 90000;

--7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a 
--parameter for the ApplicantID, and return a result set with the job titles, company names, and 
--application dates for all the jobs the applicant has applied to. 
SELECT Jobs.JobTitle, Companies.CompanyName, Applications.ApplicationDate
FROM Applications
JOIN Jobs ON Applications.JobID = Jobs.JobID
JOIN Companies ON Jobs.CompanyID = Companies.CompanyID
WHERE Applications.ApplicantID = 1;--HERE APPLICANT ID IS VARIABLE

--8. Create an SQL query that calculates and displays the average salary offered by all companies for 
--	job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero. 
SELECT AVG(Salary) AS AverageSalary
FROM Jobs
WHERE Salary > 0;


--9. Write an SQL query to identify the company that has posted the most job listings. Display the 
--company name along with the count of job listings they have posted. Handle ties if multiple 
--companies have the same maximum count. 
SELECT C.COMPANYNAME, COUNT(APS.JOBID) AS COUNTOFLISTINGS
FROM JOBS J
JOIN COMPANIES C ON C.CompanyID = J.CompanyID
JOIN Applications APS ON APS.JobID = J.JobID
GROUP BY C.CompanyName
ORDER BY COUNTOFLISTINGS DESC;

--10. Find the applicants who have applied for positions in companies located in 'CityX' and have at 
--least 3 years of experience. 
SELECT Applicants.*
FROM Applicants
JOIN Applications ON Applicants.ApplicantID = Applications.ApplicantID
JOIN Jobs ON Applications.JobID = Jobs.JobID
JOIN Companies ON Jobs.CompanyID = Companies.CompanyID
WHERE Companies.Location = 'Hyderabad' AND
   APPLICANTS.EXPERIENCE >= 3

--11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000. 
SELECT DISTINCT(JOBTITLE), SALARY  FROM Jobs
WHERE SALARY BETWEEN 60000 AND 80000;

--ADDING MORE VALUES TO CREATE A JOB WITH NO APPLICATIONS
INSERT INTO Companies (CompanyID, CompanyName, Location) VALUES
(6, 'ABC Ltd', 'Hyderabad')

INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(5, 6, 'NlockChain Developer', 'Developing Blockchain applications', 'Delhi', 75500.00, 'Part-time', '2024-02-07 09:00:00');

--12. Find the jobs that have not received any applications. 
SELECT Jobs.JobID, Jobs.JobTitle
FROM Jobs
LEFT JOIN Applications ON Jobs.JobID = Applications.JobID
WHERE Applications.JobID IS NULL;

--13. Retrieve a list of job applicants along with the companies they have applied to and the positions 
--they have applied for. 

SELECT DISTINCT APP.FIRSTNAME, APP.LASTNAME, C.COMPANYNAME, J.JOBTITLE , APP.ApplicantID FROM Applicants APP
LEFT JOIN Applications APS ON APP.ApplicantID = APS.ApplicantID
LEFT JOIN JOBS J ON J.JobID = APS.JobID
LEFT JOIN Companies C ON C.CompanyID = J.CompanyID

--14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not 
--received any applications

SELECT Companies.CompanyID, Companies.CompanyName , COUNT(Jobs.JobID) AS JobCount
FROM Companies
LEFT JOIN Jobs ON Companies.CompanyID = Jobs.CompanyID
LEFT JOIN Applications ON Jobs.JobID = Applications.JobID
GROUP BY Companies.CompanyID,Companies.CompanyName

--15. List all applicants along with the companies and positions they have applied for, including those 
--who have not applied. 

SELECT Applicants.FirstName , Applicants.LastName , Companies.CompanyName , JobS.JobTitle FROM Applicants
LEFT JOIN Applications ON Applicants.ApplicantID = Applications.ApplicantID
LEFT JOIN JOBS ON JOBS.JobID = Applications.JobID
LEFT JOIN Companies ON Companies.CompanyID = Jobs.JobID

--16. Find companies that have posted jobs with a salary higher than the average salary of all jobs. 
SELECT Companies.CompanyName
FROM Companies
JOIN Jobs ON Companies.CompanyID = Jobs.CompanyID
WHERE Jobs.Salary > (SELECT AVG(Salary) FROM Jobs);

--17. Display a list of applicants with their names and a concatenated string of their city and state. 
SELECT Applicants.FirstName, Applicants.LastName, CONCAT(Companies.Location, ', ', Companies.STATE) AS Location
FROM Applicants
INNER JOIN Applications ON Applicants.ApplicantID = Applications.ApplicantID
INNER JOIN Jobs ON Applications.JobID = Jobs.JobID
INNER JOIN Companies ON Jobs.CompanyID = Companies.CompanyID;

--18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'. 

SELECT JobTitle FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR  JobTitle LIKE '%Engineer%'

--19. Retrieve a list of applicants and the jobs they have applied for, including those who have not 
--applied and jobs without applicants. 

SELECT Applicants.FirstName, Applicants.LastName, Companies.CompanyName, Jobs.JobTitle
FROM Applicants
CROSS JOIN Companies
RIGHT JOIN Applications ON Applicants.ApplicantID = Applications.ApplicantID
RIGHT JOIN Jobs ON Applications.JobID = Jobs.JobID
AND Jobs.CompanyID = Companies.CompanyID;

--20. List all combinations of applicants and companies where the company is in a specific city and the 
--applicant has more than 2 years of experience. For example: city=Chennai 
SELECT DISTINCT Applicants.FirstName, Applicants.LastName, Companies.CompanyName
FROM Applicants
CROSS JOIN Companies
LEFT JOIN Applications ON Applicants.ApplicantID = Applications.ApplicantID
LEFT JOIN Jobs ON Applications.JobID = Jobs.JobID
AND Jobs.CompanyID = Companies.CompanyID
WHERE Companies.Location = 'Chennai' AND Applicants.EXPERIENCE >= 2