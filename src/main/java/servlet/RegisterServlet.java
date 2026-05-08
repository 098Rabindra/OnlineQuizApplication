package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

import db.DBConnection;
import util.PasswordUtil;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String name = req.getParameter("name");
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            // ================= BASIC VALIDATION =================
            if (name == null || username == null || password == null ||
                name.trim().isEmpty() || username.trim().isEmpty() || password.trim().isEmpty()) {

                res.sendRedirect("register.html?error=empty");
                return;
            }

            name = name.trim();
            username = username.trim();
            password = password.trim();

            // ================= ADVANCED VALIDATION =================

            if (!name.matches("^[A-Z][a-z]+( [A-Z][a-z]+)*$")) {
                res.sendRedirect("register.html?error=name");
                return;
            }

            if (!username.matches("^[A-Za-z]{8,}$")) {
                res.sendRedirect("register.html?error=username");
                return;
            }

            if (password.length() < 8) {
                res.sendRedirect("register.html?error=password");
                return;
            }

            try (Connection con = DBConnection.getConnection()) {

                // ================= CHECK DUPLICATE =================
                PreparedStatement check = con.prepareStatement(
                        "SELECT id FROM users WHERE username=?");
                check.setString(1, username);

                ResultSet rs = check.executeQuery();
                if (rs.next()) {
                    res.sendRedirect("register.html?error=exists");
                    return;
                }

                // ================= INSERT USER =================
                String hashedPassword = PasswordUtil.hash(password);

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO users(name, username, password) VALUES(?, ?, ?)");

                ps.setString(1, name);
                ps.setString(2, username);
                ps.setString(3, hashedPassword);

                int i = ps.executeUpdate();

                // ================= SUCCESS =================
                if (i > 0) {
                    res.sendRedirect("login.html?registered=1");
                } else {
                    res.sendRedirect("register.html?error=failed");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("register.html?error=server");
        }
    }
}