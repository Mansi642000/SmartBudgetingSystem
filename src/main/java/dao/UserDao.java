package dao;

import java.sql.*;
import model.User;
import util.DBConnection;

public class UserDao {
	public static boolean registerUser(User u) {
				try (Connection conn = DBConnection.getConnection()) {
	            String sql = "INSERT INTO users(name, email, password) VALUES (?, ?, ?)";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, u.getName());
	            ps.setString(2, u.getEmail());
	            ps.setString(3, u.getPassword());
	            return ps.executeUpdate() > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

	    public static User login(String email, String password) {
	        try (Connection conn = DBConnection.getConnection()) {
	            String sql = "SELECT * FROM users WHERE email=? AND password=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, email);
	            ps.setString(2, password);
	            ResultSet rs = ps.executeQuery();
	            if (rs.next()) {
	                User u = new User();
	                u.setId(rs.getInt("id"));
	                u.setName(rs.getString("name"));
	                u.setEmail(email);
	                return u;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return null;
	    }
	    public static boolean isUserExists(String email) {
	        try (Connection conn = DBConnection.getConnection()) {
	            String sql = "SELECT id FROM users WHERE email=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, email);
	            ResultSet rs = ps.executeQuery();
	            return rs.next();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

}
