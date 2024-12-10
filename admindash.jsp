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
    <title>CoachPulse Navigation System (TM) - Admin Dashboard</title>
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

        form {
            margin-bottom: 20px; /* Adds spacing between buttons */
        }

        button {
            padding: 12px 24px;
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
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Admin Dashboard Container -->
    <div class="container">
        <h2>Welcome, <%= session.getAttribute("username") %>!</h2>
        <p>This is your Admin Dashboard.</p>

        <!-- Admin Metrics Button -->
        <form method="get" action="adminmetrics.jsp">
            <button type="submit">View Metrics</button>
        </form>

        <!-- Admin Add Representatives Button -->
        <form method="get" action="adminaddreps.jsp">
            <button type="submit">Add/Edit/Delete Customer Reps</button>
        </form>

        <!-- Logout Form -->
        <form method="post" action="logout.jsp">
            <button type="submit">Logout</button>
        </form>
    </div>

</body>
</html>