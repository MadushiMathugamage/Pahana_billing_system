<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 06/08/2025
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Add New Item Form</title>
    <style>
        /* Reset and base */
        *, *::before, *::after {
            box-sizing: border-box;
        }
        body {
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
            Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background: #f9fafb;
            padding: 2rem;
            color: #374151;
        }
        .container {
            max-width: 720px;
            margin: auto;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border: 1px solid #e5e7eb;
            overflow: hidden;
        }
        .header {
            background: linear-gradient(90deg, #2563eb, #1e40af); /* blue-600 to blue-700 */
            padding: 1rem 1.5rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h2 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .icon-package {
            display: inline-block;
            width: 20px;
            height: 20px;
            background: white;
            border-radius: 0.5rem;
        }
        button.close-btn {
            background: transparent;
            border: none;
            color: white;
            cursor: pointer;
            padding: 0.25rem;
            font-weight: bold;
            font-size: 1.25rem;
            border-radius: 0.5rem;
            transition: background-color 0.2s;
        }
        button.close-btn:hover {
            background: rgba(255 255 255 / 0.2);
        }

        form {
            padding: 1.5rem;
        }

        .grid-2-cols {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .full-span {
            grid-column: span 2;
        }

        label {
            display: block;
            font-weight: 600;
            font-size: 0.875rem;
            margin-bottom: 0.4rem;
            color: #374151;
        }

        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            border-radius: 0.75rem;
            border: 1px solid #d1d5db;
            font-size: 1rem;
            transition: border-color 0.2s, box-shadow 0.2s;
            font-family: inherit;
        }
        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #3b82f6; /* blue-500 */
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
        }
        textarea {
            resize: none;
        }

        .error-message {
            color: #dc2626;
            font-size: 0.75rem;
            margin-top: 0.25rem;
        }

        .footer-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
        }
        button.cancel-btn,
        button.submit-btn {
            padding: 0.75rem 2rem;
            border-radius: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s, color 0.3s;
            border: none;
            font-family: inherit;
        }
        button.cancel-btn {
            background: transparent;
            color: #4b5563;
        }
        button.cancel-btn:hover {
            background: #f3f4f6;
            color: #1f2937;
        }
        button.submit-btn {
            background: linear-gradient(90deg, #2563eb, #1e40af);
            color: white;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 10px 15px rgba(37, 99, 235, 0.4);
        }
        button.submit-btn:hover {
            background: linear-gradient(90deg, #1e40af, #2563eb);
            box-shadow: 0 12px 20px rgba(37, 99, 235, 0.6);
        }
        button.submit-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            box-shadow: none;
        }

        button.submit-btn svg {
            width: 16px;
            height: 16px;
            stroke: white;
            stroke-width: 2;
        }

        /* Icons */
        .icon {
            display: inline-block;
            vertical-align: middle;
            margin-right: 0.25rem;
        }

        /* Responsive */
        @media (max-width: 600px) {
            .grid-2-cols {
                grid-template-columns: 1fr;
            }
            .full-span {
                grid-column: auto;
            }
        }
    </style>
</head>
<body>

<div class="container" role="dialog" aria-modal="true" aria-labelledby="dialogTitle">
    <div class="header">
        <h2 id="dialogTitle">
            <span class="icon-package"></span>
            Add New Item
        </h2>
        <button class="close-btn" aria-label="Close form">&times;</button>
    </div>

    <form id="addItemForm" novalidate>
        <div class="grid-2-cols">
            <div class="full-span">
                <label for="name">Item Name *</label>
                <input type="text" id="name" name="name" placeholder="Enter item name" required />
                <p class="error-message" aria-live="polite"></p>
            </div>

            <div>
                <label for="price">
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" fill="none" stroke="currentColor" stroke-width="2"
                         viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round" width="16" height="16" aria-hidden="true">
                        <line x1="12" y1="1" x2="12" y2="23"></line>
                        <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                    </svg>
                    Price *
                </label>
                <input type="number" step="0.01" min="0" id="price" name="price" placeholder="0.00" required />
                <p class="error-message" aria-live="polite"></p>
            </div>

            <div>
                <label for="category">
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" fill="none" stroke="currentColor" stroke-width="2"
                         viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round" width="16" height="16" aria-hidden="true">
                        <path d="M20 12v7a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2v-7"></path>
                        <path d="M20 12V5a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v7"></path>
                        <line x1="10" y1="17" x2="14" y2="17"></line>
                    </svg>
                    Category *
                </label>
                <select id="category" name="category" required>
                    <option value="">Select category</option>
                    <option>Electronics</option>
                    <option>Clothing</option>
                    <option>Home &amp; Garden</option>
                    <option>Sports &amp; Outdoors</option>
                    <option>Books</option>
                    <option>Health &amp; Beauty</option>
                    <option>Toys &amp; Games</option>
                    <option>Other</option>
                </select>
                <p class="error-message" aria-live="polite"></p>
            </div>

            <div>
                <label for="sku">
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" fill="none" stroke="currentColor" stroke-width="2"
                         viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round" width="16" height="16" aria-hidden="true">
                        <line x1="4" y1="12" x2="20" y2="12"></line>
                        <line x1="12" y1="4" x2="12" y2="20"></line>
                    </svg>
                    SKU *
                </label>
                <input type="text" id="sku" name="sku" placeholder="SKU-001" required />
                <p class="error-message" aria-live="polite"></p>
            </div>

            <div>
                <label for="quantity">Quantity</label>
                <input type="number" min="0" id="quantity" name="quantity" placeholder="0" />
                <p class="error-message" aria-live="polite"></p>
            </div>

            <div class="full-span">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="3" placeholder="Enter item description..."></textarea>
            </div>
        </div>

        <div class="footer-buttons">
            <button type="button" class="cancel-btn">Cancel</button>
            <button type="submit" class="submit-btn" disabled> <!-- Disabled by default -->
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"
                     stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" width="16" height="16">
                    <path d="M19 21H5a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h11l5 5v9a2 2 0 0 1-2 2z"></path>
                    <polyline points="17 21 17 13 7 13 7 21"></polyline>
                    <polyline points="7 3 7 8 15 8"></polyline>
                </svg>
                Save Item
            </button>
        </div>
    </form>
</div>

</body>
</html>
