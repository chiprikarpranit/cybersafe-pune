-- ============================================
-- CYBERSAFE PUNE - DATABASE FILE
-- PostgreSQL (psql)
-- ============================================

-- CREATE DATABASE
CREATE DATABASE cybersafe;

-- CONNECT TO DATABASE
\c cybersafe;

-- ============================================
-- TABLE 1: STUDENTS
-- ============================================
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    class VARCHAR(10) NOT NULL,
    school VARCHAR(150) NOT NULL,
    created_at DATE DEFAULT CURRENT_DATE
);

-- ============================================
-- TABLE 2: FEEDBACK
-- ============================================
CREATE TABLE feedback (
    id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    class VARCHAR(10) NOT NULL,
    school VARCHAR(150) NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    learned TEXT,
    suggestions TEXT,
    session_date DATE DEFAULT CURRENT_DATE
);

-- ============================================
-- TABLE 3: QUIZ RESULTS
-- ============================================
CREATE TABLE quiz_results (
    id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    class VARCHAR(10) NOT NULL,
    score INT CHECK (score BETWEEN 0 AND 5),
    total INT DEFAULT 5,
    attempted_on DATE DEFAULT CURRENT_DATE
);

-- ============================================
-- TABLE 4: SESSION LOG
-- ============================================
CREATE TABLE session_log (
    id SERIAL PRIMARY KEY,
    topic VARCHAR(200) NOT NULL,
    class VARCHAR(20) NOT NULL,
    students_count INT,
    method VARCHAR(100),
    session_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Done'
);

