package vn.iotstar.controler.product;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

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
import vn.iotstar.utils.UploadImage;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,  // 1 MB
        maxFileSize = 1024 * 1024 * 10,       // 10 MB
        maxRequestSize = 1024 * 1024 * 15     // 15 MB
)
@WebServlet(urlPatterns = "/admin/product/edit")
public class ProductEditController extends HttpServlet {
    CategoryService categoryService = new CategoryServiceImpl();
    ProductService productService = new ProductServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.get(id);
        List<Category> categories = categoryService.getAll();

        req.setAttribute("product", product);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // Lấy thông tin từ form
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            String salePriceStr = req.getParameter("salePrice");
            BigDecimal salePrice = (salePriceStr != null && !salePriceStr.isEmpty())
                    ? new BigDecimal(salePriceStr) : null;
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            boolean active = req.getParameter("active") != null;
            String oldImage = req.getParameter("oldImage");

            StringBuilder images = new StringBuilder();
            
            // Xử lý upload nhiều file mới (nếu có)
            for (Part part : req.getParts()) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String image = UploadImage.saveImage(part, "products");
                    if (image != null && !image.isEmpty()) {
                        if (images.length() > 0) {
                            images.append(";");
                        }
                        images.append(image);
                    }
                }
            }

            // Nếu không upload ảnh mới, giữ ảnh cũ
            if (images.length() == 0) {
                images = new StringBuilder(oldImage);
            }

            // Tạo đối tượng Product
            Product product = new Product();
            product.setProductId(productId);
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);
            product.setSalePrice(salePrice);
            product.setQuantity(quantity);
            product.setImage(images.toString());
            product.setCategoryId(categoryId);
            product.setActive(active);

            // Cập nhật database
            productService.edit(product);

            req.setAttribute("message", "Cập nhật sản phẩm thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.get(id);
            List<Category> categories = categoryService.getAll();

            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
        }
    }
}
