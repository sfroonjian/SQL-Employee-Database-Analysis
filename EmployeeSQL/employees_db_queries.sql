-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT emp_no, first_name, last_name, sex,
	(SELECT salaries.salary
	 FROM salaries
	 WHERE employees.emp_no = salaries.emp_no) AS salary
FROM employees;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1/1/86'
	AND hire_date <= '12/31/86';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments as d
LEFT JOIN dept_manager as dm
	ON d.dept_no = dm.dept_no
LEFT JOIN employees as e
	ON dm.emp_no = e.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
LEFT JOIN dept_emp as de
	ON de.emp_no = e.emp_no
LEFT JOIN departments as d
	ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT emp_no, last_name, first_name,
	(SELECT departments.dept_name
	 FROM departments
	 WHERE dept_name = 'Sales'
	 )
FROM employees
WHERE emp_no IN(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN (
		SELECT dept_no
		FROM departments
		WHERE dept_name = 'Sales'
	)
);
	 
-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
LEFT JOIN dept_emp as de
	ON de.emp_no = e.emp_no
LEFT JOIN departments as d
	ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'
	OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(emp_no)
FROM employees
GROUP BY 1
ORDER BY 2 DESC;