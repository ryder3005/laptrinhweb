<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/14/2025
  Time: 6:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Forgot Password</h2>
<%
    String message = (String) request.getAttribute("message");
    if (message != null) {
        out.println("<p>" + message + "</p>");
    }
%>
<form action="forgot-password" method="post">
    <label for="email">Enter your email address:</label><br>
    <input type="email" id="email" name="email" required><br><br>
    <input type="submit" value="Submit">
</body>
</html>
