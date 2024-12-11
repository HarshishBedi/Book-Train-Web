<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
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
    <title>CoachPulse Navigation System (TM) - Metrics</title>
    <style>
        /* Reset and general styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }

        /* Header styles */
        header {
            background-color: #d32f2f;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        /* Main content area */
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
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

        .return-link {
            text-align: center;
            margin-top: 20px;
        }

        .return-link a {
            color: #d32f2f;
            text-decoration: none;
            font-size: 14px;
        }

        .return-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <!-- <header>
        CoachPulse Navigation System (TM)
    </header> -->

    <!-- Sales Report Section -->
    <div class="container">
        <h2>Sales Reports</h2>
        <p>Check sales reports for a given month.</p>
        <form method="post" action="metricsscreen.jsp">
            <label for="month">Month:</label>
            <input type="number" id="month" name="month" min="1" max="12" placeholder="Enter month" required>
            <label for="year">Year:</label>
            <input type="number" id="year" name="year" min="2000" max="2100" placeholder="Enter year" required>
            <button type="submit">Get Report</button>
        </form>
    </div>

    <!-- Transit Line Reservations Section -->
    <div class="container">
        <h2>Transit Line Reservations</h2>
        <p>Check reservations and revenue for a given transit line.</p>
        <form method="post" action="metricsscreen.jsp">
            <label for="transitLine">Transit Line:</label>
            <input type="text" id="transitLine" name="transitLine" placeholder="Enter transit line" required>
            <button type="submit">Get Details</button>
        </form>
    </div>

    <!-- Customer Reservations Section -->
    <div class="container">
        <h2>Customer Reservations</h2>
        <p>Check reservations and revenue for a specific customer.</p>
        <form method="post" action="metricsscreen.jsp">
            <label for="customer">Customer Name:</label>
            <input type="text" id="customer" name="customer" placeholder="Enter customer name" required>
            <button type="submit">Get Details</button>
        </form>
    </div>
</body>
</html>