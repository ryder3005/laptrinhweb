package vn.iotstar.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
public class ProductDaoImpl implements ProductDao {

    public Connection conn = null;
    public PreparedStatement ps = null;
    public ResultSet rs = null;

    @Override
    public void insert(Product product) {
        String sql = "INSERT INTO products (product_name, description, price, sale_price, quantity, image, cate_id, active, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setBigDecimal(4, product.getSalePrice());
            ps.setInt(5, product.getQuantity());
            ps.setString(6, product.getImage());
            ps.setInt(7, product.getCategoryId());
            ps.setInt(8, product.isActive() ? 1 : 0);
            ps.setTimestamp(9, Timestamp.valueOf(LocalDateTime.now()));
            ps.setTimestamp(10, Timestamp.valueOf(LocalDateTime.now()));

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    @Override
    public void edit(Product product) {
        String sql = "UPDATE products SET product_name=?, description=?, price=?, sale_price=?, quantity=?, image=?, cate_id=?, active=?, updated_at=? WHERE product_id=?";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setBigDecimal(4, product.getSalePrice());
            ps.setInt(5, product.getQuantity());
            ps.setString(6, product.getImage());
            ps.setInt(7, product.getCategoryId());
            ps.setInt(8, product.isActive() ? 1 : 0);
            ps.setTimestamp(9, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(10, product.getProductId());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM products WHERE product_id=?";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    @Override
    public Product get(int id) {
        String sql = "SELECT p.*, c.cate_id, c.cate_name, c.icons " +
                "FROM products p " +
                "LEFT JOIN category c ON p.cate_id = c.cate_id " +
                "WHERE p.product_id=?";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToProduct(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    @Override
    public List<Product> getAll() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cate_id, c.cate_name, c.icons " +
                "FROM products p " +
                "LEFT JOIN category c ON p.cate_id = c.cate_id " +
                "ORDER BY p.created_at DESC";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return products;
    }

    @Override
    public List<Product> search(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cate_id, c.cate_name, c.icons " +
                "FROM products p " +
                "LEFT JOIN category c ON p.cate_id = c.cate_id " +
                "WHERE p.product_name LIKE ? OR p.description LIKE ? " +
                "ORDER BY p.created_at DESC";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return products;
    }

    // Phương thức bổ sung
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cate_id, c.cate_name, c.icons " +
                "FROM products p " +
                "LEFT JOIN category c ON p.cate_id = c.cate_id " +
                "WHERE p.cate_id=? AND p.active=1 " +
                "ORDER BY p.created_at DESC";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return products;
    }

    public List<Product> getActiveProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cate_id, c.cate_name, c.icons " +
                "FROM products p " +
                "LEFT JOIN category c ON p.cate_id = c.cate_id " +
                "WHERE p.active=1 " +
                "ORDER BY p.created_at DESC";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return products;
    }

    public List<Product> getProductsOnSale() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cate_id, c.cate_name, c.icons " +
                "FROM products p " +
                "LEFT JOIN category c ON p.cate_id = c.cate_id " +
                "WHERE p.active=1 AND p.sale_price IS NOT NULL AND p.sale_price < p.price " +
                "ORDER BY p.created_at DESC";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return products;
    }

    public List<Product> getLatestProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cate_id, c.cate_name, c.icons " +
                "FROM products p " +
                "LEFT JOIN category c ON p.cate_id = c.cate_id " +
                "WHERE p.active=1 " +
                "ORDER BY p.created_at DESC LIMIT ?";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return products;
    }

    public void updateQuantity(int productId, int quantity) {
        String sql = "UPDATE products SET quantity=?, updated_at=? WHERE product_id=?";
        try {
            conn = DBConnection.getDBConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(3, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    // Helper method để map ResultSet sang Product object
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();

        product.setProductId(rs.getInt("product_id"));
        product.setProductName(rs.getString("product_name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setSalePrice(rs.getBigDecimal("sale_price"));
        product.setQuantity(rs.getInt("quantity"));
        product.setImage(rs.getString("image"));
        product.setCategoryId(rs.getInt("cate_id"));
        product.setActive(rs.getInt("active") == 1);

        Timestamp createdTimestamp = rs.getTimestamp("created_at");
        if (createdTimestamp != null) {
            product.setCreatedAt(createdTimestamp.toLocalDateTime());
        }

        Timestamp updatedTimestamp = rs.getTimestamp("updated_at");
        if (updatedTimestamp != null) {
            product.setUpdatedAt(updatedTimestamp.toLocalDateTime());
        }

        // Map Category nếu có
        try {
            int cateid = rs.getInt("cateid");
            if (cateid > 0) {
                Category category = new Category();
                category.setCateid(cateid);
                category.setCatename(rs.getString("catename"));
                category.setIcon(rs.getString("icon"));
                product.setCategory(category);
            }
        } catch (SQLException e) {
            // Category columns không tồn tại trong query, bỏ qua
        }

        return product;
    }

    // Đóng tài nguyên
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}