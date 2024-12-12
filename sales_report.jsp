<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.time.*" %>
<%
    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/dbdsproject";
    String dbUser = "root";
    String dbPassword = "root";

    // Default year
    String year = request.getParameter("year") != null ? request.getParameter("year") : "2024";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Sales data
    Map<String, Double> monthlySales = new LinkedHashMap<>();
    String[] monthNames = {"January", "February", "March", "April", "May", "June", 
                           "July", "August", "September", "October", "November", "December"};
    double currentMonthSales = 0.0;

    try {
        if (year != null && !year.trim().isEmpty()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            for (String month : monthNames) {
                monthlySales.put(month, 0.0);
            }

            pstmt = conn.prepareStatement(
                "SELECT MONTH(travel_dt) as month, SUM(total_fare) as total_revenue " +
                "FROM booking " +
                "WHERE YEAR(travel_dt) = ? " +
                "GROUP BY MONTH(travel_dt)"
            );
            pstmt.setString(1, year);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int monthIndex = rs.getInt("month") - 1;
                double revenue = rs.getDouble("total_revenue");
                monthlySales.put(monthNames[monthIndex], revenue);
                if (monthIndex == LocalDate.now().getMonthValue() - 1) {
                    currentMonthSales = revenue;
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
        try { if (conn != null) conn.close(); } catch (Exception e) { }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script>
        google.charts.load('current', { packages: ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
            const data = google.visualization.arrayToDataTable([
                ['Month', 'Total Sales (USD)'],
                <% for (Map.Entry<String, Double> entry : monthlySales.entrySet()) { %>
                    ['<%= entry.getKey() %>', <%= entry.getValue() %>],
                <% } %>
            ]);
            const options = { 
                title: 'Monthly Sales for <%= year %>',
                hAxis: { title: 'Month', textStyle: { fontSize: 12 }, titleTextStyle: { bold: true } },
                vAxis: { title: 'Total Sales (USD)', textStyle: { fontSize: 12 }, titleTextStyle: { bold: true } },
                chartArea: { width: '80%', height: '70%' },
                colors: ['#d32f2f']
            };
            const chart = new google.visualization.ColumnChart(document.getElementById('sales_chart'));
            chart.draw(data, options);
        }
    </script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
            color: #333;
        }

        form {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        form label {
            font-size: 18px;
            margin-right: 10px;
            align-self: center;
        }

        form input[type="text"] {
            padding: 8px 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
            width: 200px;
        }

        form button {
            padding: 8px 16px;
            font-size: 16px;
            color: white;
            background-color: #d32f2f;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #b71c1c;
        }

        #sales_chart {
            margin: 0 auto;
            width: 90%;
            height: 500px;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 10px;
        }
    </style>
</head>
<body>
    <form method="GET">
        <label for="year">Year:</label>
        <input type="text" id="year" name="year" value="<%= year %>" placeholder="Enter year (e.g., 2024)">
        <button type="submit">View</button>
    </form>
    <div id="sales_chart"></div>
</body>
</html>