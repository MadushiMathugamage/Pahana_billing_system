<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.final_project.item.dto.ItemDto" %>
<%@ page import="com.example.final_project.item.service.ItemService" %>
<%@ page import="java.util.ArrayList" %>
<%
  // Fetch all items from DB
  ItemService itemService = new ItemService();
  List<ItemDto> items = itemService.getAllItems();

  if (items == null) {
    items = new ArrayList<>();
  }
  // Sample items if DB empty
  items.add(new ItemDto(1, "Pen", 50.0, 20));
  items.add(new ItemDto(2, "Notebook", 150.0, 15));
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Billing System</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f9fafb; margin: 0; padding: 20px; color: #111827; }
    .container { max-width: 1200px; margin: auto; }
    header { margin-bottom: 20px; }
    h1 { font-size: 2em; margin-bottom: 5px; }
    .grid { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }
    .card { background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 0 10px #ccc3; }
    .form-row { display: flex; gap: 15px; margin-bottom: 15px; flex-wrap: wrap; }
    .field { flex: 1; display: flex; flex-direction: column; }
    select, input { padding: 8px; border-radius: 6px; border: 1px solid #d1d5db; }
    .customer-info { background: #f3f4f6; padding: 10px; border-radius: 6px; margin-top: 10px; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { border: 1px solid #e5e7eb; padding: 8px; text-align: left; }
    .btn { padding: 8px 12px; border: none; border-radius: 6px; cursor: pointer; }
    .btn.add { background-color: #38bdf8; color: white; }
    .btn.remove { background: #f87171; color: white; }
    .btn.generate { background-color: #0ea5e9; color: white; width: 100%; margin-top: 15px; }
    .btn.print { background-color: #f3f4f6; color: #111; width: 100%; margin-top: 10px; }
    .summary-item { display: flex; justify-content: space-between; margin: 10px 0; }
    .total { font-size: 1.1em; }
    .btn:hover { opacity: 0.9; }
  </style>
</head>
<body>
<div class="container">
  <header>
    <h1>Billing System</h1>
  </header>

  <main class="grid">
    <!-- Billing Form -->
    <section class="bill-form">
      <div class="card">
        <h2>Create New Bill</h2>

        <!-- Customer Select -->
        <div class="form-row">
          <div class="field">
            <label>Select Customer</label>
            <select id="customerSelect">
              <option disabled selected>Choose customer</option>
              <option>John Doe|123 Main Street|+94 71 234 5678</option>
              <option>Jane Smith|456 Park Street|+94 77 987 6543</option>
            </select>
            <div class="customer-info" id="customerInfo">
              <p><strong>John Doe</strong></p>
              <p>123 Main Street</p>
              <p>+94 71 234 5678</p>
            </div>
          </div>
        </div>

        <!-- Item Select -->
        <div class="form-row">
          <div class="field">
            <label>Select Item</label>
            <select id="itemSelect">
              <option disabled selected>Choose item</option>
              <% for(ItemDto item : items) { %>
              <option value="<%= item.getItemId() %>|<%= item.getName() %>|<%= item.getPrice() %>|<%= item.getStock() %>">
                <%= item.getName() %> - Rs. <%= item.getPrice() %> (Stock: <%= item.getStock() %>)
              </option>
              <% } %>
            </select>
          </div>
          <div class="field">
            <label>Quantity</label>
            <input type="number" id="itemQuantity" min="1" value="1" />
          </div>
          <button class="btn add" id="addItemBtn" type="button">➕ Add Item</button>
        </div>

        <!-- Bill Items Table -->
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
      </div>
    </section>

    <!-- Summary -->
    <aside class="summary">
      <div class="card">
        <h2>Bill Summary</h2>
        <div class="summary-item"><span>Subtotal:</span><span id="subtotal">Rs. 0</span></div>
        <div class="summary-item"><span>Tax (10%):</span><span id="tax">Rs. 0</span></div>
        <hr />
        <div class="summary-item total"><strong>Total:</strong><strong id="total">Rs. 0</strong></div>
        <button class="btn generate">🧾 Generate Bill</button>
        <button class="btn print">🖨️ Print Bill</button>
      </div>
    </aside>
  </main>
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

  // Update customer info
  customerSelect.addEventListener('change', () => {
    const [name, address, phone] = customerSelect.value.split('|');
    customerInfo.innerHTML = `<p><strong>${name}</strong></p><p>${address}</p><p>${phone}</p>`;
  });

  // Add item to table
  addItemBtn.addEventListener('click', () => {
    if (!itemSelect.value) { alert("Select an item!"); return; }

    const [itemId, itemName, unitPrice, stock] = itemSelect.value.split('|');
    const qty = parseInt(itemQuantity.value);
    const availableStock = parseInt(stock);

    if (qty < 1) { alert("Quantity must be at least 1"); return; }
    if (qty > availableStock) { alert(`Only ${availableStock} in stock`); return; }

    const price = parseFloat(unitPrice);
    const totalPrice = price * qty;
    subtotal += totalPrice;

    const row = document.createElement('tr');
    row.innerHTML = `
            <td>${itemName}</td>
            <td>${price.toFixed(2)}</td>
            <td class="qty">${qty}</td>
            <td class="total">${totalPrice.toFixed(2)}</td>
            <td><button class="btn remove" onclick="removeItem(this, ${totalPrice})">🗑 Remove</button></td>
        `;
    billItemsTable.appendChild(row);
    updateSummary();
  });

  function removeItem(button, itemTotal) {
    subtotal -= itemTotal;
    button.closest('tr').remove();
    updateSummary();
  }

  function updateSummary() {
    const tax = subtotal * 0.10;
    const total = subtotal + tax;
    subtotalEl.textContent = `Rs. ${subtotal.toFixed(2)}`;
    taxEl.textContent = `Rs. ${tax.toFixed(2)}`;
    totalEl.textContent = `Rs. ${total.toFixed(2)}`;
  }
</script>
</body>
</html>
