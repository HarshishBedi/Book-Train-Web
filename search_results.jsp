<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 800px;
            margin: 50px auto;
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #d32f2f;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .no-results {
            text-align: center;
            font-size: 18px;
            color: #555;
            margin-top: 20px;
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
            margin-top: 15px;
        }

        button:hover {
            background-color: #b71c1c;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Search Results Container -->
    <div class="container">
        <h2>Train Search Results</h2>

        <% 
            // Get the form data from the request
            String origin = request.getParameter("origin");
            String destination = request.getParameter("destination");

            if ((origin != null && !origin.isEmpty()) || (destination != null && !destination.isEmpty())) {
                // Fetch the search results from the database based on the origin and/or destination
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/dbdsproject";
                    String username = "root";
                    String password = "root";
                    conn = DriverManager.getConnection(url, username, password);

                    StringBuilder query = new StringBuilder("SELECT * FROM schedule WHERE ");
                    boolean addWhere = false;

                    if (origin != null && !origin.isEmpty()) {
                        query.append("Origin = ?");
                        addWhere = true;
                    }
                    if (destination != null && !destination.isEmpty()) {
                        if (addWhere) query.append(" AND ");
                        query.append("Destination = ?");
                    }

                    stmt = conn.prepareStatement(query.toString());

                    // Set parameters dynamically based on the fields
                    int paramIndex = 1;
                    if (origin != null && !origin.isEmpty()) {
                        stmt.setString(paramIndex++, origin);
                    }
                    if (destination != null && !destination.isEmpty()) {
                        stmt.setString(paramIndex++, destination);
                    }

                    rs = stmt.executeQuery();

                    // Check if there are any results
                    if (rs.next()) {
        %>
                        <!-- Display results in a table -->
                        <table>
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
        <% 
                        // Loop through the result set and display each row
                        do {
        %>
                            <tr>
                                <td><%= rs.getInt("Schedule_ID") %></td>
                                <td><%= rs.getInt("Train_ID") %></td>
                                <td><%= rs.getString("Transit_Line") %></td>
                                <td><%= rs.getString("Origin") %></td>
                                <td><%= rs.getString("Destination") %></td>
                                <td><%= rs.getTime("Departure_Time") %></td>
                                <td><%= rs.getTime("Arrival_Time") %></td>
                                <td><%= rs.getBigDecimal("Fare") %></td>
                            </tr>
        <% 
                        } while (rs.next()); 
                    } else {
        %>
                        <!-- No results found message -->
                        <div class="no-results">
                            No trains found for the selected criteria.
                        </div>
        <% 
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
        %>
                <!-- Message if no form data is submitted -->
                <div class="no-results">
                    Please select at least one field (origin or destination) to search for trains.
                </div>
        <% 
            }
        %>

        <!-- Back to search form button -->
        <form method="get" action="schedule.jsp">
            <button type="submit">Back to Search</button>
        </form>

    </div>

</body>
</html>