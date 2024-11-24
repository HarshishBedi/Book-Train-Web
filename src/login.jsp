<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Get form data
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	// Database connection parameters
	String jdbcUrl = "jdbc:mysql://localhost:3306/dbdsproject"; // Update with your database name
	String jdbcUser = "root"; // Update with your MySQL username
	String jdbcPassword = "root"; // Update with your MySQL password
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	try {
	    // Load MySQL JDBC driver
	    Class.forName("com.mysql.cj.jdbc.Driver");
	
	    // Establish a connection
	    conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
	
	    // Prepare SQL query
	    String sql = "SELECT * FROM customers WHERE username = ? AND pass = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, username);
	    stmt.setString(2, password);
	
	    // Execute query
	    rs = stmt.executeQuery();
	
	    // Check if user exists
	    if (rs.next()) {
	        out.println("Login successful! Welcome, " + username + "!");
	        session.setAttribute("username", username);
		    response.sendRedirect("dashboard.jsp");
	    } else {
	        out.println("Invalid username or password.");
	        response.sendRedirect("index.jsp?error=1");
	    }
	} catch (Exception e) {
	    e.printStackTrace();
	    out.println("Error: " + e.getMessage());
	} finally {
	    // Close resources
	    if (rs != null) rs.close();
	    if (stmt != null) stmt.close();
	    if (conn != null) conn.close();
	}
%>
