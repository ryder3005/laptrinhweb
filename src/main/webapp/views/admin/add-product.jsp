<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/17/2025
  Time: 2:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới</title>
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

        .preview-thumbnail {
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            background: #f0f0f0;
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .preview-thumbnail img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }

        .remove-image-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            opacity: 0;
            transition: opacity 0.2s;
        }

        .preview-thumbnail:hover .remove-image-btn {
            opacity: 1;
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

        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }

        .price-group {
            position: relative;
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

        .section-divider {
            border-top: 2px solid #e9ecef;
            margin: 30px 0;
        }
    </style>
</head>
<body>
<div class="main-container">
    <!-- Header Card -->
    <div class="card">
        <div class="card-header">
            <h3>
                <i class="bi bi-plus-circle"></i>
                Thêm Sản Phẩm Mới
            </h3>
        </div>

        <div class="card-body p-4">
            <!-- Alert Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>
                        ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/admin/product/add"
                  method="post"
                  enctype="multipart/form-data"
                  id="productForm">

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
                               placeholder="Nhập tên sản phẩm"
                               required>
                    </div>

                    <div class="col-md-4">
                        <label for="categoryId" class="form-label required">Danh mục</label>
                        <select class="form-select" id="categoryId" name="categoryId" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.cateid}">${category.catename}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả sản phẩm</label>
                    <textarea class="form-control"
                              id="description"
                              name="description"
                              rows="4"
                              placeholder="Nhập mô tả chi tiết về sản phẩm..."></textarea>
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
                                   placeholder="0"
                                   min="0"
                                   step="1000"
                                   required>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <label for="salePrice" class="form-label">
                            Giá khuyến mãi
                            <small class="text-muted">(Tùy chọn)</small>
                        </label>
                        <div class="input-group price-group">
                            <span class="input-group-text">₫</span>
                            <input type="number"
                                   class="form-control"
                                   id="salePrice"
                                   name="salePrice"
                                   placeholder="0"
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
                               placeholder="0"
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

                <div class="mb-3">
                    <input type="file"
                           class="form-control d-none"
                           id="images"
                           name="images"
                           accept="image/*"
                           multiple
                           onchange="previewImages(event)">

                    <div class="image-preview" onclick="document.getElementById('images').click()">
                        <div class="preview-icon">
                            <i class="bi bi-cloud-upload"></i>
                        </div>
                        <h6 class="text-muted">Click để chọn ảnh (có thể chọn nhiều)</h6>
                        <small class="text-muted">Hỗ trợ: JPG, PNG, GIF (Tối đa 10MB/file)</small>
                    </div>

                    <!-- Image Preview Container -->
                    <div id="imagePreviewContainer" class="mt-3" style="display: none;">
                        <h6>Ảnh đã chọn:</h6>
                        <div id="previewList" class="row g-2"></div>
                        <button type="button" class="btn btn-sm btn-outline-danger mt-2" onclick="clearImages()">
                            <i class="bi bi-trash me-2"></i>Xóa tất cả
                        </button>
                    </div>
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
                               checked>
                        <label class="form-check-label" for="active">
                            <strong>Kích hoạt sản phẩm</strong>
                            <br>
                            <small class="text-muted">Sản phẩm sẽ hiển thị trên website</small>
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
                        Thêm sản phẩm
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let selectedFiles = [];

    // Preview multiple images
    function previewImages(event) {
        const files = Array.from(event.target.files);
        selectedFiles = files;
        
        const previewContainer = document.getElementById('imagePreviewContainer');
        const previewList = document.getElementById('previewList');
        
        if (files.length === 0) {
            previewContainer.style.display = 'none';
            return;
        }

        previewList.innerHTML = '';
        previewContainer.style.display = 'block';

        files.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function(e) {
                const col = document.createElement('div');
                col.className = 'col-md-3';
                
                const thumbnail = document.createElement('div');
                thumbnail.className = 'preview-thumbnail';
                
                const img = document.createElement('img');
                img.src = e.target.result;
                img.alt = file.name;
                
                const removeBtn = document.createElement('button');
                removeBtn.type = 'button';
                removeBtn.className = 'remove-image-btn';
                removeBtn.innerHTML = '<i class="bi bi-x"></i>';
                removeBtn.onclick = (e) => {
                    e.preventDefault();
                    removeImage(index);
                };
                
                const fileName = document.createElement('small');
                fileName.className = 'd-block text-center mt-1 text-muted';
                fileName.textContent = file.name.length > 20 ? file.name.substring(0, 17) + '...' : file.name;
                
                thumbnail.appendChild(img);
                thumbnail.appendChild(removeBtn);
                col.appendChild(thumbnail);
                col.appendChild(fileName);
                previewList.appendChild(col);
            };
            reader.readAsDataURL(file);
        });
    }

    // Remove single image
    function removeImage(index) {
        selectedFiles.splice(index, 1);
        
        if (selectedFiles.length === 0) {
            document.getElementById('imagePreviewContainer').style.display = 'none';
            document.getElementById('images').value = '';
        } else {
            // Recreate FileList-like object
            const dataTransfer = new DataTransfer();
            selectedFiles.forEach(file => {
                dataTransfer.items.add(file);
            });
            document.getElementById('images').files = dataTransfer.files;
            
            // Trigger preview update
            const event = { target: { files: dataTransfer.files } };
            previewImages(event);
        }
    }

    // Clear all images
    function clearImages() {
        selectedFiles = [];
        document.getElementById('images').value = '';
        document.getElementById('imagePreviewContainer').style.display = 'none';
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

        if (selectedFiles.length === 0) {
            e.preventDefault();
            alert('Vui lòng chọn ít nhất một ảnh cho sản phẩm!');
            return false;
        }
    });

    // Format number with thousand separator
    function formatNumber(input) {
        let value = input.value.replace(/\D/g, '');
        input.value = value;
    }

    document.getElementById('price').addEventListener('input', function() {
        formatNumber(this);
    });

    document.getElementById('salePrice').addEventListener('input', function() {
        formatNumber(this);
    });
</script>
</body>
</html>
