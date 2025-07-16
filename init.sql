-- Database: employee_onboarding

-- Drop tables if they exist (order matters due to foreign key constraints)
DROP TABLE IF EXISTS signatures;
DROP TABLE IF EXISTS employment_history;
DROP TABLE IF EXISTS education;
DROP TABLE IF EXISTS bank_details;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS previous_employment;
DROP TABLE IF EXISTS government_ids;
DROP TABLE IF EXISTS employees;

-- Create employees table
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone_no VARCHAR(15) NOT NULL,
  alternate_number VARCHAR(15),
  guardian_name VARCHAR(100),
  guardian_contact VARCHAR(15),
  marital_status VARCHAR(20) NOT NULL,
  gender VARCHAR(10) NOT NULL,
  blood_group VARCHAR(5) NOT NULL,
  date_of_birth DATE NOT NULL,
  employment_status VARCHAR(20) NOT NULL
);

-- Government IDs
CREATE TABLE government_ids (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
  aadhar_no VARCHAR(20) NOT NULL,
  aadhar_file TEXT NOT NULL,
  pan_no VARCHAR(20) NOT NULL,
  pan_file TEXT NOT NULL
);

-- Previous employment (for experienced employees)
CREATE TABLE previous_employment (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
  pf_no VARCHAR(30),
  uan_no VARCHAR(30)
);

-- Addresses table
CREATE TABLE addresses (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
  current_address TEXT NOT NULL,
  current_city VARCHAR(50) NOT NULL,
  current_state VARCHAR(50) NOT NULL,
  current_pincode VARCHAR(10) NOT NULL,
  permanent_address TEXT NOT NULL,
  permanent_city VARCHAR(50) NOT NULL,
  permanent_state VARCHAR(50) NOT NULL,
  permanent_pincode VARCHAR(10) NOT NULL
);

-- Bank details
CREATE TABLE bank_details (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
  bank_name VARCHAR(100) NOT NULL,
  account_no VARCHAR(50) NOT NULL,
  ifsc_code VARCHAR(20) NOT NULL,
  branch_name VARCHAR(100) NOT NULL
);

-- Education table
CREATE TABLE education (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
  level VARCHAR(50),
  stream VARCHAR(50),
  institution VARCHAR(100),
  year VARCHAR(10),
  score VARCHAR(20),
  doc_path TEXT
);

-- Employment history
CREATE TABLE employment_history (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
  company_name VARCHAR(100),
  designation VARCHAR(100),
  department VARCHAR(100),
  last_project VARCHAR(100),
  start_date DATE,
  end_date DATE,
  doc_path TEXT
);

-- Signature & consent
CREATE TABLE signatures (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
  signature_file TEXT NOT NULL,
  consent BOOLEAN NOT NULL,
  status VARCHAR(20) DEFAULT 'pending'
);
