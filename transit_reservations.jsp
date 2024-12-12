<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Connection details
    String dbURL = "jdbc:mysql://localhost:3306/dbdsproject";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<String> transitLines = new ArrayList<>();
    String selectedLine = request.getParameter("transit_line"); // Get selected transit line from dropdown
    List<Map<String, String>> reservations = new ArrayList<>();

    // Fetch all transit lines for dropdown
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        pstmt = conn.prepareStatement("SELECT DISTINCT transit_line FROM schedule ORDER BY transit_line");
        rs = pstmt.executeQuery();

        while (rs.next()) {
            transitLines.add(rs.getString("transit_line"));
        }

        // If a transit line is selected, fetch reservations for that line
        if (selectedLine != null && !selectedLine.trim().isEmpty()) {
            pstmt = conn.prepareStatement(
                "SELECT " +
                    "b.Booking_ID as 'Booking ID', " +
                    "c.Customer_ID as 'Customer ID', " +
                    "c.First_Name as 'First Name', " +
                    "c.Last_Name as 'Last Name', " +
                    "b.travel_dt AS 'Travel Date', " +
                    "b.Total_Fare AS 'Fare', " +
                    "s.Transit_line AS 'Travel Line' " +
                "FROM " +
                    "booking b " +
                "JOIN " +
                    "schedule s ON b.Schedule_ID = s.Schedule_ID " +
                "JOIN " +
                    "customers c ON b.Customer_ID = c.Customer_ID " +
                "WHERE " +
                    "s.Transit_Line = ? " +
                "AND Date(b.travel_dt) >= CURDATE()"); // Only show upcoming bookings
            pstmt.setString(1, selectedLine);  // Set the selected transit line in the query
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> reservation = new HashMap<>();
                reservation.put("booking_id", rs.getString("Booking ID"));
                reservation.put("travel_dt", rs.getString("Travel Date"));
                reservation.put("total_fare", rs.getString("Fare"));
                reservation.put("customer_name", rs.getString("First Name") + " " + rs.getString("Last Name"));
                reservation.put("transit_line", rs.getString("Travel Line"));
                reservations.add(reservation);
            }
        }
    } catch (Exception e) {
        e.printStackTrace(); // Log the error if any
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
    <title>Transit Line Reservations</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #d32f2f;
        }

        select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 20px;
            width: 300px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
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

    <script>
        // Function to dynamically load reservations when a transit line is selected
        function loadReservations() {
            var selectedLine = document.getElementById("transit-line").value;
            var url = "transit_reservations.jsp?transit_line=" + selectedLine;
            window.location.href = url; // Refresh the page with the selected line
        }
    </script>
</head>
<body>
    <h1>Transit Line Reservations</h1>
    
    <!-- Dropdown for Transit Lines -->
    <select id="transit-line" onchange="loadReservations()">
        <option value="">Select a Transit Line</option>
        <% for (String line : transitLines) { %>
            <option value="<%= line %>" <%= (line.equals(selectedLine) ? "selected" : "") %>><%= line %></option>
        <% } %>
    </select>

    <% if (reservations.isEmpty() && selectedLine != null) { %>
        <div class="no-results">No upcoming reservations found for the transit line "<%= selectedLine %>".</div>
    <% } else if (!reservations.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Customer Name</th>
                    <th>Travel Date</th>
                    <th>Total Fare (USD)</th>
                    <th>Transit Line</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> res : reservations) { %>
                    <tr>
                        <td><%= res.get("booking_id") %></td>
                        <td><%= res.get("customer_name") %></td>
                        <td><%= res.get("travel_dt") %></td>
                        <td>$<%= res.get("total_fare") %></td>
                        <td><%= res.get("transit_line") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>