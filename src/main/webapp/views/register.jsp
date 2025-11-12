<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/12/2025
  Time: 5:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Register</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
          href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">
<div class="container">
  <div class="card o-hidden border-0 shadow-lg my-5">
    <div class="card-body p-0">
      <div class="row">
        <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
        <div class="col-lg-7">
          <div class="p-5">
            <div class="text-center">
              <h1 class="h4 text-gray-900 mb-4">Tạo tài khoản</h1>
            </div>

<%--            <!-- Hiển thị thông báo lỗi -->--%>
<%--            <c:if test="${alert != null}">--%>
<%--              <div class="alert alert-danger alert-dismissible fade show" role="alert">--%>
<%--                <i class="fas fa-exclamation-triangle"></i> ${alert}--%>
<%--                <button type="button" class="close" data-dismiss="alert">--%>
<%--                  <span>&times;</span>--%>
<%--                </button>--%>
<%--              </div>--%>
<%--            </c:if>--%>

            <form class="user" method="post" action="${pageContext.request.contextPath}/register">
              <!-- Username -->
              <div class="form-group">
                <input type="text"
                       class="form-control form-control-user"
                       id="username"
                       name="username"
                       placeholder="Tên đăng nhập"
                       required>
              </div>

              <!-- Full Name -->
              <div class="form-group">
                <input type="text"
                       class="form-control form-control-user"
                       id="fullname"
                       name="fullname"
                       placeholder="Họ và tên"
                       required>
              </div>

              <!-- Email -->
              <div class="form-group">
                <input type="email"
                       class="form-control form-control-user"
                       id="email"
                       name="email"
                       placeholder="Địa chỉ Email"
                       required>
              </div>

              <!-- Phone -->
              <div class="form-group">
                <input type="tel"
                       class="form-control form-control-user"
                       id="phone"
                       name="phone"
                       placeholder="Số điện thoại"
                       pattern="[0-9]{10,11}"
                       required>
              </div>

              <!-- Password -->
              <div class="form-group row">
                <div class="col-sm-6 mb-3 mb-sm-0">
                  <input type="password"
                         class="form-control form-control-user"
                         id="password"
                         name="password"
                         placeholder="Mật khẩu"
                         required>
                </div>
                <div class="col-sm-6">
                  <input type="password"
                         class="form-control form-control-user"
                         id="repeatPassword"
                         placeholder="Nhập lại mật khẩu"
                         required>
                </div>
              </div>

              <!-- Submit Button -->
              <button type="submit" class="btn btn-primary btn-user btn-block">
                Đăng ký tài khoản
              </button>

              <hr>

              <!-- Social Login -->
              <a href="#" class="btn btn-google btn-user btn-block">
                <i class="fab fa-google fa-fw"></i> Đăng ký với Google
              </a>
              <a href="#" class="btn btn-facebook btn-user btn-block">
                <i class="fab fa-facebook-f fa-fw"></i> Đăng ký với Facebook
              </a>
            </form>

            <hr>

            <div class="text-center">
              <a class="small" href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
            </div>
            <div class="text-center">
              <a class="small" href="${pageContext.request.contextPath}/login">Đã có tài khoản? Đăng nhập!</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.bundle.min.js"></script>

<script>
  // Validate password match
  document.querySelector('form').addEventListener('submit', function(e) {
    const password = document.getElementById('password').value;
    const repeatPassword = document.getElementById('repeatPassword').value;

    if (password !== repeatPassword) {
      e.preventDefault();
      alert('Mật khẩu nhập lại không khớp!');
      return false;
    }

    if (password.length < 6) {
      e.preventDefault();
      alert('Mật khẩu phải có ít nhất 6 ký tự!');
      return false;
    }
  });

  // Phone validation
  document.getElementById('phone').addEventListener('input', function(e) {
    this.value = this.value.replace(/[^0-9]/g, '');
  });
</script>
</body>
</html>