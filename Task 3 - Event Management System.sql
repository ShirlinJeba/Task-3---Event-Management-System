CREATE database EMS;
Use EMS;

CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

CREATE TABLE Attendees (
    Attendee_Id INT PRIMARY KEY,
    Attendee_Name VARCHAR(100),
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100),
    Attendee_City VARCHAR(100)
);

CREATE TABLE Registrations (
    Registration_id INT PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount DECIMAL(10, 2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);
-- Insert table--

INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
(1, 'Tech Conference 2025', '2025-09-10', 'Chennai Convention Center', 'A national conference on emerging technologies.'),
(2, 'Startup Pitch Fest', '2025-10-05', 'Bangalore Startup Hub', 'Event for startup founders to pitch ideas to investors.'),
(3, 'AI Workshop', '2025-11-15', 'IIT Delhi', 'Hands-on workshop on AI and machine learning.'),
(4, 'Cybersecurity Summit', '2025-12-02', 'Mumbai Tech Park', 'National summit focusing on cybersecurity trends.');

INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
(101, 'Shirlin Joseph', '9790625079', 'shirlin@gmail.com', 'Chennai'),
(102, 'Rahul Dev', '9778899001', 'rahul.dev@gmail.com', 'Bangalore'),
(103, 'Meera S', '9790012345', 'meera.s@gmail.com', 'Hyderabad'),
(104, 'Dinesh K', '9791115022', 'dinesh.k@gmail.com', 'Delhi'),
(105, 'Ancy Mathew', '9790655579', 'ancy.m@gmail.com', 'Mumbai');

INSERT INTO Registrations (Registration_id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(1001, 1, 101, '2025-08-15', 1500.00),
(1002, 1, 102, '2025-08-16', 1500.00),
(1003, 2, 103, '2025-08-20', 1200.00),
(1004, 3, 104, '2025-08-25', 1800.00),
(1005, 4, 105, '2025-08-28', 1300.00),
(1006, 2, 101, '2025-08-30', 1200.00);

-- a) Inserting a new event --
INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES 
(5, 'Data Science Expo 2025', '2025-12-20', 'Hyderabad Tech Park', 'An expo focused on data science trends, tools, and real-world applications.');

--- b)Updating an event's information---

UPDATE Events
SET 
    Event_Name = 'Startup Pitch Fest 2025',
    Event_Location = 'Bangalore Tech Arena'
WHERE 
    Event_Id = 2;
--- Deleting an event.---

DELETE FROM Registrations
WHERE Event_Id = 2;

--- Inserting a new attendee.--

INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES (106, 'Priya Sharma', '9786654321', 'priya.sharma@gmail.com', 'Pune'
);

--- Registering an attendee for an event.--

INSERT INTO Registrations (Registration_id,Event_Id,Attendee_Id,Registration_Date,Registration_Amount)
VALUES (1007,3,106,CURDATE(),1800.00             
);

--- retrieve event information--
-- Retrieve All Event Details--

-- generate attendee lists--

SELECT * 
FROM Attendees
ORDER BY Attendee_Name;

--- Total Attendees per Event--
SELECT E.Event_Id,E.Event_Name,
COUNT(R.Registration_id) AS Total_Attendees
FROM Events E
JOIN Registrations R ON E.Event_Id = R.Event_Id;

--- Total Revenue Collected per Event--
select E.Event_Id,E.Event_Name,
SUM(R.Registration_Amount) AS Total_Revenue
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Id, E.Event_Name
ORDER BY Total_Revenue DESC;
