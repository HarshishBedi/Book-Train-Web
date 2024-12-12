<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String scheduleId = request.getParameter("scheduleId");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Variables to hold schedule data
    String origin = null;
    String destination = null;
    String departureTime = null;
    String arrivalTime = null;
    double fare = 0.0;

    if (scheduleId != null) {
        try {
            String url = "jdbc:mysql://localhost:3306/dbdsproject";
            String username = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, username, password);

            String query = "SELECT * FROM schedule WHERE Schedule_ID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(scheduleId));
            rs = stmt.executeQuery();

            if (rs.next()) {
                origin = rs.getString("Origin");
                destination = rs.getString("Destination");
                departureTime = rs.getString("Departure_Time");
                arrivalTime = rs.getString("Arrival_Time");
                fare = rs.getDouble("Fare");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Train Schedule</title>
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
            max-width: 600px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 16px;
            color: #555;
            display: block;
            margin-bottom: 8px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
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

    <!-- Modify or Delete Schedule Form -->
    <div class="container">
        <h2>Modify Train Schedule (ID: <%= scheduleId %>)</h2>

        <% if (origin != null) { %>
            <form method="post" action="update_delete_schedule.jsp">
                <label for="origin">Origin</label>
                <input type="text" id="origin" name="origin" value="<%= origin %>" required>

                <label for="destination">Destination</label>
                <input type="text" id="destination" name="destination" value="<%= destination %>" required>

                <label for="departure_time">Departure Time</label>
                <input type="text" id="departure_time" name="departure_time" value="<%= departureTime %>" required>

                <label for="arrival_time">Arrival Time</label>
                <input type="text" id="arrival_time" name="arrival_time" value="<%= arrivalTime %>" required>

                <label for="fare">Fare</label>
                <input type="number" id="fare" name="fare" value="<%= fare %>" required>

                <input type="hidden" name="scheduleId" value="<%= scheduleId %>">

                <button type="submit" name="action" value="update">Update Schedule</button>
                <button type="submit" name="action" value="delete">Delete Schedule</button>
            </form>
        <% } else { %>
            <p>No schedule found with the provided Schedule ID.</p>
        <% } %>
    </div>

</body>
</html>