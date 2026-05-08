package servlet;

import db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/UpdateQuestionServlet")
public class UpdateQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");

        try {
            // 🔥 VALIDATE ID
            String idParam = request.getParameter("id");
            String answerParam = request.getParameter("answer");

            if (idParam == null || idParam.isEmpty() ||
                answerParam == null || answerParam.isEmpty()) {

                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("Missing required fields");
                return;
            }

            int id = Integer.parseInt(idParam);
            String answer = answerParam;
            
            // 🔥 GET OTHER FIELDS (SAFE)
            String question = request.getParameter("question");
            String o1 = request.getParameter("o1");
            String o2 = request.getParameter("o2");
            String o3 = request.getParameter("o3");
            String o4 = request.getParameter("o4");

            // Optional: null safety
            if (question == null) question = "";
            if (o1 == null) o1 = "";
            if (o2 == null) o2 = "";
            if (o3 == null) o3 = "";
            if (o4 == null) o4 = "";

            // 🔥 DB UPDATE
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                         "UPDATE questions SET question=?, option1=?, option2=?, option3=?, option4=?, answer=? WHERE id=?"
                 )) {

                ps.setString(1, question);
                ps.setString(2, o1);
                ps.setString(3, o2);
                ps.setString(4, o3);
                ps.setString(5, o4);
                ps.setString(6, answer);
                ps.setInt(7, id);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    response.getWriter().print("success");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().print("No record found");
                }
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("Invalid number format");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("Server error");
        }
    }
}