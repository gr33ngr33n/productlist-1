package eadassignment2.model;

import java.sql.*;

public class adminDB {

	public admin adminLoginCheck(String adminUserId, String adminPassword){
	
		Connection conn = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://172.30.214.228:3306/eadassignment?user=root&password=will12345";
			conn = DriverManager.getConnection(connURL);
			
			//query to check admin login
			String Qstmt_adminLogin = "SELECT * FROM admin WHERE admin_id=? AND admin_pass=?";
		
			PreparedStatement Pstmt_adminLogin = conn.prepareStatement(Qstmt_adminLogin);
			
			//get resultset for admin login
			Pstmt_adminLogin.setString(1, adminUserId);
			Pstmt_adminLogin.setString(2, adminPassword);
			ResultSet rs_adminLogin = Pstmt_adminLogin.executeQuery();
			
			if(rs_adminLogin.next()){
				admin adminFound = new admin(rs_adminLogin.getString("admin_id"), rs_adminLogin.getString("admin_pass"));				
				conn.close();
				return adminFound;
			}else{
				conn.close();
				return null;
			}
			
		}catch(Exception err){
			return null;
		}
		
	}
	
}
