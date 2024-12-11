<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Search</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            color: #333;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #C00;
            color: white;
            padding: 20px;
            text-align: center;
        }
        h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }
        form {
            margin: 30px auto;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            width: 50%;
        }
        label {
            font-size: 18px;
            color: #333;
            display: block;
            margin-bottom: 8px;
        }
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            color: #333;
        }
        textarea:disabled {
            background-color: #e0e0e0;
        }
        input[type="submit"] {
            background-color: #C00;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #900;
        }
        table {
            width: 80%;
            margin-top: 30px;
            border-collapse: collapse;
            margin: 0 auto;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #C00;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        p {
            color: #C00;
            font-size: 18px;
            text-align: center;
        }
    </style>
    <script>
        function toggleFields() {
            var origin = document.getElementById('origin').value;
            var destination = document.getElementById('destination').value;
            
            if (origin) {
                document.getElementById('destination').disabled = true;
            } else if (destination) {
                document.getElementById('origin').disabled = true;
            } else {
                document.getElementById('origin').disabled = false;
                document.getElementById('destination').disabled = false;
            }
        }
    </script>
</head>
<body>
    <header>
        <h2>Schedule Search</h2>
    </header>

    <% 
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        
        if ((origin != null && !origin.trim().isEmpty()) || (destination != null && !destination.trim().isEmpty())) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                // Assuming JDBC connection setup
                String url = "jdbc:mysql://localhost:3306/dbdsproject";
                String username = "root";
                String password = "root";
                
                conn = DriverManager.getConnection(url, username, password);
                
                String query = "SELECT * FROM schedule WHERE ";
                if (origin != null && !origin.trim().isEmpty()) {
                    query += "Origin = ? ";
                } else {
                    query += "Destination = ? ";
                }
                
                stmt = conn.prepareStatement(query);
                stmt.setString(1, origin != null && !origin.trim().isEmpty() ? origin : destination);
                
                rs = stmt.executeQuery();
                
                if (rs.next()) {
                    out.println("<h3>Schedule Records</h3>");
                    out.println("<table>");
                    out.println("<tr><th>Schedule_ID</th><th>Train_ID</th><th>Transit_Line</th><th>Origin</th><th>Destination</th><th>Departure_Time</th><th>Arrival_Time</th><th>Fare</th></tr>");
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("Schedule_ID") + "</td>");
                        out.println("<td>" + rs.getInt("Train_ID") + "</td>");
                        out.println("<td>" + rs.getString("Transit_Line") + "</td>");
                        out.println("<td>" + rs.getString("Origin") + "</td>");
                        out.println("<td>" + rs.getString("Destination") + "</td>");
                        out.println("<td>" + rs.getTime("Departure_Time") + "</td>");
                        out.println("<td>" + rs.getTime("Arrival_Time") + "</td>");
                        out.println("<td>" + rs.getBigDecimal("Fare") + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</table>");
                } else {
                    out.println("<p>No schedule found for the given search criteria.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
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
    %>

    <form method="POST">
        <label for="origin">Origin:</label>
        <textarea id="origin" name="origin" rows="2" oninput="toggleFields()"></textarea><br>
        
        <label for="destination">Destination:</label>
        <textarea id="destination" name="destination" rows="2" oninput="toggleFields()"></textarea><br>
        
        <input type="submit" value="Search">
    </form>

</body>
</html>
