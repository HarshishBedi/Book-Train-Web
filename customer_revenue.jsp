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
    List<Map<String, String>> customerRevenue = new ArrayList<>();

    try {
        // Load JDBC driver and establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to get total revenue for each customer
        pstmt = conn.prepareStatement(
            "SELECT c.Customer_ID, c.First_Name, c.Last_Name, SUM(b.Total_Fare) AS Total_Revenue " +
            "FROM booking b " +
            "JOIN customers c ON b.Customer_ID = c.Customer_ID " +
            "GROUP BY c.Customer_ID, c.First_Name, c.Last_Name " +
            "ORDER BY Total_Revenue DESC");

        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> revenue = new HashMap<>();
            revenue.put("customer_id", rs.getString("Customer_ID"));
            revenue.put("first_name", rs.getString("First_Name"));
            revenue.put("last_name", rs.getString("Last_Name"));
            revenue.put("total_revenue", "$" + String.format("%.2f", rs.getDouble("Total_Revenue")));
            customerRevenue.add(revenue);
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
    <title>Customer Revenue</title>
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
    <h1>Customer Revenue</h1>
    
    <% if (!customerRevenue.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Total Revenue</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> customer : customerRevenue) { %>
                    <tr>
                        <td><%= customer.get("customer_id") %></td>
                        <td><%= customer.get("first_name") %></td>
                        <td><%= customer.get("last_name") %></td>
                        <td><%= customer.get("total_revenue") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>No customer revenue data found.</p>
    <% } %>
</body>
</html>