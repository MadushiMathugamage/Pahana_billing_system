<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 04/08/2025
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Pahana Edu Dashboard</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
      margin: 0;
      padding: 2rem;
      color: #1e293b;
    }

    h1 {
      font-size: 2rem;
      font-weight: bold;
    }

    .subtitle {
      color: #64748b;
      margin-top: 0.25rem;
      margin-bottom: 2rem;
    }

    .grid {
      display: grid;
      gap: 1.5rem;
    }

    .stats-grid {
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    }

    .cards-grid {
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      margin-top: 2rem;
    }

    .card {
      background-color: white;
      border-radius: 0.75rem;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      padding: 1.25rem;
      transition: box-shadow 0.3s;
    }

    .card:hover {
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
    }

    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }

    .card-title {
      font-size: 0.875rem;
      color: #475569;
      font-weight: 600;
    }

    .icon-box {
      width: 40px;
      height: 40px;
      border-radius: 9999px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .value {
      font-size: 1.5rem;
      font-weight: bold;
      color: #1e293b;
    }

    .list-item {
      display: flex;
      align-items: center;
      gap: 1rem;
      margin-bottom: 1rem;
    }

    .avatar {
      width: 40px;
      height: 40px;
      border-radius: 9999px;
      background-color: #f1f5f9;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.1rem;
    }

    .name {
      font-weight: 600;
      color: #1e293b;
    }

    .meta {
      font-size: 0.875rem;
      color: #64748b;
    }

    .meta.red {
      color: #dc2626;
    }

    .bg-blue { background-color: #dbeafe; color: #2563eb; }
    .bg-green { background-color: #bbf7d0; color: #16a34a; }
    .bg-purple { background-color: #e9d5ff; color: #7e22ce; }
    .bg-orange { background-color: #fed7aa; color: #ea580c; }
    .bg-red { background-color: #fecaca; color: #dc2626; }
  </style>
</head>
<body>

<h1>Dashboard</h1>
<p class="subtitle">Welcome to Pahana Edu Management System</p>

<!-- Stats -->
<div class="grid stats-grid">
  <div class="card">
    <div class="card-header">
      <div class="card-title">Total Customers</div>
      <div class="icon-box bg-blue">👥</div>
    </div>
    <div class="value" id="totalCustomers">0</div>
  </div>

  <div class="card">
    <div class="card-header">
      <div class="card-title">Total Items</div>
      <div class="icon-box bg-green">📦</div>
    </div>
    <div class="value" id="totalItems">0</div>
  </div>

  <div class="card">
    <div class="card-header">
      <div class="card-title">Total Bills</div>
      <div class="icon-box bg-purple">🧾</div>
    </div>
    <div class="value" id="totalBills">0</div>
  </div>

  <div class="card">
    <div class="card-header">
      <div class="card-title">Total Stock Value</div>
      <div class="icon-box bg-orange">📈</div>
    </div>
    <div class="value" id="stockValue">Rs. 0</div>
  </div>
</div>

<!-- Lists -->
<div class="grid cards-grid">
  <!-- Recent Customers -->
  <div class="card">
    <div class="card-header">
      <div class="card-title">Recent Customers</div>
    </div>
    <div id="recentCustomers"></div>
  </div>

  <!-- Low Stock Items -->
  <div class="card">
    <div class="card-header">
      <div class="card-title">Low Stock Items</div>
    </div>
    <div id="lowStockItems"></div>
  </div>
</div>

<script>
  // Simulated App State
  const state = {
    customers: [
      { id: 1, name: "Nimal Perera", accountNumber: "AC1001" },
      { id: 2, name: "Sunil Kumara", accountNumber: "AC1002" },
      { id: 3, name: "Kamal Silva", accountNumber: "AC1003" },
      { id: 4, name: "Nadeesha Fernando", accountNumber: "AC1004" },
      { id: 5, name: "Ishara Wijesinghe", accountNumber: "AC1005" },
    ],
    items: [
      { id: 1, name: "A4 Paper", price: 50, stock: 120 },
      { id: 2, name: "Pen", price: 20, stock: 15 },
      { id: 3, name: "Notebook", price: 120, stock: 10 },
      { id: 4, name: "Marker", price: 40, stock: 25 },
      { id: 5, name: "Eraser", price: 10, stock: 5 },
    ],
    bills: [
      { id: 1 }, { id: 2 }, { id: 3 }, { id: 4 },
    ]
  };

  // Inject Stats
  document.getElementById("totalCustomers").textContent = state.customers.length;
  document.getElementById("totalItems").textContent = state.items.length;
  document.getElementById("totalBills").textContent = state.bills.length;

  const totalValue = state.items.reduce((sum, item) => sum + item.price * item.stock, 0);
  document.getElementById("stockValue").textContent = "Rs. " + totalValue.toLocaleString();

  // Recent Customers
  const customersList = document.getElementById("recentCustomers");
  state.customers.slice(0, 5).forEach(c => {
    customersList.innerHTML += `
        <div class="list-item">
          <div class="avatar">👤</div>
          <div>
            <div class="name">${c.name}</div>
            <div class="meta">${c.accountNumber}</div>
          </div>
        </div>
      `;
  });

  // Low Stock Items
  const lowStock = document.getElementById("lowStockItems");
  state.items.filter(i => i.stock < 20).slice(0, 5).forEach(i => {
    lowStock.innerHTML += `
        <div class="list-item">
          <div class="avatar bg-red">📦</div>
          <div>
            <div class="name">${i.name}</div>
            <div class="meta red">Stock: ${i.stock} units</div>
          </div>
        </div>
      `;
  });
</script>
</body>
</html>

