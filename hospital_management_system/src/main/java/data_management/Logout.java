package data_management;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/logout")
public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(); // fetch session if exists
        if (session != null) {
            session.invalidate(); // end the session
            RequestDispatcher rd = req.getRequestDispatcher("index.html");
            rd.forward(req, resp);
        }

        
    }
}
