    package vn.iotstar.controler;

    import java.io.File;
    import java.io.FileNotFoundException;
    import java.io.IOException;
    import java.io.PrintWriter;
    import java.util.UUID;

    import io.github.cdimascio.dotenv.Dotenv;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.model.User;

    @WebServlet(urlPatterns = {"/home"})
    public class HomeController extends HttpServlet {
     private static final long serialVersionUID = 1L;
        static Dotenv dotenv = Dotenv.load();
        private static final String UPLOAD_FILE_PATH = dotenv.get("UPLOAD_FILE_PATH");

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    //        super.doGet(req, resp);
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html; charset=UTF-8");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();
            HttpSession session = req.getSession(true);
            User user=(User)session.getAttribute("account");
            if (user == null) {
                out.println("<h1>You are not logged in</h1>");
                out.println("<a href='" + req.getContextPath() + "/login'>Login</a>");
            } else {
                out.println("<h1>Hello from Java! " + user.getUserName() + "</h1>");
                out.println("<a href='" + req.getContextPath() + "/logout'>Logout</a>");
            }
//            out.close();
        }
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String uploadPath = File.separator + UPLOAD_FILE_PATH; //upload vào thư mục bất kỳ
            //String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY; //upload vào thư mục project
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdir();
            try {
                String fileName = "";
                for (Part part : req.getParts()) {
                    fileName = getFileName(part);
                    part.write(uploadPath + File.separator + fileName);
                }
                req.setAttribute("message", "File " + fileName + " has uploaded successfully!");


            } catch (FileNotFoundException fne) {
                req.setAttribute("message", "There was an error: " + fne.getMessage());
            }


            getServletContext().getRequestDispatcher("/views/result.jsp").forward(req, resp);
        }
        private String getFileName(Part part) {
            // Lấy header Content-Disposition
            String contentDisp = part.getHeader("content-disposition");
            if (contentDisp == null) {
                // Nếu không có header, trả về tên file mặc định từ biến môi trường
                Dotenv dotenv = Dotenv.load();
                String uploadPath = dotenv.get("UPLOAD_FILE_PATH");
                return uploadPath;
            }

            // Tách từng phần của header
            for (String content : contentDisp.split(";")) {
                content = content.trim();
                if (content.startsWith("filename")) {
                    // Lấy tên file gốc
                    String fileName = content.substring(content.indexOf('=') + 1).trim().replace("\"", "");

                    // Nếu fileName rỗng, trả về default
                    if (fileName.isEmpty()) {
//
                        Dotenv dotenv = Dotenv.load();
                        String uploadPath = dotenv.get("UPLOAD_FILE_PATH");
                        return uploadPath;
                    }

                    // Lấy phần mở rộng của file
                    int dotIndex = fileName.lastIndexOf('.');
                    String ext = dotIndex > 0 ? fileName.substring(dotIndex) : "";

                    // Tạo tên file duy nhất bằng UUID + extension
                    return UUID.randomUUID().toString() + ext;
                }
            }

            // Nếu không tìm thấy filename trong header, trả về default
            Dotenv dotenv = Dotenv.load();
            String uploadPath = dotenv.get("UPLOAD_FILE_PATH");
            return uploadPath;
        }
    }
