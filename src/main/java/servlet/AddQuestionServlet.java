package servlet;

import db.DBConnection;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        try {

            String question = request.getParameter("question");
            String o1 = request.getParameter("o1");
            String o2 = request.getParameter("o2");
            String o3 = request.getParameter("o3");
            String o4 = request.getParameter("o4");
            String correct = request.getParameter("correct");

            // Validation
            if (question == null || o1 == null || o2 == null ||
                o3 == null || o4 == null || correct == null ||
                question.trim().isEmpty() || o1.trim().isEmpty() ||
                o2.trim().isEmpty() || o3.trim().isEmpty() ||
                o4.trim().isEmpty() || correct.trim().isEmpty()) {

                out.write("All fields required");
                return;
            }

            // Convert to uppercase
            correct = correct.toUpperCase();

            // Allow only A/B/C/D
            if (!correct.equals("A") &&
                !correct.equals("B") &&
                !correct.equals("C") &&
                !correct.equals("D")) {

                out.write("Invalid correct answer");
                return;
            }

            try (
                Connection con = DBConnection.getConnection();

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO questions(question, option1, option2, option3, option4, answer) VALUES (?, ?, ?, ?, ?, ?)"
                )
            ) {

                ps.setString(1, question);
                ps.setString(2, o1);
                ps.setString(3, o2);
                ps.setString(4, o3);
                ps.setString(5, o4);

                // Store A/B/C/D as String
                ps.setString(6, correct);

                int row = ps.executeUpdate();

                if (row > 0) {
                    out.write("success");
                } else {
                    out.write("failed");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            out.write("error");
        }
    }
}