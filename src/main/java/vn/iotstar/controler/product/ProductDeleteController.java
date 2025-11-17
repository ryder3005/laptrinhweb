package vn.iotstar.controler.product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.implement.ProductServiceImpl;

import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/product/delete"})
public class ProductDeleteController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService ps = new ProductServiceImpl();
        int id = Integer.parseInt(request.getParameter("id"));
        ps.delete(id);
        response.sendRedirect("/admin/products");
    }
}
