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
    <title>CoachPulse Navigation System (TM) - Admin Metrics</title>
    <style>
        /* Reset some default styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            height: 100vh;
            background-color: #f8f9fa;
        }

        /* Sidebar styles */
        .sidebar {
        width: 220px;
        background-color: #d32f2f;
        color: white;
        padding-top: 60px; /* Increased padding-top for more space at the top */
        position: fixed;
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        padding-left: 20px;
        top: 0;
    }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 12px 15px;
            width: 100%;
            text-align: left;
            font-size: 16px;
            margin-bottom: 8px;
            border-radius: 6px;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #b71c1c;
        }

        .sidebar a.active {
            background-color: #c62828;
        }

        /* Main content area */
        .main-content {
            margin-left: 240px; /* Account for the sidebar width */
            padding: 20px;
            width: 100%;
            overflow-y: auto;
            padding-top: 120px; /* Adjusted padding to avoid overlap with the header */
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            display: none; /* Initially hide all sections */
            max-width: 800px; /* Set max-width for better layout */
            margin-left: auto;
            margin-right: auto; /* Center content */
        }

        .container.active {
            display: block; /* Show active section */
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 999;
            width: 100%;
        }

        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }

        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
            text-align: center;
        }

        form {
            margin-bottom: 30px;
        }

        label {
            font-size: 14px;
            color: #333;
            display: block;
            margin-bottom: 8px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 16px;
            color: #333;
            box-sizing: border-box;
        }

        button {
            padding: 12px;
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

        .return-link {
            text-align: center;
            margin-top: 20px;
        }

        .return-link a {
            color: #d32f2f;
            text-decoration: none;
            font-size: 14px;
        }

        .return-link a:hover {
            text-decoration: underline;
        }

    </style>
    <script>
        window.onload = function() {
            // Set the default section to be visible (Sales Report)
            showSection('salesReportSection', document.querySelector('.sidebar a'));
        };

        function showSection(sectionId, link) {
            // Hide all sections
            var sections = document.querySelectorAll('.container');
            sections.forEach(function(section) {
                section.classList.remove('active');
            });

            // Remove active class from all sidebar links
            var links = document.querySelectorAll('.sidebar a');
            links.forEach(function(link) {
                link.classList.remove('active');
            });

            // Show the selected section
            var activeSection = document.getElementById(sectionId);
            activeSection.classList.add('active');

            // Add active class to the clicked link
            link.classList.add('active');
        }
    </script>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Sidebar -->
    <div class="sidebar">
        <a href="javascript:void(0)" onclick="showSection('salesReportSection', this)">Sales Reports</a>
        <a href="javascript:void(0)" onclick="showSection('transitLineSection', this)">Transit Line Reservations</a>
        <a href="javascript:void(0)" onclick="showSection('customerSection', this)">Customer Reservations</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        
        <!-- Sales Report Section -->
        <div class="container" id="salesReportSection">
            <h2>Sales Reports</h2>
            <p>Check sales reports for a given month.</p>

            <form method="post" action="metricsscreen.jsp">
                <label for="month">Month:</label>
                <input type="number" id="month" name="month" placeholder="Enter month" min="1" max="12" required>
            
                <label for="year">Year:</label>
                <input type="number" id="year" name="year" placeholder="Enter year" min="2000" max="2100" required>
            
                <button type="submit">Get Report</button>
            </form>
        </div>

        <!-- Transit Line Reservations Section -->
        <div class="container" id="transitLineSection">
            <h2>Get Reservations and Revenue (Transit Line)</h2>
            <p>Fill in the details below to get all reservations and revenue for a given transit line.</p>

            <form method="post" action="metricsscreen.jsp">
                <label for="transitLine">Transit Line:</label>
                <input type="text" id="transitLine" name="transitLine" placeholder="Enter transit line" required>
            
                <button type="submit">Get Details</button>
            </form>
        </div>

        <!-- Customer Reservations Section -->
        <div class="container" id="customerSection">
            <h2>Get Reservations and Revenue (Customer Name)</h2>
            <p>Fill in the details below to get all reservations and revenue for a given customer.</p>

            <form method="post" action="metricsscreen.jsp">
                <label for="customer">Customer Name:</label>
                <input type="text" id="customer" name="customer" placeholder="Enter customer name" required>
            
                <button type="submit">Get Details</button>
            </form>
        </div>

        <div class="return-link">
            <a href="admindash.jsp">Back to Dashboard</a>
        </div>
    </div>

</body>
</html>