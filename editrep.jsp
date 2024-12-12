<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%
    // Retrieve session data and form parameters
    String repUsername = "";
    String repPassword = "";
    String firstName = "";
    String lastName = "";
    String ssn = "";
    String employeeId = request.getParameter("id");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

        // Query to get schedule_id, departure_time, and arrival_time for the outgoing journey
        String query = "SELECT * FROM employee WHERE employee_Id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, employeeId);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            repUsername = rs.getString("Username");
            repPassword = rs.getString("Pass");
            firstName = rs.getString("First_Name");
            lastName = rs.getString("Last_Name");
            ssn = rs.getString("SSN");
        }

        // Close resources
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Representative Edit</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #dddddd;
        }

        th, td {
            text-align: left;
            padding: 12px;
        }

        th {
            background-color: #f8f9fa;
            color: #333333;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px 0;
            font-size: 14px;
            font-weight: bold;
            color: #ffffff;
            text-decoration: none;
            text-align: center;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #a71d2a;
        }

        form {
            margin-top: 30px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        button[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Representative Edit
    </header>

    <!-- Edit Customer Representative Form -->
    <div class="container">
        <h2>Edit Representative</h2>
        <form method="post" action="createrep.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="<%= repUsername %>" required>
            
            <label for="password">Password:</label>
            <input type="text" id="password" name="password" placeholder="<%= repPassword %>" required>

            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" placeholder="<%= firstName %>" required>

            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" placeholder="<%= lastName %>" required>

            <label for="ssn">SSN:</label>
            <input type="text" id="ssn" name="ssn" placeholder="<%= ssn %>" required>
            
            <button type="submit">Edit Representative</button>
        </form>
    </div>
</body>
</html>