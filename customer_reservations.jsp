<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/dbdsproject";
    String dbUser = "root";
    String dbPassword = "root";

    String firstName = request.getParameter("first_name");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    List<Map<String, String>> reservations = new ArrayList<>();
    try {
        if (firstName != null && !firstName.trim().isEmpty()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            pstmt = conn.prepareStatement(
                "SELECT b.booking_id, b.travel_dt, b.total_fare, c.first_name, c.last_name " +
                "FROM booking b " +
                "JOIN customers c ON b.customer_id = c.customer_id " +
                "WHERE c.first_name = ? " +
                "ORDER BY b.travel_dt DESC"
            );
            pstmt.setString(1, firstName);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> reservation = new HashMap<>();
                reservation.put("booking_id", rs.getString("booking_id"));
                reservation.put("travel_dt", rs.getString("travel_dt"));
                reservation.put("total_fare", rs.getString("total_fare"));
                reservation.put("customer_name", rs.getString("first_name") + " " + rs.getString("last_name"));
                reservations.add(reservation);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
        try { if (conn != null) conn.close(); } catch (Exception e) { }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Reservations</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #d32f2f;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        form label {
            font-size: 18px;
            margin-right: 10px;
            align-self: center;
        }

        form input[type="text"] {
            padding: 8px 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
            width: 300px;
        }

        form button {
            padding: 8px 16px;
            font-size: 16px;
            color: white;
            background-color: #d32f2f;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #b71c1c;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            margin-top: 20px;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #d32f2f;
            color: white;
            font-weight: bold;
        }

        table tr:hover {
            background-color: #f5f5f5;
        }

        table td {
            color: #555;
        }

        .no-results {
            text-align: center;
            font-size: 18px;
            color: #777;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Customer Reservations</h1>
    <form method="GET">
        <label for="first_name">First Name:</label>
        <input type="text" id="first_name" name="first_name" value="<%= firstName != null ? firstName : "" %>" placeholder="Enter customer's first name">
        <button type="submit">Search</button>
    </form>

    <% if (reservations.isEmpty() && firstName != null) { %>
        <div class="no-results">No reservations found for the name "<%= firstName %>".</div>
    <% } else if (!reservations.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Customer Name</th>
                    <th>Travel Date</th>
                    <th>Total Fare (USD)</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> res : reservations) { %>
                    <tr>
                        <td><%= res.get("booking_id") %></td>
                        <td><%= res.get("customer_name") %></td>
                        <td><%= res.get("travel_dt") %></td>
                        <td>$<%= res.get("total_fare") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>