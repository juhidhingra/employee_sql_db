SELECT 
    dept_no
FROM
    departments;

SELECT 
    *
FROM
    departments;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'elvis';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%');

SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');

SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Jack%');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack%');

SELECT 
    *
FROM
    salaries;
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN '66000' AND '70000';

SELECT 
    *
FROM
    salaries
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';

SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;
SELECT 
    hire_date
FROM
    employees;
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND hire_date >= '2000/01/01';

SELECT 
    *
FROM
    salaries;
SELECT 
    *
FROM
    salaries
WHERE
    salary > 150000;

SELECT 
    hire_date
FROM
    employees;
    
SELECT 
    salary
FROM
    salaries;
    
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;

SELECT 
    title
FROM
    titles;

SELECT 
    COUNT(*)
FROM
    dept_manager;

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;


SELECT 
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

SELECT 
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

SELECT 
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

SELECT 
    *
FROM
    dept_emp
WHERE
    from_date > '2000-01-01';

SELECT 
    emp_no, from_date
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

SELECT 
    *
FROM
    dept_emp
LIMIT 100;

SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;
    
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

SELECT 
    MIN(emp_no)
FROM
    employees;
SELECT 
    MAX(emp_no)
FROM
    employees;

SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01'; 
    
drop table if exists departments_dup;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

insert into departments_dup(dept_no, dept_name)select * from departments;

Insert into departments_dup(dept_name) values ('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';

insert into departments_dup(dept_no) values('d010'),('d011');

drop table if exists dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);
  
insert into dept_manager_dup
 select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)

VALUES                (999904, '2017-01-01'),

                                (999905, '2017-01-01'),

                               (999906, '2017-01-01'),

                               (999907, '2017-01-01');
                               
DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';
    
INSERT INTO departments_dup (dept_name)

VALUES                ('Public Relations');

 

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';
    

SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    employees.emp_no,
    employees.first_name,
    employees.last_name,
    dept_manager.dept_no,
    employees.hire_date
FROM
    employees
        JOIN
    dept_manager ON employees.emp_no = dept_manager.emp_no;
    
SELECT 
    dept_manager_dup.dept_no,
    dept_manager_dup.emp_no,
    departments_dup.dept_name
FROM
    dept_manager_dup
        JOIN
    departments_dup ON departments_dup.dept_no = dept_manager_dup.dept_no
ORDER BY dept_manager_dup.dept_no;


DELETE FROM dept_manager_dup 
WHERE
    emp_no = '110028';

DELETE FROM departments_dup 
WHERE
    dept_no = '009';

INSERT INTO dept_manager_dup
VALUES('110028','d003','1992-03-21','9999-01-01');

INSERT INTO dept_manager_dup
VALUES('d009','Customer Service');

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup AS m
        LEFT JOIN
    departments_dup AS d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager m ON e.emp_no = m.emp_no
WHERE
    e.last_name = 'Markovitch'
GROUP BY m.dept_no
ORDER BY m.dept_no DESC , e.emp_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, d.dept_no
FROM
    employees AS e
        JOIN
    dept_manager AS d ON e.emp_no = d.emp_no;

SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees AS e
        JOIN
    titles AS t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager AS dm
        CROSS JOIN
    departments AS d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*, e.*
FROM
    dept_manager AS dm
        CROSS JOIN
    departments AS d
        JOIN
    employees AS e ON dm.emp_no = e.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager AS dm
        CROSS JOIN
    departments AS d
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_name;

SELECT 
    *
FROM
    employees
LIMIT 10;

SELECT 
    e.*, d.*
FROM
    employees AS e
        CROSS JOIN
    departments AS d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_no;

SELECT 
    e.gender, AVG(s.salary) AS Average_Salary
FROM
    employees AS e
        JOIN
    salaries AS s ON e.emp_no = s.emp_no
GROUP BY e.gender;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    employees AS e
        JOIN
    dept_manager AS dm ON e.emp_no = dm.emp_no
        JOIN
    departments AS d ON dm.dept_no = d.dept_no
ORDER BY dept_name;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    t.from_date,
    de.dept_no,
    d.dept_name
FROM
    employees AS e
        JOIN
    titles AS t ON e.emp_no = t.emp_no
        JOIN
    dept_emp AS de ON e.emp_no = de.emp_no
        JOIN
    departments AS d ON de.dept_no = d.dept_no
ORDER BY e.emp_no;

SELECT 
    e.gender, COUNT(dm.emp_no)
FROM
    employees AS e
        JOIN
    dept_manager AS dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;

drop table if exists employees_dup;

CREATE TABLE employees_dup (
    emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);

# duplicate structure of employees table

INSERT INTO employees_dup
select e.* from employees e limit 20;

SELECT 
    *
FROM
    employees_dup;

INSERT INTO employees_dup VALUES ('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

SELECT 
    *
FROM
    employees_dup;
    
# UNION SYNTAX

# SELECT N COLUMNS
# FROM TABLE1
# UNION ALL SELECT 
# N COLUMNS
# FROM TABLE2




SELECT 
    e.first_name, e.last_name
FROM
    employees AS e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager AS dm);
            
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
		
SELECT 
    *
FROM
    employees AS e
WHERE
    EXISTS( SELECT 
            title
        FROM
            employees.titles AS et
        WHERE
            e.emp_no = et.emp_no
                AND et.title = 'Assistant Engineer');
                
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS Employee_ID,
            MIN(de.dept_no) AS Department_code,
            (SELECT 
                    emp_no
                FROM
                    employees.dept_manager
                WHERE
                    emp_no = 110022) AS Manager_ID
    FROM
        employees AS e
    JOIN dept_emp AS de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS Employee_ID,
            MIN(de.dept_no) AS Department_code,
            (SELECT 
                    emp_no
                FROM
                    employees.dept_manager
                WHERE
                    emp_no = 110039) AS Manager_ID
    FROM
        employees AS e
    JOIN dept_emp AS de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
# EXERCISE

# Starting your code with “DROP TABLE”,
# create a table called “emp_manager” 
# (emp_no – integer of 11, not null; dept_no – CHAR of 4, null; 
# manager_no – integer of 11, not null). 

DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4),
    manager_no INT(11) NOT NULL
);

#Fill emp_manager with data about employees, 
#the number of the department they are working in, 
#and their managers

 


    
