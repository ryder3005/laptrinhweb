package vn.iotstar.controler;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.model.Token;
import vn.iotstar.service.UserService;
import vn.iotstar.service.implement.TokenServiceImpl;
import vn.iotstar.service.implement.UserServiceImpl;
import vn.iotstar.service.TokenService;
import vn.iotstar.utils.email.SendMail;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService = new UserServiceImpl();
    private TokenService tokenService = new TokenServiceImpl();

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws jakarta.servlet.ServletException, java.io.IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (userService.checkExistEmail(email)) {

            String resetToken = java.util.UUID.randomUUID().toString();
            TokenService tokenService = new vn.iotstar.service.implement.TokenServiceImpl();
            tokenService.deleteResetTokenByEmail(email);
            tokenService.saveResetToken(email, resetToken, java.time.LocalDateTime.now().plusHours(1));
            String resetLink = req.getScheme() + "://"
                    + req.getServerName() + ":"
                    + req.getServerPort()
                    + req.getContextPath()
                    + "/reset-password?token=" + resetToken
                    + "&email=" + email;
            SendMail sendMail = new SendMail();
            boolean emailSent = sendMail.send(email, "Thay đổi mật khẩu", "Click vào link để thay mật khẩu: " + resetLink);
            
            System.out.println(resetLink);
            if (emailSent) {
                req.setAttribute("message", "Password reset link has been sent to your email!");
                req.setAttribute("alertType", "success");
            } else {
                req.setAttribute("message", "Failed to send email. Please try again.");
                req.setAttribute("alertType", "error");
            }
        } else {
            req.setAttribute("message", "Email not found in our system.");
            req.setAttribute("alertType", "error");
        }
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }
}
