--- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (t.emp_no) e.emp_no,e.first_name,e.last_name,t.title,t.from_date,t.to_date
INTO retirement_titles
FROM titles as t
INNER JOIN employees as e  
ON (t.emp_no=e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY t.emp_no, e.first_name DESC;

SELECT * FROM retirement_titles

--Create table for employees still employed at company
SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01');

--Create a table to count number of eployees retiring by most recent job title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

--Create a table for employees that are eligible for the Mentorhsip Program
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de  
ON (e.emp_no=de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no=t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

select * from mentorship_eligibility











