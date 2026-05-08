package servlet;

import db.DBConnection;
import dao.ResultDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/SubmitQuizServlet")
public class SubmitQuizServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int score = 0;
        int total = 0;

        try {

            String user = (String) req.getSession().getAttribute("user");

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT id, answer FROM questions");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                total++;

                String questionId = rs.getString("id");

                String correctAnswer = rs.getString("answer");

                // User selected answer
                String userAnswer = req.getParameter("q" + questionId);

                if (userAnswer != null &&
                        userAnswer.equalsIgnoreCase(correctAnswer)) {

                    score++;
                }
            }

            // Save Result
            new ResultDAO().save(user, total, score);

            // Send result to JSP
            req.setAttribute("score", score);
            req.setAttribute("total", total);

            req.getRequestDispatcher("result.jsp")
                    .forward(req, res);

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            res.getWriter().println("Error : " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        doPost(req, res);
    }
}