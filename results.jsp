<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Results</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }

        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
        }

        h1 {
            color: #d32f2f;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #d32f2f;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Schedule Results</h1>
        <table>
            <thead>
                <tr>
                    <th>Schedule ID</th>
                    <th>Train ID</th>
                    <th>Transit Line</th>
                    <th>Origin</th>
                    <th>Destination</th>
                    <th>Departure Time</th>
                    <th>Arrival Time</th>
                    <th>Fare</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Retrieve origin and destination from session
                    String origin = (String) session.getAttribute("search_origin");
                    String destination = (String) session.getAttribute("search_destination");

                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                        // Query to fetch all data for the selected origin and destination
                        String query = "SELECT * FROM schedule WHERE origin = ? AND destination = ?";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setString(1, origin);
                        stmt.setString(2, destination);
                        ResultSet rs = stmt.executeQuery();

                        // Display each row in the table
                        while (rs.next()) {
                            String scheduleId = rs.getString("schedule_id");
                            String trainId = rs.getString("train_id");
                            String transitLine = rs.getString("transit_line");
                            String departureTime = rs.getString("departure_time");
                            String arrivalTime = rs.getString("arrival_time");
                            String fare = rs.getString("fare");

                %>
                <tr>
                    <td><%= scheduleId %></td>
                    <td><%= trainId %></td>
                    <td><%= transitLine %></td>
                    <td><%= origin %></td>
                    <td><%= destination %></td>
                    <td><%= departureTime %></td>
                    <td><%= arrivalTime %></td>
                    <td><%= fare %></td>
                </tr>
                <%
                        }

                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='8'>Error fetching schedule details.</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
