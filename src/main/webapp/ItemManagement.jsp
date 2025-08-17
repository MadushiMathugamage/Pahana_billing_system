<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Pahana Edu - Sidebar & Item Management with Add Item Form</title>

  <!-- Lucide Icons -->
  <script src="https://unpkg.com/lucide@latest"></script>

  <style>
    body, html {
      margin: 0; padding: 0; height: 100%;
      font-family: Arial, sans-serif;
    }
    .container {
      display: flex;
      height: 100vh;
    }
    /* Sidebar */
    .sidebar {
      width: 260px;
      background: #fff;
      border-right: 1px solid #e5e7eb;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .sidebar-header {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 24px;
      border-bottom: 1px solid #e5e7eb;
    }
    .logo-icon {
      width: 40px; height: 40px;
      background: #0ea5e9;
      color: white;
      border-radius: 8px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .logo-title {
      margin: 0;
      font-weight: bold;
      font-size: 1.1rem;
      color: #111827;
    }
    .logo-subtitle {
      margin: 0;
      font-size: 0.875rem;
      color: #6b7280;
    }
    .menu {
      padding: 16px;
      display: flex;
      flex-direction: column;
      gap: 10px;
      flex-grow: 1;
    }
    .menu-item {
      background: transparent;
      border: none;
      cursor: pointer;
      padding: 10px 14px;
      font-size: 0.95rem;
      color: #4b5563;
      display: flex;
      align-items: center;
      gap: 12px;
      border-radius: 6px;
      text-align: left;
      transition: background-color 0.2s, color 0.2s;
    }
    .menu-item:hover, .menu-item.active {
      background: #e0f2fe;
      color: #0369a1;
    }
    .sidebar-footer {
      padding: 16px;
      border-top: 1px solid #e5e7eb;
    }
    .user-box {
      background: #f9fafb;
      padding: 12px;
      border-radius: 8px;
      margin-bottom: 10px;
    }
    .user-name {
      margin: 0;
      font-weight: 500;
      color: #111827;
      font-size: 0.9rem;
    }
    .user-role {
      margin: 0;
      font-size: 0.75rem;
      color: #6b7280;
      text-transform: capitalize;
    }
    .logout-btn {
      width: 100%;
      background: transparent;
      border: 1px solid #fecaca;
      color: #dc2626;
      padding: 10px 14px;
      border-radius: 6px;
      font-size: 0.9rem;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 10px;
      transition: background-color 0.2s, color 0.2s;
    }
    .logout-btn:hover {
      background: #fef2f2;
      color: #b91c1c;
    }
    /* Main content */
    .main-content {
      flex: 1;
      background: #f8fafc;
      padding: 2rem;
      overflow-y: auto;
    }
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.5rem;
    }
    .header h1 {
      margin: 0;
      font-size: 2rem;
      color: #111827;
    }
    .header p {
      margin: 0;
      color: #6b7280;
    }
    .btn-add {
      background: #10b981;
      color: white;
      border: none;
      padding: 0.5rem 1rem;
      border-radius: 6px;
      cursor: pointer;
      font-size: 0.9rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }
    .btn-add:hover {
      background: #059e68;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      border: 1px solid #e5e7eb;
      border-radius: 8px;
      overflow: hidden;
    }
    th, td {
      padding: 0.75rem 1rem;
      text-align: left;
      border-bottom: 1px solid #e5e7eb;
      vertical-align: middle;
    }
    th {
      background: #f3f4f6;
    }
    .badge {
      padding: 0.25rem 0.5rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      display: inline-block;
    }
    .badge-outline {
      border: 1px solid #cbd5e1;
      color: #374151;
    }
    .badge-secondary {
      background: #e5e7eb;
      color: #374151;
    }
    .badge-green {
      background: #d1fae5;
      color: #065f46;
    }
    .badge-orange {
      background: #ffedd5;
      color: #c2410c;
    }
    .badge-red {
      background: #fee2e2;
      color: #b91c1c;
    }
    .btn-sm {
      border: none;
      background: #f3f4f6;
      padding: 0.4rem;
      border-radius: 6px;
      cursor: pointer;
      font-size: 0.8rem;
      display: inline-flex;
      align-items: center;
    }
    .btn-sm:hover {
      background: #e5e7eb;
    }
    .btn-sm.delete {
      color: #b91c1c;
      background: #fee2e2;
    }
    .btn-sm.delete:hover {
      background: #fef2f2;
    }
    /* Add Item Form Styles */
    .add-item-form {
      background: white;
      padding: 1.5rem;
      border-radius: 8px;
      margin-top: 1rem;
      max-width: 480px;
      box-shadow: 0 4px 8px rgb(0 0 0 / 0.1);
    }
    .form-group {
      margin-bottom: 1rem;
    }
    label {
      display: block;
      margin-bottom: 0.25rem;
      font-weight: 600;
      color: #374151;
    }
    input {
      width: 100%;
      padding: 0.5rem 0.75rem;
      border-radius: 6px;
      border: 1px solid #d1d5db;
      font-size: 1rem;
      color: #111827;
    }
    input:focus {
      outline: none;
      border-color: #0ea5e9;
      box-shadow: 0 0 0 3px #bae6fd;
    }
    .submit-btn {
      background: #0ea5e9;
      border: none;
      color: white;
      font-weight: 600;
      padding: 0.75rem 1rem;
      border-radius: 6px;
      cursor: pointer;
      width: 100%;
    }
    .submit-btn:hover {
      background: #0369a1;
    }
    .cancel-btn {
      background: #f3f4f6;
      border: none;
      color: #374151;
      font-weight: 600;
      padding: 0.75rem 1rem;
      border-radius: 6px;
      cursor: pointer;
      width: 100%;
      margin-top: 0.5rem;
    }
    .cancel-btn:hover {
      background: #e5e7eb;
    }
  </style>
