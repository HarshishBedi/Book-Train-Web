<!-- <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dropdown Example</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 18px;
            color: #555;
            display: block;
            margin-bottom: 10px;
            text-align: left;
        }

        select {
            padding: 10px;
            width: 100%;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
            margin-bottom: 20px;
            box-sizing: border-box;
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
        }

        button:hover {
            background-color: #b71c1c;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: absolute;
            top: 0;
        }
    </style>
    <script>
        // Function to update destination dropdown based on selected origin
        function updateDestination() {
            var origin = document.getElementById("origin").value;
            
            // If no origin is selected, clear the destination dropdown
            if (origin === "") {
                document.getElementById("destination").innerHTML = "<option value=''>Select a destination</option>";
                return;
            }

            // Create an AJAX request to fetch destinations for the selected origin
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "fetchDestinations.jsp?origin=" + origin, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    // Populate the destination dropdown with the response
                    document.getElementById("destination").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>

    <!-- Header 
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Container 
    <div class="container">
        <h1>Select Origin and Destination</h1>

        <form action="processSelection.jsp" method="post">
            <label for="origin">Origin:</label>
            <select name="origin" id="origin" onchange="updateDestination()">
                <option value="">Select an origin</option>
                <%
                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                        // Query to get distinct origin values
                        String query = "SELECT DISTINCT origin FROM schedule";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        ResultSet rs = stmt.executeQuery();

                        // Populate the origin dropdown
                        while (rs.next()) {
                            String origin = rs.getString("origin");
                %>
                            <option value="<%= origin %>"><%= origin %></option>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error connecting to the database or fetching data.</p>");
                    }
                %>
            </select>

            <br><br>

            <label for="destination">Destination:</label>
            <select name="destination" id="destination">
                <option value="">Select a destination</option>
            </select>

            <br><br>

            <button type="submit">Submit</button>
        </form>
    </div>

</body>
</html> -->



<%@ page import="java.sql.*" %>
<%
    // Handle form submission
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");

        // Store in session attributes
        session.setAttribute("search_origin", origin);
        session.setAttribute("search_destination", destination);

        // Redirect to the results page
        response.sendRedirect("results.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dropdown Example</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 18px;
            color: #555;
            display: block;
            margin-bottom: 10px;
            text-align: left;
        }

        select {
            padding: 10px;
            width: 100%;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
            margin-bottom: 20px;
            box-sizing: border-box;
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
        }

        button:hover {
            background-color: #b71c1c;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: absolute;
            top: 0;
        }
    </style>
    <script>
        // Function to update destination dropdown based on selected origin
        function updateDestination() {
            var origin = document.getElementById("origin").value;

            if (origin === "") {
                document.getElementById("destination").innerHTML = "<option value=''>Select a destination</option>";
                return;
            }

            var xhr = new XMLHttpRequest();
            xhr.open("GET", "fetchDestinations.jsp?origin=" + origin, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("destination").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>

<header>
    CoachPulse Navigation System (TM)
</header>

<div class="container">
    <h1>Select Origin and Destination</h1>

    <form method="post">
        <label for="origin">Origin:</label>
        <select name="origin" id="origin" onchange="updateDestination()">
            <option value="">Select an origin</option>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                    String query = "SELECT DISTINCT origin FROM schedule";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        String origin = rs.getString("origin");
            %>
                        <option value="<%= origin %>"><%= origin %></option>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error connecting to the database or fetching data.</p>");
                }
            %>
        </select>

        <br><br>

        <label for="destination">Destination:</label>
        <select name="destination" id="destination">
            <option value="">Select a destination</option>
        </select>

        <br><br>

        <button type="submit">Submit</button>
    </form>
</div>

</body>
</html>
