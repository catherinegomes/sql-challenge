DROP DATABASE IF EXISTS employees_db;
CREATE DATABASE employees_db;
USE employees_db;

CREATE TABLE employees(
    emp_no      INT         NOT NULL,
    birth_date  DATE        NOT NULL,
    first_name  VARCHAR(14) NOT NULL,
    last_name   VARCHAR(16) NOT NULL,
    gender      VARCHAR(1)  NOT NULL,
    hire_date   DATE        NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments(
    dept_no     VARCHAR(4)  NOT NULL,
    dept_name   VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE (dept_name)
);

CREATE TABLE dept_emp(
    emp_no      INT         NOT NULL,
    dept_no     VARCHAR(4)  NOT NULL,
    from_date   DATE        NOT NULL,
    to_date     DATE        NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE dept_manager(
    dept_no     VARCHAR(4)  NOT NULL,
    emp_no      INT         NOT NULL,
    from_date   DATE        NOT NULL,
    to_date     DATE        NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE salaries(
    emp_no      INT         NOT NULL,
    salary      INT         NOT NULL,
    from_date   DATE        NOT NULL,
    to_date     DATE        NOT NULL,
    PRIMARY KEY (emp_no, from_date),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE titles(
    emp_no      INT         NOT NULL,
    title       VARCHAR(50) NOT NULL,
    from_date   DATE        NOT NULL,
    to_date     DATE,
    PRIMARY KEY (emp_no, title, from_date),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);