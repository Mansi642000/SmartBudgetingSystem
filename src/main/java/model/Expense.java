package model;

public class Expense {
	
	private int id;
    private String title;
    private String date;
    private String description;
    private double price;
    private int userId;
	public Expense() {
		super();
		
	}
	public Expense(String title, String date, String description, double price, int userId) {
		super();
		this.title = title;
		this.date = date;
		this.description = description;
		this.price = price;
		this.userId = userId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
}
