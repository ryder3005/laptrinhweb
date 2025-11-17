package vn.iotstar.utils.email;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class SendMail {

    private final String username = Dotenv.load().get("EMAIL");      // Gmail của anh
    private final String appPassword = Dotenv.load().get("APPPASSWORD");     // Mật khẩu ứng dụng 16 ký tự
    public boolean send(String toEmail, String subject, String body) {

        // Cấu hình Gmail SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Đăng nhập SMTP
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, appPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(username));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject(subject);
            message.setText(body);

            // Gửi mail
            Transport.send(message);

            System.out.println("Gửi email thành công tới: " + toEmail);
            return  true;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        SendMail sm = new SendMail();
        sm.send("caothophuthinh@gmail.com", "Xin chào","Xin chào");
    }
}
