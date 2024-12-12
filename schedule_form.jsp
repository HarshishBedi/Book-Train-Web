<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Search</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            color: #333;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #C00;
            color: white;
            padding: 20px;
            text-align: center;
        }
        h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }
        form {
            margin: 30px auto;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            width: 50%;
        }
        label {
            font-size: 18px;
            color: #333;
            display: block;
            margin-bottom: 8px;
        }
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            color: #333;
        }
        input[type="submit"] {
            background-color: #C00;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #900;
        }
    </style>
    <script>
        function toggleFields() {
            var originField = document.getElementById('origin');
            var destinationField = document.getElementById('destination');
            
            if (originField.value) {
                destinationField.disabled = true;
            } else if (destinationField.value) {
                originField.disabled = true;
            } else {
                originField.disabled = false;
                destinationField.disabled = false;
            }
        }
    </script>
</head>
<body>
    <header>
        <h2>Schedule Search</h2>
    </header>

    <form method="POST" action="schedule_results.jsp">
        <label for="origin">Origin:</label>
        <textarea id="origin" name="origin" rows="2" oninput="toggleFields()"></textarea><br>
        
        <label for="destination">Destination:</label>
        <textarea id="destination" name="destination" rows="2" oninput="toggleFields()"></textarea><br>
        
        <input type="submit" value="Search">
    </form>

</body>
</html>
