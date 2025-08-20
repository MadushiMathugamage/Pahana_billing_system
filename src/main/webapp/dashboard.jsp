<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pahana Edu - Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            color: white;
            padding: 20px;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 12px;
            margin: 8px 0;
            text-decoration: none;
            background: #34495e;
            border-radius: 6px;
        }

        .sidebar a:hover {
            background: #1abc9c;
        }

        .main {
            flex: 1;
            padding: 20px;
            background: #ecf0f1;
        }

        .main h1 {
            margin-top: 0;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <h2>Pahana Edu</h2>
    <!-- Navigation buttons -->
    <a href="Dashboard.jsp">🏠 Dashboard</a>
    <a href="CustomerManagement.jsp">👤 Manage Customers</a>
    <a href="ItemManagement.jsp">📦 Manage Items</a>
    <a href="BillingManagement.jsp">🧾 Manage Billing</a>
    <a href="Reports.jsp">📊 Reports</a>
</div>

<!-- Main Content -->
<div class="main">
    <h1>Welcome to Pahana Edu Dashboard</h1>
    <p>Select a module from the sidebar to continue.</p>
</div>
</body>
</html>
