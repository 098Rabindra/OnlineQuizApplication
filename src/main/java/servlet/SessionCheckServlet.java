package servlet;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SessionCheckServlet")
public class SessionCheckServlet extends HttpServlet {
	   private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);

        if(session == null ||
           session.getAttribute("user") == null){

            response.getWriter().write("invalid");
        }
        else{
            response.getWriter().write("valid");
        }
    }
}