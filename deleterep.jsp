<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%
    // Retrieve session data and form parameters
    String employeeId = request.getParameter("id");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbdsproject", "root", "root");

        String insertQuery = "DELETE FROM employee WHERE employee_Id = ?";
        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
        insertStmt.setString(1, employeeId);
        insertStmt.executeUpdate();

        // Close resources
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
    <title>Representative Delete</title>
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
        CoachPulse Representative Delete
    </header>

    <div class="container">
        <h1>Representative Deleted</h1>
        <p>Please make sure the representative is not assigned to any customers. If they are, they were <strong>not deleted</strong>.</p>
    </div>

</body>
</html>