<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/14/2025
  Time: 5:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container">
    <%
        String message = (String) request.getAttribute("message");
        boolean isSuccess = message != null && message.contains("successfully");
    %>

    <div class="icon <%= isSuccess ? "success-icon" : "error-icon" %>">
        <%= isSuccess ? "✓" : "✗" %>
    </div>

    <h1><%= isSuccess ? "Upload Successful" : "Upload Failed" %></h1>

    <div class="message <%= isSuccess ? "success-message" : "error-message" %>">
        <%= message != null ? message : "No message available" %>
    </div>

    <div class="button-group">
        <a href="<%= request.getContextPath() %>/admin/category/multiPartServlet" class="btn btn-primary">
            Upload Another File
        </a>
        <a href="<%= request.getContextPath() %>/admin/category" class="btn btn-secondary">
            Back to Categories
        </a>
    </div>
</div>
</body>
</html>
