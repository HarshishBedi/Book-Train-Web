<%@ page import="java.sql.*, java.util.ArrayList" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int customerId = (int) session.getAttribute("customer_id"); // Assuming customer_id is stored in the session

    // Lists to store booking details for past and upcoming journeys
    ArrayList<String[]> upcomingBookings = new ArrayList<>();
    ArrayList<String[]> pastBookings = new ArrayList<>();

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "asscrack69");

        // Query to fetch all bookings
        String query = "SELECT b.booking_id, s.origin, s.destination, b.travel_dt, b.total_fare " +
                       "FROM booking b " +
                       "JOIN schedule s ON b.schedule_id = s.schedule_id " +
                       "WHERE b.customer_id = ? " +
                       "ORDER BY b.travel_dt ASC";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, customerId);

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            String[] booking = new String[5];
            booking[0] = rs.getString("booking_id");    // Booking ID
            booking[1] = rs.getString("origin");       // Origin
            booking[2] = rs.getString("destination");  // Destination
            booking[3] = rs.getString("travel_dt");    // Travel Date and Time
            booking[4] = rs.getString("total_fare");   // Fare

            // Split bookings into past and upcoming
            String travelDate = rs.getString("travel_dt");
            if (travelDate != null && travelDate.compareTo(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())) > 0) {
                upcomingBookings.add(booking);  // Upcoming journey
            } else {
                pastBookings.add(booking);      // Past journey
            }
        }

        rs.close();
        stmt.close();
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
    <title>Upcoming Journeys</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #d32f2f;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
        }

        .container {
            padding: 20px;
            margin: 50px auto;
            max-width: 800px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        table th {
            background-color: #d32f2f;
            color: white;
        }

        button {
            padding: 8px 16px;
            background-color: #d32f2f;
            color: white;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #b71c1c;
        }

        /* Styles for greyed-out (past) cancel button */
        .greyed-out {
            background-color: #b0bec5;  /* Light grey */
            color: #fff;
            cursor: not-allowed;
        }

        .no-data {
            text-align: center;
            color: #555;
            font-size: 16px;
            margin-top: 20px;
        }
    </style>
    <script>
        // Confirmation dialog for booking cancellation
        function confirmCancellation(event) {
            if (!confirm("Are you sure you want to cancel this booking?")) {
                event.preventDefault(); // Prevent form submission if the user cancels
            }
        }
    </script>
</head>
<body>

<header>
    CoachPulse - Upcoming and Past Journeys
</header>

<div class="container">
    <h2>Your Upcoming Journeys</h2>
    <% if (upcomingBookings.isEmpty()) { %>
        <p class="no-data">You have no upcoming journeys.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Origin</th>
                    <th>Destination</th>
                    <th>Travel Date</th>
                    <th>Fare</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] booking : upcomingBookings) { %>
                    <tr>
                        <td><%= booking[0] %></td>
                        <td><%= booking[1] %></td>
                        <td><%= booking[2] %></td>
                        <td><%= booking[3] %></td>
                        <td>$<%= booking[4] %></td>
                        <td>
                            <form method="post" action="cancel_booking.jsp" style="display:inline;" onsubmit="confirmCancellation(event)">
                                <input type="hidden" name="booking_id" value="<%= booking[0] %>">
                                <button type="submit">Cancel</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <h2>Your Past Journeys</h2>
    <% if (pastBookings.isEmpty()) { %>
        <p class="no-data">You have no past journeys.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Origin</th>
                    <th>Destination</th>
                    <th>Travel Date</th>
                    <th>Fare</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] booking : pastBookings) { %>
                    <tr>
                        <td><%= booking[0] %></td>
                        <td><%= booking[1] %></td>
                        <td><%= booking[2] %></td>
                        <td><%= booking[3] %></td>
                        <td>$<%= booking[4] %></td>
                        <td>
                            <!-- Greyed-out cancel button for past journeys -->
                            <button type="button" class="greyed-out" disabled>Cancel</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>

</body>
</html>