<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transit Booking Details</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Align top of the page */
            min-height: 100vh;
        }

        /* Header Styles */
        header {
            background-color: #d32f2f;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

        /* Main content wrapper */
        .main-wrapper {
            margin-top: 80px; /* Add space for header */
            width: 100%;
            display: flex;
            justify-content: center; /* Center the content horizontally */
            padding: 20px;
        }

        /* Container Styles */
        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 700px;
            text-align: center;
        }

        h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 8px;
            color: #555;
            text-align: left;
        }

        select, input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        button {
            padding: 12px 20px;
            background-color: #d32f2f;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #b71c1c;
        }

        /* Table Styles */
        .result-table {
            width: 90%;
            margin: 30px auto;
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

        .result-table tr:hover {
            background-color: #f5f5f5;
        }

        /* No records found message */
        .no-records {
            text-align: center;
            font-size: 18px;
            color: #777;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<!-- Header -->
<header>
    CoachPulse Navigation System (TM)
</header>

<!-- Main Content Wrapper -->
<div class="main-wrapper">
    <!-- Container -->
    <div class="container">
        <h2>Select Transit Line and Date</h2>
        <form method="post" action="bookingdetails.jsp">
            <label for="transitLine">Select Transit Line:</label>
            <select name="transitLine" id="transitLine" required>
                <option value="">-- Select a Transit Line --</option>
                <% 
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
                    }
                %>
            </select>

            <label for="travelDate">Select Date:</label>
            <input type="date" name="travelDate" id="travelDate" required>

            <button type="submit" name="search" value="search">Search</button>
        </form>

        <%
            String transitLine = request.getParameter("transitLine");
            String travelDate = request.getParameter("travelDate");

            if (transitLine != null && travelDate != null) {
                // Store values as session attributes
                session.setAttribute("transitLine", transitLine);
                session.setAttribute("travelDate", travelDate);

                // Database query to fetch booking details
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                    String query = "SELECT c.Customer_ID AS 'Customer ID', " +
                                   "c.First_Name AS 'First Name', " +
                                   "c.Last_Name AS 'Last Name', " +
                                   "b.travel_dt AS 'Travel Date', " +
                                   "s.Transit_Line AS 'Transit Line Name', " +
                                   "s.Origin, s.Destination " +
                                   "FROM booking b " +
                                   "JOIN schedule s ON b.Schedule_ID = s.Schedule_ID " +
                                   "JOIN customers c ON b.Customer_ID = c.Customer_ID " +
                                   "WHERE s.Transit_Line = ? AND DATE(b.travel_dt) = ?";

                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, transitLine);
                    stmt.setString(2, travelDate);
                    ResultSet rs = stmt.executeQuery();
        %>

                    <table class="result-table">
                        <thead>
                            <tr>
                                <th>Customer ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Travel Date</th>
                                <th>Transit Line Name</th>
                                <th>Origin</th>
                                <th>Destination</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                boolean hasData = false;
                                while (rs.next()) {
                                    hasData = true;
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
                                if (!hasData) {
                            %>
                                    <tr>
                                        <td colspan="7" class="no-records">No records found for the selected criteria.</td>
                                    </tr>
                            <%
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            %>
                        </tbody>
                    </table>
        <%
                } catch (Exception e) {
                    e.printStackTrace();
        %>
                    <p>Error fetching booking details. Please try again.</p>
        <%
                }
            }
        %>
    </div>
</div>

</body>
</html>