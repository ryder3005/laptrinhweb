package vn.iotstar.controler.Category;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
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
import java.util.List;

@WebServlet(urlPatterns = { "/admin/category/edit" })
public class CategoryEditController extends HttpServlet {
    CategoryService cateService = new CategoryServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws
            ServletException, IOException {
        String id = req.getParameter("id");
        Category category = cateService.get(Integer.parseInt(id));
        req.setAttribute("category", category);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/editcategory.jsp");
        dispatcher.forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Category category = new Category();

        // Thiết lập mã hóa UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        // Thư mục lưu file (biến môi trường)

        String uploadDirPath = Dotenv.load().get("UPLOAD_FILE_PATH") + "/category";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try {
            // Lấy ID và tên
            category.setCateid(Integer.parseInt(req.getParameter("id")));
            category.setCatename(req.getParameter("name"));

            // Lấy Part file
            Part filePart = req.getPart("icon");

            if (filePart != null && filePart.getSize() > 0) {
                // Lấy tên file tối ưu + UUID
                String fileName = getFileName(filePart);
                // Ghi file vào thư mục
                filePart.write(uploadDirPath + File.separator + fileName);
                // Lưu đường dẫn vào Category
                category.setIcon("category/" + fileName);
            } else {
                // Không upload file mới → giữ icon cũ
                Category old = cateService.get(category.getCateid());
                category.setIcon(old != null ? old.getIcon() : null);
            }

            // Cập nhật Category vào DB
            cateService.edit(category);

            // Redirect về danh sách category
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            getServletContext().getRequestDispatcher("/views/admin/editcategory.jsp").forward(req, resp);
        }
    }

    // Hàm getFileName tối ưu
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return Dotenv.load().get("UPLOAD_FILE_NAME") ;

        for (String content : contentDisp.split(";")) {
            content = content.trim();
            if (content.startsWith("filename")) {
                String fileName = content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
                if (fileName.isEmpty()) return Dotenv.load().get("UPLOAD_FILE_NAME");

                int dotIndex = fileName.lastIndexOf('.');
                String ext = dotIndex > 0 ? fileName.substring(dotIndex) : "";
                return java.util.UUID.randomUUID().toString() + ext;
            }
        }
        return Dotenv.load().get("UPLOAD_FILE_NAME");
    }

}
