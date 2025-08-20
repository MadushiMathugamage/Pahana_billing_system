<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.final_project.customer.dto.CustomerDto" %>
<%@ page import="com.example.final_project.customer.service.CustomerService" %>
<%@ page import="com.example.final_project.item.dto.ItemDto" %>
<%@ page import="com.example.final_project.item.service.ItemService" %>

<%!
    // Utility method for stock badge
    public String getStockBadge(int stock) {
        if (stock <= 5) return "<span style='color:red;font-weight:bold;'>Low</span>";
        else return "<span style='color:green;'>Available</span>";
    }
%>

<%
    // Fetch customers
    CustomerService customerService = new CustomerService();
    List<CustomerDto> customers = customerService.getAllCustomers();

    // Fetch items
    ItemService itemService = new ItemService();
    List<ItemDto> items = itemService.getAllItems();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Customer Billing System</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f9fafb; padding: 20px; }
        .container { max-width: 1200px; margin: auto; }
        header { margin-bottom: 20px; }
        h1, h2 { margin: 0 0 10px 0; }
        select, input { padding: 6px; border-radius: 6px; border: 1px solid #ccc; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #e5e7eb; }
        .btn { padding: 6px 10px; border: none; border-radius: 6px; cursor: pointer; }
        .btn.add { background-color: #38bdf8; color: white; }
        .btn.remove { background-color: #f87171; color: white; }
        .summary { margin-top: 20px; background: #fff; padding: 15px; border-radius: 8px; }
        .summary-item { display: flex; justify-content: space-between; margin: 5px 0; }
        .total { font-weight: bold; }
        .badge { padding: 4px 8px; border-radius: 6px; font-size: 0.9em; }
    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>Customer Billing System</h1>
    </header>

    <section class="customer-selection">
        <h2>Select Customer</h2>
        <select id="customerSelect">
            <option disabled selected>Choose customer</option>
            <%
                for(CustomerDto customer : customers){
            %>
            <option value="<%= customer.getName() %>|<%= customer.getAddress() %>|<%= customer.getPhone() %>">
                <%= customer.getName() %> (<%= customer.getCode() %>)
            </option>
            <%
                }
            %>
        </select>
        <div id="customerInfo" style="margin-top:10px;">
            <p><strong>Customer Info will appear here</strong></p>
        </div>
    </section>

    <section class="billing">
        <h2>Add Items</h2>
        <div>
            <select id="itemSelect">
                <option disabled selected>Choose item</option>
                <%
                    for(ItemDto item : items){
                %>
                <option value="<%= item.getItemId() %>|<%= item.getName() %>|<%= item.getPrice() %>|<%= item.getStock() %>">
                    <%= item.getName() %> - Rs. <%= item.getPrice() %> (Stock: <%= item.getStock() %>)
                </option>
                <%
                    }
                %>
            </select>
            <input type="number" id="itemQuantity" min="1" value="1"/>
            <button class="btn add" id="addItemBtn" type="button">➕ Add Item</button>
        </div>

        <h3>Bill Items</h3>
        <table>
            <thead>
            <tr>
                <th>Item</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="billItemsTable"></tbody>
        </table>

        <div class="summary">
            <div class="summary-item"><span>Subtotal:</span><span id="subtotal">Rs. 0</span></div>
            <div class="summary-item"><span>Tax (10%):</span><span id="tax">Rs. 0</span></div>
            <hr/>
            <div class="summary-item total"><span>Total:</span><span id="total">Rs. 0</span></div>
        </div>
    </section>
</div>

<script>
    const customerSelect = document.getElementById('customerSelect');
    const customerInfo = document.getElementById('customerInfo');
    const itemSelect = document.getElementById('itemSelect');
    const itemQuantity = document.getElementById('itemQuantity');
    const addItemBtn = document.getElementById('addItemBtn');
    const billItemsTable = document.getElementById('billItemsTable');
    const subtotalEl = document.getElementById('subtotal');
    const taxEl = document.getElementById('tax');
    const totalEl = document.getElementById('total');

    let subtotal = 0;

    customerSelect.addEventListener('change', () => {
        const [name, address, phone] = customerSelect.value.split('|');
        customerInfo.innerHTML = `<p><strong>${name}</strong></p><p>${address}</p><p>${phone}</p>`;
    });

    addItemBtn.addEventListener('click', () => {
        if (!itemSelect.value) { alert("Select an item!"); return; }

        const [id, name, price, stock] = itemSelect.value.split('|');
        const quantity = parseInt(itemQuantity.value);
        const availableStock = parseInt(stock);

        if (quantity < 1) { alert("Quantity must be at least 1"); return; }
        if (quantity > availableStock) { alert(`Only ${availableStock} in stock`); return; }

        const totalPrice = quantity * parseFloat(price);
        subtotal += totalPrice;

        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${name}</td>
            <td>Rs. ${price}</td>
            <td>${quantity}</td>
            <td>Rs. ${totalPrice}</td>
            <td><button class="btn remove">🗑️</button></td>
        `;

        row.querySelector('.remove').addEventListener('click', () => {
            subtotal -= totalPrice;
            updateSummary();
            row.remove();
        });

        billItemsTable.appendChild(row);
        updateSummary();
    });

    function updateSummary() {
        const tax = subtotal * 0.10;
        const total = subtotal + tax;
        subtotalEl.textContent = `Rs. ${subtotal}`;
        taxEl.textContent = `Rs. ${tax}`;
        totalEl.textContent = `Rs. ${total}`;
    }
</script>
</body>
</html>
