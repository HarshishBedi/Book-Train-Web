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
    <title>CoachPulse Navigation System (TM) - Admin Metrics</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
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
            max-width: 700px;
        }

        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }

        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
            text-align: center;
        }

        form {
            margin-bottom: 30px;
        }

        label {
            font-size: 14px;
            color: #333;
            display: block;
            margin-bottom: 8px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 16px;
            color: #333;
            box-sizing: border-box;
        }

        button {
            padding: 12px;
            background-color: #d32f2f;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #b71c1c;
        }

        a {
            color: #d32f2f;
            text-decoration: none;
            font-size: 14px;
        }

        a:hover {
            text-decoration: underline;
        }

        .section {
            margin-bottom: 40px;
        }

        .return-link {
            text-align: center;
            margin-top: 20px;
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Metrics Form Container -->
    <div class="container">
        <div class="section">
            <h2>Sales Reports</h2>
            <p>Check sales reports for a given month.</p>

            <form method="post" action="metricsscreen.jsp">
                <label for="month">Month:</label>
                <input type="number" id="month" name="month" placeholder="Enter month" min="1" max="12" required>
            
                <label for="year">Year:</label>
                <input type="number" id="year" name="year" placeholder="Enter year" min="2000" max="2100" required>
            
                <button type="submit">Get Report</button>
            </form>
        </div>

        <div class="section">
            <h2>Get Reservations and Revenue (Transit Line)</h2>
            <p>Fill in the details below to get all reservations and revenue for a given transit line.</p>

            <form method="post" action="metricsscreen.jsp">
                <label for="transitLine">Transit Line:</label>
                <input type="text" id="transitLine" name="transitLine" placeholder="Enter transit line" required>
            
                <button type="submit">Get Details</button>
            </form>
        </div>

        <div class="section">
            <h2>Get Reservations and Revenue (Customer Name)</h2>
            <p>Fill in the details below to get all reservations and revenue for a given customer.</p>

            <form method="post" action="metricsscreen.jsp">
                <label for="customer">Customer Name:</label>
                <input type="text" id="customer" name="customer" placeholder="Enter customer name" required>
            
                <button type="submit">Get Details</button>
            </form>
        </div>

        <div class="return-link">
            <a href="admindash.jsp">Back to Dashboard</a>
        </div>
    </div>

</body>
</html>