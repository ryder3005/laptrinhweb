package vn.iotstar.controler.product;

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
import vn.iotstar.model.Product;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.implement.CategoryServiceImpl;
import vn.iotstar.service.implement.ProductServiceImpl;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = "/admin/product/edit")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProductEditController extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");
        Product product = productService.get(Integer.parseInt(id));
        List<Category> categories = categoryService.getAll();

        req.setAttribute("product", product);
        req.setAttribute("categories", categories);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/edit-product.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Thiết lập mã hóa UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        // Thư mục lưu file
        String uploadDirPath = Dotenv.load().get("UPLOAD_FILE_PATH") + "/products";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try {
            // Lấy thông tin từ form
            int productId = Integer.parseInt(req.getParameter("id"));
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            BigDecimal price = new BigDecimal(req.getParameter("price"));

            String salePriceStr = req.getParameter("salePrice");
            BigDecimal salePrice = (salePriceStr != null && !salePriceStr.isEmpty())
                    ? new BigDecimal(salePriceStr) : null;

            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            boolean active = req.getParameter("active") != null;

            // Lấy product cũ để giữ ảnh cũ nếu không upload mới
            Product oldProduct = productService.get(productId);
            String oldImages = oldProduct.getImage();

            // Xử lý upload nhiều file ảnh
            StringBuilder newImagesList = new StringBuilder();
            List<String> uploadedImages = new ArrayList<>();

            for (Part part : req.getParts()) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String fileName = getFileName(part);
                    String filePath = uploadDirPath + File.separator + fileName;
                    part.write(filePath);
                    uploadedImages.add("products/" + fileName);
                }
            }

            // Xử lý giữ lại ảnh cũ
            String[] keepOldImages = req.getParameterValues("keepImages");
            List<String> finalImages = new ArrayList<>();

            // Thêm ảnh cũ được giữ lại
            if (keepOldImages != null && oldImages != null) {
                String[] oldImagesArray = oldImages.split(";");
                for (String keepIndex : keepOldImages) {
                    try {
                        int index = Integer.parseInt(keepIndex);
                        if (index >= 0 && index < oldImagesArray.length) {
                            finalImages.add(oldImagesArray[index]);
                        }
                    } catch (NumberFormatException e) {
                        // Ignore invalid index
                    }
                }
            }

            // Thêm ảnh mới
            finalImages.addAll(uploadedImages);

            // Nếu không có ảnh nào, giữ ảnh cũ
            String finalImagesString;
            if (finalImages.isEmpty()) {
                finalImagesString = oldImages;
            } else {
                finalImagesString = String.join(";", finalImages);
            }

            // Tạo đối tượng Product để update
            Product product = new Product();
            product.setProductId(productId);
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);
            product.setSalePrice(salePrice);
            product.setQuantity(quantity);
            product.setImage(finalImagesString);
            product.setCategoryId(categoryId);
            product.setActive(active);

            // Cập nhật vào database
            productService.edit(product);

            // Redirect về danh sách
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            doGet(req, resp);
        }
    }

    // Hàm getFileName tối ưu
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return Dotenv.load().get("UPLOAD_FILE_NAME");

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