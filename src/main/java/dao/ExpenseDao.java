package dao;

import java.sql.*;
import java.util.*;
import model.Expense;

public class ExpenseDao {

    // Save a new expense
    public static boolean saveExpense(Connection conn, Expense expense) {
        boolean success = false;
        PreparedStatement ps = null;

        try {
            String sql = "INSERT INTO expense(title, date, description, price, user_id) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, expense.getTitle());
            ps.setString(2, expense.getDate());
            ps.setString(3, expense.getDescription());
            ps.setDouble(4, expense.getPrice());
            ps.setInt(5, expense.getUserId());

            int rows = ps.executeUpdate();
            success = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return success;
    }

    // Get all expenses for a specific user
    public static List<Expense> getAllExpensesByUserId(Connection conn, int userId) {
        List<Expense> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM expense WHERE user_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Expense ex = new Expense();
                ex.setId(rs.getInt("id"));
                ex.setTitle(rs.getString("title"));
                ex.setDescription(rs.getString("description"));
                ex.setDate(rs.getString("date"));
                ex.setPrice(rs.getDouble("price"));
                ex.setUserId(rs.getInt("user_id"));
                list.add(ex);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return list;
    }

    // Get a single expense by ID
    public static Expense getExpenseById(Connection conn, int id) {
        Expense ex = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM expense WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                ex = new Expense();
                ex.setId(rs.getInt("id"));
                ex.setTitle(rs.getString("title"));
                ex.setDescription(rs.getString("description"));
                ex.setDate(rs.getString("date"));
                ex.setPrice(rs.getDouble("price"));
                ex.setUserId(rs.getInt("user_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return ex;
    }

    // Update an existing expense
    public static boolean updateExpense(Connection conn, Expense ex) {
        boolean success = false;
        PreparedStatement ps = null;

        try {
            String sql = "UPDATE expense SET title = ?, description = ?, date = ?, price = ? WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, ex.getTitle());
            ps.setString(2, ex.getDescription());
            ps.setString(3, ex.getDate());
            ps.setDouble(4, ex.getPrice());
            ps.setInt(5, ex.getId());

            int i = ps.executeUpdate();
            success = (i == 1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return success;
    }
    public static boolean deleteExpenseById(Connection conn, int id) {
        boolean success = false;
        try {
            String sql = "DELETE FROM expense WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int i = ps.executeUpdate();
            success = i == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
    public static List<Expense> getExpensesByMonth(Connection conn, int userId, String month, int year) throws SQLException {
        List<Expense> list = new ArrayList<>();
        String sql = "SELECT * FROM expense WHERE user_id = ? AND MONTHNAME(date) = ? AND YEAR(date) = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setString(2, month);
        ps.setInt(3, year);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Expense e = new Expense();
            e.setId(rs.getInt("id"));
            e.setTitle(rs.getString("title"));
            e.setDescription(rs.getString("description"));
            e.setDate(rs.getDate("date").toString());
            e.setPrice(rs.getDouble("price"));
            e.setUserId(rs.getInt("user_id"));
            list.add(e);
        }
        return list;
    }
}

