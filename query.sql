-- Here is the SQL command to create the users table for your Gyan Ganga project in PostgreSQL.

-- This command sets up all the necessary columns with appropriate data types and constraints to ensure data integrity.

-- SQL

-- First, create a custom type for the user roles to ensure data consistency.
CREATE TYPE user_role AS ENUM ('student', 'teacher');

-- Now, create the users table.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role user_role NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Run this ALTER TABLE command in your database tool (like pgAdmin).

-- SQL

ALTER TABLE users
ADD COLUMN phone_number VARCHAR(20),
ADD COLUMN school_name VARCHAR(150),
ADD COLUMN grade VARCHAR(10),
ADD COLUMN city VARCHAR(100);

-- First, we need a table to store your course topics. Run the CREATE TABLE command in your database tool. Then, run the INSERT commands to populate it with some mock data for all your categories.

-- ### SQL Commands
-- SQL

-- Command 1: Create the 'topics' table
CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    topic_name VARCHAR(150) NOT NULL,
    description TEXT,
    category VARCHAR(50) NOT NULL, -- 'maths', 'science', etc.
    grade_level INT NOT NULL
);

-- Command 2: Insert mock data for all categories
INSERT INTO topics (topic_name, description, category, grade_level) VALUES
-- Maths
('Algebra Basics', 'Introduction to variables, expressions, and equations.', 'maths', 7),
('Geometry: Shapes and Angles', 'Learn about fundamental geometric shapes and the properties of angles.', 'maths', 8),
('Trigonometry', 'The study of relationships between side lengths and angles of triangles.', 'maths', 10),

-- Science
('The Solar System', 'Explore the planets, moons, and other celestial bodies in our solar system.', 'science', 6),
('Chemical Reactions', 'Understanding how substances combine or break apart to form new substances.', 'science', 9),
('Newton''s Laws of Motion', 'The fundamental principles governing the motion of objects.', 'science', 11),

-- Technology
('Introduction to HTML & CSS', 'Learn the building blocks of web pages and how to style them.', 'technology', 8),
('Basic Python Programming', 'An introduction to one of the world''s most popular programming languages.', 'technology', 9),
('Understanding Circuits', 'Learn how electricity flows and how to build simple circuits.', 'technology', 7),

-- Engineering
('The Engineering Design Process', 'A step-by-step method to solve problems through design, prototyping, and testing.', 'engineering', 9),
('Simple Machines', 'Explore levers, pulleys, and inclined planes and how they make work easier.', 'engineering', 6);


-- First, let's create the necessary tables and populate them with mock data.

-- ### SQL Commands
-- SQL

-- Command 1: Create the 'missions' table
CREATE TABLE missions (
    id SERIAL PRIMARY KEY,
    topic_id INT NOT NULL, -- Links to the 'topics' table
    mission_title VARCHAR(200) NOT NULL,
    mission_description TEXT,
    mission_order INT NOT NULL, -- Order within a topic
    FOREIGN KEY (topic_id) REFERENCES topics(id)
);

-- Command 2: Create the 'videos' (or lessons) table
CREATE TABLE videos (
    id SERIAL PRIMARY KEY,
    mission_id INT NOT NULL, -- Links to the 'missions' table
    video_title VARCHAR(200) NOT NULL,
    video_description TEXT,
    video_url VARCHAR(255) NOT NULL, -- URL to the video file
    video_order INT NOT NULL, -- Order within a mission
    language VARCHAR(20) NOT NULL DEFAULT 'english', -- 'english', 'hindi', 'telugu'
    quality VARCHAR(20) NOT NULL DEFAULT '720p', -- '360p', '480p', '720p', '1080p'
    FOREIGN KEY (mission_id) REFERENCES missions(id)
);

-- Command 3: Insert Mock Data (Example for Algebra Basics)
-- NOTE: This assumes 'Algebra Basics' has topic_id = 1.
-- You can find the correct ID by running: SELECT id FROM topics WHERE topic_name = 'Algebra Basics';

INSERT INTO missions (topic_id, mission_title, mission_description, mission_order) VALUES
(1, 'Introduction to Variables', 'Understand what variables are and why they are used in algebra.', 1),
(1, 'Solving One-Step Equations', 'Learn how to solve basic equations involving addition, subtraction, multiplication, and division.', 2),
(1, 'Expressions and Terms', 'Differentiate between algebraic expressions, terms, and coefficients.', 3);


