<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/14/2025
  Time: 5:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload File</title>
</head>
<body>
<form method="post" action="${pageContext.request.contextPath}/admin/category/multiPartServlet"
      enctype="multipart/form-data">

    Select file to upload:
    <br />
    <input type="file" name="file" />
    <br /><br />

    Name:
    <br />
    <input type="text" name="name" size="100" />
    <br /><br />

    <input type="submit" value="Upload" />
</form>
</body>
</html>

</body>
</html>
