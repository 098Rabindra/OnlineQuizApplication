package servlet;

import db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Leaderboard</title>");

        out.println("<style>");
        out.println("body { font-family:'Segoe UI'; background:linear-gradient(135deg,#43cea2,#185a9d); display:flex; justify-content:center; align-items:center; height:100vh; margin:0; }");
        out.println(".container { background:#fff; padding:30px; border-radius:12px; width:500px; box-shadow:0 10px 25px rgba(0,0,0,0.2); text-align:center; }");
        out.println("h2 { margin-bottom:20px; }");
        out.println("table { width:100%; border-collapse:collapse; margin-top:10px; }");
        out.println("th, td { padding:12px; border-bottom:1px solid #ddd; text-align:center; }");
        out.println("th { background:#185a9d; color:white; }");
        out.println("tr:hover { background:#f5f5f5; }");
        out.println(".btn { margin-top:20px; padding:10px; width:100%; border:none; border-radius:8px; background:#43cea2; color:white; cursor:pointer; }");
        out.println("</style>");

        out.println("</head><body>");
        out.println("<div class='container'>");

        out.println("<h2>User Leaderboard</h2>");
        out.println("<table>");
        out.println("<tr><th>Rank</th><th>Username</th><th>Score</th></tr>");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT username, SUM(score) AS totalScore FROM results GROUP BY username ORDER BY totalScore DESC";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            int rank = 1;
            boolean hasData = false;

            while (rs.next()) {
                hasData = true;

                out.println("<tr>");
                out.println("<td>" + rank++ + "</td>");
                out.println("<td>" + rs.getString("username") + "</td>");
                out.println("<td>" + rs.getInt("totalScore") + "</td>");
                out.println("</tr>");
            }

            // ✅ If no data
            if (!hasData) {
                out.println("<tr>");
                out.println("<td colspan='3'>No records found</td>");
                out.println("</tr>");
            }

        } catch (Exception e) {
            out.println("<tr><td colspan='3'>Error loading data</td></tr>");
        }

        out.println("</table>");
        out.println("<button class='btn' onclick=\"location.href='dashboard.jsp'\">Back</button>");
        out.println("</div></body></html>");
    }
}