</head>
<body>

<div class="container">

  <!-- Sidebar -->
  <aside class="sidebar">
    <div>
      <div class="sidebar-header">
        <div class="logo-icon">
          <i data-lucide="book-open"></i>
        </div>
        <div>
          <h1 class="logo-title">Pahana Edu</h1>
          <p class="logo-subtitle">Management System</p>
        </div>
      </div>

      <nav class="menu">
        <button class="menu-item active" data-page="dashboard">
          <i data-lucide="bar-chart-3"></i>
          Dashboard
        </button>
        <button class="menu-item" data-page="customers">
          <i data-lucide="users"></i>
          Customers
        </button>
        <button class="menu-item" data-page="items">
          <i data-lucide="package"></i>
          Items
        </button>
        <button class="menu-item" data-page="billing">
          <i data-lucide="receipt"></i>
          Billing
        </button>
        <button class="menu-item" data-page="help">
          <i data-lucide="help-circle"></i>
          Help
        </button>
      </nav>
    </div>

    <div class="sidebar-footer">
      <div class="user-box">
        <p class="user-name">Madushi Mathugamage</p>
        <p class="user-role">admin</p>
      </div>
      <button class="logout-btn">
        <i data-lucide="log-out"></i>
        Logout
      </button>
    </div>
  </aside>

  <!-- Main content -->
  <main class="main-content">

    <!-- Dashboard Page -->
    <section class="page" data-page="dashboard">
      <h1>Dashboard</h1>
      <p>Welcome to the dashboard!</p>
    </section>

    <!-- Customers Page -->
    <section class="page" data-page="customers" style="display:none;">
      <h1>Customers</h1>
      <p>Customer management coming soon.</p>
    </section>

    <!-- Items Page -->
    <section class="page" data-page="items" style="display:none;">
      <div class="header">
        <div>
          <h1>Item Management</h1>
          <p>Manage inventory and item information</p>
        </div>
        <button id="add-item-btn" class="btn-add">
          <svg data-lucide="plus"></svg>
          Add Item
        </button>
      </div>

      <!-- Add Item Form - initially hidden -->
      <form id="add-item-form" class="add-item-form" style="display:none;">
        <div class="form-group">
          <label for="item-code">Code</label>
          <input type="text" id="item-code" name="code" required placeholder="e.g. BK004" />
        </div>
        <div class="form-group">
          <label for="item-name">Name</label>
          <input type="text" id="item-name" name="name" required placeholder="Item name" />
        </div>
        <div class="form-group">
          <label for="item-category">Category</label>
          <input type="text" id="item-category" name="category" required placeholder="Category" />
        </div>
        <div class="form-group">
          <label for="item-price">Price</label>
          <input type="number" id="item-price" name="price" required placeholder="Price in Rs." />
        </div>
        <div class="form-group">
          <label for="item-stock">Stock</label>
          <input type="number" id="item-stock" name="stock" required placeholder="Stock quantity" />
        </div>
        <button type="submit" class="submit-btn">Add Item</button>
        <button type="button" class="cancel-btn" id="cancel-add-item">Cancel</button>
      </form>

      <table>
        <thead>
        <tr>
          <th>Code</th>
          <th>Name</th>
          <th>Category</th>
          <th>Price</th>
          <th>Stock</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody id="item-table-body">
        <tr>
          <td><span class="badge badge-outline">BK001</span></td>
          <td>
            <strong>Advanced Mathematics</strong><br />
            <p class="desc">Grade 12 Mathematics Textbook</p>
          </td>
          <td><span class="badge badge-secondary">Textbooks</span></td>
          <td>Rs. 1,500</td>
          <td>25</td>
          <td><span class="badge badge-green">In Stock</span></td>
          <td>
            <button class="btn-sm"><svg data-lucide="edit-2"></svg></button>
            <button class="btn-sm delete"><svg data-lucide="trash-2"></svg></button>
          </td>
        </tr>
        <tr>
          <td><span class="badge badge-outline">BK002</span></td>
          <td>
            <strong>English Literature</strong><br />
            <p class="desc">A/L Poetry Collection</p>
          </td>
          <td><span class="badge badge-secondary">Literature</span></td>
          <td>Rs. 980</td>
          <td>5</td>
          <td><span class="badge badge-orange">Low Stock</span></td>
          <td>
            <button class="btn-sm"><svg data-lucide="edit-2"></svg></button>
            <button class="btn-sm delete"><svg data-lucide="trash-2"></svg></button>
          </td>
        </tr>
        <tr>
          <td><span class="badge badge-outline">BK003</span></td>
          <td>
            <strong>Science Book</strong><br />
            <p class="desc">Practical Science for Grade 10</p>
          </td>
          <td><span class="badge badge-secondary">Textbooks</span></td>
          <td>Rs. 1,200</td>
          <td>0</td>
          <td><span class="badge badge-red">Out of Stock</span></td>
          <td>
            <button class="btn-sm"><svg data-lucide="edit-2"></svg></button>
            <button class="btn-sm delete"><svg data-lucide="trash-2"></svg></button>
          </td>
        </tr>
        </tbody>
      </table>
    </section>

    <!-- Billing Page -->
    <section class="page" data-page="billing" style="display:none;">
      <h1>Billing</h1>
      <p>Billing system coming soon.</p>
    </section>

    <!-- Help Page -->
    <section class="page" data-page="help" style="display:none;">
      <h1>Help</h1>
      <p>Help information here.</p>
    </section>

  </main>
