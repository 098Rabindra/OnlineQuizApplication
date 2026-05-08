package model;

public class User {
	private String name;
    private String username;
    private String password;

    public User(String n,String u, String p) {
        this.name = n;
    	this.username = u;
        this.password = p;
    }

    public String name() {return name; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }
}