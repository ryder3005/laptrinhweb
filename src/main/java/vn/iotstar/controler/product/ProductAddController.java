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
@WebServlet(urlPatterns ="/admin/product/add")
public class ProductAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // Lấy thông tin từ form
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            String salePriceStr = req.getParameter("salePrice");
            BigDecimal salePrice = (salePriceStr != null && !salePriceStr.isEmpty())
                    ? new BigDecimal(salePriceStr) : null;
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            boolean active = req.getParameter("active") != null;

            // Xử lý upload file

            Part filePart = req.getPart("image");
            String image = UploadImage.saveImage(filePart,"");

            // Tạo đối tượng Product
            Product product = new Product();
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);
            product.setSalePrice(salePrice);
            product.setQuantity(quantity);
            product.setImage(image);
            product.setCategoryId(categoryId);
            product.setActive(active);

            // Thêm vào database
            productService.insert(product);

            req.setAttribute("message", "Thêm sản phẩm thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
//            showAddForm(req, resp);
            req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.getAll();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
    }
}
