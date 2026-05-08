package servlet;

import db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/GetQuestionByIdServlet")
public class GetQuestionByIdServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM questions WHERE id=?"
            );

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute("editId", rs.getInt("id"));
                request.setAttribute("editQuestion", rs.getString("question"));
                request.setAttribute("editOpt1", rs.getString("option1"));
                request.setAttribute("editOpt2", rs.getString("option2"));
                request.setAttribute("editOpt3", rs.getString("option3"));
                request.setAttribute("editOpt4", rs.getString("option4"));
                request.setAttribute("editAnswer", rs.getString("answer"));

            }

            // show add/edit section
            request.setAttribute("editMode", true);

            request.getRequestDispatcher("admin.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}