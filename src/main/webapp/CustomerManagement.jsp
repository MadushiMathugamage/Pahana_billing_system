<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9fafb;
            padding: 20px;
            color: #111827;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            font-size: 28px;
            font-weight: bold;
        }
        .header p {
            color: #6b7280;
            margin-top: 4px;
        }

        /* Button */
        .btn {
            background-color: #0ea5e9;
            color: white;
            border: none;
            padding: 8px 16px;
            display: flex;
            align-items: center;
            gap: 4px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn:hover {
            background-color: #0284c7;
        }
        .btn-red {
            background-color: transparent;
            color: #dc2626;
            border: 1px solid #dc2626;
        }
        .btn-red:hover {
            background-color: #fee2e2;
        }
        .btn-outline {
            background-color: transparent;
            border: 1px solid #d1d5db;
            color: #111827;
        }
        .btn-outline:hover {
            background-color: #f3f4f6;
        }

        /* Dialog */
        .dialog-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.4);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 50;
        }
        .dialog-overlay.active {
            display: flex;
        }
        .dialog {
            background: white;
            border-radius: 12px;
            max-width: 400px;
            width: 100%;
            padding: 24px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .dialog h2 {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 16px;
        }
        .dialog form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .dialog label {
            font-weight: 500;
        }
        .dialog input {
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            outline: none;
        }
        .dialog input:focus {
            border-color: #0ea5e9;
            box-shadow: 0 0 0 2px rgba(14,165,233,0.3);
        }
        .dialog .cancel-btn {
            background: none;
            border: none;
            color: #6b7280;
            cursor: pointer;
            margin-top: 8px;
        }
        .dialog .cancel-btn:hover {
            color: #111827;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
        }
        th, td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        th {
            background-color: #f9fafb;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            color: #6b7280;
        }
        tr:hover {
            background-color: #f3f4f6;
        }

        /* Search */
        .search-wrapper {
            position: relative;
            width: 250px;
        }
        .search-wrapper input {
            width: 100%;
            padding: 6px 12px 6px 32px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
        }
        .search-wrapper svg {
            position: absolute;
            left: 8px;
            top: 50%;
            transform: translateY(-50%);
            width: 16px;
            height: 16px;
            color: #9ca3af;
        }

    </style>
</head>
<body>

<div class="container">

    <!-- Header -->
    <div class="header">
        <div>
            <h1>Customer Management</h1>
            <p>Manage customer accounts and information</p>
        </div>
        <button class="btn" id="openDialog">+ Add Customer</button>
    </div>

    <!-- Dialog -->
    <div class="dialog-overlay" id="dialog">
        <div class="dialog">
            <h2 id="dialogTitle">Add New Customer</h2>
            <form id="customerForm">
                <label>Account Number</label>
                <input type="text" id="accountNumber" required>
                <label>Name</label>
                <input type="text" id="name" required>
                <label>Address</label>
                <input type="text" id="address" required>
                <label>Telephone</label>
                <input type="text" id="telephone" required>
                <label>Email (optional)</label>
                <input type="email" id="email">
                <button type="submit" class="btn" id="formSubmitButton">Add Customer</button>
            </form>
            <button class="cancel-btn" id="closeDialog">Cancel</button>
        </div>
    </div>

    <!-- Search + Table -->
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2 id="customerCount">Customers (0)</h2>
        <div class="search-wrapper">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            <input type="text" id="searchInput" placeholder="Search customers...">
        </div>
    </div>

    <table>
        <thead>
        <tr>
            <th>Account Number</th>
            <th>Name</th>
            <th>Telephone</th>
            <th>Registration Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody id="customerTableBody">
        <!-- Customers inserted here -->
        </tbody>
    </table>

</div>

<script>
    // JS functionality (same as previous script)
    let customers = [];
    let editingCustomerId = null;

    const dialog = document.getElementById('dialog');
    const dialogTitle = document.getElementById('dialogTitle');
    const formSubmitButton = document.getElementById('formSubmitButton');
    const customerForm = document.getElementById('customerForm');
    const customerTableBody = document.getElementById('customerTableBody');
    const customerCount = document.getElementById('customerCount');
    const searchInput = document.getElementById('searchInput');

    const accountNumberInput = document.getElementById('accountNumber');
    const nameInput = document.getElementById('name');
    const addressInput = document.getElementById('address');
    const telephoneInput = document.getElementById('telephone');
    const emailInput = document.getElementById('email');

    function openDialog(edit = false, customer = null) {
        dialog.classList.add('active');
        if(edit) {
            dialogTitle.textContent = 'Edit Customer';
            formSubmitButton.textContent = 'Update Customer';
            editingCustomerId = customer.id;
            accountNumberInput.value = customer.accountNumber;
            nameInput.value = customer.name;
            addressInput.value = customer.address;
            telephoneInput.value = customer.telephone;
            emailInput.value = customer.email;
        } else {
            dialogTitle.textContent = 'Add New Customer';
            formSubmitButton.textContent = 'Add Customer';
            editingCustomerId = null;
            customerForm.reset();
        }
    }

    function closeDialog() {
        dialog.classList.remove('active');
        customerForm.reset();
        editingCustomerId = null;
    }

    function renderCustomers(filter = '') {
        customerTableBody.innerHTML = '';
        const filtered = customers.filter(c =>
            c.name.toLowerCase().includes(filter.toLowerCase()) ||
            c.accountNumber.toLowerCase().includes(filter.toLowerCase()) ||
            c.telephone.includes(filter)
        );

        filtered.forEach(customer => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
        <td>${customer.accountNumber}</td>
        <td>${customer.name}</td>
        <td>${customer.telephone}</td>
        <td>${customer.registrationDate}</td>
        <td>
          <button class="btn-outline" onclick='editCustomer("${customer.id}")'>Edit</button>
          <button class="btn-red" onclick='deleteCustomer("${customer.id}")'>Delete</button>
        </td>
      `;
            customerTableBody.appendChild(tr);
        });

        customerCount.textContent = `Customers (${filtered.length})`;
    }

    function editCustomer(id) {
        const customer = customers.find(c => c.id === id);
        if(customer) openDialog(true, customer);
    }

    function deleteCustomer(id) {
        customers = customers.filter(c => c.id !== id);
        renderCustomers(searchInput.value);
    }

    customerForm.addEventListener('submit', e => {
        e.preventDefault();
        const newCustomer = {
            id: editingCustomerId || Date.now().toString(),
            accountNumber: accountNumberInput.value,
            name: nameInput.value,
            address: addressInput.value,
            telephone: telephoneInput.value,
            email: emailInput.value,
            registrationDate: new Date().toISOString().split('T')[0]
        };

        if(editingCustomerId) {
            customers = customers.map(c => c.id === editingCustomerId ? newCustomer : c);
        } else {
            customers.push(newCustomer);
        }

        renderCustomers(searchInput.value);
        closeDialog();
    });

    document.getElementById('openDialog').addEventListener('click', () => openDialog());
    document.getElementById('closeDialog').addEventListener('click', closeDialog);

    searchInput.addEventListener('input', e => renderCustomers(e.target.value));

    renderCustomers();
</script>

</body>
</html>
