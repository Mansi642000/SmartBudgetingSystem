package model;

public class Budget {
	private int id;
	private int userId;
	private String month;
	private int year;
	private double amount;
	public Budget() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Budget(int userId, String month, int year, double amount) {
		super();
		this.userId = userId;
		this.month = month;
		this.year = year;
		this.amount = amount;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
}
