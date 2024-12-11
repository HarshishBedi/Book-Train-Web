<%@ page import="java.sql.*, java.util.*" %>
<%
    String departure = request.getParameter("departure");
    String destination = request.getParameter("destination");
    String username = (String) session.getAttribute("username");

    // Initialize variables
    double fare = 0;
    double discountedFare = 0;
    String discountReason = "";
    
    // Fetch the customer's DOB and disability status from the customer table
    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

        // Query to get fare for the selected route
        String query = "SELECT fare FROM schedule WHERE origin = ? AND destination = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, departure);
        stmt.setString(2, destination);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            fare = rs.getDouble("fare");
        }

        // Query to get the customer's DOB and disability status
        String customerQuery = "SELECT dob, disabled FROM customer WHERE username = ?";
        PreparedStatement customerStmt = conn.prepareStatement(customerQuery);
        customerStmt.setString(1, username);
        ResultSet customerRs = customerStmt.executeQuery();

        String dob = "";
        boolean isDisabled = false;
        
        if (customerRs.next()) {
            dob = customerRs.getString("dob");
            isDisabled = "Yes".equalsIgnoreCase(customerRs.getString("disabled"));
        }
        
        // Calculate age from DOB
        int age = 0;
        if (dob != null && !dob.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date birthDate = sdf.parse(dob);
            Calendar birthCalendar = Calendar.getInstance();
            birthCalendar.setTime(birthDate);
            
            Calendar today = Calendar.getInstance();
            age = today.get(Calendar.YEAR) - birthCalendar.get(Calendar.YEAR);
            
            // Adjust age if birthday hasn't occurred this year yet
            if (today.get(Calendar.MONTH) < birthCalendar.get(Calendar.MONTH) ||
                (today.get(Calendar.MONTH) == birthCalendar.get(Calendar.MONTH) &&
                 today.get(Calendar.DAY_OF_MONTH) < birthCalendar.get(Calendar.DAY_OF_MONTH))) {
                age--;
            }
        }

        // Apply discount logic
        if (age < 5) {
            discountedFare = fare / 2;
            discountReason = "50% discount for Child (under 5 years old)";
        } else if (age > 50) {
            discountedFare = fare / 2;
            discountReason = "50% discount for Senior (over 50 years old)";
        } else if (isDisabled) {
            discountedFare = fare / 2;
            discountReason = "50% discount for Disabled passenger";
        } else {
            discountedFare = fare;
            discountReason = "No discount";
        }

        // Set the fare and discount details as request attributes
        request.setAttribute("fare", fare);
        request.setAttribute("discountedFare", discountedFare);
        request.setAttribute("discountReason", discountReason);

        rs.close();
        customerRs.close();
        stmt.close();
        customerStmt.close();
        conn.close();

        // Forward to the form with updated fare details
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookTrain.jsp");
        dispatcher.forward(request, response);
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error fetching data from the database or calculating fare.</p>");
    }
%>