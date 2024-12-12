<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transit Line Search</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        select, input[type="date"], button {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
        }
        button {
            background-color: #d32f2f;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #b71c1c;
        }
        .result-table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        .result-table th, .result-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .result-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Select Transit Line and Date</h2>

    <form method="post" action="bookingdetails.jsp">
        <label for="transitLine">Select Transit Line:</label>
        <select name="transitLine" id="transitLine" required>
            <option value="">-- Select a Transit Line --</option>
            <%
                // Database connection and fetching distinct transit lines
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                    String query = "SELECT DISTINCT Transit_Line FROM schedule";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        String transitLine = rs.getString("Transit_Line");
            %>
                        <option value="<%= transitLine %>"><%= transitLine %></option>
            <%
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error fetching transit lines from the database.</p>");
                }
            %>
        </select>

        <label for="travelDate">Select Date:</label>
        <input type="date" name="travelDate" id="travelDate" required>

        <button type="submit" name="submit">Search</button>

        <button type="button" onclick="window.location.href='employeedash.jsp'" style="
    background-color: #d32f2f;
    color: white;
    font-size: 18px;
    padding: 12px 20px;
    margin-top: 20px;
    width: 100%;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;">
    Go To Dashboard
</button>

    </form>

    <%
        // Handling form submission
        if (request.getParameter("submit") != null) {
            String selectedTransitLine = request.getParameter("transitLine");
            String selectedDate = request.getParameter("travelDate");

            // Store values as session attributes
            session.setAttribute("transitLine", selectedTransitLine);
            session.setAttribute("travelDate", selectedDate);

            // Database query to fetch and display results
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                String sqlQuery = "SELECT " +
                                  "c.Customer_ID AS 'Customer ID', " +
                                  "c.First_Name AS 'First Name', " +
                                  "c.Last_Name AS 'Last Name', " +
                                  "b.travel_dt AS 'Travel Date', " +
                                  "s.Transit_Line AS 'Transit Line Name', " +
                                  "s.Origin, " +
                                  "s.Destination " +
                                  "FROM booking b " +
                                  "JOIN schedule s ON b.Schedule_ID = s.Schedule_ID " +
                                  "JOIN customers c ON b.Customer_ID = c.Customer_ID " +
                                  "WHERE s.Transit_Line = ? AND Date(b.travel_dt) = ?";

                PreparedStatement stmt = conn.prepareStatement(sqlQuery);
                stmt.setString(1, selectedTransitLine);
                stmt.setString(2, selectedDate);
                ResultSet rs = stmt.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<p>No results found for the selected transit line and date.</p>");
                } else {
    %>
                    <table class="result-table">
                        <tr>
                            <th>Customer ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Travel Date</th>
                            <th>Transit Line Name</th>
                            <th>Origin</th>
                            <th>Destination</th>
                        </tr>
    <%
                    while (rs.next()) {
    %>
                        <tr>
                            <td><%= rs.getInt("Customer ID") %></td>
                            <td><%= rs.getString("First Name") %></td>
                            <td><%= rs.getString("Last Name") %></td>
                            <td><%= rs.getDate("Travel Date") %></td>
                            <td><%= rs.getString("Transit Line Name") %></td>
                            <td><%= rs.getString("Origin") %></td>
                            <td><%= rs.getString("Destination") %></td>
                        </tr>
    <%
                    }
    %>
                    </table>
    <%
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error fetching data from the database.</p>");
            }
        }
    %>
</div>

</body>
</html>
