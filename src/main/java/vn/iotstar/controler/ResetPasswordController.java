package vn.iotstar.controler;

import java.io.IOException;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.model.Token;
import vn.iotstar.service.TokenService;
import vn.iotstar.service.UserService;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

    private UserService userService = new vn.iotstar.service.implement.UserServiceImpl();

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws jakarta.servlet.ServletException, java.io.IOException {
        String token = req.getParameter("token");
        String email = req.getParameter("email");
        TokenService tokenService = new vn.iotstar.service.implement.TokenServiceImpl();
        Token resetToken = tokenService.getResetTokenByEmail(email);

        if (token == null || token.isEmpty()) {
            req.setAttribute("error", "Token khong hop le.");

            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);

        }
        if (resetToken == null) {
            req.setAttribute("error", "Token không tồn tại hoặc không hợp lệ.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
            return;
        }

// Không khớp token
        if (!resetToken.getToken().equals(token)) {
            req.setAttribute("error", "Token không hợp lệ.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
            return;
        }

// Token hết hạn
        if (resetToken.getExpiryTime().isBefore(LocalDateTime.now())) {
            req.setAttribute("error", "Token đã hết hạn.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
            return;
        }

// Token đã dùng
        if (resetToken.isUsed()) {
            req.setAttribute("error", "Token đã được sử dụng.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
            return;
        }

// Nếu qua hết kiểm tra → cho đặt lại mật khẩu
        req.setAttribute("email", email);
        req.setAttribute("token", token);
        req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        String email = req.getParameter("email");
        String newPassword = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        
        // Validate input
        if (newPassword == null || newPassword.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            req.setAttribute("token", token);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.setAttribute("token", token);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }
        
        // Reset password
        boolean success = userService.changePassword(email, newPassword);
        
        if (success) {
            req.setAttribute("message", "Password has been reset successfully!");
            req.setAttribute("alertType", "success");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Failed to reset password. Link may have expired.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }
    
}
