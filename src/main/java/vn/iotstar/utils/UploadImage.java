package vn.iotstar.utils;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class UploadImage {

    public static String saveImage(Part filePart, String subFolder) throws IOException {

        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Định nghĩa các loại MIME Type được phép và phần mở rộng tương ứng
        final Map<String, String> allowedImageTypes = new HashMap<>();
        allowedImageTypes.put("image/jpeg", ".jpg");
        allowedImageTypes.put("image/png", ".png");
        allowedImageTypes.put("image/gif", ".gif");
        allowedImageTypes.put("image/webp", ".webp");
        allowedImageTypes.put("image/bmp", ".bmp");

        String contentType = filePart.getContentType();
        String ext = allowedImageTypes.get(contentType);

        if (ext == null) {
            return null;
        }

        // Tạo thư mục lưu nếu chưa tồn tại (sử dụng Files.createDirectories)
        String uploadBaseDir= Dotenv.load().get("UPLOAD_FILE_PATH");
        Path uploadPath = Paths.get(uploadBaseDir, subFolder);
        Files.createDirectories(uploadPath); // Sẽ tạo thư mục nếu chưa có và không ném ngoại lệ nếu đã tồn tại

        // Tên file mới bằng UUID
        String newFileName = UUID.randomUUID().toString() + ext;

        // Lưu file lên disk
        Path filePath = uploadPath.resolve(newFileName);
        filePart.write(filePath.toString());

        return newFileName;
    }
}
