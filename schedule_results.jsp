<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Results</title>
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
        // Sortable table functionality
        function sortTable(n) {
            var table = document.getElementById("scheduleTable");
            var rows = table.rows;
            var switching = true;
            var dir = "asc";
            var switchcount = 0;

            while (switching) {
                switching = false;
                var rowsArray = Array.from(rows).slice(1); // Exclude header row
                for (var i = 0; i < rowsArray.length - 1; i++) {
                    var x = rowsArray[i].getElementsByTagName("TD")[n];
                    var y = rowsArray[i + 1].getElementsByTagName("TD")[n];
                    if (dir === "asc" && x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase() || 
                        dir === "desc" && x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                        rowsArray[i].parentNode.insertBefore(rowsArray[i + 1], rowsArray[i]);
                        switching = true;
                        switchcount++;
                        break;
                    }
                }
                if (switchcount === 0 && dir === "asc") {
                    dir = "desc";
                    switching = true;
                }
            }
        }
    </script>
</head>
<body>
    <header>
        <h2>Schedule Results</h2>
    </header>

    <%
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
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
                query += "Origin = ?";
            } else {
                query += "Destination = ?";
            }

            stmt = conn.prepareStatement(query);
            stmt.setString(1, origin != null && !origin.trim().isEmpty() ? origin : destination);
            rs = stmt.executeQuery();

            if (rs.next()) {
                out.println("<h3>Schedule Records</h3>");
                out.println("<table id='scheduleTable'>");
                out.println("<tr><th onclick='sortTable(0)'>Schedule_ID</th><th onclick='sortTable(1)'>Train_ID</th><th onclick='sortTable(2)'>Transit_Line</th><th onclick='sortTable(3)'>Origin</th><th onclick='sortTable(4)'>Destination</th><th onclick='sortTable(5)'>Departure_Time</th><th onclick='sortTable(6)'>Arrival_Time</th><th onclick='sortTable(7)'>Fare</th></tr>");
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
    %>

</body>
</html>
