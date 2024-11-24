<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String dbURL = "jdbc:mysql://localhost:3306/your_database";
    String dbUser = "your_db_username";
    String dbPassword = "your_db_password";

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String message = "";
    boolean isAuthenticated = false;

    if (username != null && password != null) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                isAuthenticated = true;
                message = "Login successful! Welcome, " + username + ".";
            } else {
                message = "Invalid username or password.";
            }

        } catch (Exception e) {
            message = "An error occurred: " + e.getMessage();
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .login-container h1 {
            color: #333;
            margin-bottom: 1.5rem;
        }

        .login-container label {
            display: block;
            font-weight: bold;
            margin: 0.5rem 0 0.25rem;
            text-align: left;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }

        .login-container button {
            background-color: #007bff;
            color: white;
            padding: 0.75rem 1rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            width: 100%;
        }

        .login-container button:hover {
            background-color: #0056b3;
        }

        .message {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #d9534f; /* Red color for error */
        }

        .message.success {
            color: #5cb85c; /* Green color for success */
        }

        .dashboard-link {
            display: block;
            margin-top: 1rem;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .dashboard-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form method="post" action="login.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit">Login</button>
        </form>

        <p class="message <%= isAuthenticated ? "success" : "" %>">
            <%= message %>
        </p>

        <% if (isAuthenticated) { %>
            <a href="welcome.jsp" class="dashboard-link">Go to Dashboard</a>
        <% } %>
    </div>
</body>
</html>