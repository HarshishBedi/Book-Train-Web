<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="java.io.IOException" %>
<%
    // Initialize session and database variables
    <!-- HttpSession session = request.getSession(); // No need to import HttpSession, it's available by default -->
    String employeeIdToDelete = (String) session.getAttribute("employee_id_to_delete");
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    if (employeeIdToDelete != null) {
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load the JDBC driver
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root"); // Update with your database credentials

            // SQL query to delete the employee record
            String deleteQuery = "DELETE FROM employee WHERE employee_id = ?";
            preparedStatement = connection.prepareStatement(deleteQuery);
            preparedStatement.setInt(1, Integer.parseInt(employeeIdToDelete));

            // Execute the delete operation
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Successfully deleted
                session.removeAttribute("employee_id_to_delete");
                response.sendRedirect("manage_reps.jsp?message=Representative deleted successfully");
            } else {
                // If no rows affected, send error message
                response.sendRedirect("manage_reps.jsp?message=Error deleting representative");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_reps.jsp?message=An error occurred while deleting the representative");
        } finally {
            // Close resources
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        // If no employee ID was found in the session, redirect to the manage reps page with an error message
        response.sendRedirect("manage_reps.jsp?message=No representative selected for deletion");
    }
%>