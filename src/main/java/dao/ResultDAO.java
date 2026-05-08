package dao;

import db.DBConnection;
import java.sql.*;

public class ResultDAO {

    public void save(String user, int quizId, int score) throws Exception {

        Connection con = DBConnection.getConnection();

        // Check existing user
        PreparedStatement check = con.prepareStatement(
            "SELECT * FROM results WHERE username=?"
        );

        check.setString(1, user);

        ResultSet rs = check.executeQuery();

        if(rs.next()){

            // UPDATE SCORE
            PreparedStatement update = con.prepareStatement(
                "UPDATE results SET score=?, quiz_id=? WHERE username=?"
            );

            update.setInt(1, score);
            update.setInt(2, quizId);
            update.setString(3, user);

            update.executeUpdate();

        }else{

            // INSERT NEW
            PreparedStatement insert = con.prepareStatement(
                "INSERT INTO results(username, quiz_id, score) VALUES(?,?,?)"
            );

            insert.setString(1, user);
            insert.setInt(2, quizId);
            insert.setInt(3, score);

            insert.executeUpdate();
        }

        con.close();
    }
}