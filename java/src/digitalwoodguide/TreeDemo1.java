package digitalwoodguide;

public class TreeDemo1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Tree t = new Tree();
		t.setType("Birch");
		t.setFamily("Common");
		t.setLocation("Canada", "Toronto");
		t.setImage("example.jpg");
		t.addNote("This is a demo tree object");
		t.addNote("This is a second note that was added");
		t.detailDescription();
	}

}
