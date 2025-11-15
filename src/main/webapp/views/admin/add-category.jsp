<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/14/2025
  Time: 1:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form role="form" action="add" method="post"
      enctype="multipart/form-data">
    <div class="form-group">
        <label>Tên danh mục:</label> <input class="form-control"
                                            placeholder="please enter category Name" name="name"/>
    </div>
    <div class="form-group">
        <label>Ảnh đại diện</label> <input type="file" name="icon"/>
    </div>
    <button type="submit" class=
            "btn btn-default">Thêm
    </button>
    <button type="reset" class=
            "btn btn-primary">Hủy
    </button>
</form>
</body>
</html>
