package vn.iotstar.controler;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.model.User;
import vn.iotstar.service.implement.UserServiceImpl;

@WebServlet("/login")
public class LoginController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        if (session != null &&session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath()+ "/waiting");
            return;
        }
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("account")) {
                    session=req.getSession(true);
                    session.setAttribute("account", cookie.getValue());
                    resp.sendRedirect(req.getContextPath()+ "/waiting");
                    return;
                }
            }
        }
        req.getRequestDispatcher("views/login.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email=req.getParameter("email");

        String password=req.getParameter("password");
        boolean isRememberMe = false;

        boolean remember=Boolean.parseBoolean(req.getParameter("remember"));
        if (req.getParameter("remember") != null) { isRememberMe = true; }
        String alertMsg="";
        if (email.isEmpty() || password.isEmpty()){
            alertMsg="Tài khoản hoặc mật khẩu không được rỗng";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher("views/login.jsp").forward(req, resp);
            return;
        }
        UserServiceImpl userService=new UserServiceImpl();
        User user =userService.login(email,password);
        if  (user==null){
            alertMsg = "Tài khoản hoặc mật khẩu không đúng";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);        }
        else{
            HttpSession session = req.getSession(true);
            session.setAttribute("account", user);
            if (isRememberMe){
                saveRemeberMe(resp, email);
            }

            // Chuyển hướng về trang home hoặc dashboard
            resp.sendRedirect(req.getContextPath() + "/waiting");

        }


    }

    private void saveRemeberMe(HttpServletResponse response, String
            username){
        Cookie cookie = new Cookie(COOKIE_REMEMBER,
                username);
        cookie.setMaxAge(7 * 24 * 60 * 60);
        response.addCookie(cookie);
    }
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";
}