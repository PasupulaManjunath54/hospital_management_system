package display_all_records;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_management.DatabaseConnectivity;

@WebServlet("/DisplayAllDoctors")
public class DisplayAllDoctors extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter pw = resp.getWriter();
        Connection conn = DatabaseConnectivity.getConnection();

        pw.println("<html>");
        pw.println("<head>");
        pw.println("<title>All Doctors</title>");
        pw.println("<style>");
        pw.println("body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #eef3f7; padding: 20px; }");
        pw.println("h1.title { text-align: center; color: #222; margin-bottom: 30px; }");
        pw.println(".doctor-card { background: #ffffff; padding: 25px; margin: 20px auto; border-radius: 12px; box-shadow: 0 6px 16px rgba(0,0,0,0.1); width: 60%; }");
        pw.println(".doctor-card h2 { font-size: 18px; margin: 8px 0; color: #333; }");
        pw.println(".btn { display: inline-block; padding: 10px 16px; background-color: #2e7d32; color: white; text-decoration: none; border-radius: 8px; margin-right: 10px; font-size: 14px; border: none; cursor: pointer; }");
        pw.println(".btn:hover { background-color: #1b5e20; }");
        pw.println("</style>");
        pw.println("</head>");
        pw.println("<body>");
        pw.println("<h1 class='title'>All Doctor Records</h1>");

        try {
            PreparedStatement ps = conn.prepareStatement("select * from doctor");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pw.println("<div class='doctor-card'>");
                pw.println("<h2>Doctor ID: " + rs.getInt(1) + "</h2>");
                pw.println("<h2>Doctor Name: " + rs.getString(2) + "</h2>");
                pw.println("<h2>Specialty: " + rs.getString(3) + "</h2>");
                pw.println("<h2>Salary: ₹" + rs.getInt(4) + "</h2>");
                pw.println("<h2>Phone: " + rs.getLong(5) + "</h2>");
                pw.println("<a class='btn' href='./UpdateDoctor.jsp'>Edit</a>");
                pw.println("<a class='btn' href='./DeleteDoctor.jsp'>Delete</a>");
                pw.println("</div>");
            }
        } catch (SQLException e) {
            pw.println("<div style='text-align: center; color: red; font-weight: bold;'>SQL Exception: " + e.getMessage() + "</div>");
        }

        pw.println("</body>");
        pw.println("</html>");
    }
}
