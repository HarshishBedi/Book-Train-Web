<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CoachPulse</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
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

        /* Sidebar Styles */
        .sidebar {
            width: 200px;
            background-color: #d32f2f;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 20px;
            position: fixed;
            top: 60px; /* Leaves space for the fixed header */
            bottom: 0;
            overflow-y: auto;
        }

        .sidebar h2 {
            text-align: center;
            color: white;
            margin-bottom: 20px;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            padding: 10px 15px;
            margin: 5px 0;
            border-radius: 5px;
            background-color: #b71c1c;
            display: block;
        }

        .sidebar a:hover {
            background-color: #9c1616;
        }

        /* Main Content Area */
        .main-content {
            margin-top: 80px; /* Space for the header */
            margin-left: 250px; /* Space for the sidebar */
            padding: 20px;
            flex-grow: 1;
            width: calc(100% - 250px);
            overflow-y: auto;
        }

        iframe {
            width: 100%;
            height: calc(100vh - 80px); /* Adjust for header height */
            border: none;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                top: 0;
                height: auto;
            }

            .main-content {
                margin-left: 0;
                width: 100%;
            }
        }
    </style>
    <script>
        // JavaScript to load content into the iframe
        function loadContent(url) {
            const iframe = document.getElementById('content-frame');
            iframe.src = url;
        }
    </script>
</head>
<body>
    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM) - Admin Dashboard
    </header>

    <!-- Sidebar -->
<!-- Sidebar -->
    <div class="sidebar">
        <a href="#" onclick="loadContent('sales_report.jsp')">Sales Report</a>
        <a href="#" onclick="loadContent('customer_reservations.jsp')">Customer Reservations</a>
        <a href="#" onclick="loadContent('transit_reservations.jsp')">Transit Line Reservations</a> <!-- New button -->
        <a href="logout.jsp">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Iframe to dynamically load content -->
        <iframe id="content-frame" src="sales_report.jsp"></iframe>
    </div>
</body>
</html>