</div>

<script>
  lucide.createIcons();

  // Sidebar navigation logic
  const menuButtons = document.querySelectorAll('.menu-item');
  const pages = document.querySelectorAll('.page');
  menuButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      // Remove active from all menu buttons
      menuButtons.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      const pageToShow = btn.getAttribute('data-page');
      pages.forEach(page => {
        if (page.getAttribute('data-page') === pageToShow) {
          page.style.display = 'block';
        } else {
          page.style.display = 'none';
        }
      });

      // Hide add item form if switching away from items page
      if (pageToShow !== 'items') {
        document.getElementById('add-item-form').style.display = 'none';
      }
    });
  });

  // Add Item button toggles add item form visibility
  const addItemBtn = document.getElementById('add-item-btn');
  const addItemForm = document.getElementById('add-item-form');
  const cancelAddItemBtn = document.getElementById('cancel-add-item');

  addItemBtn.addEventListener('click', () => {
    addItemForm.style.display = 'block';
    // Scroll form into view
    addItemForm.scrollIntoView({ behavior: 'smooth' });
  });

  cancelAddItemBtn.addEventListener('click', () => {
    addItemForm.style.display = 'none';
  });

  // Handle form submit (for demo, just alert and reset)
  addItemForm.addEventListener('submit', e => {
    e.preventDefault();

    // Collect form data
    const code = document.getElementById('item-code').value.trim();
    const name = document.getElementById('item-name').value.trim();
    const category = document.getElementById('item-category').value.trim();
    const price = parseFloat(document.getElementById('item-price').value);
    const stock = parseInt(document.getElementById('item-stock').value);

    if (!code || !name || !category || isNaN(price) || isNaN(stock)) {
      alert('Please fill all fields correctly.');
      return;
    }

    // Add new item row to table
    const tbody = document.getElementById('item-table-body');
    const tr = document.createElement('tr');

    // Determine status badge class
    let statusClass = 'badge-green';
    let statusText = 'In Stock';
    if(stock === 0){
      statusClass = 'badge-red';
      statusText = 'Out of Stock';
    } else if(stock < 10){
      statusClass = 'badge-orange';
      statusText = 'Low Stock';
    }

    tr.innerHTML = `
      <td><span class="badge badge-outline">${code}</span></td>
      <td><strong>${name}</strong><br><p class="desc"></p></td>
      <td><span class="badge badge-secondary">${category}</span></td>
      <td>Rs. ${price.toFixed(2)}</td>
      <td>${stock}</td>
      <td><span class="badge ${statusClass}">${statusText}</span></td>
      <td>
        <button class="btn-sm"><svg data-lucide="edit-2"></svg></button>
        <button class="btn-sm delete"><svg data-lucide="trash-2"></svg></button>
      </td>
    `;

    tbody.appendChild(tr);

    lucide.createIcons(); // re-create icons inside new elements

    // Reset and hide form
    addItemForm.reset();
    addItemForm.style.display = 'none';
  });
</script>

</body>
</html>
