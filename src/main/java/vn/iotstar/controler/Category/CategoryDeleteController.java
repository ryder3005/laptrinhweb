package vn.iotstar.controler.Category;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.implement.CategoryServiceImpl;

@WebServlet(urlPatterns = { "/admin/category/delete" })
public class CategoryeDeleteController extends HttpServlet {
    CategoryService cateService = new CategoryServiceImpl();

}
