<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Process Schedule Updates</title>
</head>
<body>
    <h1>Processing Updates</h1>
    <%
        Connection conn = null;
        PreparedStatement updateStmt = null;
        PreparedStatement deleteStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

            // Prepare SQL statements
            String updateSQL = "UPDATE schedule SET Train_ID = ?, Transit_Line = ?, Origin = ?, Destination = ?, Departure_Time = ?, Arrival_Time = ?, Fare = ? WHERE Schedule_ID = ?";
            updateStmt = conn.prepareStatement(updateSQL);

            String deleteSQL = "DELETE FROM schedule WHERE Schedule_ID = ?";
            deleteStmt = conn.prepareStatement(deleteSQL);

            // Process parameters
            for (String param : request.getParameterMap().keySet()) {
                if (param.startsWith("trainId_")) {
                    int scheduleId = Integer.parseInt(param.split("_")[1]);

                    // Check if the row is marked for deletion
                    String deleteFlag = request.getParameter("delete_" + scheduleId);
                    if ("true".equals(deleteFlag)) {
                        deleteStmt.setInt(1, scheduleId);
                        deleteStmt.executeUpdate();
                    } else {
                        // Update the row
                        int trainId = Integer.parseInt(request.getParameter("trainId_" + scheduleId));
                        String transitLine = request.getParameter("transitLine_" + scheduleId);
                        String origin = request.getParameter("origin_" + scheduleId);
                        String destination = request.getParameter("destination_" + scheduleId);
                        String departureTime = request.getParameter("departureTime_" + scheduleId);
                        String arrivalTime = request.getParameter("arrivalTime_" + scheduleId);
                        String fare = request.getParameter("fare_" + scheduleId);

                        updateStmt.setInt(1, trainId);
                        updateStmt.setString(2, transitLine);
                        updateStmt.setString(3, origin);
                        updateStmt.setString(4, destination);
                        updateStmt.setString(5, departureTime);
                        updateStmt.setString(6, arrivalTime);
                        updateStmt.setString(7, fare);
                        updateStmt.setInt(8, scheduleId);

                        updateStmt.executeUpdate();
                    }
                }
            }

            out.println("<p>Updates and deletions processed successfully.</p>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (updateStmt != null) updateStmt.close();
            if (deleteStmt != null) deleteStmt.close();
            if (conn != null) conn.close();
        }
    %>
    <a href="schedule.jsp">Back to Schedule</a>
</body>
</html>
