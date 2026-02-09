# User Access Management System — Final Project Report

---

## Table of Contents

1. [Abstract](#1-abstract)
2. [Introduction](#2-introduction)
3. [Project Proposal](#3-project-proposal)
4. [System Analysis](#4-system-analysis)
5. [System Design](#5-system-design)
6. [Implementation Details](#6-implementation-details)
7. [Testing & Results](#7-testing--results)
8. [Conclusion & Future Enhancements](#8-conclusion--future-enhancements)
9. [References](#9-references)
10. [Appendices](#10-appendices)

---

## 1. Abstract

The **User Access Management System** is a web-based Java enterprise application designed to manage software access requests within an organization. Built using the Model-View-Controller (MVC) architecture with JSP, Servlets, JDBC, and PostgreSQL, the system implements role-based access control (RBAC) for three user roles: **Admin**, **Manager**, and **Employee**. Employees can request access to software applications, Managers can approve or reject those requests, and Admins can manage both users and software. The system features server-side validation, session management, authentication filters, and a responsive Bootstrap-based UI. The application is deployed on Apache Tomcat 10.1 and uses PostgreSQL 14 for data persistence.

---

## 2. Introduction

### 2.1 Background
In modern organizations, managing who has access to which software applications is critical for security and compliance. Manual access management through emails or spreadsheets is error-prone, lacks audit trails, and creates delays. A centralized digital system streamlines the entire process.

### 2.2 Purpose
This project implements a **User Access Management System** that automates the process of requesting, reviewing, and approving access to software applications. It provides:
- A structured workflow for access requests
- Role-based access control ensuring appropriate authorization
- An audit trail of all requests and their statuses
- CRUD operations for managing users and software

### 2.3 Technology Stack
| Component | Technology |
|-----------|-----------|
| Language | Java 17 |
| Web Framework | Jakarta Servlet 6.0, JSP 3.1 |
| Database | PostgreSQL 14 |
| ORM/Data Access | JDBC with DAO Pattern |
| Application Server | Apache Tomcat 10.1.50 |
| Build Tool | Apache Maven 3.6.3 |
| Frontend | Bootstrap 5.3.2, Font Awesome 6.4 |
| Tag Library | JSTL (Jakarta Standard Tag Library 3.0) |
| Architecture | MVC (Model-View-Controller) |

---

## 3. Project Proposal

### 3.1 Title
**User Access Management System — A Role-Based Web Application for Software Access Control**

### 3.2 Problem Statement
Organizations face challenges in managing software access:
- **No centralized system** to track who has access to what software
- **Manual approval workflows** using email are slow and lack accountability
- **No audit trail** of access requests, approvals, and rejections
- **Security risks** from unmanaged access permissions
- **No role differentiation** between administrators, managers, and regular employees

### 3.3 Objectives
1. Design and implement a web-based access management system using Java MVC architecture
2. Implement role-based access control with three distinct user roles
3. Create a structured approval workflow for software access requests
4. Provide full CRUD functionality for users, software, and requests
5. Ensure robust server-side validation and error handling
6. Deploy the application on a production-grade application server

### 3.4 Scope
The system covers:
- **User Management**: Registration, authentication, role assignment (Admin, Manager, Employee)
- **Software Management**: CRUD operations for software catalog (Admin only)
- **Access Requests**: Employees submit requests with justification
- **Approval Workflow**: Managers approve/reject pending requests
- **Dashboard**: Role-specific views and navigation
- **Security**: Authentication filter, session management, authorization checks

**Out of Scope**: Email notifications, password hashing, LDAP/SSO integration, REST APIs.

### 3.5 Technologies
- Java 17 with Jakarta EE 10 (Servlets & JSP)
- PostgreSQL 14 relational database
- JDBC for database connectivity
- Bootstrap 5 for responsive UI
- Apache Tomcat 10.1 for deployment
- Maven for build management

### 3.6 Expected Outcomes
- A fully functional web application accessible via browser
- Three user roles with appropriate access controls
- Complete CRUD operations for all entities
- A streamlined approval workflow
- Clean, user-friendly interface

---

## 4. System Analysis

### 4.1 Functional Requirements

| ID | Requirement | Description |
|----|------------|-------------|
| FR-01 | User Registration | New users can sign up with username/password, assigned Employee role |
| FR-02 | User Authentication | Users login with credentials; session is created |
| FR-03 | Role-Based Dashboard | Each role sees a customized dashboard with relevant actions |
| FR-04 | Software CRUD (Admin) | Admin can Create, Read, Update, and Delete software entries |
| FR-05 | User CRUD (Admin) | Admin can Create, Read, Update, and Delete user accounts |
| FR-06 | Access Request (Employee) | Employees submit requests for software with access type and reason |
| FR-07 | View My Requests (Employee) | Employees can see the status of their submitted requests |
| FR-08 | Pending Requests (Manager) | Managers view all pending requests in a queue |
| FR-09 | Approve/Reject (Manager) | Managers approve or reject requests with one-click actions |
| FR-10 | Request History (Manager) | Managers can view all historical requests with statuses |
| FR-11 | All Requests View (Admin) | Admin can view all requests across the system |
| FR-12 | Logout | Users can securely log out, invalidating their session |
| FR-13 | Delete Request (Employee) | Employees can cancel their pending requests |

### 4.2 Non-Functional Requirements

| ID | Requirement | Description |
|----|------------|-------------|
| NFR-01 | Security | Authentication required for all non-public pages |
| NFR-02 | Usability | Responsive UI using Bootstrap; intuitive navigation |
| NFR-03 | Performance | Database indexes on frequently queried columns |
| NFR-04 | Maintainability | Clean MVC separation; DAO pattern for data access |
| NFR-05 | Reliability | Server-side validation; error handling; constraint checks |
| NFR-06 | Portability | Standard WAR deployment on any Jakarta EE compatible server |

### 4.3 User Roles

| Role | Permissions |
|------|------------|
| **Admin** | Manage software (CRUD), manage users (CRUD), view all requests |
| **Manager** | View pending requests, approve/reject requests, view request history |
| **Employee** | Submit access requests, view own request statuses, cancel pending requests |

### 4.4 Use Cases

#### Use Case 1: User Registration
- **Actor**: Unregistered User
- **Precondition**: User is on the signup page
- **Flow**: User enters username, password, confirms password → System validates → Creates account with Employee role → Redirects to login
- **Postcondition**: User can log in

#### Use Case 2: Login
- **Actor**: Registered User
- **Precondition**: User has a valid account
- **Flow**: User enters credentials → System authenticates → Creates session → Redirects to role-specific dashboard

#### Use Case 3: Submit Access Request
- **Actor**: Employee
- **Precondition**: Employee is logged in
- **Flow**: Employee selects software → Selects access type → Provides reason → Submits → Request created with "Pending" status

#### Use Case 4: Approve/Reject Request
- **Actor**: Manager
- **Precondition**: There are pending requests
- **Flow**: Manager views pending requests → Clicks Approve or Reject → Status updated to "Approved" or "Rejected"

#### Use Case 5: Manage Software
- **Actor**: Admin
- **Precondition**: Admin is logged in
- **Flow**: Admin creates/edits/deletes software entries with name, description, and access level

#### Use Case 6: Manage Users
- **Actor**: Admin
- **Precondition**: Admin is logged in
- **Flow**: Admin creates/edits/deletes user accounts, assigns roles

---

## 5. System Design

### 5.1 MVC Architecture

The application follows the **Model-View-Controller** pattern:

```
┌─────────────┐     ┌──────────────────┐     ┌─────────────┐
│   Browser    │────▶│   Controller     │────▶│    Model     │
│   (Client)   │     │   (Servlets)     │     │ (DAO/Beans)  │
│              │◀────│                  │◀────│              │
└─────────────┘     └──────────────────┘     └─────────────┘
       │                     │                       │
       │              ┌──────┴──────┐         ┌──────┴──────┐
       │              │    View     │         │  Database   │
       └─────────────▶│   (JSP)     │         │ (PostgreSQL)│
                      └─────────────┘         └─────────────┘
```

- **Model**: JavaBeans (`User`, `Software`, `Request`), DAO classes (`UserDAO`, `SoftwareDAO`, `RequestDAO`), Utility (`DBUtil`)
- **View**: JSP pages with JSTL and Bootstrap (`login.jsp`, `signup.jsp`, `dashboard.jsp`, `createSoftware.jsp`, `requestAccess.jsp`, `pendingRequests.jsp`, `manageUsers.jsp`, `allRequests.jsp`)
- **Controller**: Servlets (`LoginServlet`, `SignUpServlet`, `LogoutServlet`, `SoftwareServlet`, `RequestServlet`, `ApprovalServlet`, `PendingRequestsServlet`, `AdminUserServlet`, `AdminRequestServlet`)

### 5.2 Use Case Diagram (Description)

```
                    ┌───────────────────────────────┐
                    │   User Access Management      │
                    │          System                │
                    │                               │
  ┌────────┐       │  ┌──────────────────────┐     │
  │Employee│───────┼─▶│  Register/Login       │     │
  │        │───────┼─▶│  Submit Request       │     │
  │        │───────┼─▶│  View My Requests     │     │
  │        │───────┼─▶│  Cancel Request       │     │
  └────────┘       │  └──────────────────────┘     │
                    │                               │
  ┌────────┐       │  ┌──────────────────────┐     │
  │Manager │───────┼─▶│  Login                │     │
  │        │───────┼─▶│  View Pending Requests│     │
  │        │───────┼─▶│  Approve/Reject       │     │
  │        │───────┼─▶│  View Request History │     │
  └────────┘       │  └──────────────────────┘     │
                    │                               │
  ┌────────┐       │  ┌──────────────────────┐     │
  │ Admin  │───────┼─▶│  Login                │     │
  │        │───────┼─▶│  Manage Software(CRUD)│     │
  │        │───────┼─▶│  Manage Users (CRUD)  │     │
  │        │───────┼─▶│  View All Requests    │     │
  └────────┘       │  └──────────────────────┘     │
                    └───────────────────────────────┘
```

### 5.3 Class Diagram (Description)

**Model Classes:**
- `User` (id, username, password, role) — maps to `users` table
- `Software` (id, name, description, accessLevels) — maps to `software` table
- `Request` (id, userId, softwareId, accessType, reason, status, createdAt, username, softwareName) — maps to `requests` table with joined display fields

**DAO Classes:**
- `UserDAO` — authenticate(), create(), findById(), findByUsername(), findAll(), update(), delete(), usernameExists()
- `SoftwareDAO` — create(), findById(), findByName(), findAll(), update(), delete()
- `RequestDAO` — create(), findById(), findAll(), findPending(), findByUserId(), updateStatus(), delete()

**Controller Classes (Servlets):**
- `LoginServlet` — doPost() for authentication, doGet() for redirect
- `SignUpServlet` — doPost() for registration with validation
- `LogoutServlet` — doGet() for session invalidation
- `SoftwareServlet` — CRUD actions (list, create, edit, update, delete)
- `RequestServlet` — form display, submit request, delete request
- `ApprovalServlet` — doPost() for approve/reject
- `PendingRequestsServlet` — doGet() for pending and all requests
- `AdminUserServlet` — CRUD actions for user management
- `AdminRequestServlet` — doGet() for all requests view

**Utility:**
- `DBUtil` — getConnection(), close()

**Filter:**
- `AuthenticationFilter` — intercepts all requests, allows public URLs, blocks unauthenticated access

### 5.4 Sequence Diagram (Description)

**Login Sequence:**
1. User → `login.jsp`: Enters credentials
2. `login.jsp` → `LoginServlet`: POST (username, password)
3. `LoginServlet` → `UserDAO.authenticate()`: Validates credentials
4. `UserDAO` → Database: SELECT query
5. Database → `UserDAO`: Returns User or null
6. `UserDAO` → `LoginServlet`: User object
7. `LoginServlet` → Session: Stores user, role
8. `LoginServlet` → `dashboard.jsp`: Redirect

**Access Request Sequence:**
1. Employee → `RequestServlet` (GET): action=form
2. `RequestServlet` → `SoftwareDAO.findAll()`: Get software list
3. `RequestServlet` → `RequestDAO.findByUserId()`: Get employee's requests
4. `RequestServlet` → `requestAccess.jsp`: Forward with data
5. Employee → `RequestServlet` (POST): Submit form
6. `RequestServlet` → `RequestDAO.create()`: Insert request
7. `RequestDAO` → Database: INSERT query
8. `RequestServlet` → Employee: Redirect with success message

**Approval Sequence:**
1. Manager → `PendingRequestsServlet` (GET): View pending
2. `PendingRequestsServlet` → `RequestDAO.findPending()`: Get pending requests
3. Manager → `ApprovalServlet` (POST): Approve/Reject
4. `ApprovalServlet` → `RequestDAO.updateStatus()`: Update status
5. `RequestDAO` → Database: UPDATE query
6. `ApprovalServlet` → Manager: Redirect to pending requests

### 5.5 ER Diagram (Description)

```
┌──────────────┐        ┌──────────────┐        ┌──────────────┐
│    users     │        │   requests   │        │   software   │
├──────────────┤        ├──────────────┤        ├──────────────┤
│ PK id        │───┐    │ PK id        │    ┌───│ PK id        │
│ username     │   │    │ FK user_id   │────┘   │ name         │
│ password     │   └───▶│ FK software_id│       │ description  │
│ role         │        │ access_type  │        │ access_levels│
│ created_at   │        │ reason       │        │ created_at   │
└──────────────┘        │ status       │        └──────────────┘
                        │ created_at   │
                        └──────────────┘

Relationships:
- users (1) ──── (N) requests : One user can have many requests
- software (1) ──── (N) requests : One software can have many requests
```

**Normalization (3NF):**
- All tables have atomic values (1NF)
- No partial dependencies — all non-key attributes depend on the full primary key (2NF)
- No transitive dependencies — `username` and `softwareName` are joined at query time, not stored in `requests` (3NF)

---

## 6. Implementation Details

### 6.1 Project Structure

```
UserAccessManagement/
├── pom.xml                          # Maven build configuration
├── sql/
│   └── setup.sql                    # Database schema & sample data
├── src/main/
│   ├── java/com/useraccess/
│   │   ├── controller/              # Servlets (Controller layer)
│   │   │   ├── LoginServlet.java
│   │   │   ├── SignUpServlet.java
│   │   │   ├── LogoutServlet.java
│   │   │   ├── SoftwareServlet.java
│   │   │   ├── RequestServlet.java
│   │   │   ├── ApprovalServlet.java
│   │   │   ├── PendingRequestsServlet.java
│   │   │   ├── AdminUserServlet.java
│   │   │   └── AdminRequestServlet.java
│   │   ├── dao/                     # Data Access Objects
│   │   │   ├── UserDAO.java
│   │   │   ├── SoftwareDAO.java
│   │   │   └── RequestDAO.java
│   │   ├── filter/                  # Security filters
│   │   │   └── AuthenticationFilter.java
│   │   ├── model/                   # JavaBean model classes
│   │   │   ├── User.java
│   │   │   ├── Software.java
│   │   │   └── Request.java
│   │   └── util/                    # Utilities
│   │       └── DBUtil.java
│   └── webapp/
│       ├── WEB-INF/web.xml          # Deployment descriptor
│       ├── login.jsp                # Login page
│       ├── signup.jsp               # Registration page
│       ├── dashboard.jsp            # Role-based dashboard
│       ├── createSoftware.jsp       # Admin: Software management
│       ├── manageUsers.jsp          # Admin: User management
│       ├── allRequests.jsp          # Admin: All requests view
│       ├── requestAccess.jsp        # Employee: Request form & history
│       └── pendingRequests.jsp      # Manager: Approval queue
└── docs/                            # Documentation
```

### 6.2 Database Configuration (DBUtil.java)
The `DBUtil` class manages JDBC connections using PostgreSQL driver, connecting to `useraccess_db` on `localhost:5432`.

### 6.3 Authentication Filter
The `AuthenticationFilter` intercepts all HTTP requests. Public resources (login, signup, CSS) are allowed through. All other requests require a valid session with a `user` attribute.

### 6.4 DAO Pattern
Each entity has a dedicated DAO class:
- **UserDAO**: Full CRUD + authenticate + usernameExists
- **SoftwareDAO**: Full CRUD + findByName
- **RequestDAO**: Full CRUD + findPending + findByUserId + updateStatus

### 6.5 Server-Side Validation
All servlets perform robust validation:
- Null/empty checks for all form fields
- Username minimum 3 characters
- Password minimum 6 characters
- Password confirmation matching
- Duplicate username detection
- Numeric parsing with error handling
- Role authorization checks

### 6.6 Session Management
- Sessions created on login with 30-minute timeout
- User object, user_id, username, and role stored in session
- Session invalidated on logout
- Filter prevents access without valid session

---

## 7. Testing & Results

### 7.1 Test Cases

| # | Test Case | Input | Expected Result | Actual Result | Status |
|---|-----------|-------|-----------------|---------------|--------|
| 1 | Login with valid Admin | admin / admin123 | Redirect to dashboard (Admin view) | Dashboard loads with Admin cards | PASS |
| 2 | Login with valid Manager | manager / manager123 | Redirect to dashboard (Manager view) | Dashboard loads with Manager cards | PASS |
| 3 | Login with valid Employee | john_doe / employee123 | Redirect to dashboard (Employee view) | Dashboard loads with Employee cards | PASS |
| 4 | Login with invalid credentials | wrong / wrong | Error message on login page | "Invalid username or password" shown | PASS |
| 5 | Login with empty fields | (empty) | Error message | "Username and password are required" | PASS |
| 6 | Sign up new user | newuser / pass123 / pass123 | Account created, redirect to login | Registration successful message shown | PASS |
| 7 | Sign up with existing username | admin / pass123 | Error message | "Username already exists" shown | PASS |
| 8 | Sign up with short password | user / abc | Error message | "Password must be at least 6 characters" | PASS |
| 9 | Sign up with mismatched passwords | user / pass123 / pass456 | Error message | "Passwords do not match" | PASS |
| 10 | Admin: Create software | TestApp / Desc / Read | Software added to list | Software appears in table | PASS |
| 11 | Admin: Edit software | Change name to TestApp2 | Software updated in list | Updated name shown | PASS |
| 12 | Admin: Delete software | Delete TestApp2 | Software removed from list | Software no longer in table | PASS |
| 13 | Admin: Create user | testmgr / pass123 / Manager | User added to list | User appears with Manager badge | PASS |
| 14 | Admin: Edit user role | Change to Employee | User role updated | Employee badge shown | PASS |
| 15 | Admin: Delete user | Delete testmgr | User removed from list | User no longer in table | PASS |
| 16 | Admin: View all requests | Navigate to All Requests | All requests displayed with statuses | Table shows all requests | PASS |
| 17 | Employee: Submit request | Select Salesforce / Read / "Need access" | Request created as Pending | Request appears in My Requests table | PASS |
| 18 | Employee: Submit without reason | No reason entered | Validation error | "Please provide a reason" shown | PASS |
| 19 | Employee: Cancel pending request | Click delete on pending | Request removed | Request no longer in list | PASS |
| 20 | Manager: View pending requests | Navigate to Pending Requests | Pending requests displayed | Table shows pending items | PASS |
| 21 | Manager: Approve request | Click Approve | Status changes to Approved | "Request has been approved" message | PASS |
| 22 | Manager: Reject request | Click Reject | Status changes to Rejected | "Request has been rejected" message | PASS |
| 23 | Unauthorized access | Employee tries /SoftwareServlet | Redirect to login with error | "Unauthorized access" shown | PASS |
| 24 | Session expiry | Access after 30 min | Redirect to login | "Please log in first" shown | PASS |
| 25 | Logout | Click Logout | Session invalidated, redirect to login | "Successfully logged out" message | PASS |

### 7.2 Sample Test Data

**Users:**
| Username | Password | Role |
|----------|----------|------|
| admin | admin123 | Admin |
| manager | manager123 | Manager |
| john_doe | employee123 | Employee |
| jane_smith | employee123 | Employee |
| bob_wilson | employee123 | Employee |

**Software:**
| Name | Description | Access Level |
|------|-------------|-------------|
| Salesforce CRM | Customer relationship management platform | Read |
| GitHub Enterprise | Source code repository and collaboration tool | Write |
| AWS Console | Amazon Web Services cloud management console | Admin |
| Jira | Project management and issue tracking software | Read |
| Slack Enterprise | Team communication and collaboration platform | Write |

**Sample Requests:**
| Employee | Software | Access Type | Reason | Status |
|----------|----------|-------------|--------|--------|
| john_doe | Salesforce CRM | Read | Need CRM access for sales reporting project | Pending |
| john_doe | GitHub Enterprise | Write | Need to commit code for the Q1 feature sprint | Approved |
| jane_smith | AWS Console | Read | Need to monitor server infrastructure | Pending |
| jane_smith | Jira | Write | Need to create and manage project tickets | Rejected |
| bob_wilson | Slack Enterprise | Read | Need access to team communication channels | Pending |

### 7.3 Test Evidence Descriptions

1. **Login Success**: Login page with Bootstrap UI renders correctly. Entering valid credentials redirects to role-specific dashboard with welcome message and navigation cards.

2. **Login Failure**: Entering invalid credentials shows a red alert banner with "Invalid username or password" on the login page.

3. **Admin Software CRUD**: Admin dashboard shows three cards. Clicking "Manage Software" shows a split-view: form on the left, software table on the right. Creating software adds a row. Edit populates the form. Delete removes with confirmation dialog.

4. **Admin User CRUD**: Similar split-view for users. Role badges are color-coded (Admin=red, Manager=yellow, Employee=blue). Admin cannot delete their own account.

5. **Employee Request Form**: Employee sees a dropdown of all software, access type selector, and reason textarea. After submission, the request appears in "My Requests" table with a "Pending" badge.

6. **Manager Approval**: Manager sees pending requests with Approve (green) and Reject (red) buttons. Below is a history table showing all requests with color-coded status badges.

7. **Validation Errors**: All forms display Bootstrap alert dismissible messages for validation failures.

---

## 8. Conclusion & Future Enhancements

### 8.1 Conclusion
The User Access Management System successfully implements all required functionality:
- **Role-Based Access Control** with three user roles (Admin, Manager, Employee)
- **Full CRUD operations** for users, software, and access requests
- **Structured approval workflow** with status transitions (Pending → Approved/Rejected)
- **Security features** including authentication filter, session management, and authorization checks
- **Server-side validation** for all form inputs
- **Clean MVC architecture** with proper separation of concerns
- **Responsive UI** using Bootstrap 5 with consistent design across all pages
- **PostgreSQL database** with normalized schema (3NF) and proper constraints

The application is fully deployed and operational on Apache Tomcat 10.1, demonstrating proficiency in Java web development, database design, and enterprise application architecture.

### 8.2 Future Enhancements

1. **Password Hashing**: Implement BCrypt password hashing for secure credential storage
2. **Email Notifications**: Send email alerts when requests are submitted/approved/rejected
3. **Audit Logging**: Maintain a log of all system actions with timestamps
4. **Search & Filtering**: Add search/filter functionality to data tables
5. **Pagination**: Implement pagination for large datasets
6. **REST API**: Add RESTful endpoints for mobile/API integration
7. **SSO Integration**: Support LDAP/Active Directory/OAuth for enterprise SSO
8. **Connection Pooling**: Implement HikariCP or c3p0 for database connection pooling
9. **Unit Testing**: Add JUnit tests for DAO and Servlet layers
10. **Docker Deployment**: Containerize the application for cloud deployment

---

## 9. References

1. Oracle. "Jakarta Servlet Specification 6.0." Jakarta EE, 2022.
2. Oracle. "JavaServer Pages (JSP) Specification 3.1." Jakarta EE, 2022.
3. PostgreSQL Global Development Group. "PostgreSQL 14 Documentation." postgresql.org, 2024.
4. Apache Software Foundation. "Apache Tomcat 10.1 Documentation." tomcat.apache.org, 2024.
5. Apache Software Foundation. "Apache Maven Documentation." maven.apache.org, 2024.
6. Bootstrap Team. "Bootstrap 5.3 Documentation." getbootstrap.com, 2024.
7. Fowler, Martin. "Patterns of Enterprise Application Architecture." Addison-Wesley, 2002.
8. Bauer, Christian, and Gavin King. "Java Persistence with Hibernate." Manning, 2015.
9. Oracle. "JDBC API Documentation." docs.oracle.com, 2024.
10. Font Awesome. "Font Awesome 6 Documentation." fontawesome.com, 2024.

---

## 10. Appendices

### Appendix A: Database Schema (setup.sql)

The database consists of three tables in 3rd Normal Form:

```sql
-- Users table with role constraint
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('Employee', 'Manager', 'Admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Software table with access level constraint
CREATE TABLE software (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    access_levels VARCHAR(50) CHECK (access_levels IN ('Read', 'Write', 'Admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Requests table with foreign keys and status constraint
CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    software_id INTEGER NOT NULL REFERENCES software(id) ON DELETE CASCADE,
    access_type VARCHAR(20) NOT NULL CHECK (access_type IN ('Read', 'Write', 'Admin')),
    reason TEXT,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Approved', 'Rejected')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Appendix B: Key Code Explanations

#### B.1 Authentication Filter
The `AuthenticationFilter` implements `jakarta.servlet.Filter` with `@WebFilter("/*")` to intercept all requests. It checks if the requested URI is a public resource (login, signup, CSS). If not, it verifies the session contains a `user` attribute. Unauthenticated users are redirected to the login page.

#### B.2 DAO Pattern
Each DAO class encapsulates all database operations for its entity. Connections are obtained from `DBUtil.getConnection()` and managed with try-with-resources for automatic cleanup. PreparedStatements prevent SQL injection. The `mapRow()` method converts ResultSet rows to Java objects.

#### B.3 Servlet Request Routing
Servlets use action parameters to route requests to appropriate handler methods. For example, `SoftwareServlet` handles: `list` (display all), `create` (add new), `edit` (show form), `update` (save changes), `delete` (remove). GET requests handle navigation; POST requests handle data modifications.

#### B.4 JSTL in JSP
JSP pages use Jakarta Standard Tag Library (JSTL) with `<c:forEach>`, `<c:if>`, and `<c:choose>` tags to iterate over data, conditionally render content, and display role-specific UI elements without scriptlet code.

### Appendix C: Deployment Instructions

```bash
# 1. Create database
sudo -u postgres psql -c "CREATE DATABASE useraccess_db;"

# 2. Run schema setup
PGPASSWORD=password psql -h 127.0.0.1 -U postgres -d useraccess_db -f sql/setup.sql

# 3. Build project
mvn clean package -DskipTests

# 4. Deploy to Tomcat
cp target/UserAccessManagement.war /opt/tomcat/webapps/

# 5. Start Tomcat
/opt/tomcat/bin/startup.sh

# 6. Access application
# http://localhost:8080/UserAccessManagement/login.jsp
```

### Appendix D: Application URLs

| URL | Description | Access |
|-----|-------------|--------|
| `/login.jsp` | Login page | Public |
| `/signup.jsp` | Registration page | Public |
| `/dashboard.jsp` | Role-based dashboard | Authenticated |
| `/SoftwareServlet?action=list` | Software management | Admin |
| `/AdminUserServlet?action=list` | User management | Admin |
| `/AdminRequestServlet?action=list` | All requests view | Admin |
| `/RequestServlet?action=form` | Access request form | Employee |
| `/PendingRequestsServlet` | Pending requests queue | Manager |
| `/ApprovalServlet` | Approve/Reject (POST) | Manager |
| `/LogoutServlet` | Logout | Authenticated |

---

*Document generated: February 2026*
*System: User Access Management System v1.0-SNAPSHOT*
