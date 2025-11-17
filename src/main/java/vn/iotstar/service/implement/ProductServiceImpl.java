package vn.iotstar.service.implement;

import vn.iotstar.model.Product;

import java.util.List;

import vn.iotstar.dao.ProductDao;
import vn.iotstar.dao.implement.ProductDaoImpl;

public class ProductServiceImpl implements vn.iotstar.service.ProductService {

    ProductDao productDao= new ProductDaoImpl();
    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void edit(Product product) {
        productDao.edit(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public Product get(int id) {
        return productDao.get(id);
    }

    @Override
    public List<Product> getAll() {
        return productDao.getAll();
    }

    @Override
    public List<Product> search(String keyword) {
        return productDao.search(keyword);
    }
}
