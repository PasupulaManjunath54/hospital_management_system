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

@WebServlet("/DisplayAllPatients")
public class DisplayAllPatients extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter pw = resp.getWriter();
		Connection conn = DatabaseConnectivity.getConnection();

		pw.println("<html>");
		pw.println("<head>");
		pw.println("<title>All Patients</title>");
		pw.println("<style>");
		pw.println("body { font-family: Arial, sans-serif; background-color: #f4f7f9; padding: 20px; }");
		pw.println(".patient-card { background: white; padding: 20px; margin: 20px auto; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 60%; }");
		pw.println("h1 { font-size: 20px; color: #333; }");
		pw.println(".btn { margin: 10px 5px 0 0; padding: 10px 18px; border: none; border-radius: 8px; background-color: #1976d2; color: white; cursor: pointer; font-size: 14px; text-decoration: none; }");
		pw.println(".btn:hover { background-color: #125a9c; }");
		pw.println("</style>");
		pw.println("</head>");
		pw.println("<body>");
		pw.println("<h1 style='text-align:center;'>All Patient Records</h1>");

		try {
			PreparedStatement ps = conn.prepareStatement("select * from patient");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				pw.println("<div class='patient-card'>");
				pw.println("<h1>Patient Name: " + rs.getString(2) + "</h1>");
				pw.println("<h1>Patient Age: " + rs.getInt(3) + "</h1>");
				pw.println("<h1>Patient Disease: " + rs.getString(4) + "</h1>");
				pw.println("<h1>Doctor ID: " + rs.getInt(5) + "</h1>");
				pw.println("<a class='btn' href='./UpdatePatient.jsp'>Edit</a>");
				pw.println("<a class='btn' href='./DeletePatient.jsp'>Delete</a>");
				pw.println("</div>");
			}
		} catch (SQLException e) {
			pw.println("<div style='color: red; font-weight: bold;'>SQL Exception: " + e.getMessage() + "</div>");
		}

		pw.println("</body>");
		pw.println("</html>");
	}
}
