<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/17/2025
  Time: 5:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chỉnh Sửa Sản Phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
  <style>
    body {
      background: #f8f9fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .main-container {
      max-width: 1000px;
      margin: 30px auto;
    }

    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 0 20px rgba(0,0,0,0.08);
    }

    .card-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border-radius: 15px 15px 0 0 !important;
      padding: 20px 30px;
    }

    .card-header h3 {
      margin: 0;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .form-label {
      font-weight: 600;
      color: #333;
      margin-bottom: 8px;
    }

    .required::after {
      content: " *";
      color: #dc3545;
    }

    .form-control, .form-select {
      border: 2px solid #e0e0e0;
      border-radius: 10px;
      padding: 12px 15px;
      transition: all 0.3s ease;
    }

    .form-control:focus, .form-select:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
    }

    .current-images {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
      gap: 15px;
      margin-bottom: 20px;
    }

    .image-item {
      position: relative;
      border-radius: 10px;
      overflow: hidden;
      border: 2px solid #e0e0e0;
      transition: all 0.3s;
    }

    .image-item:hover {
      border-color: #667eea;
      transform: translateY(-2px);
    }

    .image-item img {
      width: 100%;
      height: 120px;
      object-fit: cover;
      display: block;
    }

    .image-item-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0,0,0,0.6);
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      transition: opacity 0.3s;
    }

    .image-item:hover .image-item-overlay {
      opacity: 1;
    }

    .image-item-checkbox {
      position: absolute;
      top: 8px;
      right: 8px;
      width: 24px;
      height: 24px;
      cursor: pointer;
      z-index: 10;
    }

    .delete-badge {
      position: absolute;
      top: 8px;
      left: 8px;
      background: rgba(220, 53, 69, 0.9);
      color: white;
      padding: 4px 8px;
      border-radius: 5px;
      font-size: 11px;
      font-weight: 600;
      display: none;
    }

    .image-item input:not(:checked) ~ .delete-badge {
      display: block;
    }

    .image-preview {
      border: 2px dashed #dee2e6;
      border-radius: 10px;
      padding: 20px;
      text-align: center;
      background: #f8f9fa;
      transition: all 0.3s ease;
      cursor: pointer;
    }

    .image-preview:hover {
      border-color: #667eea;
      background: #f0f2ff;
    }

    .preview-icon {
      font-size: 60px;
      color: #adb5bd;
      margin-bottom: 10px;
    }

    .btn-primary {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border: none;
      padding: 12px 30px;
      border-radius: 10px;
      font-weight: 600;
      transition: transform 0.2s;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
    }

    .btn-secondary {
      padding: 12px 30px;
      border-radius: 10px;
      font-weight: 600;
    }

    .section-divider {
      border-top: 2px solid #e9ecef;
      margin: 30px 0;
    }

    .price-group .input-group-text {
      border: 2px solid #e0e0e0;
      border-right: none;
      background: #f8f9fa;
      border-radius: 10px 0 0 10px;
      font-weight: 600;
    }

    .price-group .form-control {
      border-left: none;
      border-radius: 0 10px 10px 0;
    }

    .alert {
      border-radius: 10px;
      border: none;
    }
  </style>
