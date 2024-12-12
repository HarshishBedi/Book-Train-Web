<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Train Search</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            margin: 50px auto;
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 16px;
            color: #555;
            display: block;
            margin-bottom: 8px;
        }

        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            color: #333;
        }

        button {
            padding: 12px 24px;
            background-color: #d32f2f;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            margin-top: 15px;
        }

        button:hover {
            background-color: #b71c1c;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // AJAX request to fetch dynamic dropdown values
        function updateDestinations() {
            var origin = $('#origin').val();
            if (origin != '') {
                $.ajax({
                    url: 'getDestinations.jsp', // File to return destination options
                    type: 'GET',
                    data: { origin: origin },
                    success: function(response) {
                        $('#destination').html(response); // Update destination dropdown
                    }
                });
            } else {
                $('#destination').html('<option value="">Select Destination</option>'); // Reset destination if origin is empty
            }
        }
    </script>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Dynamic Train Search Form -->
    <div class="container">
        <h2>Train Search</h2>
        <form method="get" action="search_results.jsp">

            <label for="origin">Origin</label>
            <select id="origin" name="origin" onchange="updateDestinations()">
                <option value="">Select Origin</option>
                <% 
                    // Fetch origins dynamically from the database
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        String url = "jdbc:mysql://localhost:3306/dbdsproject";
                        String username = "root";
                        String password = "root";
                        conn = DriverManager.getConnection(url, username, password);

                        String query = "SELECT DISTINCT Origin FROM schedule";
                        stmt = conn.prepareStatement(query);
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                %>
                            <option value="<%= rs.getString("Origin") %>">
                                <%= rs.getString("Origin") %>
                            </option>
                <% 
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
                %>
            </select>

            <label for="destination">Destination</label>
            <select id="destination" name="destination">
                <option value="">Select Destination</option>
            </select>

            <button type="submit">Search Trains</button>
        </form>
    </div>

</body>
</html>