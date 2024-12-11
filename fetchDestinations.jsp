<%@ page import="java.sql.*" %>
<%
    String selectedOrigin = request.getParameter("origin");

    if (selectedOrigin != null && !selectedOrigin.isEmpty()) {
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

            // Query to get distinct destinations based on the selected origin
            String query = "SELECT DISTINCT destination FROM schedule WHERE origin = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, selectedOrigin);  // Set the selected origin as a parameter
            ResultSet rs = stmt.executeQuery();

            // Generate options for the destination dropdown
            while (rs.next()) {
                String destination = rs.getString("destination");
                out.println("<option value=\"" + destination + "\">" + destination + "</option>");
            }

            rs.close();
        stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<option value=\"\">Error fetching destinations</option>");
        }
    } else {
        out.println("<option value=\"\">Select a valid origin first</option>");
    }
%>