<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CoachPulse Navigation System (TM) - Sign Up</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="password"], input[type="date"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            background-color: #f9f9f9;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus, input[type="date"]:focus {
            border-color: #d32f2f;
            background-color: #ffffff;
        }
        button {
            width: 100%;
            padding: 14px;
            background-color: #d32f2f;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #d32f2f;
        }
        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
        }
        .disclaimer {
            font-size: 12px;
            color: #777;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM) - Sign Up
    </header>

    <!-- Sign Up Form Container -->
    <div class="container">
        <h2>Sign Up</h2>

        <form method="post" action="signup.jsp">
            <label for="first_name">First Name:</label>
            <input type="text" id="first_name" name="first_name" required>

            <label for="last_name">Last Name:</label>
            <input type="text" id="last_name" name="last_name" required>

            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" required>

            <label for="disabled">Are you a person with a disability?</label>
            <input type="checkbox" id="disabled" name="disabled">

            <div class="disclaimer">
                <p>By checking this box, you acknowledge that you may be eligible for assistance based on your disability status in accordance with local policies.</p>
            </div>

            <button type="submit">Sign Up</button>
        </form>

        <% 
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String dob = request.getParameter("dob");
            String disabled = request.getParameter("disabled");

            boolean isDisabled = (disabled != null && disabled.equals("on"));

            if (firstName != null && lastName != null && username != null && password != null && dob != null) {
                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    java.sql.Connection conn = java.sql.DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/dbdsproject", "root", "asscrack69");

                    // Check if username already exists
                    String checkQuery = "SELECT * FROM customers WHERE Username = ?";
                    java.sql.PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                    checkStmt.setString(1, username);
                    java.sql.ResultSet checkRs = checkStmt.executeQuery();

                    if (checkRs.next()) {
                        out.println("<p class='error-message'>Username already taken. Please choose a different one.</p>");
                    } else {
                        // Insert the new customer into the database
                        String insertQuery = "INSERT INTO customers (First_Name, Last_Name, Username, pass, DOB, disabled) VALUES (?, ?, ?, ?, ?, ?)";
                        java.sql.PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                        insertStmt.setString(1, firstName);
                        insertStmt.setString(2, lastName);
                        insertStmt.setString(3, username);
                        insertStmt.setString(4, password);
                        insertStmt.setString(5, dob);
                        insertStmt.setBoolean(6, isDisabled);

                        int result = insertStmt.executeUpdate();
                        if (result > 0) {
                            out.println("<p>Sign up successful! You can now <a href='login.jsp'>login</a>.</p>");
                        } else {
                            out.println("<p class='error-message'>Error during sign up. Please try again.</p>");
                        }
                        insertStmt.close();
                    }

                    checkRs.close();
                    checkStmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p class='error-message'>Error connecting to the database.</p>");
                }
            }
        %>
    </div>

</body>
</html>