<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Support - Solve Ticket</title>
    <style>
        body {
            font-family: Arial, sans-serif;
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
        }
        h2 {
            text-align: center;
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }
        .ticket {
            margin-bottom: 20px;
            padding: 12px;
            background-color: #f1f1f1;
            border-radius: 6px;
            cursor: pointer;
        }
        .ticket:hover {
            background-color: #d32f2f;
            color: white;
        }
        .answer-box {
            display: none;
            margin-top: 10px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            background-color: #f9f9f9;
        }
        button {
            padding: 12px 20px;
            background-color: #d32f2f;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #b71c1c;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Customer Support - Answer Tickets</h2>

    <% 
        String submitAnswer = request.getParameter("submitAnswer");
        String answer = request.getParameter("answer");
        String ticketNo = request.getParameter("ticketNo");
        Integer employeeId = (Integer) session.getAttribute("employee_id");

        if ("submit".equals(submitAnswer)) {
            // Database connection and update operation
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                // Update the answer for the selected ticket
                String updateQuery = "UPDATE customer_support SET answer = ?, customer_rep_id = ? WHERE ticket_no = ?";
                PreparedStatement stmt = conn.prepareStatement(updateQuery);
                stmt.setString(1, answer);  // Set the answer provided by the user
                stmt.setInt(2, employeeId);  // Set the employee_id (customer_rep_id)
                stmt.setInt(3, Integer.parseInt(ticketNo));  // Set the ticket_no to identify the record
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p>Answer submitted successfully!</p>");
                } else {
                    out.println("<p>Failed to submit the answer. Please try again.</p>");
                }

                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error connecting to the database.</p>");
            }
        }

        // Fetch tickets with null answers from the customer_support table
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

            String query = "SELECT * FROM customer_support WHERE answer = 'Please give the customer support team 3 to 5 days to answer the question'";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int ticketNoVal = rs.getInt("ticket_no");
                String question = rs.getString("question");
    %>
                <div class="ticket" onclick="showAnswerBox('<%= ticketNoVal %>')">
                    <strong>Ticket <%= ticketNoVal %>:</strong> <%= question %>
                </div>

                <!-- Hidden answer box for each ticket -->
                <div class="answer-box" id="answer-box-<%= ticketNoVal %>">
                    <form method="post" action="solve_CS.jsp">
                        <input type="hidden" name="ticketNo" value="<%= ticketNoVal %>">
                        <label for="answer">Answer:</label>
                        <textarea name="answer" required></textarea>
                        <button type="submit" name="submitAnswer" value="submit">Submit Answer</button>
                    </form>
                </div>
    <%  
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error fetching tickets from the database.</p>");
        }
    %>
</div>

<script>
    function showAnswerBox(ticketNo) {
        // Toggle visibility of the answer box for the specific ticket
        var answerBox = document.getElementById("answer-box-" + ticketNo);
        answerBox.style.display = (answerBox.style.display === "block") ? "none" : "block";
    }
</script>

</body>
</html>
