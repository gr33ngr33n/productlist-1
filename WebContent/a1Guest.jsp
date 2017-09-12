<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>WiLL-Commerce Guest</title>
	
	<link rel="stylesheet" type="text/css" href="css/invalid.css">
	
</head>

<body>

<div style="margin-right:20px; text-align:right; font-size:15px">
	<a href="<%=request.getContextPath() + "/a1Login.jsp" %>">Login as Admin</a>
</div>

<h2>WiLL-Commerce</h2>

<hr style="box-shadow:0px 0px 5px #f48b00; color:#ff6600"></hr>
<br/>

	<%
				
		//search product variables
		String searchName_guest = request.getParameter("searchName_guest");
		String searchBrand_guest = request.getParameter("searchBrand_guest");
		String searchType_guest = request.getParameter("searchType_guest");
		String searchMaxPrice_guest = request.getParameter("searchMaxPrice_guest");
		
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/eadassignment?user=root&password=wiwi12345";
			Connection conn = DriverManager.getConnection(connURL);
			
			
			//query to load all product type into table
			String Qstmt_productTypeName = "SELECT * FROM product_type WHERE type_id=?";
			//query to load all product type into droplist
			String Qstmt_dropListProductTypeName = "SELECT * FROM product_type";
			//query to filter max price of product
			String Qstmt_productMaxPrice = "SELECT MAX(price) 'max_price' FROM electronic_product";
			//query to load/search products
			String Qstmt_electronicProduct;
			if(searchName_guest!=null && !searchType_guest.equalsIgnoreCase("all")){
				Qstmt_electronicProduct = "SELECT * FROM electronic_product WHERE " + 
						"name LIKE '%" + searchName_guest + "%' AND brand LIKE '%" + searchBrand_guest + "%' AND " +
						"type_id=" + Integer.parseInt(searchType_guest) + " AND " +
						"price<= " + Integer.parseInt(searchMaxPrice_guest) + "";
			}
			else{
				if(searchMaxPrice_guest!=null){
					Qstmt_electronicProduct = "SELECT * FROM electronic_product WHERE " + 
							"name LIKE '%" + searchName_guest + "%' AND brand LIKE '%" + searchBrand_guest + "%' AND " +
							"price<= " + Integer.parseInt(searchMaxPrice_guest) + "";
				}
				else{
					Qstmt_electronicProduct = "SELECT * FROM electronic_product";
				}
			}
			
			
			
			PreparedStatement Pstmt_electronicProduct = conn.prepareStatement(Qstmt_electronicProduct);
			PreparedStatement Pstmt_productTypeName = conn.prepareStatement(Qstmt_productTypeName);
			PreparedStatement Pstmt_dropListProductTypeName = conn.prepareStatement(Qstmt_dropListProductTypeName);
			PreparedStatement Pstmt_productMaxPrice = conn.prepareStatement(Qstmt_productMaxPrice);
			
			
			
			//get resultset for droplist content
			ResultSet rs_dropListProductTypeName = Pstmt_dropListProductTypeName.executeQuery();
			//get resultset for product max price
			ResultSet rs_productMaxPrice = Pstmt_productMaxPrice.executeQuery();
			

				%>
				<!-- Search Product UI-->
				<div style="float:left; width:100%">
					<fieldset>
						<legend>Search Product</legend>
						<form action="a1Guest.jsp" method="post">
							Model :
							<input type="text" name="searchName_guest" />
							Brand :
							<input type="text" name="searchBrand_guest" />
							Type  :
							<select name="searchType_guest">
								<option value="all">All</option>
							<%
							while(rs_dropListProductTypeName.next()){
								%>
								<option value=<%=rs_dropListProductTypeName.getInt("type_id")%>>
									<%=rs_dropListProductTypeName.getString("type_name")%>
								</option>
								<%	
							}
							rs_dropListProductTypeName.close();
							%>
							</select>
							Max. Price :
							<input type="text" name="searchMaxPrice_guest" value=
							<%
							rs_productMaxPrice.next();
							out.println(rs_productMaxPrice.getInt("max_price"));
							%> 
							/>
							<br/><br/>
							<input type="submit" name="btnSearch_guest" value="Search Product" />		
						</form>
					</fieldset>
					<br/>			
				</div>
				
				
				<%
				//execute query to display electronic product data
				ResultSet rs_electronicProduct = Pstmt_electronicProduct.executeQuery();
				%>
				<!-- create table for electronic products -->
				<div style="padding-top:20px;">
					<table border=1 width=100% style="border-collapse:collapse">
						<tr>
							<th>Model</th>
							<th>Brand</th>
							<th>Type</th>
							<th>Picture</th>
							<th>Price</th>
							<th>Description</th>
						</tr>
					<%
					//view all data of electronic_product table
					while(rs_electronicProduct.next()){
						
					//execute query to filter type_name from table product_type
					Pstmt_productTypeName.setInt(1, rs_electronicProduct.getInt("type_id"));
					ResultSet rs_productTypeName = Pstmt_productTypeName.executeQuery();				
					%>

						<tr>
							<!-- print name from table electronic_product -->
							<td><%=rs_electronicProduct.getString("name")%></td>
							<!-- print brand from table electronic_product -->
							<td><%=rs_electronicProduct.getString("brand")%></td>
							<!-- print type_name from table product_type -->
							<td>
								<%
								rs_productTypeName.next();
								out.println(rs_productTypeName.getString("type_name"));
								%>
							</td>
							<!-- display picture which name is stored in table electronic_product -->
							<td>
								<div style="height:100px; text-align:center">
									<img height=100% src=
										<%
										out.println(request.getContextPath()+"/img/"+rs_electronicProduct.getString("picture_name"));
										%>
									/>
								</div>
							</td>	
							<!-- print price from table electronic_product -->
							<td><%=rs_electronicProduct.getInt("price")%></td>			
							<!-- print description from table electronic_product -->
							<td><%=rs_electronicProduct.getString("description")%></td>				
						</tr>
					<%
					}
				
				%>
					</table>
				</div>
				<%
				//out.println(request.getContextPath());
				//out.println(searchName);
				//out.println(searchMaxPrice);
				//out.println(searchType);
				//out.println(backFrmAdd);
				//out.println(backFrmEdit);
			
			
			conn.close();
		}catch(Exception err){
			out.println(err.getMessage());
		}
		
	
	%>


</body>
</html>