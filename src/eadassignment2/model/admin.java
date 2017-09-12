package eadassignment2.model;

public class admin {

	private String admin_id;
	private String admin_pass;
	
	public admin(String admin_id, String admin_pass) {
		super();
		this.admin_id = admin_id;
		this.admin_pass = admin_pass;
	}
	
	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getAdmin_pass() {
		return admin_pass;
	}

	public void setAdmin_pass(String admin_pass) {
		this.admin_pass = admin_pass;
	}	
	
}
