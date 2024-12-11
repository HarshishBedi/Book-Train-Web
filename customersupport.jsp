<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Support</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            text-align: center;
        }

        .question {
            margin: 10px 0;
        }

        button {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #d32f2f;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #b71c1c;
        }

        .answer {
            margin: 10px 0;
            padding: 10px;
            background-color: #f8f9fa;
            border-left: 4px solid #d32f2f;
            display: none;
        }

        .new-question {
            margin-top: 20px;
        }

        .new-question input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .new-question button {
            background-color: #d32f2f;
        }

        .new-question button:hover {
            background-color: #b71c1c;
        }

        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }

        .search-bar input {
            width: 80%;
            padding: 10px;
            font-size: 16px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
    </style>
    <script>
        function toggleAnswer(id) {
            var answerElement = document.getElementById("answer_" + id);
            if (answerElement.style.display === "none" || answerElement.style.display === "") {
                answerElement.style.display = "block";
            } else {
                answerElement.style.display = "none";
            }
        }

        function searchQuestions() {
            var searchQuery = document.getElementById('searchInput').value.toLowerCase();
            var questions = document.getElementsByClassName('question');
            var answers = document.getElementsByClassName('answer');
            
            for (var i = 0; i < questions.length; i++) {
                var questionText = questions[i].innerText.toLowerCase();
                var answerText = answers[i].innerText.toLowerCase();

                if (questionText.includes(searchQuery) || answerText.includes(searchQuery)) {
                    questions[i].style.display = "block";
                    answers[i].style.display = "none"; // Keep answers hidden initially
                } else {
                    questions[i].style.display = "none";
                    answers[i].style.display = "none"; // Hide answers for non-matching questions
                }
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Customer Support Questions</h1>

        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" id="searchInput" onkeyup="searchQuestions()" placeholder="Search questions or answers...">
        </div>

        <% // Handle new question submission
            if (request.getParameter("newQuestion") != null) {
                String newQuestion = request.getParameter("newQuestion");
                int customerId = (int) session.getAttribute("customer_id");

                if (session.getAttribute("submitted") == null) {
                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                        // Insert new question
                        String insertQuery = "INSERT INTO customer_support (question, customer_id) VALUES (?, ?)";
                        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                        insertStmt.setString(1, newQuestion);
                        insertStmt.setInt(2, customerId);
                        insertStmt.executeUpdate();

                        insertStmt.close();
                        conn.close();

                        session.setAttribute("submitted", true);
                        response.sendRedirect("submitted.jsp"); // Redirect to submitted.jsp
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error submitting the question.</p>");
                    }
                }
            } else {
                session.removeAttribute("submitted");
            }
        %>

        <% // Fetch and display questions and answers
            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

                // Query to fetch all records
                String query = "SELECT * FROM customer_support";
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery();

                int id = 1; // Counter for unique IDs

                while (rs.next()) {
                    String question = rs.getString("question");
                    String answer = rs.getString("answer");
        %>

        <!-- Display question as a button --> 
        <div class="question">
            <button type="button" onclick="toggleAnswer(<%= id %>)"><%= question %></button>
        </div>

        <!-- Hidden answer section --> 
        <div id="answer_<%= id %>" class="answer">
            <%= answer %>
        </div>

        <%
                    id++; // Increment counter
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error fetching data from the database.</p>");
            }
        %>

        <!-- New Question Section -->
        <div class="new-question">
            <h2>Create a New Question</h2>
            <form method="post">
                <input type="text" name="newQuestion" placeholder="Enter your question here" required>
                <button type="submit">Submit</button>
            </form>
        </div>
    </div>
</body>
</html>

