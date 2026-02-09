-- ============================================
-- User Access Management System
-- Database Setup Script for PostgreSQL
-- ============================================

-- Create the database (run this separately if needed)
-- CREATE DATABASE useraccess_db;

-- Connect to useraccess_db before running the rest

-- ============================================
-- DROP existing tables (if any) for clean setup
-- ============================================
DROP TABLE IF EXISTS requests CASCADE;
DROP TABLE IF EXISTS software CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ============================================
-- TABLE: users
-- Stores user accounts with role-based access
-- ============================================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('Employee', 'Manager', 'Admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TABLE: software
-- Stores software applications managed by Admin
-- ============================================
CREATE TABLE software (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    access_levels VARCHAR(50) CHECK (access_levels IN ('Read', 'Write', 'Admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TABLE: requests
-- Stores access requests from Employees
-- ============================================
CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    software_id INTEGER NOT NULL REFERENCES software(id) ON DELETE CASCADE,
    access_type VARCHAR(20) NOT NULL CHECK (access_type IN ('Read', 'Write', 'Admin')),
    reason TEXT,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Approved', 'Rejected')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- INDEX for performance
-- ============================================
CREATE INDEX idx_requests_status ON requests(status);
CREATE INDEX idx_requests_user_id ON requests(user_id);

-- ============================================
-- SAMPLE DATA: Users (Admin, Manager, Employees)
-- ============================================
INSERT INTO users (username, password, role) VALUES
    ('admin', 'admin123', 'Admin'),
    ('manager', 'manager123', 'Manager'),
    ('john_doe', 'employee123', 'Employee'),
    ('jane_smith', 'employee123', 'Employee'),
    ('bob_wilson', 'employee123', 'Employee');

-- ============================================
-- SAMPLE DATA: Software applications
-- ============================================
INSERT INTO software (name, description, access_levels) VALUES
    ('Salesforce CRM', 'Customer relationship management platform', 'Read'),
    ('GitHub Enterprise', 'Source code repository and collaboration tool', 'Write'),
    ('AWS Console', 'Amazon Web Services cloud management console', 'Admin'),
    ('Jira', 'Project management and issue tracking software', 'Read'),
    ('Slack Enterprise', 'Team communication and collaboration platform', 'Write');

-- ============================================
-- SAMPLE DATA: Access requests
-- ============================================
INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES
    (3, 1, 'Read', 'Need CRM access for sales reporting project', 'Pending'),
    (3, 2, 'Write', 'Need to commit code for the Q1 feature sprint', 'Approved'),
    (4, 3, 'Read', 'Need to monitor server infrastructure', 'Pending'),
    (4, 4, 'Write', 'Need to create and manage project tickets', 'Rejected'),
    (5, 5, 'Read', 'Need access to team communication channels', 'Pending');

-- ============================================
-- Verify data
-- ============================================
SELECT 'Users:' AS info, COUNT(*) AS count FROM users
UNION ALL
SELECT 'Software:', COUNT(*) FROM software
UNION ALL
SELECT 'Requests:', COUNT(*) FROM requests;
