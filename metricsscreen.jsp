<%
    // Get form data
    String customerName = request.getParameter("customer");
    String transitLine = request.getParameter("transitLine");
    String month = request.getParameter("month");
    String year = request.getParameter("year");

    String bestCustomerName = "GET THIS FROM DATABASE";
    String[] bestTrainLines = {"GET THESE FROM DATABASE"};

    // Example: you can add ticket booking logic here
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Confirmation</title>
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
            box-sizing: border-box;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            font-size: 32px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 15px;
            line-height: 1.6;
        }

        button {
            padding: 12px 24px;
            background-color: #d32f2f;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 20px;
        }

        button:hover {
            background-color: #b71c1c;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
        }

    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Ticket Confirmation Container -->
    <div class="container">
        <h2>Metrics</h2>

        <% if (customerName != null) { %>
            <p><strong>Customer:</strong> <%= customerName %></p>
            <!--DISPLAY REVENUE AND RESERVATION DATA-->
        <% } else if (transitLine != null) { %>
            <p><strong>Transit Line:</strong> <%= transitLine %></p>
            <!--DISPLAY REVENUE AND RESERVATION DATA-->
        <% } else { %>
            <p><strong>Total Sales in <%= month %>/<%= year %>:</strong> <!--DISPLAY THE SALES HERE--></p>
        <% } %>

        <p><strong>Best Customer:</strong> <%= bestCustomerName %></p>

        <p><strong>Best Train Lines:</strong> <%= bestTrainLines %></p>

    </div>

</body>
</html>