-- Insert Mock Video Data for Mission 1 (Introduction to Variables)
-- NOTE: This assumes 'Introduction to Variables' will get mission_id = 1 after the previous insert.
-- You can find the correct ID by running: SELECT id FROM missions WHERE mission_title = 'Introduction to Variables';

INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(1, 'What is a Variable?', 'A simple explanation of variables.', '/videos/sample_video_eng.mp4', 1, 'english', '720p'),
(1, 'Variables in Hindi', 'Same concept, but in Hindi.', '/videos/sample_video_hin.mp4', 1, 'hindi', '720p'),
(1, 'Variables in Telugu', 'Same concept, but in Telugu.', '/videos/sample_video_tel.mp4', 1, 'telugu', '720p'), -- THIS LINE IS NOW FIXED
(1, 'Algebraic Expressions', 'Forming expressions with variables.', '/videos/sample_video_eng.mp4', 2, 'english', '720p');
-- You'll need to insert similar data for Mission 2, Mission 3, etc.

-- Mock Video Data for Mission 2: 'Solving One-Step Equations'
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(2, 'Solving with Addition & Subtraction', 'Learn how to isolate a variable using addition and subtraction.', '/videos/sample_video_eng.mp4', 1, 'english', '720p'),
(2, 'Solving with Addition & Subtraction (Hindi)', 'Same concept, but in Hindi.', '/videos/sample_video_hin.mp4', 1, 'hindi', '720p'),
(2, 'Solving with Addition & Subtraction (Telugu)', 'Same concept, but in Telugu.', '/videos/sample_video_tel.mp4', 1, 'telugu', '720p'),
(2, 'Solving with Multiplication & Division', 'Learn how to isolate a variable using multiplication and division.', '/videos/sample_video_eng.mp4', 2, 'english', '720p'),
(2, 'Solving with Multiplication & Division (Hindi)', 'Same concept, but in Hindi.', '/videos/sample_video_hin.mp4', 2, 'hindi', '720p'),
(2, 'Solving with Multiplication & Division (Telugu)', 'Same concept, but in Telugu.', '/videos/sample_video_tel.mp4', 2, 'telugu', '720p');


-- Mock Video Data for Mission 3: 'Expressions and Terms'
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(3, 'Identifying Terms in Expressions', 'Learn what constitutes a "term" in an algebraic expression.', '/videos/sample_video_eng.mp4', 1, 'english', '720p'),
(3, 'Identifying Terms (Hindi)', 'Same concept, but in Hindi.', '/videos/sample_video_hin.mp4', 1, 'hindi', '720p'),
(3, 'Identifying Terms (Telugu)', 'Same concept, but in Telugu.', '/videos/sample_video_tel.mp4', 1, 'telugu', '720p'),
(3, 'Coefficients and Variables', 'Understand the difference between the number part (coefficient) and the letter part (variable).', '/videos/sample_video_eng.mp4', 2, 'english', '720p'),
(3, 'Coefficients and Variables (Hindi)', 'Same concept, but in Hindi.', '/videos/sample_video_hin.mp4', 2, 'hindi', '720p'),
(3, 'Coefficients and Variables (Telugu)', 'Same concept, but in Telugu.', '/videos/sample_video_tel.mp4', 2, 'telugu', '720p');



-- ## SQL Script for New Missions
-- SQL

-- ======================================================
-- SCIENCE MISSIONS
-- Assumes 'The Solar System' has topic_id = 4
-- ======================================================
INSERT INTO missions (topic_id, mission_title, mission_description, mission_order) VALUES
(4, 'The Inner Planets', 'A journey to Mercury, Venus, Earth, and Mars.', 1),
(4, 'The Gas Giants', 'Exploring the massive outer planets: Jupiter, Saturn, Uranus, and Neptune.', 2);

-- Insert videos for the new missions (assumes new mission IDs are 4 and 5)
-- Videos for 'The Inner Planets' (mission_id = 4)
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(4, 'Exploring Mars', 'A look at the red planet.', '/videos/sample_video_eng.mp4', 1, 'english', '720p'),
(4, 'Mars in Hindi', 'Same concept, but in Hindi.', '/videos/sample_video_hin.mp4', 1, 'hindi', '720p'),
(4, 'Mars in Telugu', 'Same concept, but in Telugu.', '/videos/sample_video_tel.mp4', 1, 'telugu', '720p');

