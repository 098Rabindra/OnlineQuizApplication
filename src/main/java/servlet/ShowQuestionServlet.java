package servlet;

import db.DBConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/ShowQuestionServlet")
public class ShowQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> questions = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM questions")) {

            while (rs.next()) {
                Map<String, String> q = new HashMap<>();

                q.put("id", String.valueOf(rs.getInt("id")));
                q.put("question", rs.getString("question"));
                q.put("opt1", rs.getString("option1"));
                q.put("opt2", rs.getString("option2"));
                q.put("opt3", rs.getString("option3"));
                q.put("opt4", rs.getString("option4"));
                q.put("answer", rs.getString("answer"));
                questions.add(q);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("questions", questions);

        RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
        rd.forward(request, response);
    }
}