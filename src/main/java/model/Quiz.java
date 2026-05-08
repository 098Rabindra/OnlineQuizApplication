package model;

public class Quiz {

    private int id;
    private String title;

    // 🔹 Default constructor
    public Quiz() {}

    // 🔹 Parameterized constructor
    public Quiz(int id, String title) {
        this.id = id;
        this.title = title;
    }

    // 🔹 Getter & Setter
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

    // 🔹 toString (useful for debugging)
    @Override
    public String toString() {
        return "Quiz{id=" + id + ", title='" + title + "'}";
    }
}