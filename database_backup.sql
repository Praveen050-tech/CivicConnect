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
    complaint_id VARCHAR(30),
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
