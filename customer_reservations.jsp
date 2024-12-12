<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/dbdsproject";
    String dbUser = "root";
    String dbPassword = "root";

    String customerId = request.getParameter("customer_id");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    List<Map<String, String>> reservations = new ArrayList<>();
    try {
        if (customerId != null && !customerId.trim().isEmpty()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            pstmt = conn.prepareStatement(
                "SELECT booking_id, travel_dt, total_fare " +
                "FROM booking WHERE customer_id = ? ORDER BY travel_dt DESC"
            );
            pstmt.setString(1, customerId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> reservation = new HashMap<>();
                reservation.put("booking_id", rs.getString("booking_id"));
                reservation.put("travel_dt", rs.getString("travel_dt"));
                reservation.put("total_fare", rs.getString("total_fare"));
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
    <title>Customer Reservations</title>
</head>
<body>
    <form method="GET">
        <label>Customer ID:</label>
        <input type="text" name="customer_id" value="<%= customerId != null ? customerId : "" %>">
        <button type="submit">Search</button>
    </form>
    <table border="1">
        <tr>
            <th>Booking ID</th>
            <th>Travel Date</th>
            <th>Total Fare</th>
        </tr>
        <% for (Map<String, String> res : reservations) { %>
            <tr>
                <td><%= res.get("booking_id") %></td>
                <td><%= res.get("travel_dt") %></td>
                <td><%= res.get("total_fare") %></td>
            </tr>
        <% } %>
    </table>
</body>
</html>