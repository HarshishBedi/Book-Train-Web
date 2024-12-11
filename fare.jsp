<%@ page import="java.sql.*" %>
<%
    // Get selected origin and destination from the form
    String selectedOrigin = request.getParameter("origin");
    String selectedDestination = request.getParameter("destination");
    String fare = "";
    String reason = "";  // To store the discount reason
    double originalFare = 0.0;
    boolean isReturnJourney = request.getParameter("returnJourney") != null;  // Check if return journey is checked
    String customerId = session.getAttribute("customerId").toString();  // Assuming customer ID is stored in session

    if (selectedOrigin != null && !selectedOrigin.isEmpty() && selectedDestination != null && !selectedDestination.isEmpty()) {
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbdsproject", "root", "asscrack69");

            // Query to get fare based on origin and destination
            String query = "SELECT fare FROM schedule WHERE origin = ? AND destination = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, selectedOrigin);  // Set the selected origin
            stmt.setString(2, selectedDestination);  // Set the selected destination
            ResultSet rs = stmt.executeQuery();

            // Check if fare exists for the given origin and destination
            if (rs.next()) {
                originalFare = rs.getDouble("fare");
                fare = String.valueOf(originalFare);
            } else {
                fare = "No fare found for the selected route.";
            }

            // Get customer information to calculate age and apply discount
            String customerQuery = "SELECT DOB, disabled FROM customer WHERE customer_id = ?";
            PreparedStatement customerStmt = conn.prepareStatement(customerQuery);
            customerStmt.setString(1, customerId);
            ResultSet customerRs = customerStmt.executeQuery();
            
            if (customerRs.next()) {
                Date dob = customerRs.getDate("DOB");
                boolean disabled = customerRs.getBoolean("disabled");

                // Calculate age based on DOB
                int age = calculateAge(dob);

                // Apply discounts based on age and disability
                if (age < 5) {
                    fare = String.format("%.2f", originalFare * 0.5); // 50% discount for age below 5
                    reason = "CHILD";
                } else if (age > 50) {
                    fare = String.format("%.2f", originalFare * 0.5); // 50% discount for age over 50
                    reason = "SENIOR";
                } else if (disabled) {
                    fare = String.format("%.2f", originalFare * 0.5); // 50% discount for disability
                    reason = "DISABILITY";
                }

                // If return journey is checked, double the fare
                if (isReturnJourney) {
                    fare = String.format("%.2f", Double.parseDouble(fare) * 2);
                }
            }

            rs.close();
            stmt.close();
            customerRs.close();
            customerStmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            fare = "Error fetching fare.";
        }
    } else {
        fare = "Please select both origin and destination.";
    }

    // Function to calculate age from DOB
    public int calculateAge(Date dob) {
        Calendar dobCalendar = Calendar.getInstance();
        dobCalendar.setTime(dob);
        int birthYear = dobCalendar.get(Calendar.YEAR);
        int birthMonth = dobCalendar.get(Calendar.MONTH);
        int birthDay = dobCalendar.get(Calendar.DAY_OF_MONTH);

        Calendar today = Calendar.getInstance();
        int age = today.get(Calendar.YEAR) - birthYear;

        // If the birthday hasn't occurred yet this year, subtract one year from the age
        if (today.get(Calendar.MONTH) < birthMonth || (today.get(Calendar.MONTH) == birthMonth && today.get(Calendar.DAY_OF_MONTH) < birthDay)) {
            age--;
        }

        return age;
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
            max-width: 600px;
            text-align: center;
        }

        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 15px;
        }

        .fare-result {
            font-size: 22px;
            font-weight: bold;
            color: #d32f2f;
            margin-top: 20px;
        }

        .discount-reason {
            font-size: 18px;
            color: #2c6e49;
            margin-top: 15px;
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
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Fare Information Container -->
    <div class="container">
        <h1>Fare Information</h1>

        <p><strong>Origin:</strong> <%= selectedOrigin %></p>
        <p><strong>Destination:</strong> <%= selectedDestination %></p>
        <p class="fare-result"><strong>Fare:</strong> <%= fare %></p>

        <%
            if (!reason.isEmpty()) {
        %>
        <p class="discount-reason"><strong>Discount Reason:</strong> <%= reason %></p>
        <%
            }
        %>
    </div>

</body>
</html>