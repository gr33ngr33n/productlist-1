package eadassignment2.model;

import java.sql.*;
import java.util.ArrayList;

public class electronicproductDB {
	
	//search or view product
	public ArrayList<electronicproduct> viewProduct(String searchName, String searchBrand, String searchType, String searchMaxPrice){
		
		ArrayList<electronicproduct> searchResult = new ArrayList<electronicproduct>();
		Connection conn = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://172.30.214.228:3306/eadassignment?user=root&password=will12345";
			conn = DriverManager.getConnection(connURL);
			
			//query to load all product type into table
			String Qstmt_productTypeName = "SELECT * FROM product_type WHERE type_id=?";
			//query to filter max price of product
			String Qstmt_productMaxPrice = "SELECT MAX(price) 'max_price' FROM electronic_product";
			//query to load/search products
			String Qstmt_electronicProduct;
			if(searchName!=null && !searchType.equalsIgnoreCase("all")){
				Qstmt_electronicProduct = "SELECT * FROM electronic_product WHERE " + 
						"name LIKE '%" + searchName + "%' AND brand LIKE '%" + searchBrand + "%' AND " +
						"type_id=" + Integer.parseInt(searchType) + " AND " +
						"price<= " + Integer.parseInt(searchMaxPrice) + "";
			}
			else{
				if(searchMaxPrice!=null){
					Qstmt_electronicProduct = "SELECT * FROM electronic_product WHERE " + 
							"name LIKE '%" + searchName + "%' AND brand LIKE '%" + searchBrand + "%' AND " +
							"price<= " + Integer.parseInt(searchMaxPrice) + "";
				}
				else{
					Qstmt_electronicProduct = "SELECT * FROM electronic_product";
				}
			}
			
			
			PreparedStatement Pstmt_productTypeName = conn.prepareStatement(Qstmt_productTypeName);
			PreparedStatement Pstmt_productMaxPrice = conn.prepareStatement(Qstmt_productMaxPrice);
			PreparedStatement Pstmt_electronicProduct = conn.prepareStatement(Qstmt_electronicProduct);
			
			
			//get resultset for product max price
			ResultSet rs_productMaxPrice = Pstmt_productMaxPrice.executeQuery();
			//execute query to display electronic product data
			ResultSet rs_electronicProduct = Pstmt_electronicProduct.executeQuery();
			
			
			//view data of electronic_product table
			while(rs_electronicProduct.next()){
			//execute query to filter type_name from table product_type
			Pstmt_productTypeName.setInt(1, rs_electronicProduct.getInt("type_id"));
			ResultSet rs_productTypeName = Pstmt_productTypeName.executeQuery();
			rs_productTypeName.next();
			
			electronicproduct searchResult_itemData = new electronicproduct();
			searchResult_itemData.setProduct_id(rs_electronicProduct.getInt("product_id"));
			searchResult_itemData.setName(rs_electronicProduct.getString("name"));
			//searchResult_itemData.setType_id(rs_productTypeName.getString("type_name"));
			searchResult_itemData.setPicture_name(rs_electronicProduct.getString("picture_name"));
			searchResult_itemData.setBrand(rs_electronicProduct.getString("brand"));
			searchResult_itemData.setPrice(rs_electronicProduct.getInt("price"));
			searchResult_itemData.setDescription(rs_electronicProduct.getString("description"));
			
			searchResult.add(searchResult_itemData);
			
			}
			
			conn.close();
			return searchResult;
			
		}catch(Exception err){
			return null;
		}		
		
	}
	
	//execute add product
	public int addProduct(String addName, String addType, String addPicName, String addBrand, String addPrice, String addDesc){
		
		int addOutput = 0;
		Connection conn = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://mysql/eadassignment?user=root&password=will12345";
			conn = DriverManager.getConnection(connURL);
			
			//query to add product
			String Qstmt_addElectronicProduct = "INSERT INTO electronic_product(name,type_id,picture_name,brand," + 
					"price,description) VALUES(?,?,?,?,?,?)";
			PreparedStatement Pstmt_addElectronicProduct = conn.prepareStatement(Qstmt_addElectronicProduct);
			
			//if data is not null, execute add product
			if(addName!=null){
				Pstmt_addElectronicProduct.setString(1, addName);
				Pstmt_addElectronicProduct.setInt(2, Integer.parseInt(addType));
				Pstmt_addElectronicProduct.setString(3, addPicName);
				Pstmt_addElectronicProduct.setString(4, addBrand);
				Pstmt_addElectronicProduct.setInt(5, Integer.parseInt(addPrice));
				Pstmt_addElectronicProduct.setString(6, addDesc);
				
				addOutput = Pstmt_addElectronicProduct.executeUpdate();
			}
			
			conn.close();
			return addOutput;
			
		}catch(Exception err){
			return 0;
		}
		
	}
	
	//execute delete product
	public int deleteProduct(String[] itemSelect){
		
		int countItemSelect = 0;
		int delOutput = 0;
		
		/* if no item is selected, return 0 */
		if(itemSelect!=null){
			countItemSelect = itemSelect.length; /* to count number of selected items */
		}else{
			return 0;
		}
		
		Connection conn = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://mysql/eadassignment?user=root&password=will12345";
			conn = DriverManager.getConnection(connURL);
			
			String Qstmt_delProduct = "DELETE FROM electronic_product WHERE product_id IN(";
			for(int i=0; i<countItemSelect; i++){
				if(i==(countItemSelect-1))
					Qstmt_delProduct += "?)";
				else
					Qstmt_delProduct += "?,";
			}
			
			PreparedStatement Pstmt_delProduct = conn.prepareStatement(Qstmt_delProduct);
			for(int i=0; i<countItemSelect; i++){
				Pstmt_delProduct.setInt(i+1, Integer.parseInt(itemSelect[i]));
			}
			
			/* just for safety purpose, one more layer of filtering is added */
			if(itemSelect!=null){
				delOutput = Pstmt_delProduct.executeUpdate();
			}
			
			conn.close();
			return delOutput;
		}catch(Exception err){
			return 0;
		}
		
	}
	
	//view edit product page(a1EditProduct.jsp) data
	public electronicproduct viewEditProduct(String itemEdit, String editProductPicName){
		
		electronicproduct viewEditInput = new electronicproduct();
		Connection conn = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://mysql/eadassignment?user=root&password=will12345";
			conn = DriverManager.getConnection(connURL);
			
			//query to filter out record of selected item to be edited
			String Qstmt_itemEdit = "SELECT * FROM electronic_product WHERE product_id=?";
			
			PreparedStatement Pstmt_itemEdit = conn.prepareStatement(Qstmt_itemEdit);
			Pstmt_itemEdit.setInt(1, Integer.parseInt(itemEdit));	
			
			//get resultset for selected item to be edited
			ResultSet rs_itemEdit = Pstmt_itemEdit.executeQuery();
			
			if(rs_itemEdit.next()){
				viewEditInput.setProduct_id(Integer.parseInt(itemEdit));
				viewEditInput.setName(rs_itemEdit.getString("name"));
				viewEditInput.setType_id(rs_itemEdit.getInt("type_id"));
				
				//if itemEdit submitted frm a1Dashboard.jsp, get the picture name frm DB
				//if itemEdit submitted frm UploadPicServlet, get the picture name frm UploadPicServlet(frm newly uploaded file)
				if(editProductPicName!=null){
					viewEditInput.setPicture_name(editProductPicName);
				}
				else{
					viewEditInput.setPicture_name(rs_itemEdit.getString("picture_name"));
				}
				
				viewEditInput.setBrand(rs_itemEdit.getString("brand"));
				viewEditInput.setPrice(rs_itemEdit.getInt("price"));
				viewEditInput.setDescription(rs_itemEdit.getString("description"));
			}
			
			conn.close();
			return viewEditInput;
			
		}catch(Exception err){
			return null;
		}
		
	}
	
	//execute edit product
	public int editProduct(String itemEdit, String editName, String editType, String editPicName, String editBrand, 
			String editPrice, String editDesc){
		
		int editOutput = 0;
		Connection conn = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://mysql/eadassignment?user=root&password=will12345";
			conn = DriverManager.getConnection(connURL);
			
			//query to edit/update product
			String Qstmt_editElectronicProduct = "UPDATE electronic_product " + 
					"SET name=?,type_id=?,picture_name=?,brand=?,price=?,description=? " + 
					"WHERE product_id=?";
			PreparedStatement Pstmt_editElectronicProduct = conn.prepareStatement(Qstmt_editElectronicProduct);
			
			//if data is not null, execute edit/update product
			if(editName!=null){
				Pstmt_editElectronicProduct.setString(1, editName);
				Pstmt_editElectronicProduct.setInt(2, Integer.parseInt(editType));
				Pstmt_editElectronicProduct.setString(3, editPicName);
				Pstmt_editElectronicProduct.setString(4, editBrand);
				Pstmt_editElectronicProduct.setInt(5, Integer.parseInt(editPrice));
				Pstmt_editElectronicProduct.setString(6, editDesc);
				Pstmt_editElectronicProduct.setInt(7, Integer.parseInt(itemEdit));
				
				editOutput = Pstmt_editElectronicProduct.executeUpdate();
			}
			
			conn.close();
			return editOutput;
			
		}catch(Exception err){
			return 0;
		}
		
	}
	

}
