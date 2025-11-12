package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection conn;
    private static final String USERNAME = "root";
    private static final String PASSWORD = "phuthinh";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quanlybanhang";

    // Hàm trả về đối tượng Connection
    public static Connection getDBConnection() throws SQLException {
        if (conn == null || conn.isClosed()) {
            try {
                // Nạp driver MySQL
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());

                // Kết nối đến database
                conn = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
                System.out.println("Kết nối MySQL thành công!");
            } catch (SQLException e) {
                System.err.println("Lỗi kết nối CSDL: " + e.getMessage());
                throw e; // ném lỗi ra để lớp khác biết
            }
        }
        return conn;
    }

    // Đóng kết nối
    public static void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Đã đóng kết nối MySQL!");
            }
        } catch (SQLException e) {
            System.err.println(" Lỗi khi đóng kết nối: " + e.getMessage());
        }
    }
//    public  static void main (String[] args) {
//        try {
//
//            Connection c=getDBConnection();
//            if (c == null) {
//                System.out.println("wrong");
//            }
//            else{
//                System.out.println("ok");
//            }
//        }catch(Exception e) {
//            e.printStackTrace();
//        }
//    }
}
