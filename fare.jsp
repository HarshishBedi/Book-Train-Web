<%@ page import="java.sql.*" %>
<%
    // Check if the user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve origin, destination, and other parameters from the form
    String selectedOrigin = request.getParameter("origin");
    String selectedDestination = request.getParameter("destination");
    String travelDate = request.getParameter("travelDate");
    String returnDate = request.getParameter("returnDate");

    // Save dates to session
    session.setAttribute("travelDate", travelDate);
    if (returnDate != null && !returnDate.isEmpty()) {
        session.setAttribute("returnDate", returnDate);
    }

    String fare = "";
    String discountedFareMessage = "";
    double originalFare = 0.0;

    boolean isSeniorChild = "on".equals(request.getParameter("seniorChild"));
    boolean isDisabled = "on".equals(request.getParameter("disabled"));
    boolean isDiscountApplicable = isSeniorChild || isDisabled;

    if (selectedOrigin != null && !selectedOrigin.isEmpty() && selectedDestination != null && !selectedDestination.isEmpty()) {
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

            // Query to get fare based on origin and destination
            String query = "SELECT fare FROM schedule WHERE origin = ? AND destination = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, selectedOrigin);  // Set the selected origin
            stmt.setString(2, selectedDestination);  // Set the selected destination
            ResultSet rs = stmt.executeQuery();

            // Check if fare exists for the given origin and destination
            if (rs.next()) {
                originalFare = rs.getDouble("fare");
                fare = String.format("%.2f", originalFare);
                
                // Apply 20% discount if the user is a senior/child or disabled
                if (isDiscountApplicable) {
                    double discountedFare = originalFare * 0.80; // 20% off
                    fare = String.format("%.2f", discountedFare);
                    discountedFareMessage = "Discounted Fare (20% off): ";
                }
            } else {
                fare = "No fare found for the selected route.";
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            fare = "Error fetching fare.";
        }
    } else {
        fare = "Please select both origin and destination.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fare Information</title>
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
            margin-bottom: 30px;
        }

        .fare-info {
            font-size: 22px;
            font-weight: bold;
            color: #333;
            margin-top: 10px;
        }

        .error-message {
            color: #d32f2f;
            font-size: 18px;
            font-weight: bold;
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

        /* Styling for Pay and Confirm button */
        .pay-button {
            background-color: #28a745;
            color: white;
            padding: 12px 24px;
            font-size: 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
        }

        .pay-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Fare Information 
    </header>

    <!-- Fare Information Container -->
    <div class="container">
    <h1>Fare Information (One-Way)</h1>
        <p>Origin: <%= selectedOrigin %></p>
        <p>Destination: <%= selectedDestination %></p>

        <div class="fare-info">
            <p><%= discountedFareMessage %>Fare: <%= fare %></p>
        </div>

        <% if ("No fare found for the selected route.".equals(fare) || "Error fetching fare.".equals(fare)) { %>
            <p class="error-message"><%= fare %></p>
        <% } %>

        <!-- Pay and Confirm Button (Redirect to printTickets.jsp) -->
        <form action="printTickets.jsp" method="get">
            <!-- Pass the fare and origin/destination information -->
            <input type="hidden" name="origin" value="<%= selectedOrigin %>">
            <input type="hidden" name="destination" value="<%= selectedDestination %>">
            <input type="hidden" name="fare" value="<%= fare %>">
            <input type="hidden" name="discountedFareMessage" value="<%= discountedFareMessage %>">
            <input type="hidden" name="travelDate" value="<%= travelDate %>">
            <input type="hidden" name="returnDate" value="<%= returnDate != null ? returnDate : "" %>">
            <button type="submit" class="pay-button">Pay and Confirm</button>
        </form>
    </div>

</body>
</html>