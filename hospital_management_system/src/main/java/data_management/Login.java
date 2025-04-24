package data_management;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("email");
        String password = req.getParameter("password");

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        try {
            Connection conn = DatabaseConnectivity.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM staff WHERE staff_email=? AND staff_password=?");
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                out.println("<h1>Login Successful. Welcome, " + username + "!</h1>");
                 HttpSession session = req.getSession();
                 session.setAttribute("id", rs.getInt(1));
                 session.setAttribute("name", rs.getString(2));
                 session.setAttribute("email", rs.getString(3));
                 session.setAttribute("phno", rs.getLong(4));
                 session.setAttribute("password", rs.getString(5));

                 RequestDispatcher rd = req.getRequestDispatcher("HomePage.jsp");
                 rd.forward(req, resp);
            } else {
                out.println("<h1 style='color:red;'>Login Failed. Invalid credentials.</h1>");
            }
        } catch (SQLException e) {
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
        }
    }
}
