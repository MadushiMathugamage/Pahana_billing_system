<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pahana Edu - Login</title>
    <style>
        /* === CSS STYLES === */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to bottom right, #e0f2fe, #c7d2fe);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 1rem;
        }
        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            padding: 2rem;
        }
        .card-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .card-header .icon-wrapper {
            width: 64px;
            height: 64px;
            background: #0ea5e9;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1e293b;
        }
        .card-description {
            color: #64748b;
            margin-top: 0.25rem;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #334155;
            font-weight: 500;
        }
        .form-group .input-icon {
            position: relative;
        }
        .form-group .input-icon i {
            position: absolute;
            top: 12px;
            left: 12px;
            color: #94a3b8;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.75rem 0.75rem 0.75rem 2.5rem;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            font-size: 1rem;
        }
        input:focus {
            outline: none;
            border-color: #38bdf8;
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.2);
        }
        button {
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
            background-color: #0ea5e9;
            color: white;
            font-weight: 500;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background-color: #0284c7;
        }
        button:disabled {
            background-color: #7dd3fc;
            cursor: not-allowed;
        }
        .demo {
            text-align: center;
            font-size: 0.875rem;
            color: #64748b;
            margin-top: 1.5rem;
        }
        .demo code {
            font-family: monospace;
            font-size: 0.75rem;
            display: block;
            margin-top: 0.25rem;
        }
        #toast {
            position: fixed;
            top: 1rem;
            right: 1rem;
            padding: 1rem 1.5rem;
            border-radius: 0.5rem;
            color: white;
            font-weight: 500;
            display: none;
            z-index: 999;
        }
        .toast-success {
            background-color: #16a34a;
        }
        .toast-error {
            background-color: #dc2626;
        }
    </style>
</head>
<body>

<div class="card">
    <div class="card-header">
        <div class="icon-wrapper">
            📘
        </div>
        <div class="card-title">Pahana Edu</div>
        <div class="card-description">Bookshop Management System</div>
    </div>

    <form id="loginForm">
        <div class="form-group">
            <label for="username">Username</label>
            <div class="input-icon">
                <i>👤</i>
                <input type="text" id="username" placeholder="Enter your username" required />
            </div>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <div class="input-icon">
                <i>🔒</i>
                <input type="password" id="password" placeholder="Enter your password" required />
            </div>
        </div>

        <button type="submit" id="loginButton">Sign In</button>
    </form>

    <div class="demo">
        <p>Demo Credentials:</p>
        <code>Admin: admin / admin123</code>
        <code>Employee: employee / emp123</code>
    </div>
</div>

<!-- Toast Message -->
<div id="toast"></div>

<script>
    const form = document.getElementById('loginForm');
    const loginBtn = document.getElementById('loginButton');
    const toast = document.getElementById('toast');

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        loginBtn.disabled = true;
        loginBtn.textContent = 'Signing in...';

        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        setTimeout(() => {
            let success = false;
            let message = '';

            if (username === 'admin' && password === 'admin123') {
                success = true;
                message = 'Welcome Admin to Pahana Edu!';
            } else if (username === 'employee' && password === 'emp123') {
                success = true;
                message = 'Welcome Employee to Pahana Edu!';
            } else {
                message = 'Invalid username or password.';
            }

            showToast(message, success);
            loginBtn.disabled = false;
            loginBtn.textContent = 'Sign In';
        }, 1000);
    });

    function showToast(message, success) {
        toast.textContent = message;
        toast.className = success ? 'toast-success' : 'toast-error';
        toast.style.display = 'block';

        setTimeout(() => {
            toast.style.display = 'none';
        }, 3000);
    }
</script>
</body>
</html>
