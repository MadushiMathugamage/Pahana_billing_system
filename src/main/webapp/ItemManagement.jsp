<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Item Management</title>
  <style>
    body { font-family: Arial; background:#f9fafb; margin:0; padding:20px; }
    .container { max-width:1200px; margin:auto; }
    .header { display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; }
    .btn { padding:8px 16px; border:none; border-radius:6px; cursor:pointer; color:white; transition:.2s; }
    .btn-add { background:#10b981; }
    .btn-add:hover { background:#059669; }
    .btn-outline { background:transparent; border:1px solid #d1d5db; color:#111827; }
    .btn-outline:hover { background:#f3f4f6; }
    .btn-red { background:transparent; border:1px solid #dc2626; color:#dc2626; }
    .btn-red:hover { background:#fee2e2; }
    .dialog-overlay { position:fixed; inset:0; background:rgba(0,0,0,0.4); display:none; justify-content:center; align-items:center; z-index:50; }
    .dialog-overlay.active { display:flex; }
    .dialog { background:white; border-radius:12px; max-width:450px; width:100%; max-height:90vh; overflow-y:auto; padding:24px; box-shadow:0 10px 25px rgba(0,0,0,0.1); }
    .dialog h2 { margin-bottom:16px; font-size:20px; font-weight:bold; }
    .dialog label { display:block; margin-top:8px; font-weight:500; }
    .dialog input, .dialog select { width:100%; padding:8px; border:1px solid #d1d5db; border-radius:6px; margin-top:4px; }
    .cancel-btn { margin-top:12px; background:none; border:none; color:#6b7280; cursor:pointer; }
    .cancel-btn:hover { color:#111827; }
    table { width:100%; border-collapse:collapse; background:white; border-radius:12px; overflow:hidden; }
    th, td { padding:12px 16px; text-align:left; border-bottom:1px solid #e5e7eb; }
    th { background:#f9fafb; font-size:12px; font-weight:600; text-transform:uppercase; color:#6b7280; }
    tr:hover { background:#f3f4f6; }
    .badge { padding:4px 8px; border-radius:8px; font-size:12px; font-weight:500; display:inline-block; }
    .badge-secondary { background:#d1fae5; color:#065f46; }
    .badge-low { background:#fed7aa; color:#9a3412; }
    .badge-destructive { background:#fecaca; color:#991b1b; }
    .flex { display:flex; gap:8px; align-items:center; }
    .flex-col { flex-direction:column; }
    .search-wrapper { position:relative; width:250px; }
    .search-wrapper input { width:100%; padding:6px 12px 6px 32px; border:1px solid #d1d5db; border-radius:6px; }
    .search-wrapper svg { position:absolute; left:8px; top:50%; transform:translateY(-50%); width:16px; height:16px; color:#9ca3af; }
  </style>
</head>
<body>

<div class="container">

  <div class="header">
    <div>
      <h1>Item Management</h1>
      <p>Manage inventory and item information</p>
    </div>
    <button class="btn btn-add" id="openDialogBtn">+ Add Item</button>
  </div>

  <div class="dialog-overlay" id="dialog">
    <div class="dialog">
      <h2 id="dialogTitle">Add New Item</h2>
      <form id="itemForm">
        <label>Item Code</label>
        <input type="text" id="code" required>
        <label>Item Name</label>
        <input type="text" id="name" required>
        <label>Description</label>
        <input type="text" id="description">
        <label>Category</label>
        <select id="category">
          <option value="">Select category</option>
          <option value="Textbooks">Textbooks</option>
          <option value="Literature">Literature</option>
          <option value="Stationery">Stationery</option>
          <option value="Reference">Reference</option>
          <option value="Notebooks">Notebooks</option>
          <option value="Art Supplies">Art Supplies</option>
        </select>
        <label>Price</label>
        <input type="number" step="0.01" id="price" required>
        <label>Stock Quantity</label>
        <input type="number" id="stock" required>
        <label>Author (Optional)</label>
        <input type="text" id="author">
        <label>ISBN (Optional)</label>
        <input type="text" id="isbn">
        <button type="submit" class="btn btn-add">Submit</button>
      </form>
      <button class="cancel-btn" id="closeDialogBtn">Cancel</button>
    </div>
  </div>

  <div class="flex justify-between" style="margin-bottom:10px;">
    <h2 id="itemCount">Items (0)</h2>
    <div class="flex gap-4">
      <div class="search-wrapper">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
        </svg>
        <input type="text" id="searchInput" placeholder="Search items...">
      </div>
      <select id="filterCategory">
        <option value="all">All Categories</option>
        <option value="Textbooks">Textbooks</option>
        <option value="Literature">Literature</option>
        <option value="Stationery">Stationery</option>
        <option value="Reference">Reference</option>
        <option value="Notebooks">Notebooks</option>
        <option value="Art Supplies">Art Supplies</option>
      </select>
    </div>
  </div>

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
    <tbody id="itemTableBody"></tbody>
  </table>

</div>

<script>
  let items = [];
  let editingItemId = null;

  const dialog = document.getElementById('dialog');
  const dialogTitle = document.getElementById('dialogTitle');
  const itemForm = document.getElementById('itemForm');
  const itemTableBody = document.getElementById('itemTableBody');
  const itemCount = document.getElementById('itemCount');

  const codeInput = document.getElementById('code');
  const nameInput = document.getElementById('name');
  const descInput = document.getElementById('description');
  const categoryInput = document.getElementById('category');
  const priceInput = document.getElementById('price');
  const stockInput = document.getElementById('stock');
  const authorInput = document.getElementById('author');
  const isbnInput = document.getElementById('isbn');

  const searchInput = document.getElementById('searchInput');
  const filterCategory = document.getElementById('filterCategory');

  function openDialog(edit=false, item=null){
    dialog.classList.add('active');
    if(edit && item){
      dialogTitle.textContent='Edit Item';
      editingItemId=item.id;
      codeInput.value=item.code;
      nameInput.value=item.name;
      descInput.value=item.description;
      categoryInput.value=item.category;
      priceInput.value=item.price;
      stockInput.value=item.stock;
      authorInput.value=item.author;
      isbnInput.value=item.isbn;
    } else {
      dialogTitle.textContent='Add New Item';
      editingItemId=null;
      itemForm.reset();
    }
  }

  function closeDialog(){
    dialog.classList.remove('active');
    itemForm.reset();
    editingItemId=null;
  }

  function getStockBadge(stock){
    if(stock===0) return '<span class="badge badge-destructive">Out of Stock</span>';
    if(stock<10) return '<span class="badge badge-low">Low Stock</span>';
    return '<span class="badge badge-secondary">In Stock</span>';
  }

  function renderItems(){
    const search = searchInput.value.toLowerCase();
    const categoryFilterValue = filterCategory.value;
    const filtered = items.filter(item=>
            (item.name.toLowerCase().includes(search) || item.code.toLowerCase().includes(search)) &&
            (categoryFilterValue==='all' || item.category===categoryFilterValue)
    );
    itemTableBody.innerHTML='';
    filtered.forEach(item=>{
      const tr=document.createElement('tr');
      tr.innerHTML=`
      <td>${item.code}</td>
      <td>${item.name}<br><small>${item.description || ''}</small></td>
      <td>${item.category}</td>
      <td>${item.price}</td>
      <td>${item.stock}</td>
      <td>${getStockBadge(item.stock)}</td>
      <td>
        <button class="btn-outline edit-btn">Edit</button>
        <button class="btn-red delete-btn">Delete</button>
      </td>
    `;
      tr.querySelector('.edit-btn').addEventListener('click',()=>openDialog(true,item));
      tr.querySelector('.delete-btn').addEventListener('click',()=>deleteItem(item.id));
      itemTableBody.appendChild(tr);
    });
    itemCount.textContent=`Items (${filtered.length})`;
  }

  function deleteItem(id){
    if(confirm("Are you sure you want to delete this item?")){
      items = items.filter(i=>i.id!==id);
      renderItems();
    }
  }

  itemForm.addEventListener('submit', e=>{
    e.preventDefault();
    const newItem={
      id: editingItemId || Date.now().toString(),
      code: codeInput.value,
      name: nameInput.value,
      description: descInput.value,
      category: categoryInput.value,
      price: parseFloat(priceInput.value),
      stock: parseInt(stockInput.value),
      author: authorInput.value,
      isbn: isbnInput.value
    };
    if(editingItemId){
      items = items.map(i=>i.id===editingItemId? newItem:i);
    } else {
      items.push(newItem);
    }
    renderItems();
    closeDialog();
  });

  document.getElementById('openDialogBtn').addEventListener('click', ()=>openDialog());
  document.getElementById('closeDialogBtn').addEventListener('click', closeDialog);
  searchInput.addEventListener('input', renderItems);
  filterCategory.addEventListener('change', renderItems);

  renderItems();
</script>

</body>
</html>
