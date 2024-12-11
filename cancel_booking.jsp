<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get the booking ID from the form submission
    String bookingId = request.getParameter("booking_id");

    if (bookingId != null && !bookingId.isEmpty()) {
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "asscrack69");

            // Query to delete the booking
            String deleteQuery = "DELETE FROM booking WHERE booking_id = ?";
            PreparedStatement stmt = conn.prepareStatement(deleteQuery);
            stmt.setString(1, bookingId);

            int rowsAffected = stmt.executeUpdate();

            stmt.close();
            conn.close();

            // Feedback message (optional, for logging/debugging)
            if (rowsAffected > 0) {
                System.out.println("Booking with ID " + bookingId + " successfully canceled.");
            } else {
                System.out.println("No booking found with ID " + bookingId + ".");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Redirect back to view_cancel.jsp
    response.sendRedirect("view_cancel.jsp");
%>