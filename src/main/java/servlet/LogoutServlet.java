package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private void processLogout(HttpServletRequest request,
                               HttpServletResponse response)
            throws IOException {

        // ================= DESTROY SESSION =================
        HttpSession session =
                request.getSession(false);

        if (session != null) {

            session.invalidate();
        }

        // ================= PREVENT CACHE =================
        response.setHeader("Cache-Control",
                "no-cache, no-store, must-revalidate");

        response.setHeader("Pragma", "no-cache");

        response.setDateHeader("Expires", 0);

        // ================= REDIRECT =================
        response.sendRedirect("login.html");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        processLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        processLogout(request, response);
    }
}