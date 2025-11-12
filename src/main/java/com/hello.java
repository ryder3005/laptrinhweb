package com;
import java.io.*;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

public class hello extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String username = req.getParameter("username");

        PrintWriter out = resp.getWriter();
        out.println("<h1>Hello from Java Servlet!</h1>");
    }
}
