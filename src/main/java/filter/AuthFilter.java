package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getServletPath();

        // ✅ Add cache control (VERY IMPORTANT)
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        // ✅ PUBLIC ROUTES (ONLY AUTH PAGES + STATIC)
        if (path.equals("/login.html") ||
            path.equals("/register.html") ||
            path.equals("/LoginServlet") ||
            path.equals("/RegisterServlet") ||
            path.equals("/logout") ||
            path.startsWith("/css/") ||
            path.startsWith("/js/") ||
            path.startsWith("/images/") ||
            path.endsWith(".css") ||
            path.endsWith(".js") ||
            path.endsWith(".png") ||
            path.endsWith(".jpg") ||
            path.endsWith(".jpeg")) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        // ❌ Not logged in
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.html");
            return;
        }

        String role = (String) session.getAttribute("role");

        // ✅ ADMIN PROTECTION
        if ((path.contains("admin.jsp") ||
             path.contains("UserListServlet") ||
             path.contains("ShowQuestionServlet") ||
             path.contains("DeleteQuestionServlet") ||
             path.contains("UpdateQuestionServlet") ||
             path.contains("GetQuestionByIdServlet"))
            && !"admin".equals(role)) {

            res.sendRedirect(req.getContextPath() + "/login.html");
            return;
        }

        // ✅ USER PROTECTION (optional, for dashboard)
        if (path.contains("dashboard.jsp") && role == null) {
            res.sendRedirect(req.getContextPath() + "/login.html");
            return;
        }

        chain.doFilter(request, response);
    }
}