-- Videos for 'The Gas Giants' (mission_id = 5)
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(5, 'Jupiter''s Great Red Spot', 'Understanding the giant storm.', '/videos/sample_video_eng.mp4', 1, 'english', '720p');


-- ======================================================
-- TECHNOLOGY MISSIONS
-- Assumes 'Introduction to HTML & CSS' has topic_id = 7
-- ======================================================
INSERT INTO missions (topic_id, mission_title, mission_description, mission_order) VALUES
(7, 'Your First Web Page', 'Learn to structure a simple web page using HTML tags.', 1),
(7, 'Styling with CSS', 'An introduction to CSS for adding colors, fonts, and layouts.', 2);

-- Insert videos for the new missions (assumes new mission IDs are 6 and 7)
-- Videos for 'Your First Web Page' (mission_id = 6)
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(6, 'HTML Tags Explained', 'Understanding p, h1, and div tags.', '/videos/sample_video_eng.mp4', 1, 'english', '720p'),
(6, 'HTML in Hindi', 'Same concept, but in Hindi.', '/videos/sample_video_hin.mp4', 1, 'hindi', '720p');

-- Videos for 'Styling with CSS' (mission_id = 7)
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(7, 'Introduction to CSS Selectors', 'Learn how to target HTML elements.', '/videos/sample_video_eng.mp4', 1, 'english', '720p');


-- ======================================================
-- ENGINEERING MISSIONS
-- Assumes 'Simple Machines' has topic_id = 10
-- ======================================================
INSERT INTO missions (topic_id, mission_title, mission_description, mission_order) VALUES
(10, 'Levers and Pulleys', 'Understanding mechanical advantage with levers and pulleys.', 1);

-- Insert videos for the new mission (assumes new mission ID is 8)
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(8, 'How a Lever Works', 'A simple demonstration of a lever.', '/videos/sample_video_eng.mp4', 1, 'english', '720p'),
(8, 'Levers in Telugu', 'Same concept, but in Telugu.', '/videos/sample_video_tel.mp4', 1, 'telugu', '720p');


-- SQL Script for Missions 9, 10, & 11
-- SQL

-- ======================================================
-- First, create the new missions.
-- Assumes these topic IDs from the previous script. Adjust if necessary.
-- 'Chemical Reactions' (Science) has topic_id = 5
-- 'Basic Python Programming' (Technology) has topic_id = 8
-- 'The Engineering Design Process' (Engineering) has topic_id = 9
-- ======================================================

INSERT INTO missions (topic_id, mission_title, mission_description, mission_order) VALUES
(5, 'Acids and Bases', 'Understanding pH, and the properties of acidic and alkaline solutions.', 2),
(8, 'Variables and Data Types', 'Learn how to store information in Python using variables.', 2),
(9, 'Prototyping and Testing', 'The crucial phase of building and testing a physical model.', 2);


-- ======================================================
-- Now, insert videos for the new missions.
-- This assumes the INSERT above created missions with IDs 9, 10, and 11.
-- ======================================================

-- Videos for 'Acids and Bases' (mission_id = 9)
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(9, 'The pH Scale Explained', 'A simple guide to the pH scale.', '/videos/sample_video_eng.mp4', 1, 'english', '720p'),
(9, 'pH Scale in Hindi', 'Same concept, but in Hindi.', '/videos/sample_video_hin.mp4', 1, 'hindi', '720p');

-- Videos for 'Variables and Data Types' (mission_id = 10)
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(10, 'Python Variables', 'How to declare and use variables.', '/videos/sample_video_eng.mp4', 1, 'english', '720p'),
(10, 'Python Variables in Telugu', 'Same concept, but in Telugu.', '/videos/sample_video_tel.mp4', 1, 'telugu', '720p'),
(10, 'Data Types: Strings and Integers', 'Understanding different types of data.', '/videos/sample_video_eng.mp4', 2, 'english', '720p');

-- Videos for 'Prototyping and Testing' (mission_id = 11)
INSERT INTO videos (mission_id, video_title, video_description, video_url, video_order, language, quality) VALUES
(11, 'Building a Simple Prototype', 'From idea to a physical model.', '/videos/sample_video_eng.mp4', 1, 'english', '720p');