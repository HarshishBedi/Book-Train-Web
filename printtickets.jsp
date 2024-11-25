<%
    // Get form data
    String departure = request.getParameter("departure");
    String destination = request.getParameter("destination");
    String travelDate = request.getParameter("travelDate");
    String returnJourney = request.getParameter("returnJourney");
    String returnDate = request.getParameter("returnDate");

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
            background-color: #f0f4f8;
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
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 20px;
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
            left: 0;
        }

    </style>
</head>
<body>

    <!-- Header -->
    <header>
        Train Navigation System
    </header>

    <!-- Ticket Confirmation Container -->
    <div class="container">
        <h2>Booking Confirmation</h2>

        <p><strong>Departure:</strong> <%= departure %></p>
        <p><strong>Destination:</strong> <%= destination %></p>
        <p><strong>Travel Date:</strong> <%= travelDate %></p>

        <% if ("on".equals(returnJourney)) { %>
            <p><strong>Return Journey:</strong> Yes</p>
            <p><strong>Return Date:</strong> <%= returnDate %></p>
        <% } else { %>
            <p><strong>Return Journey:</strong> No</p>
        <% } %>

        <button onclick="window.print()">Print Ticket</button>
    </div>

</body>
</html>