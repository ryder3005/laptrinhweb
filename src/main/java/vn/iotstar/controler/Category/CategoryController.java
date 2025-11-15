package vn.iotstar.controler.Category;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.implement.CategoryServiceImpl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet (urlPatterns = {"/admin/category/list"})
public class CategoryEditController extends HttpServlet {
    CategoryService categoryService=new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> cateList=new ArrayList<>();
        req.setAttribute("cateList", cateList);
        RequestDispatcher dispatcher=req.getRequestDispatcher("/views/admin/listcategory.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id =req.getParameter("id");
        Category category = categoryService.get(Integer.parseInt(id));
        req.setAttribute("category", category);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/editcategory.jsp");
        dispatcher.forward(req, resp);
    }
}
