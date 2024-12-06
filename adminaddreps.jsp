<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Edit/Add Customer Reps</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }

        input[type="text"], input[type="date"], select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 16px;
            color: #333;
        }

        button {
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #0056b3;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }

        header {
            background-color: #007bff;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: absolute;
            top: 0;
        }

        .return-journey {
            display: none;
            margin-top: 20px;
        }

        /* Align checkbox to the left */
        .checkbox-container {
            text-align: left;
            width: 100%;
            margin-bottom: 20px;
        }

        .checkbox-container input[type="checkbox"] {
            margin-right: 10px;
            vertical-align: middle;
        }
    </style>
    <script>
        function validateSalesReportForm() {
            var month = document.getElementById("month").value;
            var year = document.getElementById("year").value;
            
            // If return date is selected, validate it
            if (month) {
                // Convert to Date objects for comparison
                var travelDateObj = new Date(year, month, 1);
                var today = new Date();
                
                // If return date is earlier than travel date
                if (today.before(travelDate)) {
                    alert("Cannot be in the future.");
                    return false; // Prevent form submission
                }
            }
            
            return true; // Form is valid
        }
    </script>
</head>
<body>

    <!-- Header -->
    <header>
        Train Navigation System
    </header>

    <!-- Book Train Form Container -->
    <div class="container">
        <div>
            <h2>Add New Customer Representative</h2>
            <p>Create a new Customer Representative.</p>

            <!-- ADD MORE DETAILS AS NEEDED FOR DATABASE!!! createrep.jsp is not implemented -->
            <form method="post" action="createrep.jsp">
                <label for="newUsername">Username:</label>
                <input type="text" id="newUsername" name="newUsername" placeholder="Enter username" required>
            
                <label for="newPassword">Password:</label>
                <input type="text" id="newPassword" name="newPassword" placeholder="Enter password" required>
            
                <button type="submit">Create Account</button>
            </form>
        </div>

        <div>
            <h2>Edit Customer Representative</h2>
            <p>Edit or delete a customer representative.</p>

            <!--DISPLAY THE CUSTOMER REPRESENTATIVES HERE, PULLED FROM DATABASE.-->
        </div>

        <p><a href="admindash.jsp">Back to Dashboard</a></p>
    </div>

</body>
</html>