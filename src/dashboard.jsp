<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
</head>
<body>
	<div class="container">
        <h2 class="mb-3">Dashboard</h2>
        <%
            String username = (String) session.getAttribute("username");
            if (username != null) {
        %>
        <p>Welcome, <%= username %>!</p>
        <p><a href="logout.jsp">logout</a></p>
        <% } else { %>
        	<p>Please log in to access the dashboard.  <a href="login.jsp">login</a></p>
        <% } %>
        
    </div>
</body>
</html>