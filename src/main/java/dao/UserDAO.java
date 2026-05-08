package dao;

import java.sql.*;
import db.DBConnection;
import util.PasswordUtil;

public class UserDAO {

    // USER LOGIN
    public boolean userLogin(String username, String password) throws Exception {

        String sql = "SELECT 1 FROM users WHERE username=? AND password=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, PasswordUtil.hash(password));

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // USER EXISTS
    public boolean userExists(String username) throws Exception {

        String sql = "SELECT 1 FROM users WHERE username=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ADMIN LOGIN
    public boolean adminLogin(String username, String password) throws Exception {

        String sql = "SELECT 1 FROM admin WHERE username=? AND password=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, PasswordUtil.hash(password)); 

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}