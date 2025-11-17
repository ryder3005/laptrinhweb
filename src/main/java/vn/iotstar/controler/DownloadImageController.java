package vn.iotstar.controler;

import com.google.api.client.util.IOUtils;
import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Dotenv dotenv = Dotenv.load();
        String UPLOAD_FILE_PATH = dotenv.get("UPLOAD_FILE_PATH");
        String fileName = req.getParameter("fname");
        File file = new File(UPLOAD_FILE_PATH + "/" + fileName);
        resp.setContentType("image/jpeg");
        if (file.exists()) {
            IOUtils.copy(new FileInputStream(file), resp.getOutputStream());

        }
    }
}
