<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Trains</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container">
        <h2 class="mb-3">View Trains</h2>
        <%
            try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
                            //I have no idea how any of this works. ApplicationDB needs to be imported.
        %>
        <div>
            <p>View all trains</p>
            <table>
                <tr>    
                    <td>Name</td>
                    <td>
                        <% if (entity.equals("trains"))
                            out.print("trainLine");
                        %>
                    </td>
                </tr>
                    <%
                    //parse out the results
                    while (result.next()) { %>
                        <tr>    
                            <td><%= result.getString("name") %></td>
                            <td>
                                <% if (entity.equals("trains")){ %>
                                    <%= result.getString("trainLine")%>
                                <% } %>
                            </td>
                        </tr>
                    <% }
                    //close the connection.
                    db.closeConnection(con);
                %>
            </table>
        </div>
        <p><a href="logout.jsp">logout</a></p>
        <%} catch (Exception e) {
			out.print(e);
		}%>
        
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>