-- ============================================
-- TABLE 5: FEEDBACK AUDIT LOG (for Trigger)
-- ============================================
CREATE TABLE feedback_audit (
    id SERIAL PRIMARY KEY,
    feedback_id INT,
    action VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- INSERT SAMPLE DATA - STUDENTS
-- ============================================
INSERT INTO students (student_name, class, school) VALUES
('Raj Sharma', '9th', 'Prerna School'),
('Priya Patil', '8th', 'Prerna School'),
('Amit Desai', '10th', 'Prerna School'),
('Sneha Kulkarni', '9th', 'Prerna School'),
('Rohit More', '8th', 'Prerna School'),
('Pooja Jadhav', '10th', 'Prerna School'),
('Vikas Shinde', '9th', 'Prerna School'),
('Ankita Bhosale', '8th', 'Prerna School');

-- ============================================
-- INSERT SAMPLE DATA - FEEDBACK
-- ============================================
INSERT INTO feedback (student_name, class, school, rating, learned, suggestions, session_date) VALUES
('Raj Sharma', '9th', 'Prerna School', 5, 'Learned about OTP scams and how to avoid them', 'More real life examples', '2026-04-28'),
('Priya Patil', '8th', 'Prerna School', 4, 'Phishing attacks and strong passwords', 'Add more videos', '2026-04-28'),
('Amit Desai', '10th', 'Prerna School', 5, 'Digital arrest scam awareness was very helpful', 'Conduct more sessions', '2026-04-28'),
('Sneha Kulkarni', '9th', 'Prerna School', 4, 'Social media safety tips', 'Include quiz in session', '2026-04-28'),
('Rohit More', '8th', 'Prerna School', 3, 'Password safety practices', 'Make it more interactive', '2026-04-28'),
('Pooja Jadhav', '10th', 'Prerna School', 5, 'Never share OTP with anyone', 'Good session overall', '2026-04-28'),
('Vikas Shinde', '9th', 'Prerna School', 4, 'Cyber security basics', 'More demonstrations', '2026-04-28'),
('Ankita Bhosale', '8th', 'Prerna School', 5, 'How to identify fake messages', 'Very informative session', '2026-04-28');

-- ============================================
-- INSERT SAMPLE DATA - QUIZ RESULTS
-- ============================================
INSERT INTO quiz_results (student_name, class, score, total, attempted_on) VALUES
('Raj Sharma', '9th', 5, 5, '2026-04-28'),
('Priya Patil', '8th', 4, 5, '2026-04-28'),
('Amit Desai', '10th', 5, 5, '2026-04-28'),
('Sneha Kulkarni', '9th', 3, 5, '2026-04-28'),
('Rohit More', '8th', 4, 5, '2026-04-28'),
('Pooja Jadhav', '10th', 5, 5, '2026-04-28'),
('Vikas Shinde', '9th', 4, 5, '2026-04-28'),
('Ankita Bhosale', '8th', 5, 5, '2026-04-28');

-- ============================================
-- INSERT SAMPLE DATA - SESSION LOG
-- ============================================
INSERT INTO session_log (topic, class, students_count, method, session_date, status) VALUES
('Introduction to Cyber Security', '8th', 20, 'Interactive Talk', '2026-04-28', 'Done'),
('OTP Scam Awareness', '8th & 9th', 38, 'Video Demo', '2026-04-28', 'Done'),
('Phishing Attacks', '9th', 18, 'Real Examples', '2026-04-28', 'Done'),
('Social Media Safety', '9th & 10th', 33, 'Discussion', '2026-04-28', 'Done'),
('Strong Password Practices', '10th', 15, 'Interactive Talk', '2026-04-28', 'Done');

-- ============================================
-- SQL QUERIES
-- ============================================

-- 1. View all feedback
SELECT * FROM feedback;

-- 2. View all quiz results
SELECT * FROM quiz_results;

-- 3. Average rating of the session
SELECT ROUND(AVG(rating), 2) AS average_rating FROM feedback;

-- 4. Count feedback by class
SELECT class, COUNT(*) AS total_feedback
FROM feedback
GROUP BY class
ORDER BY class;

-- 5. Students who scored full marks in quiz
SELECT student_name, class, score
FROM quiz_results
WHERE score = 5;

-- 6. Total students educated per topic
SELECT topic, students_count
FROM session_log
ORDER BY students_count DESC;

-- 7. Feedback with rating 5
SELECT student_name, class, learned
FROM feedback
WHERE rating = 5;

-- 8. Average quiz score by class
SELECT class, ROUND(AVG(score), 2) AS avg_score
FROM quiz_results
GROUP BY class;

-- ============================================
-- TRIGGER 1 - Auto log when feedback inserted
-- ============================================
CREATE OR REPLACE FUNCTION log_feedback_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO feedback_audit (feedback_id, action, action_time)
    VALUES (NEW.id, 'INSERT', CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER feedback_insert_trigger
AFTER INSERT ON feedback
FOR EACH ROW
EXECUTE FUNCTION log_feedback_insert();

-- ============================================
-- TRIGGER 2 - Validate rating before insert
-- ============================================
CREATE OR REPLACE FUNCTION validate_rating()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.rating < 1 OR NEW.rating > 5 THEN
        RAISE EXCEPTION 'Rating must be between 1 and 5';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_rating_trigger
BEFORE INSERT ON feedback
FOR EACH ROW
EXECUTE FUNCTION validate_rating();

-- ============================================
-- STORED PROCEDURE 1 - Get feedback by class
-- ============================================
CREATE OR REPLACE PROCEDURE get_feedback_by_class(IN p_class VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
    RAISE NOTICE 'Feedback for class: %', p_class;
    PERFORM * FROM feedback WHERE class = p_class;
END;
$$;

-- ============================================
-- STORED PROCEDURE 2 - Get average rating
-- ============================================
CREATE OR REPLACE PROCEDURE get_average_rating()
LANGUAGE plpgsql AS $$
DECLARE
    avg_rating NUMERIC;
BEGIN
    SELECT ROUND(AVG(rating), 2) INTO avg_rating FROM feedback;
    RAISE NOTICE 'Average Session Rating: %', avg_rating;
END;
$$;

-- ============================================
-- STORED PROCEDURE 3 - Insert new feedback
-- ============================================
CREATE OR REPLACE PROCEDURE insert_feedback(
    p_name VARCHAR,
    p_class VARCHAR,
    p_school VARCHAR,
    p_rating INT,
    p_learned TEXT,
    p_suggestions TEXT
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO feedback (student_name, class, school, rating, learned, suggestions)
    VALUES (p_name, p_class, p_school, p_rating, p_learned, p_suggestions);
    RAISE NOTICE 'Feedback inserted successfully for: %', p_name;
END;
$$;

-- ============================================
-- STORED PROCEDURE 4 - Get quiz results by class
-- ============================================
CREATE OR REPLACE PROCEDURE get_quiz_by_class(IN p_class VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    avg_score NUMERIC;
BEGIN
    SELECT ROUND(AVG(score), 2) INTO avg_score
    FROM quiz_results WHERE class = p_class;
    RAISE NOTICE 'Average Quiz Score for class %: %', p_class, avg_score;
END;
$$;

-- ============================================
-- STORED PROCEDURE 5 - Full session summary
-- ============================================
CREATE OR REPLACE PROCEDURE get_session_summary()
LANGUAGE plpgsql AS $$
DECLARE
    total_students INT;
    total_feedback INT;
    avg_rating NUMERIC;
BEGIN
    SELECT SUM(students_count) INTO total_students FROM session_log;
    SELECT COUNT(*) INTO total_feedback FROM feedback;
    SELECT ROUND(AVG(rating), 2) INTO avg_rating FROM feedback;

    RAISE NOTICE '====== SESSION SUMMARY ======';
    RAISE NOTICE 'Total Students Educated : %', total_students;
    RAISE NOTICE 'Total Feedback Received : %', total_feedback;
    RAISE NOTICE 'Average Session Rating  : %', avg_rating;
    RAISE NOTICE '=============================';
END;
$$;

-- ============================================
-- CALL PROCEDURES (Test)
-- ============================================
CALL get_average_rating();
CALL get_session_summary();
CALL get_feedback_by_class('9th');
CALL get_quiz_by_class('8th');
CALL insert_feedback('Test Student', '9th', 'Prerna School', 5, 'Great session!', 'Keep it up');
