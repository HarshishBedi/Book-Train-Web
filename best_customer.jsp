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
    Map<String, String> bestCustomerByReservations = new HashMap<>();
    Map<String, String> bestCustomerBySpending = new HashMap<>();

    try {
        // Load JDBC driver and establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to find the customer with the most reservations
        pstmt = conn.prepareStatement(
            "SELECT c.Customer_ID, c.First_Name, c.Last_Name, COUNT(b.Booking_ID) AS Reservation_Count " +
            "FROM booking b " +
            "JOIN customers c ON b.Customer_ID = c.Customer_ID " +
            "GROUP BY c.Customer_ID " +
            "ORDER BY Reservation_Count DESC LIMIT 1");

        rs = pstmt.executeQuery();
        if (rs.next()) {
            bestCustomerByReservations.put("customer_name", rs.getString("First_Name") + " " + rs.getString("Last_Name"));
            bestCustomerByReservations.put("reservation_count", rs.getString("Reservation_Count"));
        }

        // Query to find the customer who spent the most money
        pstmt = conn.prepareStatement(
            "SELECT c.Customer_ID, c.First_Name, c.Last_Name, SUM(b.Total_Fare) AS Total_Spending " +
            "FROM booking b " +
            "JOIN customers c ON b.Customer_ID = c.Customer_ID " +
            "GROUP BY c.Customer_ID " +
            "ORDER BY Total_Spending DESC LIMIT 1");

        rs = pstmt.executeQuery();
        if (rs.next()) {
            bestCustomerBySpending.put("customer_name", rs.getString("First_Name") + " " + rs.getString("Last_Name"));
            bestCustomerBySpending.put("total_spending", "$" + String.format("%.2f", rs.getDouble("Total_Spending")));
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
    <title>Best Customer</title>
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

        .container {
            display: flex;
            justify-content: space-around;
            margin-top: 40px;
        }

        .box {
            background-color: white;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
            width: 40%;
        }

        .box h2 {
            color: #d32f2f;
            font-size: 24px;
        }

        .box p {
            font-size: 18px;
            color: #555;
        }
    </style>
</head>
<body>
    <h1>Best Customer Information</h1>

    <div class="container">
        <!-- Customer with most reservations -->
        <div class="box">
            <h2>Customer with Most Reservations</h2>
            <% if (!bestCustomerByReservations.isEmpty()) { %>
                <p><strong>Name:</strong> <%= bestCustomerByReservations.get("customer_name") %></p>
                <p><strong>Number of Reservations:</strong> <%= bestCustomerByReservations.get("reservation_count") %></p>
            <% } else { %>
                <p>No data available.</p>
            <% } %>
        </div>

        <!-- Customer who spent the most -->
        <div class="box">
            <h2>Customer Who Spent the Most</h2>
            <% if (!bestCustomerBySpending.isEmpty()) { %>
                <p><strong>Name:</strong> <%= bestCustomerBySpending.get("customer_name") %></p>
                <p><strong>Total Spending:</strong> <%= bestCustomerBySpending.get("total_spending") %></p>
            <% } else { %>
                <p>No data available.</p>
            <% } %>
        </div>
    </div>
</body>
</html>