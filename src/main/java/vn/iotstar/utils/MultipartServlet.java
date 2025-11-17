package vn.iotstar.utils;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "MultiPartServlet", urlPatterns = {"/admin/category/multiPartServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class MultipartServlet extends HttpServlet {


    private static final long serialVersionUID = 1L;
    static Dotenv dotenv = Dotenv.load();
    private static final String UPLOAD_FILE_PATH = dotenv.get("UPLOAD_FILE_PATH");


    private String getFileName(Part part) {
        // Lấy header Content-Disposition
        String contentDisp = part.getHeader("content-disposition");

        // Nếu không có header, tạo luôn UUID với đuôi mặc định .jpg
        if (contentDisp == null) {
            return UUID.randomUUID().toString() + ".jpg";
        }

        // Tách từng phần của header
        for (String content : contentDisp.split(";")) {
            content = content.trim();
            if (content.startsWith("filename")) {
                // Lấy tên file gốc
                String fileName = content.substring(content.indexOf('=') + 1)
                        .trim()
                        .replace("\"", "");

                // Nếu fileName rỗng, tạo UUID + .jpg
                if (fileName.isEmpty()) {
                    return UUID.randomUUID().toString() + ".jpg";
                }

                // Lấy phần mở rộng của file
                int dotIndex = fileName.lastIndexOf('.');
                String ext = dotIndex > 0 ? fileName.substring(dotIndex) : "";

                // Trả về UUID + extension
                return UUID.randomUUID().toString() + ext;
            }
        }

        // Nếu không tìm thấy filename trong header, tạo UUID + .jpg
        return UUID.randomUUID().toString() + ".jpg";
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uploadPath =  UPLOAD_FILE_PATH; //upload vào thư mục bất kỳ
        //String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY; //upload vào thư mục project
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdir();
        try {
            String fileName = "";
            for (Part part : req.getParts()) {
                fileName = getFileName(part);
                part.write( fileName);
            }
            req.setAttribute("message", "File " + fileName + " has uploaded successfully!");


        } catch (FileNotFoundException fne) {
            req.setAttribute("message", "There was an error: " + fne.getMessage());
        }


        getServletContext().getRequestDispatcher("/views/admin/result.jsp").forward(req, resp);
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/uploadfilemulti.jsp").forward(request, response);

    }
}