<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.final_project.customer.dto.CustomerDto" %>
<%@ page import="com.example.final_project.customer.service.CustomerService" %>

<%
    CustomerService customerService = new CustomerService();
    List<CustomerDto> customers = customerService.getAllCustomers();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Management</title>
    <style>
        /* ====== General Reset ====== */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f9fafb; color: #333; }

        /* ====== Container ====== */
        .container { max-width: 1100px; margin: 40px auto; background: #fff;
            padding: 25px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }

        h1 { font-size: 22px; font-weight: bold; margin-bottom: 20px; color: #222; }

        /* ====== Buttons ====== */
        .btn { padding: 6px 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; }
        .btn.add { background: #2563eb; color: #fff; }
        .btn.edit { background: #f59e0b; color: #fff; }
        .btn.delete { background: #ef4444; color: #fff; }
        .btn:hover { opacity: 0.9; }

        /* ====== Table ====== */
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { text-align: left; padding: 12px 10px; border-bottom: 1px solid #e5e7eb; }
        th { background: #f3f4f6; font-weight: bold; font-size: 14px; color: #111; }
        td { font-size: 14px; }

        /* ====== Form Popup ====== */
        .form-popup {
            display: none; position: fixed; top: 50%; left: 50%;
            transform: translate(-50%, -50%); background: #fff;
            padding: 25px; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            width: 400px; z-index: 1000;
        }
        .form-popup h3 { margin-bottom: 15px; font-size: 18px; }
        .form-popup input {
            width: 100%; padding: 10px; margin-bottom: 12px;
            border: 1px solid #ccc; border-radius: 6px; font-size: 14px;
        }
        .form-popup .actions { display: flex; justify-content: flex-end; gap: 10px; }
    </style>
</head>
<body>
<div class="container">
    <h1>👤 Customer Management</h1>

    <button class="btn add" onclick="openAddForm()">➕ Add Customer</button>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Code</th>
            <th>Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody id="customerTableBody">
        <% for(CustomerDto customer : customers) { %>
        <tr id="customer-<%=customer.getId()%>">
            <td><%=customer.getId()%></td>
            <td><%=customer.getCode()%></td>
            <td><%=customer.getName()%></td>
            <td><%=customer.getAddress()%></td>
            <td><%=customer.getPhone()%></td>
            <td>
                <button class="btn edit"
                        onclick="openEditForm(<%=customer.getId()%>, '<%=customer.getCode()%>', '<%=customer.getName()%>', '<%=customer.getAddress()%>', '<%=customer.getPhone()%>')">✏ Edit</button>
                <button class="btn delete" onclick="deleteCustomer(<%=customer.getId()%>)">🗑 Delete</button>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Add/Edit Form -->
<div class="form-popup" id="customerForm">
    <h3 id="formTitle">Add Customer</h3>
    <input type="hidden" id="customerId" />
    <input type="text" id="customerCode" placeholder="Code" />
    <input type="text" id="customerName" placeholder="Name" />
    <input type="text" id="customerAddress" placeholder="Address" />
    <input type="text" id="customerPhone" placeholder="Phone" />
    <div class="actions">
        <button class="btn add" onclick="saveCustomer()">Save</button>
        <button class="btn delete" onclick="closeForm()">Cancel</button>
    </div>
</div>

<script>
    function saveCustomer() {
        const id = document.getElementById('customerId').value;
        const code = document.getElementById('customerCode').value.trim();
        const name = document.getElementById('customerName').value.trim();
        const address = document.getElementById('customerAddress').value.trim();
        const phone = document.getElementById('customerPhone').value.trim();

        if (!code || !name || !address || !phone) {
            alert("All fields are required");
            return;
        }

        if (id) {
            // Update existing row
            const row = document.getElementById('customer-' + id);
            row.children[1].innerText = code;
            row.children[2].innerText = name;
            row.children[3].innerText = address;
            row.children[4].innerText = phone;
        } else {
            // Generate unique ID (safe with Date.now)
            const newId = Date.now();

            // Escape quotes to prevent breaking onclick
            const safeCode = code.replace(/'/g,"\\'");
            const safeName = name.replace(/'/g,"\\'");
            const safeAddress = address.replace(/'/g,"\\'");
            const safePhone = phone.replace(/'/g,"\\'");

            const row = document.createElement('tr');
            row.id = 'customer-' + newId;

            row.innerHTML = `
            <td>${newId}</td>
            <td>${code}</td>
            <td>${name}</td>
            <td>${address}</td>
            <td>${phone}</td>
            <td>
                <button class="btn edit"
                    onclick="openEditForm('${newId}', '${safeCode}', '${safeName}', '${safeAddress}', '${safePhone}')">✏ Edit</button>
                <button class="btn delete" onclick="deleteCustomer('${newId}')">🗑 Delete</button>
            </td>
        `;
            document.getElementById('customerTableBody').appendChild(row);
        }

        closeForm();
    }
</script>

</body>
</html>
