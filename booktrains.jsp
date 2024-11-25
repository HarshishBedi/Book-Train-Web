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
    <title>Book Train</title>
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

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }

        input[type="text"], input[type="date"], select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 16px;
            color: #333;
        }

        button {
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #0056b3;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }

        header {
            background-color: #007bff;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: absolute;
            top: 0;
        }

        .return-journey {
            display: none;
            margin-top: 20px;
        }

        /* Align checkbox to the left */
        .checkbox-container {
            text-align: left;
            width: 100%;
            margin-bottom: 20px;
        }

        .checkbox-container input[type="checkbox"] {
            margin-right: 10px;
            vertical-align: middle;
        }
    </style>
    <script>
        function toggleReturnJourney() {
            var returnJourneySection = document.getElementById('returnJourneySection');
            if (document.getElementById('returnJourney').checked) {
                returnJourneySection.style.display = 'block';
            } else {
                returnJourneySection.style.display = 'none';
            }
        }

        function validateForm() {
            var travelDate = document.getElementById("travelDate").value;
            var returnDate = document.getElementById("returnDate").value;
            
            // If return date is selected, validate it
            if (returnDate) {
                // Convert to Date objects for comparison
                var travelDateObj = new Date(travelDate);
                var returnDateObj = new Date(returnDate);
                
                // If return date is earlier than travel date
                if (returnDateObj < travelDateObj) {
                    alert("Return Date cannot be earlier than Travel Date.");
                    return false; // Prevent form submission
                }
            }
            
            return true; // Form is valid
        }
    </script>
</head>
<body>

    <!-- Header -->
    <header>
        Train Navigation System
    </header>

    <!-- Book Train Form Container -->
    <div class="container">
        <h2>Book Your Train</h2>
        <p>Fill in the details below to book your train.</p>

        <!-- Train Booking Form -->
        <form method="post" action="printtickets.jsp" onsubmit="return validateForm()">
            <label for="departure">Departure Station:</label>
            <input type="text" id="departure" name="departure" placeholder="Enter departure station" required>
        
            <label for="destination">Destination Station:</label>
            <input type="text" id="destination" name="destination" placeholder="Enter destination station" required>
        
            <label for="travelDate">Travel Date:</label>
            <input type="date" id="travelDate" name="travelDate" required>
        
            <!-- Return Journey Checkbox -->
            <div class="checkbox-container">
                <label for="returnJourney">
                    <input type="checkbox" id="returnJourney" name="returnJourney" onclick="toggleReturnJourney()"> Return Journey
                </label>
            </div>
        
            <!-- Return Journey Date, initially hidden -->
            <div id="returnJourneySection" class="return-journey">
                <label for="returnDate">Return Date:</label>
                <input type="date" id="returnDate" name="returnDate">
            </div>
        
            <button type="submit">Book Train</button>
        </form>

        <p><a href="customerdash.jsp">Back to Dashboard</a></p>
    </div>

</body>
</html>