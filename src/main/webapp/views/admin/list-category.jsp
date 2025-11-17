<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/14/2025
  Time: 1:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:forEach items= "${cateList}" var="cate" varStatus="STT" >
    <tr class="odd gradeX">
        <td>${STT.index+1 }</td>
        <c:url value="/image?fname=${cate.getIcon() }" var=
                "imgUrl"></c:url>
        <td><img height="150" width="200" src=
                "${imgUrl}" /></td>
        <td>${cate.getCatename() }</td>
        <td><a href=
                       "<c:url value='/admin/category/edit?id=${cate.getCateid() }'/>"
               class="center">Sửa</a>
            | <a href=
                         "<c:url value='/admin/category/delete?id=${cate.getCateid() }'/>"
                 class="center">Xóa</a></td>
    </tr>
</c:forEach>
</body>
</html>
