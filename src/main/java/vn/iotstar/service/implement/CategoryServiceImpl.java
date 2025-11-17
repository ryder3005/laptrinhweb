package vn.iotstar.service.implement;

import io.github.cdimascio.dotenv.Dotenv;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.implement.CategoryDAOImpl;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;

import java.io.File;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {
    CategoryDao categoryDao = new CategoryDAOImpl();
    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getCateid());
        oldCategory.setCatename(newCategory.getCatename());
        if (newCategory.getIcon() != null) {
            Dotenv dotenv = Dotenv.load();
            String uploadPath = dotenv.get("UPLOAD_FILE_PATH");
            String filename= oldCategory.getIcon();
            File file = new File(filename);
            if (!file.exists()) {
                file.mkdirs();
            }

        }
        oldCategory.setIcon(newCategory.getIcon());
        categoryDao.edit(oldCategory);
    }

    @Override
    public void delete(int id) {
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
            return categoryDao.search(keyword);
    }
}
