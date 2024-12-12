<%@ page import="java.sql.*, java.util.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/dbdsproject";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, String>> topTransitLines = new ArrayList<>();

    try {
        // Load JDBC driver and establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to find the 5 most active transit lines based on reservations
        pstmt = conn.prepareStatement(
            "SELECT s.Transit_Line, COUNT(b.Booking_ID) AS Reservation_Count " +
            "FROM booking b " +
            "JOIN schedule s ON b.Schedule_ID = s.Schedule_ID " +
            "GROUP BY s.Transit_Line " +
            "ORDER BY Reservation_Count DESC LIMIT 5");

        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> transitLineData = new HashMap<>();
            transitLineData.put("transit_line", rs.getString("Transit_Line"));
            transitLineData.put("reservation_count", rs.getString("Reservation_Count"));
            topTransitLines.add(transitLineData);
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
    <title>Most Active Transit Lines</title>
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
</head>
<body>
    <h1>Most Active Transit Lines</h1>

    <% if (topTransitLines.isEmpty()) { %>
        <div class="no-results">No data available for the most active transit lines.</div>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Transit Line</th>
                    <th>Number of Reservations</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> transitLine : topTransitLines) { %>
                    <tr>
                        <td><%= transitLine.get("transit_line") %></td>
                        <td><%= transitLine.get("reservation_count") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>