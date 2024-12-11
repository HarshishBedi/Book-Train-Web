<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Origin and Destination</title>
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
            margin-bottom: 30px;
        }

        label {
            font-size: 18px;
            color: #555;
            display: block;
            margin-bottom: 10px;
        }

        select, input[type="date"], input[type="checkbox"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 6px;
            width: 100%;
            margin-bottom: 20px;
        }

        input[type="checkbox"] {
            width: auto;
            margin-top: 10px;
        }

        input[type="submit"] {
            padding: 12px 24px;
            background-color: #d32f2f;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #b71c1c;
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
    <script>
        function updateDestination() {
            var origin = document.getElementById("origin").value;
            
            if (origin === "") {
                document.getElementById("destination").innerHTML = "<option value=''>Select a destination</option>";
                return;
            }

            var xhr = new XMLHttpRequest();
            xhr.open("GET", "fetchDestinations.jsp?origin=" + origin, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("destination").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        function updateFare() {
            var returnJourney = document.getElementById("returnJourney").checked;
            var returnDateField = document.getElementById("returnDateField");
            var fareInput = document.getElementById("fare");
            var returnDateInput = document.getElementById("returnDate");

            // Show or hide return date field based on return journey checkbox
            if (returnJourney) {
                returnDateField.style.display = "block";
                returnDateInput.required = true; // Make the return date field required
                var fareValue = parseFloat(fareInput.value);
                if (!isNaN(fareValue)) {
                    fareInput.value = (fareValue * 2).toFixed(2);
                }
            } else {
                returnDateField.style.display = "none";
                returnDateInput.required = false; // Remove the required attribute when hidden
                // Reset fare to original value if return journey is unchecked
                var originalFare = parseFloat(fareInput.dataset.originalFare);
                if (!isNaN(originalFare)) {
                    fareInput.value = originalFare.toFixed(2);
                }
            }
        }

        // Ensure return date visibility and required status when page loads
        window.onload = function() {
            updateFare();
        };

        // Disable form submission if required fields are not filled
        document.querySelector("form").addEventListener("submit", function(event) {
            var travelDate = document.getElementById("travelDate").value;
            var returnJourney = document.getElementById("returnJourney").checked;
            var returnDate = document.getElementById("returnDate").value;

            // Disable form submission if the travel date is not selected or required return date is missing
            if (!travelDate || (returnJourney && !returnDate)) {
                event.preventDefault();
                alert("Please fill out all required fields.");
            }
        });
    </script>
</head>
<body>

    <!-- Header -->
    <header>
        CoachPulse Navigation System (TM)
    </header>

    <!-- Dropdown Container -->
    <div class="container">
        <h1>Select Origin and Destination</h1>

        <form action="fare.jsp" method="post">
            <label for="origin">Origin:</label>
            <select name="origin" id="origin" onchange="updateDestination()">
                <option value="">Select an origin</option>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/dbdsproject", "root", "asscrack69");
                        String query = "SELECT DISTINCT origin FROM schedule";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                            String origin = rs.getString("origin");
                %>
                    <option value="<%= origin %>"><%= origin %></option>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error connecting to the database or fetching data.</p>");
                    }
                %>
            </select>

            <label for="destination">Destination:</label>
            <select name="destination" id="destination">
                <option value="">Select a destination</option>
            </select>

            <label for="travelDate">Travel Date:</label>
            <input type="date" name="travelDate" id="travelDate" required>

            <label>
                <input type="checkbox" id="returnJourney" onclick="updateFare()">
                Return Journey
            </label>

            <!-- Return Date (shown when Return Journey is checked) -->
            <div id="returnDateField" style="display: none;">
                <label for="returnDate">Return Date:</label>
                <input type="date" name="returnDate" id="returnDate">
            </div>

            <!-- Additional Checkboxes for Senior/Child and Disabled -->
            <label>
                <input type="checkbox" name="seniorChild" id="seniorChild">
                Senior/Child
            </label>

            <label>
                <input type="checkbox" name="disabled" id="disabled">
                Disabled
            </label>

            <input type="submit" value="Submit">
        </form>
    </div>

</body>
</html>