package eadassignment2.model;

import java.sql.*;
import java.util.*;

public class producttypeDB {
	
	public ArrayList<producttype> dropListProductTypeName(){
		
		ArrayList<producttype> dropListElement = new ArrayList<producttype>();
		Connection conn = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://mysql/eadassignment?user=root&password=will12345";
			conn = DriverManager.getConnection(connURL);
			
			String Qstmt_dropListProductTypeName = "SELECT * FROM product_type";
			
			PreparedStatement Pstmt_dropListProductTypeName = conn.prepareStatement(Qstmt_dropListProductTypeName);
			
			ResultSet rs_dropListProductTypeName = Pstmt_dropListProductTypeName.executeQuery();
			
			while(rs_dropListProductTypeName.next()){
				producttype producttypeValue = new producttype();
				producttypeValue.setType_id(rs_dropListProductTypeName.getInt("type_id"));
				producttypeValue.setType_name(rs_dropListProductTypeName.getString("type_name"));
				
				dropListElement.add(producttypeValue);
			}
			
			conn.close();
			return dropListElement;
			
		}catch(Exception err){
			return null;
		}
		
	}

}
