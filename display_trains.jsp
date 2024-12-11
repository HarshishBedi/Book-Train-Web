<%
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String date = request.getParameter("date");

    // Basic validation
    if (origin == null || destination == null || date == null) {
        out.println("<p class='error-message'>Please provide all search criteria.</p>");
        return;
    }

    // Database connection
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        java.sql.Connection conn = java.sql.DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/dbdsproject", "root", "asscrack69");

        // Query to get trains matching the search criteria
        String query = "SELECT * FROM trains WHERE origin = ? AND destination = ? AND date = ?";
        java.sql.PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, origin);
        stmt.setString(2, destination);
        stmt.setString(3, date);

        java.sql.ResultSet rs = stmt.executeQuery();

        // Check if there are any trains matching the criteria
        if (rs.next()) {
            out.println("<h3>Available Trains:</h3>");
            out.println("<table>");
            out.println("<tr><th>Train ID</th><th>Origin</th><th>Destination</th><th>Date</th><th>Time</th><th>Price</th></tr>");
            do {
                out.println("<tr>");
                out.println("<td>" + rs.getString("train_id") + "</td>");
                out.println("<td>" + rs.getString("origin") + "</td>");
                out.println("<td>" + rs.getString("destination") + "</td>");
                out.println("<td>" + rs.getString("date") + "</td>");
                out.println("<td>" + rs.getString("time") + "</td>");
                out.println("<td>" + rs.getString("price") + "</td>");
                out.println("</tr>");
            } while (rs.next());
            out.println("</table>");
        } else {
            out.println("<p>No trains found for the given criteria.</p>");
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p class='error-message'>Error connecting to the database.</p>");
    }
%>