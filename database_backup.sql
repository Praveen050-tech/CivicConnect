-- Community Complaint Management System Database Backup & Export
-- Database Name: community_complaints

CREATE DATABASE IF NOT EXISTS community_complaints;
USE community_complaints;

-- --------------------------------------------------------
-- Table structure for table `users`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(100),
    role VARCHAR(20) DEFAULT 'citizen'
);

-- --------------------------------------------------------
-- Table structure for table `complaints`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS complaints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id VARCHAR(30) UNIQUE,
    user_id INT,
    category VARCHAR(50),
    location VARCHAR(200),
    description VARCHAR(500),
    status VARCHAR(30) DEFAULT 'Pending',
    assigned_to VARCHAR(100),
    complaint_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- --------------------------------------------------------
-- Table structure for table `feedback`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id VARCHAR(30),
    rating INT,
    comments VARCHAR(500)
);

-- --------------------------------------------------------
-- Dumping seed data for table `users`
-- --------------------------------------------------------
INSERT INTO users (name, email, phone, password, role)
VALUES ('Admin', 'admin@gmail.com', '9876543210', 'admin123', 'admin')
ON DUPLICATE KEY UPDATE id=id;

INSERT INTO users (name, email, phone, password, role)
VALUES ('Arun', 'arun@gmail.com', '9876543211', '12345', 'citizen')
ON DUPLICATE KEY UPDATE id=id;

-- --------------------------------------------------------
-- Dumping seed data for table `complaints`
-- --------------------------------------------------------
INSERT INTO complaints (complaint_id, user_id, category, location, description, status, assigned_to)
VALUES 
('CMP20261006001', 2, 'Water Leakage', 'Main Street, Sector 4', 'Heavy water pipe leakage causing street flooding near apartment entrance.', 'Pending', 'Not Assigned'),
('CMP20261006002', 2, 'Street Light', 'Oak Avenue, Ward 12', 'Streetlight bulb blown out, area is pitch dark at night.', 'In Progress', 'Officer Rajesh Kumar'),
('CMP20261006003', 2, 'Garbage Collection', 'Market Road, Block B', 'Garbage bin overflowing for the past 3 days, needs urgent clearing.', 'Resolved', 'Inspector Suresh'),
('CMP20261006004', 2, 'Damaged Road', 'Park View Avenue', 'Deep pothole causing vehicle damage near school gate.', 'In Progress', 'Engineer Anil Verma'),
('CMP20261006005', 2, 'Fallen Tree', 'Green Park Road', 'Large tree branch fallen after storm blocking left lane.', 'Pending', 'Not Assigned')
ON DUPLICATE KEY UPDATE complaint_id=complaint_id;

-- --------------------------------------------------------
-- Dumping seed data for table `feedback`
-- --------------------------------------------------------
INSERT INTO feedback (complaint_id, rating, comments)
VALUES ('CMP20261006003', 5, 'Prompt resolution of the garbage issue. Thank you team!')
ON DUPLICATE KEY UPDATE complaint_id=complaint_id;
