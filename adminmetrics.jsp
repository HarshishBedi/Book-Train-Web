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
    <title>Admin Metrics</title>
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
            <h2>Sales Reports</h2>
            <p>Check sales reports for a given month.</p>

            <!-- Train Booking Form -->
            <form method="post" action="metricsscreen.jsp" onsubmit="return validateSalesReportForm()">
                <label for="month">Month:</label>
                <input type="number" id="month" name="month" placeholder="Enter month" required>
            
                <label for="year">Year:</label>
                <input type="number" id="year" name="year" placeholder="Enter year" required>
            
                <button type="submit">Get Report</button>
            </form>
        </div>

        <div>
            <h2>Get Reservations and Revenue (Transit Line)</h2>
            <p>Fill in the details below to get all reservations and revenue for a given transit line.</p>

            <!-- Train Booking Form -->
            <form method="post" action="metricsscreen.jsp" onsubmit="return true">
                <label for="transitLine">Transit Line:</label>
                <input type="text" id="transitLine" name="transitLine" placeholder="Enter transit line" required>
            
                <button type="submit">Book Train</button>
            </form>
        </div>

        <div>
            <h2>Get Reservations and Revenue (Customer Name)</h2>
            <p>Fill in the details below to get all reservations and revenue for a given customer.</p>

            <!-- Train Booking Form -->
            <form method="post" action="metricsscreen.jsp" onsubmit="return true">
                <label for="customer">Customer Name:</label>
                <input type="text" id="customer" name="customer" placeholder="Enter customer name" required>
            
                <button type="submit">Book Train</button>
            </form>
        </div>

        <p><a href="admindash.jsp">Back to Dashboard</a></p>
    </div>

</body>
</html>