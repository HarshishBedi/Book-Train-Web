<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String scheduleId = request.getParameter("scheduleId");
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String departureTime = request.getParameter("departure_time");
    String arrivalTime = request.getParameter("arrival_time");
    double fare = Double.parseDouble(request.getParameter("fare"));
    String action = request.getParameter("action");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        String url = "jdbc:mysql://localhost:3306/dbdsproject";
        String username = "root";
        String password = "root";
        conn = DriverManager.getConnection(url, username, password);

        if ("update".equals(action)) {
            String query = "UPDATE schedule SET Origin = ?, Destination = ?, Departure_Time = ?, Arrival_Time = ?, Fare = ? WHERE Schedule_ID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, origin);
            stmt.setString(2, destination);
            stmt.setString(3, departureTime);
            stmt.setString(4, arrivalTime);
            stmt.setDouble(5, fare);
            stmt.setInt(6, Integer.parseInt(scheduleId));
            stmt.executeUpdate();
            response.sendRedirect("modify_delete_schedule.jsp?success=update");
        } else if ("delete".equals(action)) {
            String query = "DELETE FROM schedule WHERE Schedule_ID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(scheduleId));
            stmt.executeUpdate();
            response.sendRedirect("modify_delete_schedule.jsp?success=delete");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>