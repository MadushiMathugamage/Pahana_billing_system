<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 06/08/2025
  Time: 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Customer Management</title>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body { margin:0; padding:2rem; background:#f8fafc; font-family:Arial,sans-serif; }
        .container { max-width:1200px; margin:auto; }
        .header { display:flex; justify-content:space-between; align-items:center; margin-bottom:1.5rem; }
        .header h1 { margin:0; font-size:2rem; color:#111827; }
        .header p { margin:0; color:#6b7280; font-size:0.9rem; }
        .btn-add { display:flex; align-items:center; gap:0.5rem; padding:0.5rem 1rem; background:#0ea5e9; color:#fff; border:none; border-radius:6px; font-size:0.9rem; cursor:pointer; }
        .btn-add:hover { background:#0284c7; }
        .btn-add svg { width:1rem; height:1rem; }
        .card { background:#fff; border:1px solid #e5e7eb; border-radius:8px; overflow:hidden; }
        .card-header { padding:1rem; border-bottom:1px solid #e5e7eb; display:flex; justify-content:space-between; align-items:center; }
        .card-header h2 { margin:0; font-size:1.25rem; }
        .search-box { position:relative; width:100%; max-width:300px; }
        .search-box svg { position:absolute; left:8px; top:50%; transform:translateY(-50%); color:#9ca3af; width:1rem; height:1rem; }
        .search-box input { width:100%; padding:0.5rem 0.5rem 0.5rem 1.8rem; border:1px solid #d1d5db; border-radius:6px; font-size:0.9rem; }
        table { width:100%; border-collapse:collapse; }
        th, td { padding:0.75rem; border-bottom:1px solid #e5e7eb; text-align:left; }
        .font-mono { font-family:monospace; }
        .btn-sm { background:#f3f4f6; border:none; padding:0.4rem; border-radius:6px; cursor:pointer; display:inline-flex; align-items:center; justify-content:center; }
        .btn-sm:hover { background:#e5e7eb; }
        .btn-sm.delete { background:#fee2e2; color:#b91c1c; }
        .btn-sm.delete:hover { background:#fef2f2; }
        .badge-outline { display:inline-block; padding:0.25rem 0.5rem; border:1px solid #cbd5e1; border-radius:9999px; font-size:0.75rem; color:#374151; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <div>
            <h1>Customer Management</h1>
            <p>Manage customer accounts and information</p>
        </div>
        <button class="btn-add">
            <svg data-lucide="plus"></svg>
            Add Customer
        </button>
    </div>

    <div class="card">
        <div class="card-header">
            <h2>Customers (3)</h2>
            <div class="search-box">
                <svg data-lucide="search"></svg>
                <input type="text" placeholder="Search customers..."/>
            </div>
        </div>
        <div class="card-content">
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
                <tbody>
                <tr>
                    <td class="font-mono"><span class="badge-outline">ACC001</span></td>
                    <td>John Silva</td>
                    <td>+94771234567</td>
                    <td>2025‑08‑02</td>
                    <td>
                        <button class="btn-sm"><svg data-lucide="edit-2"></svg></button>
                        <button class="btn-sm delete"><svg data-lucide="trash-2"></svg></button>
                    </td>
                </tr>
                <tr>
                    <td class="font-mono"><span class="badge-outline">ACC002</span></td>
                    <td>Jane Perera</td>
                    <td>+94779876543</td>
                    <td>2025‑07‑30</td>
                    <td>
                        <button class="btn-sm"><svg data-lucide="edit-2"></svg></button>
                        <button class="btn-sm delete"><svg data-lucide="trash-2"></svg></button>
                    </td>
                </tr>
                <tr>
                    <td class="font-mono"><span class="badge-outline">ACC003</span></td>
                    <td>Sam Kumara</td>
                    <td>+94770011223</td>
                    <td>2025‑07‑28</td>
                    <td>
                        <button class="btn-sm"><svg data-lucide="edit-2"></svg></button>
                        <button class="btn-sm delete"><svg data-lucide="trash-2"></svg></button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>lucide.createIcons()</script>
</body>
</html>
