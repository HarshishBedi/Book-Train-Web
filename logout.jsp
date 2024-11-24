<%
    // Invalidate the session to log the user out
    session.invalidate();

    // Redirect the user to the login page after logging out
    response.sendRedirect("login.jsp");
%>