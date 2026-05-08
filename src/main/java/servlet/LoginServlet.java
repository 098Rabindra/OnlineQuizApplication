package servlet;

import javax.servlet.annotation.WebServlet;
import dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String user = req.getParameter("username").trim();
            String pass = req.getParameter("password").trim();

            UserDAO dao = new UserDAO();
            HttpSession session = req.getSession();
            String context = req.getContextPath();

            // 🔹 ADMIN LOGIN
            if (dao.adminLogin(user, pass)) {
                session.setAttribute("user", user);
                session.setAttribute("role", "admin");

                res.sendRedirect(context + "/admin.jsp?login=success&user=" 
                        + user + "&role=admin");
                return;
            }

            // 🔹 CHECK USER EXISTS
            if (!dao.userExists(user)) {
                res.sendRedirect(context + "/login.html?error=user");
                return;
            }

            // 🔹 CHECK PASSWORD
            if (!dao.userLogin(user, pass)) {
                res.sendRedirect(context + "/login.html?error=pass");
                return;
            }

            // 🔹 SUCCESS USER LOGIN
            session.setAttribute("user", user);
            session.setAttribute("role", "user");

            res.sendRedirect(context + "/dashboard.jsp?login=success");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/login.html?error=server");
        }
    }
}