</head>
<body>
<div class="main-container">
  <div class="card">
    <div class="card-header">
      <h3>
        <i class="bi bi-pencil-square"></i>
        Chỉnh Sửa Sản Phẩm
      </h3>
    </div>

    <div class="card-body p-4">
      <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
          <i class="bi bi-exclamation-triangle-fill me-2"></i>
            ${error}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/admin/product/edit"
            method="post"
            enctype="multipart/form-data"
            id="productForm">

        <input type="hidden" name="id" value="${product.productId}">

        <!-- Thông tin cơ bản -->
        <h5 class="mb-3">
          <i class="bi bi-info-circle text-primary"></i>
          Thông tin cơ bản
        </h5>

        <div class="row mb-3">
          <div class="col-md-8">
            <label for="productName" class="form-label required">Tên sản phẩm</label>
            <input type="text"
                   class="form-control"
                   id="productName"
                   name="productName"
                   value="${product.productName}"
                   required>
          </div>

          <div class="col-md-4">
            <label for="categoryId" class="form-label required">Danh mục</label>
            <select class="form-select" id="categoryId" name="categoryId" required>
              <c:forEach var="category" items="${categories}">
                <option value="${category.cateid}"
                  ${category.cateid == product.categoryId ? 'selected' : ''}>
                    ${category.catename}
                </option>
              </c:forEach>
            </select>
          </div>
        </div>

        <div class="mb-3">
          <label for="description" class="form-label">Mô tả sản phẩm</label>
          <textarea class="form-control"
                    id="description"
                    name="description"
                    rows="4">${product.description}</textarea>
        </div>

        <div class="section-divider"></div>

        <!-- Giá và số lượng -->
        <h5 class="mb-3">
          <i class="bi bi-cash-stack text-success"></i>
          Giá và Số lượng
        </h5>

        <div class="row mb-3">
          <div class="col-md-4">
            <label for="price" class="form-label required">Giá gốc</label>
            <div class="input-group price-group">
              <span class="input-group-text">₫</span>
              <input type="number"
                     class="form-control"
                     id="price"
                     name="price"
                     value="${product.price}"
                     min="0"
                     step="1000"
                     required>
            </div>
          </div>

          <div class="col-md-4">
            <label for="salePrice" class="form-label">Giá khuyến mãi</label>
            <div class="input-group price-group">
              <span class="input-group-text">₫</span>
              <input type="number"
                     class="form-control"
                     id="salePrice"
                     name="salePrice"
                     value="${product.salePrice}"
                     min="0"
                     step="1000">
            </div>
          </div>

          <div class="col-md-4">
            <label for="quantity" class="form-label required">Số lượng</label>
            <input type="number"
                   class="form-control"
                   id="quantity"
                   name="quantity"
                   value="${product.quantity}"
                   min="0"
                   required>
          </div>
        </div>

        <div class="section-divider"></div>

        <!-- Hình ảnh -->
        <h5 class="mb-3">
          <i class="bi bi-image text-info"></i>
          Hình ảnh sản phẩm
        </h5>

        <!-- Ảnh hiện tại -->
        <c:if test="${not empty product.image}">
          <c:set var="imageArray" value="${fn:split(product.image, ';')}"/>
          <label class="form-label">Ảnh hiện tại (Bỏ tick để xóa)</label>
          <div class="current-images">
            <c:forEach var="img" items="${imageArray}" varStatus="status">
              <div class="image-item">
                <c:url value="/image?fname=${img}" var="imgUrl"></c:url>
                <img src="${imgUrl}" alt="Product image ${status.index + 1}">
                <input type="checkbox"
                       class="image-item-checkbox form-check-input"
                       name="keepImages"
                       value="${status.index}"
                       checked>
                <span class="delete-badge">
                                        <i class="bi bi-trash"></i> Xóa
                                    </span>
              </div>
            </c:forEach>
          </div>
        </c:if>

        <!-- Upload ảnh mới -->
        <div class="mb-3">
          <label class="form-label">Thêm ảnh mới</label>
          <input type="file"
                 class="form-control d-none"
                 id="images"
                 name="images"
                 accept="image/*"
                 multiple
                 onchange="previewNewImages(event)">

          <div class="image-preview" onclick="document.getElementById('images').click()">
            <div class="preview-icon">
              <i class="bi bi-cloud-upload"></i>
            </div>
            <h6 class="text-muted">Click để chọn ảnh mới</h6>
            <small class="text-muted">Có thể chọn nhiều ảnh cùng lúc</small>
          </div>
          <div id="newImagesPreview" class="current-images mt-3" style="display: none;"></div>
        </div>

        <div class="section-divider"></div>

        <!-- Trạng thái -->
        <h5 class="mb-3">
          <i class="bi bi-toggle-on text-warning"></i>
          Trạng thái
        </h5>

        <div class="mb-4">
          <div class="form-check form-switch">
            <input class="form-check-input"
                   type="checkbox"
                   id="active"
                   name="active"
            ${product.active ? 'checked' : ''}>
            <label class="form-check-label" for="active">
              <strong>Kích hoạt sản phẩm</strong>
            </label>
          </div>
        </div>

        <!-- Buttons -->
        <div class="d-flex gap-3 justify-content-end">
          <a href="${pageContext.request.contextPath}/admin/products"
             class="btn btn-secondary">
            <i class="bi bi-x-circle me-2"></i>
            Hủy bỏ
          </a>
          <button type="submit" class="btn btn-primary">
            <i class="bi bi-check-circle me-2"></i>
            Cập nhật sản phẩm
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Preview new images
  function previewNewImages(event) {
    const files = event.target.files;
    const previewContainer = document.getElementById('newImagesPreview');
    previewContainer.innerHTML = '';

    if (files.length > 0) {
      previewContainer.style.display = 'grid';

      Array.from(files).forEach((file, index) => {
        const reader = new FileReader();
        reader.onload = function(e) {
          const div = document.createElement('div');
          div.className = 'image-item';
          div.innerHTML = `
                            <img src="${e.target.result}" alt="New image ${index + 1}">
                            <span style="position: absolute; top: 8px; left: 8px; background: rgba(40, 167, 69, 0.9); color: white; padding: 4px 8px; border-radius: 5px; font-size: 11px; font-weight: 600;">
                                <i class="bi bi-plus-circle"></i> Mới
                            </span>
                        `;
          previewContainer.appendChild(div);
        }
        reader.readAsDataURL(file);
      });
    } else {
      previewContainer.style.display = 'none';
    }
  }

  // Validate sale price
  document.getElementById('productForm').addEventListener('submit', function(e) {
    const price = parseFloat(document.getElementById('price').value);
    const salePrice = parseFloat(document.getElementById('salePrice').value);

    if (salePrice && salePrice >= price) {
      e.preventDefault();
      alert('Giá khuyến mãi phải nhỏ hơn giá gốc!');
      return false;
    }
  });
</script>
</body>
</html>