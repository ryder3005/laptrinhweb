<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .header-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .header-section h2 {
            margin: 0;
            font-weight: 600;
        }
        
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-left: 4px solid #667eea;
        }
        
        .stats-card h3 {
            font-size: 32px;
            font-weight: bold;
            margin: 0;
            color: #667eea;
zle"></i> Đang kinh doanh</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card" style="border-left-color: #dc3545;">
                    <h3 style="color: #dc3545;">
                        <c:set var="outOfStock" value="0"/>
                        <c:forEach var="p" items="${products}">
                            <c:if test="${p.quantity == 0}">
                                <c:set var="outOfStock" value="${outOfStock + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${outOfStock}
                    </h3>
                    <p><i class="bi bi-exclamation-circle"></i> Hết hàng</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card" style="border-left-color: #ffc107;">
                    <h3 style="color: #ffc107;">
                        <c:set var="onSale" value="0"/>
                        <c:forEach var="p" items="${products}">
                            <c:if test="${p.salePrice != null && p.salePrice < p.price}">
                                <c:set var="onSale" value="${onSale + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${onSale}
                    </h3>
                    <p><i class="bi bi-tag"></i> Đang giảm giá</p>
                </div>
            </div>
        </div>

        <!-- Search Box -->
        <div class="search-box">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <form action="${pageContext.request.contextPath}/admin/product/search" method="get">
                        <div class="position-relative">
                            <i class="bi bi-search search-icon"></i>
                            <input type="text" 
                                   class="form-control search-input" 
                                   name="keyword" 
                                   placeholder="Tìm kiếm theo tên sản phẩm hoặc mô tả..."
                                   value="${keyword}">
                        </div>
                    </form>
                </div>
                <div class="col-md-4 text-end">
                    <div class="filter-badge active">
                        <i class="bi bi-grid-3x3"></i> Tất cả
                    </div>
                    <div class="filter-badge">
                        <i class="bi bi-tag"></i> Khuyến mãi
                    </div>
                </div>
            </div>
        </div>

        <!-- Products Table -->
        <div class="table-card">
            <c:if test="${not empty products}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 5%;">ID</th>
                                <th style="width: 10%;">Hình ảnh</th>
                                <th style="width: 25%;">Tên sản phẩm</th>
                                <th style="width: 15%;">Giá</th>
                                <th style="width: 10%;">Số lượng</th>
                                <th style="width: 10%;">Trạng thái</th>
                                <th style="width: 15%;" class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td><strong>#${product.productId}</strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty product.image}">
                                                <c:url value="/image?fname=${product.image}" var="imgUrl" />
                                                <img src="${imgUrl}"
                                                     class="product-img"
                                                     alt="${product.productName}"
                                                     height="150" width="200">
                                            </c:when>

                                            <c:otherwise>
                                                <div class="product-img d-flex align-items-center justify-content-center"
                                                     style="background: #f0f0f0; height:150px; width:200px;">
                                                    <i class="bi bi-image" style="font-size: 24px; color: #adb5bd;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="product-name">${product.productName}</div>
                                        <div class="product-category">
                                            <i class="bi bi-tag"></i>
                                            <c:choose>
                                                <c:when test="${not empty product.category}">
                                                    ${product.category.catename}
                                                </c:when>
                                                <c:otherwise>
                                                    Chưa phân loại
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.salePrice != null && product.salePrice < product.price}">
                                                <div class="price-sale">
                                                    <fmt:formatNumber value="${product.salePrice}" type="number" groupingUsed="true"/>đ
                                                    <span class="badge badge-sale">
                                                        <i class="bi bi-lightning-fill"></i> SALE
                                                    </span>
                                                </div>
                                                <div class="price-old">
                                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="price-original">
                                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="stock-badge">
                                            <c:choose>
                                                <c:when test="${product.quantity == 0}">
                                                    <span class="badge badge-danger">
                                                        <i class="bi bi-x-circle"></i> Hết hàng
                                                    </span>
                                                </c:when>
                                                <c:when test="${product.quantity < 10}">
                                                    <span class="badge badge-warning">
                                                        <i class="bi bi-exclamation-triangle"></i> ${product.quantity}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-success">
                                                        <i class="bi bi-check-circle"></i> ${product.quantity}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.active}">
                                                <span class="badge badge-success">
                                                    <i class="bi bi-check-circle"></i> Hoạt động
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">
                                                    <i class="bi bi-x-circle"></i> Tạm dừng
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/product/view?id=${product.productId}" 
                                           class="btn-action btn-view" 
                                           title="Xem chi tiết">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/product/edit?id=${product.productId}" 
                                           class="btn-action btn-edit" 
                                           title="Chỉnh sửa">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <button class="btn-action btn-delete" 
                                                onclick="confirmDelete(${product.productId})" 
                                                title="Xóa">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${empty products}">
                <div class="empty-state">
                    <i class="bi bi-inbox"></i>
                    <h4>Chưa có sản phẩm nào</h4>
                    <p class="text-muted">Hãy thêm sản phẩm đầu tiên của bạn</p>
                    <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-add mt-3">
                        <i class="bi bi-plus-circle me-2"></i>Thêm Sản Phẩm Ngay
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 15px; border: none;">
                <div class="modal-header" style="border: none; padding: 25px 25px 15px;">
                    <h5 class="modal-title">
                        <i class="bi bi-exclamation-triangle text-danger me-2"></i>
                        Xác nhận xóa
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" style="padding: 15px 25px 25px;">
                    <p>Bạn có chắc chắn muốn xóa sản phẩm này không? Hành động này không thể hoàn tác!</p>
                </div>
                <div class="modal-footer" style="border: none; padding: 0 25px 25px;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                        <i class="bi bi-trash me-2"></i>Xóa
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(productId) {
            const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            const confirmBtn = document.getElementById('confirmDeleteBtn');
            confirmBtn.href = '${pageContext.request.contextPath}/admin/product/delete?id=' + productId;
            deleteModal.show();
        }

        // Auto hide alerts
z
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 3000);
    </script>
</body>
</html>