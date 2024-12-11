<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%
    // Retrieve session data and form parameters
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String fare = request.getParameter("fare");
    String discountedFareMessage = request.getParameter("discountedFareMessage");
    String travelDate = (String) session.getAttribute("travelDate");
    String returnDate = (String) session.getAttribute("returnDate");
    int customerId = (int) session.getAttribute("customer_id"); // Assuming customer_id is stored in session

    // Variables for departure and arrival times
    String departureTime = "N/A";
    String arrivalTime = "N/A";
    int scheduleId = -1; // Default value to store schedule ID from the database
    String travelDt = "";  // This will hold the merged travel date and time
    String returnTravelDt = "";  // This will hold the merged return travel date and time
    int returnScheduleId = -1;  // Schedule ID for the return journey

    double totalFare = Double.parseDouble(fare);
    double returnFare = totalFare;  // Default return fare is same as outgoing fare

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "asscrack69");

        // Query to get schedule_id, departure_time, and arrival_time for the outgoing journey
        String query = "SELECT schedule_id, Departure_time, Arrival_time FROM schedule WHERE origin = ? AND destination = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, origin);
        stmt.setString(2, destination);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            scheduleId = rs.getInt("schedule_id");
            departureTime = rs.getString("Departure_time");
            arrivalTime = rs.getString("Arrival_time");

            // Combine travel_date and departure_time to create travel_dt
            if (!"N/A".equals(departureTime) && travelDate != null) {
                SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm:ss");
                String formattedDepartureTime = timeFormatter.format(timeFormatter.parse(departureTime));
                travelDt = travelDate + " " + formattedDepartureTime; // Format as yyyy-MM-dd HH:mm:ss
            }
        }

        // Query for the return journey (reverse origin and destination)
        if (returnDate != null && !returnDate.isEmpty()) {
            query = "SELECT schedule_id, Departure_time, Arrival_time FROM schedule WHERE origin = ? AND destination = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, destination); // Reverse origin
            stmt.setString(2, origin); // Reverse destination

            rs = stmt.executeQuery();
            if (rs.next()) {
                returnScheduleId = rs.getInt("schedule_id");
                String returnDepartureTime = rs.getString("Departure_time");

                // Combine return_date and departure_time to create returnTravelDt
                if (!"N/A".equals(returnDepartureTime)) {
                    SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm:ss");
                    String formattedReturnDepartureTime = timeFormatter.format(timeFormatter.parse(returnDepartureTime));
                    returnTravelDt = returnDate + " " + formattedReturnDepartureTime;
                }

                // Double the fare for the return journey
                returnFare = totalFare;
            }
        }

        // Insert the outgoing journey into the booking table
        String insertQuery = "INSERT INTO booking (customer_id, schedule_id, total_fare, travel_dt, booking_date) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
        insertStmt.setInt(1, customerId);
        insertStmt.setInt(2, scheduleId);
        insertStmt.setDouble(3, totalFare);
        insertStmt.setString(4, travelDt);
        insertStmt.executeUpdate();

        // Insert the return journey into the booking table if applicable
        if (returnScheduleId != -1) {
            insertStmt.setInt(2, returnScheduleId); // Use returnScheduleId
            insertStmt.setDouble(3, returnFare); // Use doubled fare
            insertStmt.setString(4, returnTravelDt); // Use returnTravelDt
            insertStmt.executeUpdate();
        }

        // Close resources
        rs.close();
        stmt.close();
        insertStmt.close();
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
    <title>Ticket Confirmation</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h1 {
            font-size: 32px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #555;
        }

        .fare-info {
            font-size: 22px;
            font-weight: bold;
            color: #333;
            margin-top: 10px;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: absolute;
            top: 0;
        }

        .button-container {
            margin-top: 30px;
        }

        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Ticket Confirmation
    </header>

    <!-- Ticket Confirmation -->
    <div class="container">
        <h1>Ticket Confirmation</h1>
        <p>Origin: <%= origin %></p>
        <p>Destination: <%= destination %></p>
        <p>Fare: <%= fare %></p>
        <p><%= discountedFareMessage %></p>
        <p>Travel Date: <%= travelDate %></p>
        <p>Return Date: <%= returnDate != null ? returnDate : "N/A" %></p>
        <p>Departure Time: <%= departureTime %></p>
        <p>Arrival Time: <%= arrivalTime %></p>

        <div class="button-container">
            <form action="customerdash.jsp" method="get">
                <button type="submit" class="btn">Back to Dashboard</button>
            </form>
        </div>

        <div class="footer">
            <p>Thank you for booking with CoachPulse!</p>
        </div>
    </div>

</body>
</html>