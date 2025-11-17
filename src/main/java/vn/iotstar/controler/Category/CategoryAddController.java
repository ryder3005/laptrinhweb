package vn.iotstar.controler.Category;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.implement.CategoryServiceImpl;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet(urlPatterns = {"/admin/category/add"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,  // 1 MB
        maxFileSize = 1024 * 1024 * 10,       // 10 MB
        maxRequestSize = 1024 * 1024 * 15     // 15 MB
)
public class CategoryAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CategoryService cateService = new CategoryServiceImpl();
    Dotenv dotenv = Dotenv.load();
    String uploadPath = dotenv.get("UPLOAD_FILE_PATH");
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        RequestDispatcher dispatcher =  req.getRequestDispatcher("/views/admin/add-category.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        // Validate biến môi trường
        String uploadBasePath = uploadPath;
        if (uploadBasePath == null || uploadBasePath.isEmpty()) {
            throw new ServletException("UPLOAD_FILE_PATH environment variable is not configured");
        }

        String uploadDirPath = uploadBasePath + File.separator + "category";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            Category category = new Category();

            // Lấy tên category
            String categoryName = req.getParameter("name");
            if (categoryName == null || categoryName.trim().isEmpty()) {
                req.setAttribute("error", "Category name is required");
                req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
                return;
            }
            category.setCatename(categoryName.trim());

            // Xử lý upload file
            Part filePart = req.getPart("icon");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);

                // Ghi file vào thư mục
                String filePath = uploadDirPath + File.separator + fileName;
                filePart.write(filePath);

                // Lưu đường dẫn tương đối vào database
                category.setIcon("category/" + fileName);
            } else {
                // Không upload file → icon = null
                category.setIcon(null);
            }

            // Insert vào database
            cateService.insert(category);

            // Redirect về trang danh sách
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error uploading file: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
        }
    }

    /**
     * Lấy tên file từ Part và tạo tên file mới với UUID
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");

        // Nếu header trống, trả về UUID.jpg
        if (contentDisp == null) {
            return UUID.randomUUID() + ".jpg";
        }

        // Parse filename từ content-disposition
        for (String content : contentDisp.split(";")) {
            content = content.trim();
            if (content.startsWith("filename")) {
                String fileName = content.substring(content.indexOf('=') + 1)
                        .trim()
                        .replace("\"", "");

                // Nếu filename rỗng, tạo UUID + .jpg
                if (fileName.isEmpty()) {
                    return UUID.randomUUID() + ".jpg";
                }

                // Lấy extension từ filename gốc
                String ext = "";
                int dotIndex = fileName.lastIndexOf('.');
                if (dotIndex > 0) {
                    ext = fileName.substring(dotIndex);
                }

                // Trả về UUID + extension
                return UUID.randomUUID() + ext;
            }
        }

        // Nếu không tìm thấy filename trong header, trả về UUID + .jpg
        return UUID.randomUUID() + ".jpg";
    }

    /**
     * Lấy extension từ filename
     */
    private String getExtension(String fileName) {
        if (fileName == null) return ".jpg";

        int dotIndex = fileName.lastIndexOf('.');
        return dotIndex > 0 ? fileName.substring(dotIndex) : ".jpg";
    }
}