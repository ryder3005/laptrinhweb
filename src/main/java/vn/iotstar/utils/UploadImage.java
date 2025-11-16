package vn.iotstar.utils;

import jakarta.servlet.http.Part;

import java.util.UUID;

public class UploadImage {
    private String getFileName(Part part) {
        // Lấy header Content-Disposition
        String contentDisp = part.getHeader("content-disposition");

        // Nếu không có header, tạo luôn UUID với đuôi mặc định .jpg
        if (contentDisp == null) {
            return UUID.randomUUID().toString() + ".jpg";
        }

        // Tách từng phần của header
        for (String content : contentDisp.split(";")) {
            content = content.trim();
            if (content.startsWith("filename")) {
                // Lấy tên file gốc
                String fileName = content.substring(content.indexOf('=') + 1)
                        .trim()
                        .replace("\"", "");

                // Nếu fileName rỗng, tạo UUID + .jpg
                if (fileName.isEmpty()) {
                    return UUID.randomUUID().toString() + ".jpg";
                }

                // Lấy phần mở rộng của file
                int dotIndex = fileName.lastIndexOf('.');
                String ext = dotIndex > 0 ? fileName.substring(dotIndex) : "";

                // Trả về UUID + extension
                return UUID.randomUUID().toString() + ext;
            }
        }

        // Nếu không tìm thấy filename trong header, tạo UUID + .jpg
        return UUID.randomUUID().toString() + ".jpg";
    }

}
