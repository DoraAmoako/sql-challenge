-- CREATE TABLES

CREATE TABLE "departments" (
    "dept_no" varchar NOT NULL,
	"dept_name" varchar NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);
SELECT *
FROM departments

CREATE TABLE "employees" (
    "emp_no" varchar NOT NULL,
	"emp_title_id" varchar NOT NULL,
    "birth_date" date NOT NULL,
    "first_name" varchar NOT NULL,
    "last_name" varchar NOT NULL,
    "sex" varchar(1) NOT NULL,
    "hire_date" date NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);
SELECT *
FROM employees

CREATE TABLE "dept_emp" (
    "emp_no" varchar NOT NULL,
    "dept_no" varchar NOT NULL
    );

CREATE TABLE "dept_manager" (
    "dept_manager" varchar NOT NULL,
    "emp_no" varchar NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" varchar NOT NULL,
    "salary" int NOT NULL
);

CREATE TABLE "titles" (
    "title_id" varchar NOT NULL,
    "title" varchar NOT NULL
);
--------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE DEPENDENCIES
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_manager" FOREIGN KEY("dept_manager")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--DATA ANALYSIS
--List the following details of each employee: employee number, last name, first name, sex, and salary
SELECT e.emp_no as "Employee Number",
		e.last_name as "Last Name",
		e.first_name as "First Name",
		e.sex as "sex",
		s.salary as "Salary"
FROM employees e
JOIN salaries s
ON (e.emp_no = s.emp_no);

--List first name, last name, and hire date for employees who were hired in 1986
SELECT e.emp_no as "Employee Number",
		e.last_name as "Last Name",
		e.first_name as "First Name",
		e.hire_date as "Hire Date"
FROM employees e
WHERE e.hire_date > '1985-12-31' AND e.hire_date <'1987-01-01'
ORDER BY e.hire_date;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name
SELECT d.dept_no as "Department Number",
		d.dept_name as "Department Name",
		m.emp_no as "Manager Employee Number",
		e.last_name as "Last Name",
		e.first_name as "First Name"
FROM dept_manager m
JOIN departments d ON (d.dept_no = m.dept_manager)
JOIN employees e ON (m.emp_no = e.emp_no);

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no as "Employee Number",
		e.last_name as "Last Name",
		e.first_name as "First Name",
		d.dept_name as "Department Name"
FROM dept_emp t
JOIN departments d on (t.dept_no = d.dept_no)
JOIN employees e on (e.emp_no = t.emp_no);

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT e.last_name as "Last Name",
		e.first_name as "First Name",
		e.emp_no as "Employee Number"
FROM employees e
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name
SELECT e.emp_no as "Employee Number",
		e.last_name as "Last Name",
		e.first_name as "First Name",
		d.dept_name as "Department Name"
FROM dept_emp t
JOIN departments d on (t.dept_no = d.dept_no)
JOIN employees e on (e.emp_no = t.emp_no)
WHERE d.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT e.emp_no as "Employee Number",
		e.last_name as "Last Name",
		e.first_name as "First Name",
		d.dept_name as "Department Name"
FROM dept_emp t
JOIN departments d on (t.dept_no = d.dept_no)
JOIN employees e on (e.emp_no = t.emp_no)
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT last_name as "Last Name", count(last_name) as "Frequency Counts"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Counts" DESC;