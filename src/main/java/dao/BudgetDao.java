package dao;

import java.sql.*;
import model.Budget;


public class BudgetDao {

	public static boolean setOrUpdateBudget(Connection conn, Budget budget) throws SQLException {
        String checkSql = "SELECT id FROM budget WHERE user_id=? AND month=? AND year=?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setInt(1, budget.getUserId());
        checkStmt.setString(2, budget.getMonth());
        checkStmt.setInt(3, budget.getYear());

        ResultSet rs = checkStmt.executeQuery();
        if (rs.next()) {
            // Update existing
            int id = rs.getInt("id");
            String updateSql = "UPDATE budget SET amount=? WHERE id=?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setDouble(1, budget.getAmount());
            updateStmt.setInt(2, id);
            return updateStmt.executeUpdate() > 0;
        } else {
            // Insert new
            String insertSql = "INSERT INTO budget (user_id, month, year, amount) VALUES (?, ?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setInt(1, budget.getUserId());
            insertStmt.setString(2, budget.getMonth());
            insertStmt.setInt(3, budget.getYear());
            insertStmt.setDouble(4, budget.getAmount());
            return insertStmt.executeUpdate() > 0;
        }
    }

    public static Budget getCurrentMonthBudget(Connection conn, int userId, String month, int year) throws SQLException {
        String sql = "SELECT * FROM budget WHERE user_id=? AND month=? AND year=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setString(2, month);
        ps.setInt(3, year);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Budget budget = new Budget();
            budget.setId(rs.getInt("id"));
            budget.setUserId(rs.getInt("user_id"));
            budget.setMonth(rs.getString("month"));
            budget.setYear(rs.getInt("year"));
            budget.setAmount(rs.getDouble("amount"));
            return budget;
        }
        return null;
    }
}