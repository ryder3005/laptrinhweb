<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập bằng Google</title>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta charset="UTF-8">
</head>
<body>
<h2>Đăng nhập bằng Google</h2>

<%
    String clientId = "688586974329-jomgjna8seka9pj8246vk5qsghojoem1.apps.googleusercontent.com";
    String redirectUri = "http://localhost:8080/demo-web/login-google";
    String scope = "email%20profile";
    String responseType = "code";
    String accessType = "offline";

    String googleLoginUrl =
            "https://accounts.google.com/o/oauth2/auth"
                    + "?client_id=" + clientId
                    + "&redirect_uri=" + redirectUri
                    + "&response_type=" + responseType // Thường là "code"
                    + "&scope=" + scope // Ví dụ: "openid email profile"
                    + "&access_type=" + accessType; // Thường là "offline" (nếu cần Refresh Token)
%>

<a href="<%= googleLoginUrl %>">
    <img src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png" />
</a>
<form action=
              “login" method=
              "post">
    <h2>Tạo tài khoản mới</h2>
    <c:if test=
                  "${alert !=null}">
    <h3 class="alert alertdanger">${alert}</h3>
    </c:if>
    <section>
        <label class="input login-input">
            <div class="input-group">
<span class="input-group-addon"><i class="fa
fa-user"></i></span>
                <input type="text" placeholder=
                        "Tài khoản"
                       name=
                               "username"
                       class="form-control">
            </div>
        </label>
    </section>
    <form action=
                  “login" method=
                  "post">
        <h2>Tạo tài khoản mới</h2>
        <c:if test=
                      "${alert !=null}">
        <h3 class="alert alertdanger">${alert}</h3>
        </c:if>
        <section>
            <label class="input login-input">
                <div class="input-group">
<span class="input-group-addon"><i class="fa
fa-user"></i></span>
                    <input type="text" placeholder=
                            "Tài khoản"
                           name=
                                   "username"
                           class="form-control">
                </div>
            </label>
        </section>
</body>
</html>
