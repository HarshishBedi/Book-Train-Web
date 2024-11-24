<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login/Logout</title>
</head>
<body>
	<div class="container">
        <%
            String username = (String) session.getAttribute("username");
            if (username == null) {
        %>
        <!-- Login Form -->
        <form class="form-login" method="post" action="login.jsp">
            <h2 class="mb-3">Login</h2>
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    Invalid username or password!
                </div>
            <% } %>
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <button class="btn btn-primary" type="submit">Sign in</button>
        </form>
        <% } else { %>
        <!-- Logout Form -->
        <form class="form-login" method="post" action="logout.jsp">
            <h2 class="mb-3">Welcome, <%= username %>!</h2>
            <button class="btn btn-primary" type="submit">Logout</button>
        </form>
        <% } %>
    </div>
</body>
</html>