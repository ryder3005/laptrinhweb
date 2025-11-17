package vn.iotstar.service;
public  interface ProductService {
    void insert(vn.iotstar.model.Product product);
    void edit(vn.iotstar.model.Product product);
    void delete(int id);
    vn.iotstar.model.Product get(int id);
    java.util.List<vn.iotstar.model.Product> getAll();
    java.util.List<vn.iotstar.model.Product> search(String keyword);
}