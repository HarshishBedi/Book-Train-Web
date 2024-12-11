<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager" %>
<%
    // Database connection setup
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load the JDBC driver
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root"); // Update with your database credentials

        // Fetch all customer representatives
        String query = "SELECT employee_id, username FROM employee";
        preparedStatement = connection.prepareStatement(query);
        resultSet = preparedStatement.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin: Add/Edit Reps</title>
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

        .btn {
            display: inline-block;
            padding: 10px 15px;
            font-size: 14px;
            font-weight: bold;
            color: #ffffff;
            text-decoration: none;
            text-align: center;
            border-radius: 5px;
            transition: all 0.3s ease-in-out;
            cursor: pointer;
        }

        .btn-add {
            background-color: #28a745;
            margin-bottom: 20px;
            display: block;
            width: max-content;
            margin-left: auto;
            margin-right: auto;
        }

        .btn-add:hover {
            background-color: #218838;
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
    <div class="container">
        <h1>Manage Customer Representatives</h1>

        <!-- Add Representative Button -->
        <a href="#addForm" class="btn btn-add">Add New Representative</a>
        
        <!-- Display Customer Representatives -->
        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Username</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (resultSet.next()) {
                        int employeeId = resultSet.getInt("employee_id");
                        String username = resultSet.getString("username");
                %>
                <tr>
                    <td><%= employeeId %></td>
                    <td><%= username %></td>
                    <td>
                        <a href="editrep.jsp?id=<%= employeeId %>" class="btn btn-primary">Edit</a>
                        <a href="deleterep.jsp?id=<%= employeeId %>" class="btn btn-danger">Delete</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <!-- Add New Customer Representative Form -->
        <h2 id="addForm">Add New Representative</h2>
        <form method="post" action="createrep.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="Enter username" required>
            
            <label for="password">Password:</label>
            <input type="text" id="password" name="password" placeholder="Enter password" required>
            
            <button type="submit">Add Representative</button>
        </form>
    </div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (resultSet != null) try { resultSet.close(); } catch (Exception ignore) {}
        if (preparedStatement != null) try { preparedStatement.close(); } catch (Exception ignore) {}
        if (connection != null) try {