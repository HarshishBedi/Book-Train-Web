<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/dbdsproject";
    String dbUser = "root";
    String dbPassword = "root";
    
    // Get form data
    String year = request.getParameter("year");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Data for graph
    Map<String, Double> monthlySales = new LinkedHashMap<>();
    String[] monthNames = {"January", "February", "March", "April", "May", "June", 
                           "July", "August", "September", "October", "November", "December"};

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Initialize monthly sales with zero values
        for (String month : monthNames) {
            monthlySales.put(month, 0.0);
        }

        // Query for monthly sales data
        pstmt = conn.prepareStatement(
            "SELECT MONTH(travel_dt) as month, SUM(total_fare) as total_revenue " +
            "FROM booking " +
            "WHERE YEAR(travel_dt) = ? " +
            "GROUP BY MONTH(travel_dt)"
        );
        pstmt.setString(1, year);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            int monthIndex = rs.getInt("month") - 1; // Convert to zero-based index
            double revenue = rs.getDouble("total_revenue");
            monthlySales.put(monthNames[monthIndex], revenue);
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
    <title>Monthly Sales Report</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart', 'bar']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Month', 'Sales'],
                <% for (Map.Entry<String, Double> entry : monthlySales.entrySet()) { %>
                    ['<%= entry.getKey() %>', <%= entry.getValue() %>],
                <% } %>
            ]);

            var options = {
                title: 'Monthly Sales Report',
                hAxis: {
                    title: 'Month'
                },
                vAxis: {
                    title: 'Sales'
                },
                legend: { position: 'none' },
                chartArea: { width: '70%', height: '70%' }
            };

            var chart = new google.visualization.ColumnChart(document.getElementById('sales_chart'));
            chart.draw(data, options);
        }
    </script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }

        h1 {
            font-size: 32px;
            text-align: center;
            color: #333;
        }

        .container {
            text-align: center;
            margin-top: 40px;
        }

        #sales_chart {
            width: 100%;
            height: 500px;
            margin: 0 auto;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            font-size: 16px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

    <h1>Monthly Sales Report</h1>

    <!-- Sales chart -->
    <div class="container" id="sales_chart"></div>

    <!-- Monthly sales table -->
    <table>
        <tr>
            <th>Month</th>
            <th>Total Sales ($)</th>
        </tr>
        <% for (Map.Entry<String, Double> entry : monthlySales.entrySet()) { %>
            <tr>
                <td><%= entry.getKey() %></td>
                <td><%= String.format("%.2f", entry.getValue()) %></td>
            </tr>
        <% } %>
    </table>

</body>
</html>