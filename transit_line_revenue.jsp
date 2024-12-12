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
    List<Map<String, String>> transitLineRevenue = new ArrayList<>();

    try {
        // Load JDBC driver and establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to get total revenue for each transit line
        pstmt = conn.prepareStatement(
            "SELECT s.Transit_Line, SUM(b.Total_Fare) AS Total_Revenue " +
            "FROM booking b " +
            "JOIN schedule s ON b.Schedule_ID = s.Schedule_ID " +
            "GROUP BY s.Transit_Line " +
            "ORDER BY Total_Revenue DESC");

        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> revenue = new HashMap<>();
            revenue.put("transit_line", rs.getString("Transit_Line"));
            revenue.put("total_revenue", "$" + String.format("%.2f", rs.getDouble("Total_Revenue")));
            transitLineRevenue.add(revenue);
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
    <title>Transit Line Revenue</title>
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
    </style>
</head>
<body>
    <h1>Transit Line Revenue</h1>

    <% if (!transitLineRevenue.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>Transit Line</th>
                    <th>Total Revenue</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> line : transitLineRevenue) { %>
                    <tr>
                        <td><%= line.get("transit_line") %></td>
                        <td><%= line.get("total_revenue") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>No transit line revenue data found.</p>
    <% } %>
</body>
</html>