📚 Pahana Edu Bookshop Billing System
A comprehensive web-based billing and inventory management system for bookshop, built with Java EE (Jakarta EE) and MySQL.

🚀 Features
👥 User Management
📋 Role-based Access Control   → Admin and Cashier roles
🔐 Secure Authentication       → BCrypt password hashing  
⚙️ User CRUD Operations        → Add, edit, delete users (admin only)
👤 Customer Management
📝 Customer Registration      → Profile management with contact details
📊 Account Tracking           → Units consumed and purchase history
🔄 Status Management          → Active/Inactive customer states
📦 Inventory Management
📚 Complete Catalog           → Books/items with detailed information
📈 Stock Tracking             → Real-time inventory levels
🏷️  Category Organization     → Author, publisher, category-wise sorting
💰 Price Management           → Dynamic pricing and cost tracking
🧾 Billing System
⚡ Real-time Generation       → Instant bill creation
💳 Payment Methods            → Cash, Card, Digital payments
🎯 Calculations               → Automatic discount and tax computation
📨 Email Integration          → PDF bills sent automatically
📚 History Tracking           → Complete bill audit trail
🎨 Design Patterns
👁️ Observer Pattern          → Email notifications for bill events
🏭 Factory Pattern           → DAO layer abstraction
🔧 Service Layer             → Clean business logic separation
🛠️ Technology Stack
// Backend Technologies
Backend     : Java EE (Jakarta EE), Servlets, JSP
Database    : MySQL 8.0+
Security    : BCrypt Password Hashing
Email       : Jakarta Mail API
PDF         : Custom PDF Generation
Build       : Maven
Server      : Apache Tomcat 10+
Patterns    : Observer, Factory, DAO, MVC etc
📋 Prerequisites
☕ Java 10 or higher
🐱 Apache Tomcat 10+
🐬 MySQL 8.0+
📦 Maven 3.6+
⚙️ Installation & Setup
1. 🗄️ Database Setup
-- Create Database
CREATE DATABASE pahana_billing;
USE pahana_billing;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Customers Table  
CREATE TABLE customers (
    account_no INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    units_consumed INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Items Table
CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category VARCHAR(50),
    author VARCHAR(100),
    publisher VARCHAR(100),
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bills Table
CREATE TABLE bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    account_no INT,
    user_id INT,
    bill_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    discount DECIMAL(10,2) DEFAULT 0,
    tax DECIMAL(10,2) DEFAULT 0,
    paid_amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    status VARCHAR(20),
    remarks TEXT,
    FOREIGN KEY (account_no) REFERENCES customers(account_no),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Bill Items Table
CREATE TABLE bill_items (
    bill_item_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT,
    item_id INT,
    quantity INT NOT NULL,
    item_price DECIMAL(10,2),
    discount DECIMAL(10,2) DEFAULT 0,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);
2. 🔧 Database Configuration
// Update DBConnection.java
private static final String URL = "[jdbc:mysql://localhost:3306/pahana_billing](http://localhost:8080/Final_project_war_exploded/index.jsp)";
private static final String USER = "your_username";
private static final String PASSWORD = "your_password";
3. 📧 Email Configuration
// Configure EmailWithAttachmentUtil.java
String from = "your-email@gmail.com";
String password = "your-app-password"; // Gmail App Password required
String host = "smtp.gmail.com";
4. 👤 Initial User Setup
# Run the initial user creation
java com.pahana.pahanaedubookshopbilling.service.CreateInitialUsers
// Default Credentials Created:
Admin User:
  Username: "--------"
  Password: "--------"
  Role: "------"

Cashier User:
  Username: "-------" 
  Password: "-------"
  Role: "-------"
5. 🚀 Deployment
# Build the project
mvn clean package

# Deploy to Tomcat
cp target/pahana-billing.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh

# Access application
[http://localhost:8080/pahana-billing](http://localhost:8080/Final_project_war_exploded/index.jsp)
🎯 Usage Guide
🔑 Login Process
1. Navigate to: http://[localhost:8080/pahana-billing](http://localhost:8080/Final_project_war_exploded/index.jsp)
2. Enter credentials (see default users above)
3. System redirects based on role:
   - Admin    → /admin/dashboard.jsp
   - Cashier  → /cashier/dashboard.jsp
👑 Admin Dashboard
✅ User Management        → Add/Edit/Delete system users
✅ System Overview       → Complete access to all modules  
✅ Reports & Analytics   → Business insights and reports
✅ Configuration         → System settings and preferences
🧑‍💼 Cashier Dashboard
✅ Customer Management   → Register and manage customers
✅ Inventory Control     → Add/Update items and stock
✅ Bill Generation       → Create and process bills
✅ Payment Processing    → Handle multiple payment methods
✅ Bill History         → View past transactions
🔄 Key Workflows
graph LR
    A[Customer Registration] --> B[Add Items to Inventory]
    B --> C[Create Bill]
    C --> D[Apply Discounts/Tax]
    D --> E[Process Payment]
    E --> F[Generate PDF]
    F --> G[Send Email]
📁 Project Architecture
📦 src/main/java/com/pahana/pahanaedubookshopbilling/
├── 🗃️  dao/                 # Data Access Objects
│   ├── UserDAO.java         # User database operations
│   ├── CustomerDAO.java     # Customer database operations  
│   ├── ItemDAO.java         # Item database operations
│   ├── BillDAO.java         # Bill database operations
│   └── BillItemDAO.java     # Bill items database operations
│
├── 🏭 factory/              # Factory Pattern Implementation
│   └── DAOFactory.java      # DAO object creation factory
│
├── 📊 model/                # Entity/Domain Models
│   ├── User.java           # User entity
│   ├── Customer.java       # Customer entity
│   ├── Item.java           # Item/Book entity
│   ├── Bill.java           # Bill entity
│   └── BillItem.java       # Bill line item entity
│
├── 👁️  observer/           # Observer Pattern
│   └── EmailNotificationObserver.java  # Email notifications
│
├── 🔧 service/             # Business Logic Layer
│   ├── AuthenticationService.java      # Login/Security
│   ├── UserService.java               # User business logic
│   ├── BillingService.java            # Billing operations
│   └── BillEmailService.java          # Email services
│
├── 🌐 servlet/             # Web Controllers (MVC)
│   ├── LoginServlet.java              # Authentication
│   ├── ItemServlet.java               # Item management
│   ├── CustomerServlet.java           # Customer management
│   ├── BillingServlet.java            # Bill processing
│   └── AddUserServlet.java            # User management
│
└── 🛠️  util/              # Utility Classes
    └── DBConnection.java              # Database connection
🔒 Security Implementation
// Password Security
BCrypt.hashpw(password, BCrypt.gensalt())    // Hashing
BCrypt.checkpw(plain, hashed)                // Verification

// SQL Injection Prevention  
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, userInput);

// Session Management
HttpSession session = request.getSession();
session.setAttribute("user", authenticatedUser);

// Role-Based Access
if (!"admin".equals(user.getRole())) {
    response.sendRedirect("unauthorized.jsp");
}
📧 Email System
// Automatic Bill Email with PDF
public void sendBillEmailWithAttachment(Bill bill, Customer customer) {
    // 1. Generate PDF bill
    String pdfPath = BillPdfGenerator.generateBillPdf(bill, customer, items);
    
    // 2. Send email with attachment
    EmailWithAttachmentUtil.sendMailWithAttachment(
        customerEmail, subject, body, pdfFile
    );
}
🏃‍♂️ Quick Start
# Clone repository
git clone https://github.com/yourusername/pahana-edu-bookshop.git
cd pahana-edu-bookshop

# Setup database
mysql -u root -p < database/schema.sql

# Configure application
# Edit src/main/java/.../util/DBConnection.java
# Edit src/main/java/.../service/EmailWithAttachmentUtil.java

# Build and deploy
mvn clean package
cp target/*.war $TOMCAT_HOME/webapps/

# Start server
$TOMCAT_HOME/bin/startup.sh

