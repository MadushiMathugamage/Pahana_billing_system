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
        showToast(message, success);

        // ✅ Redirect to admin dashboard
        setTimeout(() => {
          window.location.href = "dashboard.jsp";
        }, 1500);

      } else if (username === 'employee' && password === 'emp123') {
        success = true;
        message = 'Welcome Employee to Pahana Edu!';
        showToast(message, success);

        // ✅ Redirect to employee dashboard
        setTimeout(() => {
          window.location.href = "employee-dashboard.jsp";
        }, 1500);

      } else {
        message = 'Invalid username or password.';
        showToast(message, success);
        loginBtn.disabled = false;
        loginBtn.textContent = 'Sign In';
      }
    }, 1000);
  });

  function showToast(message, success) {
    toast.textContent = message;
    toast.className = success ? 'toast-success' : 'toast-error';
    toast.style.display = 'block';

    setTimeout(() => {
      toast.style.display = 'none';
    }, 2000);
  }
</script>
