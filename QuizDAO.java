package dao;

import db.DBConnection;
import model.Question;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO {

    // 🔹 Get all quizzes
    public List<String> getAllQuizzes() throws Exception {
        List<String> quizzes = new ArrayList<>();

        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery("SELECT title FROM questions");

        while (rs.next()) {
            quizzes.add(rs.getString("title"));
        }

        return quizzes;
    }

    // 🔹 Get questions by quiz ID
    public List<Question> getQuestionsByQuiz(int quizId) throws Exception {
        List<Question> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM questions"
        );

        ps.setInt(1, quizId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Question q = new Question();

            q.id = rs.getInt("id");
            q.question = rs.getString("question");
            q.o1 = rs.getString("option1");
            q.o2 = rs.getString("option2");
            q.o3 = rs.getString("option3");
            q.o4 = rs.getString("option4");
            q.correct = rs.getInt("correct");

            list.add(q);
        }

        return list;
    }

    // 🔹 Add new quiz (Admin)
    public void addQuiz(String title) throws Exception {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO questions(title) VALUES(?)"
        );

        ps.setString(1, title);
        ps.executeUpdate();
    }
    
    // 🔹 Delete quiz
    public void deleteQuiz(int id) throws Exception {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM questions WHERE id=?"
        );

        ps.setInt(1, id);
        ps.executeUpdate();
    }
}