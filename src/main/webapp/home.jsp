<%@ page import="com.google.api.services.oauth2.model.Userinfo" %>
<%
    Userinfo user = (Userinfo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ</title>
</head>
<body>
<h2>Chào mừng, <%= user.getName() %>!</h2>
<img src="<%= user.getPicture() %>" alt="avatar" width="100" />
<p>Email: <%= user.getEmail() %></p>
<a href="logout">Đăng xuất</a>
</body>
</html>
