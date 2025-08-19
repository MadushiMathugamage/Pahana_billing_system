<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Item Management</title>
  <style>
    :root{
      --bg:#f9fafb;--card:#ffffff;--text:#111827;--muted:#6b7280;--border:#e5e7eb;--border-2:#d1d5db;--primary:#10b981;--primary-hover:#059669;--danger:#dc2626;--danger-bg:#fee2e2;--danger-border:#fecaca;
      --green-bg:#d1fae5;--green-text:#065f46;--orange-bg:#ffedd5;--orange-text:#9a3412;--red-bg:#fee2e2;--red-text:#991b1b;
      --shadow:0 1px 2px rgba(0,0,0,.06), 0 1px 3px rgba(0,0,0,.1)
    }
    *{box-sizing:border-box}
    body{margin:0;background:var(--bg);color:var(--text);font-family:ui-sans-serif,system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,"Helvetica Neue",Arial,"Noto Sans",sans-serif;line-height:1.4;padding:2rem}
    h1{margin:0 0 .25rem;font-size:1.875rem;font-weight:800}
    p.lead{margin:.25rem 0 0;color:var(--muted)}

    .page-head{display:flex;gap:1rem;align-items:center;justify-content:space-between;margin-bottom:1.5rem}
    .btn{display:inline-flex;align-items:center;gap:.5rem;border:none;border-radius:.5rem;padding:.625rem 1rem;background:var(--primary);color:#fff;cursor:pointer;font-weight:600}
    .btn:hover{background:var(--primary-hover)}
    .btn-outline{background:#fff;border:1px solid var(--border-2);color:#111827}
    .btn-outline.danger{color:var(--danger);border-color:var(--danger-border)}
    .btn-outline:hover{background:#f3f4f6}

    .card{background:var(--card);border-radius:.75rem;box-shadow:var(--shadow)}
    .card-head{padding:1rem;border-bottom:1px solid var(--border)}
    .card-body{padding:1rem}

    .row{display:flex;flex-direction:column;gap:1rem}
    @media (min-width:768px){.row{flex-direction:row;align-items:center;justify-content:space-between}}

    .controls{display:flex;gap:1rem;flex-wrap:wrap}

    .input, select{border:1px solid var(--border-2);border-radius:.5rem;padding:.625rem .75rem;font:inherit}
    .input.search{padding-left:2.25rem;min-width:16rem}
    .search-wrap{position:relative}
    .search-icon{position:absolute;left:.6rem;top:50%;transform:translateY(-50%);width:1rem;height:1rem;opacity:.5}

    table{width:100%;border-collapse:collapse}
    th,td{padding:.75rem;border-bottom:1px solid var(--border);text-align:left;font-size:.925rem;vertical-align:top}
    tr:hover{background:#f9fafb}

    .badge{display:inline-block;padding:.25rem .5rem;border-radius:.375rem;border:1px solid var(--border-2);font-size:.75rem}
    .badge-secondary{background:#f3f4f6;color:#374151}
    .badge-green{background:var(--green-bg);color:var(--green-text)}
    .badge-orange{background:var(--orange-bg);color:var(--orange-text)}
    .badge-red{background:var(--red-bg);color:var(--red-text)}

    .mono{font-family:ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,"Liberation Mono","Courier New",monospace}

    /* Modal (using <dialog>) */
    dialog{border:none;border-radius:.75rem;box-shadow:var(--shadow);padding:0;width:min(560px,92vw)}
    dialog::backdrop{background:rgba(0,0,0,.35)}
    .modal-head{padding:1rem 1rem .5rem;border-bottom:1px solid var(--border)}
    .modal-title{margin:0;font-size:1.125rem;font-weight:700}
    .modal-body{padding:1rem;max-height:70vh;overflow:auto}
    .grid{display:grid;gap:1rem}
    .grid-2{grid-template-columns:1fr}
    @media (min-width:600px){.grid-2{grid-template-columns:1fr 1fr}}
    .field label{display:block;font-size:.85rem;color:#374151;margin-bottom:.4rem}
    .field input, .field select{width:100%}
    .modal-foot{display:flex;gap:.6rem;justify-content:flex-end;padding:0 1rem 1rem}

    /* Toast */
    .toast{position:fixed;right:1rem;bottom:1rem;display:flex;flex-direction:column;gap:.5rem;z-index:50}
    .toast-item{background:#111827;color:#fff;padding:.6rem .8rem;border-radius:.5rem;box-shadow:var(--shadow);opacity:.95}

    /* Utility */
    .muted{color:var(--muted)}
    .hidden{display:none}
  </style>
</head>
<body>
<header class="page-head">
  <div>
    <h1>Item Management</h1>
    <p class="lead">Manage inventory and item information</p>
  </div>
  <button class="btn" id="btnAdd"><span aria-hidden>➕</span> Add Item</button>
</header>

<section class="card">
  <div class="card-head">
    <div class="row">
      <h2 id="itemsTitle">Items (0)</h2>
      <div class="controls">
        <div class="search-wrap">
          <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden>
            <circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line>
          </svg>
          <input id="searchInput" class="input search" type="search" placeholder="Search items..." />
        </div>
        <select id="categoryFilter" class="input">
          <option value="all">All Categories</option>
        </select>
      </div>
    </div>
  </div>
  <div class="card-body">
    <div class="table-wrap">
      <table id="itemsTable" aria-describedby="itemsTitle">
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
        <tbody id="itemsTbody">
        <!-- rows injected by JS -->
        </tbody>
      </table>
    </div>
  </div>
</section>

<!-- Modal: Add/Edit Item -->
<dialog id="itemDialog" aria-labelledby="dialogTitle">
  <form id="itemForm" method="dialog">
    <div class="modal-head">
      <h3 id="dialogTitle" class="modal-title">Add New Item</h3>
    </div>
    <div class="modal-body">
      <div class="grid grid-2">
        <div class="field">
          <label for="code">Item Code *</label>
          <input id="code" name="code" class="input" placeholder="BK001" required />
        </div>
        <div class="field">
          <label for="name">Item Name *</label>
          <input id="name" name="name" class="input" placeholder="Advanced Mathematics" required />
        </div>
        <div class="field" style="grid-column:1/-1;">
          <label for="description">Description</label>
          <input id="description" name="description" class="input" placeholder="Grade 12 Mathematics Textbook" />
        </div>
        <div class="field">
          <label for="category">Category *</label>
          <select id="category" name="category" class="input" required></select>
        </div>
        <div class="field">
          <label for="price">Price (Rs.) *</label>
          <input id="price" name="price" class="input" type="number" step="0.01" min="0" placeholder="1500" required />
        </div>
        <div class="field">
          <label for="stock">Stock Quantity *</label>
          <input id="stock" name="stock" class="input" type="number" min="0" step="1" placeholder="25" required />
        </div>
        <div class="field">
          <label for="author">Author (Optional)</label>
          <input id="author" name="author" class="input" placeholder="Prof. K. Wijeratne" />
        </div>
        <div class="field">
          <label for="isbn">ISBN (Optional)</label>
          <input id="isbn" name="isbn" class="input" placeholder="978-955-123-456-7" />
        </div>
      </div>
      <input type="hidden" id="editingId" />
    </div>
    <div class="modal-foot">
      <button type="button" class="btn btn-outline" id="btnCancel">Cancel</button>
      <button type="submit" class="btn" id="btnSubmit">Save Item</button>
    </div>
  </form>
</dialog>

<div class="toast" id="toast"></div>

<script>
  // ====== Data & State ======
  const categories = ['Textbooks','Literature','Stationery','Reference','Notebooks','Art Supplies'];
  const categoryFilterEl = document.getElementById('categoryFilter');
  const categorySelectEl  = document.getElementById('category');

  // Populate category controls
  categories.forEach(c => {
    const opt1 = document.createElement('option'); opt1.value=c; opt1.textContent=c; categoryFilterEl.appendChild(opt1);
    const opt2 = document.createElement('option'); opt2.value=c; opt2.textContent=c; categorySelectEl.appendChild(opt2);
  });

  const LS_KEY = 'items_store_v1';
  /** @type {Array<{id:string, code:string, name:string, description?:string, category:string, price:number, stock:number, author?:string, isbn?:string}>} */
  let items = JSON.parse(localStorage.getItem(LS_KEY) || 'null') || [
    { id: crypto.randomUUID(), code:'BK001', name:'Advanced Mathematics', description:'Grade 12 Mathematics Textbook', category:'Textbooks', price:1500, stock:25, author:'Prof. K. Wijeratne', isbn:'978-955-123-456-7' },
    { id: crypto.randomUUID(), code:'ST045', name:'Blue Pen', description:'Smooth ink ballpoint pen', category:'Stationery', price:50, stock:5 },
    { id: crypto.randomUUID(), code:'NB102', name:'A4 Notebook', description:'200 pages ruled', category:'Notebooks', price:350, stock:0 }
  ];

  let searchTerm = '';
  let categoryFilter = 'all';

  // ====== Utilities ======
  const nf = new Intl.NumberFormat('en-LK');
  function formatPrice(v){ return 'Rs. ' + nf.format(v); }

  function save(){ localStorage.setItem(LS_KEY, JSON.stringify(items)); }

  function toast(msg){
    const box = document.getElementById('toast');
    const el = document.createElement('div');
    el.className = 'toast-item';
    el.textContent = msg;
    box.appendChild(el);
    setTimeout(()=>{ el.style.opacity='0'; el.style.transition='opacity .4s'; }, 2400);
    setTimeout(()=>{ el.remove(); }, 2800);
  }

  function stockBadge(stock){
    const span = document.createElement('span');
    span.classList.add('badge');
    if(stock === 0){ span.classList.add('badge-red'); span.textContent = 'Out of Stock'; }
    else if(stock < 10){ span.classList.add('badge-orange'); span.textContent = 'Low Stock'; }
    else { span.classList.add('badge-green'); span.textContent = 'In Stock'; }
    return span;
  }

  // ====== Rendering ======
  function getFiltered(){
    const term = searchTerm.trim().toLowerCase();
    return items.filter(it => {
      const matchesSearch = !term || (
              (it.name||'').toLowerCase().includes(term) ||
              (it.code||'').toLowerCase().includes(term) ||
              (it.category||'').toLowerCase().includes(term)
      );
      const matchesCategory = categoryFilter === 'all' || it.category === categoryFilter;
      return matchesSearch && matchesCategory;
    });
  }

  function render(){
    const tbody = document.getElementById('itemsTbody');
    tbody.innerHTML = '';
    const data = getFiltered();
    document.getElementById('itemsTitle').textContent = `Items (${data.length})`;

    data.forEach(it => {
      const tr = document.createElement('tr');

      // Code
      const tdCode = document.createElement('td');
      const codeBadge = document.createElement('span');
      codeBadge.className = 'badge mono';
      codeBadge.textContent = it.code;
      tdCode.appendChild(codeBadge);
      tr.appendChild(tdCode);

      // Name + desc
      const tdName = document.createElement('td');
      const nm = document.createElement('p'); nm.style.fontWeight = '600'; nm.textContent = it.name; tdName.appendChild(nm);
      if(it.description){ const ds = document.createElement('p'); ds.className='muted'; ds.style.fontSize = '.8rem'; ds.textContent = it.description; tdName.appendChild(ds);}
      tr.appendChild(tdName);

      // Category
      const tdCat = document.createElement('td');
      const catBadge = document.createElement('span'); catBadge.className='badge badge-secondary'; catBadge.textContent = it.category; tdCat.appendChild(catBadge);
      tr.appendChild(tdCat);

      // Price
      const tdPrice = document.createElement('td'); tdPrice.style.fontWeight='600'; tdPrice.textContent = formatPrice(it.price); tr.appendChild(tdPrice);

      // Stock
      const tdStock = document.createElement('td'); tdStock.textContent = it.stock; tr.appendChild(tdStock);

      // Status
      const tdStatus = document.createElement('td'); tdStatus.appendChild(stockBadge(it.stock)); tr.appendChild(tdStatus);

      // Actions
      const tdAct = document.createElement('td');
      const editBtn = document.createElement('button'); editBtn.className='btn btn-outline'; editBtn.textContent='Edit'; editBtn.addEventListener('click',()=> openEdit(it.id));
      const delBtn  = document.createElement('button'); delBtn.className='btn btn-outline danger'; delBtn.textContent='Delete'; delBtn.addEventListener('click',()=> removeItem(it.id));
      tdAct.append(editBtn, document.createTextNode(' '), delBtn);
      tr.appendChild(tdAct);

      tbody.appendChild(tr);
    });
  }

  // ====== Modal & Form ======
  const dlg = document.getElementById('itemDialog');
  const form = document.getElementById('itemForm');
  const btnAdd = document.getElementById('btnAdd');
  const btnCancel = document.getElementById('btnCancel');
  const dialogTitle = document.getElementById('dialogTitle');

  function resetForm(){ form.reset(); document.getElementById('editingId').value=''; }

  function openAdd(){
    resetForm();
    dialogTitle.textContent = 'Add New Item';
    document.getElementById('btnSubmit').textContent = 'Add Item';
    if(typeof dlg.showModal === 'function') dlg.showModal(); else dlg.setAttribute('open','');
  }

  function openEdit(id){
    const it = items.find(x=>x.id===id); if(!it) return;
    resetForm();
    dialogTitle.textContent = 'Edit Item';
    document.getElementById('btnSubmit').textContent = 'Update Item';
    document.getElementById('editingId').value = it.id;
    document.getElementById('code').value = it.code || '';
    document.getElementById('name').value = it.name || '';
    document.getElementById('description').value = it.description || '';
    document.getElementById('category').value = it.category || '';
    document.getElementById('price').value = it.price ?? '';
    document.getElementById('stock').value = it.stock ?? '';
    document.getElementById('author').value = it.author || '';
    document.getElementById('isbn').value = it.isbn || '';
    if(typeof dlg.showModal === 'function') dlg.showModal(); else dlg.setAttribute('open','');
  }

  function closeDialog(){ if(dlg.open) dlg.close(); dlg.removeAttribute('open'); }

  btnAdd.addEventListener('click', openAdd);
  btnCancel.addEventListener('click', (e)=>{ e.preventDefault(); closeDialog(); });

  form.addEventListener('submit', (e)=>{
    e.preventDefault();
    // Validate
    const data = {
      id: document.getElementById('editingId').value || crypto.randomUUID(),
      code: document.getElementById('code').value.trim(),
      name: document.getElementById('name').value.trim(),
      description: document.getElementById('description').value.trim(),
      category: document.getElementById('category').value,
      price: parseFloat(document.getElementById('price').value),
      stock: parseInt(document.getElementById('stock').value,10),
      author: document.getElementById('author').value.trim(),
      isbn: document.getElementById('isbn').value.trim()
    };

    if(!data.code || !data.name || !data.category || isNaN(data.price) || isNaN(data.stock)){
      toast('Please fill all required fields correctly.');
      return;
    }

    const existingIdx = items.findIndex(x=>x.id === data.id);
    if(existingIdx >= 0){
      items[existingIdx] = data;
      toast('Item Updated');
    } else {
      items.push(data);
      toast('Item Added');
    }
    save();
    render();
    closeDialog();
  });

  // ====== Delete ======
  function removeItem(id){
    const it = items.find(x=>x.id===id);
    if(!it) return;
    const ok = confirm(`Delete item "${it.name}"?`);
    if(!ok) return;
    items = items.filter(x=>x.id!==id);
    save();
    render();
    toast('Item Deleted');
  }

  // ====== Search & Filter ======
  document.getElementById('searchInput').addEventListener('input', (e)=>{ searchTerm = e.target.value; render(); });
  categoryFilterEl.addEventListener('change', (e)=>{ categoryFilter = e.target.value; render(); });

  // ====== Init ======
  render();
</script>
</body>
</html>
