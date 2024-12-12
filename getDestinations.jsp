<%@ page import="java.sql.*, java.util.*" %>
<%
    String origin = request.getParameter("origin");
    List<String> destinations = new ArrayList<>();
    
    if (origin != null && !origin.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String url = "jdbc:mysql://localhost:3306/dbdsproject";
            String username = "root";
            String password = "root";
            
            conn = DriverManager.getConnection(url, username, password);
            
            String query = "SELECT DISTINCT Destination FROM schedule WHERE Origin = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, origin);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                destinations.add(rs.getString("Destination"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Return the destination options dynamically based on the origin
    if (!destinations.isEmpty()) {
        for (String destination : destinations) {
            out.println("<option value='" + destination + "'>" + destination + "</option>");
        }
    } else {
        out.println("<option value=''>No destinations available</option>");
    }
%>