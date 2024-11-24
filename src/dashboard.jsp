<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .dashboard-container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h2 {
            color: #343a40;
            margin-bottom: 1.5rem;
        }

        p {
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .btn {
            margin-top: 1rem;
            padding: 0.75rem 1rem;
            font-size: 1rem;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>Dashboard</h2>
        <%
            String username = (String) session.getAttribute("username");
            if (username != null) {
        %>
        <p>Welcome, <strong><%= username %></strong>!</p>
        <a href="viewTrains.jsp" class="btn btn-primary w-100">View Trains</a>
        <a href="logout.jsp" class="btn btn-danger w-100 mt-2">Logout</a>
        <% } else { %>
        <p>Please log in to access the dashboard.</p>
        <a href="login.jsp" class="btn btn-primary w-100">Login</a>
        <% } %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>