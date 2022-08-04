-- Challange 7

-----------------
-- Deliverable 1: The Number of Retiring Employees by Title
-----------------
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM titles AS t
RIGHT JOIN employees AS e
ON t.emp_no = e.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no ASC, t.to_date DESC;

SELECT DISTINCT ON (emp_no)
	emp_no, first_name, last_name, title 
INTO unique_titles
from retirement_titles
where to_date = '9999-01-01'
order by emp_no ASC, to_date DESC;

SELECT COUNT(*) AS total, title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(*) DESC;

------ Unique query to do all in once -------
SELECT COUNT(*), title 
INTO retiring_titles
FROM (SELECT DISTINCT ON (e.emp_no)
		e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
	FROM titles AS t
	RIGHT JOIN employees AS e
	ON t.emp_no = e.emp_no
	WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
	AND t.to_date = '9999-01-01'
	ORDER BY e.emp_no ASC, t.to_date DESC) AS unique_titles
GROUP BY title
ORDER BY COUNT(*) DESC;

-----------------
-- Deliverable 2: The Employees Eligible for the Mentorship Program
-----------------

SELECT DISTINCT ON (e.emp_no)
	e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibilty
FROM employees AS e
LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
LEFT JOIN titles AS t ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no, t.to_date DESC
;


-----------------
-- Queries for analisys
-----------------
-- current employees
SELECT COUNT(*) AS total , title 
FROM (SELECT DISTINCT ON (e.emp_no)
		e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
	FROM titles AS t
	RIGHT JOIN employees AS e
	ON t.emp_no = e.emp_no
	WHERE t.to_date = '9999-01-01'
	ORDER BY e.emp_no ASC, t.to_date DESC) AS unique_titles
GROUP BY title
ORDER BY COUNT(*) DESC;

-- retiring employees
SELECT * FROM retiring_titles;

-- mentors

SELECT COUNT(*) FROM mentorship_eligibilty;