-- Create Database
CREATE DATABASE IF NOT EXISTS skill_matching_db;
USE skill_matching_db;

-- ========================
-- Personnel Table
-- ========================
CREATE TABLE personnel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    role VARCHAR(100),
    experience_level ENUM('Junior', 'Mid-Level', 'Senior') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- Skills Table
-- ========================
CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(100) NOT NULL,
    description TEXT
);

-- ========================
-- Personnel Skills (Many-to-Many)
-- ========================
CREATE TABLE personnel_skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    personnel_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert') NOT NULL,
    CONSTRAINT fk_personnel
        FOREIGN KEY (personnel_id) REFERENCES personnel(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_skill
        FOREIGN KEY (skill_id) REFERENCES skills(id)
        ON DELETE CASCADE,
    UNIQUE (personnel_id, skill_id)
);

-- ========================
-- Projects Table
-- ========================
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    status ENUM('Planning', 'Active', 'Completed') DEFAULT 'Planning',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- Project Required Skills
-- ========================
CREATE TABLE project_required_skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    skill_id INT NOT NULL,
    min_proficiency ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert') NOT NULL,
    CONSTRAINT fk_project
        FOREIGN KEY (project_id) REFERENCES projects(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_req_skill
        FOREIGN KEY (skill_id) REFERENCES skills(id)
        ON DELETE CASCADE,
    UNIQUE (project_id, skill_id)
);
