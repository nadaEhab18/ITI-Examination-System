# ITI Examination System Database

## 📘 Project Overview

The **ITI Examination System Database** is designed to manage and automate the process of creating, conducting, and evaluating exams for educational institutions. The system provides a centralized platform for managing courses, instructors, students, and examinations, ensuring data integrity, security, and efficiency.

---

## 🎯 Objectives

* Provide a **question pool** with multiple question types (MCQ, True/False, Text).
* Enable instructors to **create exams** by selecting questions manually or randomly.
* Allow the system to **auto-grade** objective questions and support manual grading for text answers.
* Facilitate **role-based access** for administrators, training managers, instructors, and students.
* Automate **exam scheduling**, **student access**, and **result calculation**.

---

## ⚙️ System Features

### 1. **Question Pool Management**

* Supports Multiple Choice, True/False, and Text questions.
* Stores correct answers for auto-grading.
* Supports regular expressions for validating text answers.

### 2. **Course & User Management**

* Stores data for courses, instructors, and students.
* Each instructor can teach one or more courses.
* Managed by a **Training Manager**, who can add/edit branches, tracks, and intakes.

### 3. **Exam Creation & Execution**

* Instructors create exams by selecting questions manually or randomly.
* Ensures exam total marks do not exceed the course’s maximum degree.
* Defines exam metadata: type, intake, branch, track, course, start/end time, and duration.
* Students can take exams only within the defined time window.

### 4. **Result Management**

* Stores student answers.
* Auto-calculates grades for objective questions.
* Displays results for manual grading of text questions.

### 5. **User Roles & Permissions**

* **Admin:** Manages the system structure and user permissions.
* **Training Manager:** Handles branches, tracks, intakes, and student records.
* **Instructor:** Creates exams and reviews results.
* **Student:** Takes exams and views results.

### 6. **Backup & Security**

* Implements **daily automatic database backups**.
* Enforces **data integrity** using constraints, triggers, and permissions.

---

## 🧠 Technical Details

### Database Design

* Designed using **SQL Server** with appropriate file groups based on data size.
* Consistent **naming conventions** applied across all objects.
* Includes **indexes** for optimized query performance.
* Utilizes **constraints and triggers** for data integrity and user access control.
* Implements **stored procedures**, **functions**, and **views** to perform all system tasks.

### User Accounts

| Role             | Permissions                                           |
| ---------------- | ----------------------------------------------------- |
| Admin            | Full control over all objects and users               |
| Training Manager | Manage branches, tracks, intakes, and student records |
| Instructor       | Manage exams and review results                       |
| Student          | Take exams and view results                           |

### Backup System

* Configured for **daily automated backups** using SQL Server Agent.

---

## 📦 Project Deliverables

1. **System Requirement Sheet**
2. **Entity Relationship Diagram (ERD)**
3. **Database Files and SQL Server Solution**

   * Individual scripts for each team member.
   * Master script for full database structure and data.
4. **Object Description Document** (Views, Procedures, Functions, Triggers, etc.)
5. **Test Sheet** (Queries, results, comments)
6. **User Accounts & Credentials File**

---

## 🧰 Tools & Technologies

* **SQL Server Management Studio (SSMS)**
* **T-SQL (Procedures, Functions, Triggers)**
* **ERD Modeling Tools** (e.g., draw.io, )
* **SQL Server Agent** for scheduling backups

