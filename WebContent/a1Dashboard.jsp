<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*, eadassignment2.model.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Admin Dashboard</title>
	
	<link rel="stylesheet" type="text/css" href="css/invalid.css">
	
	
	<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
	<!--<script type="text/javascript" src="js/a1Dashboard.js"></script>-->
	<script type="text/javascript" src="js/a1DashboardJQuery.js"></script>
	
</head>

<body>

<h2>WiLL-Commerce Admin Dashboard</h2>
<hr style="box-shadow:0px 0px 5px #f48b00; color:#ff6600"></hr>
<br/>

<div style="margin-right:20px; text-align:right; font-size:15px">
	<form action="LogoutServlet" method="post">
		<input type="submit" value="Log Out" style="border:none; cursor:pointer; font-size:15px; background-color:white; text-decoration:underline" />
	</form>
	<%-- <a href="<%=request.getContextPath() + "/a1GuestHome.jsp" %>">Log Out</a> --%>
</div>


	<%
	//get session adminFound
	admin adminFound = (admin)session.getAttribute("adminFound");
	
	//If adminFound is not null, user is logging-in
	if(adminFound!=null){
		%>
		<div style="margin-right:20px; text-align:right; font-size:15px">User ID: <%=adminFound.getAdmin_id() %></div>
		
		<%
	
		//get value of adminUserId passed by LoginServlet if admin login is successful
		String adminUserId = request.getParameter("adminUserId");
		//back from a1AddProduct.jsp
		String backFrmAdd = request.getParameter("backFrmAdd");
		//get value of backFrmEdit passed by EditProductServlet if edit record is successful
		String backFrmEdit = request.getParameter("backFrmEdit");
		//get value of backFrmDel passed by DeleteProductServlet if delete record is successful
		String backFrmDel = request.getParameter("backFrmDel");	
	
		
		
		//search product variables
		String searchName = request.getParameter("searchName");
		String searchBrand = request.getParameter("searchBrand");
		String searchType = request.getParameter("searchType");
		String searchMaxPrice = request.getParameter("searchMaxPrice");
		
		
		/* input sanitization for searchName */
		if(searchName!=null){
			searchName = searchName.replace('<', 'S');
			searchName = searchName.replace('>', 'B');
			searchName = searchName.replace('&', 'A');
			searchName = searchName.replace('\"','C');
			out.println(searchName);
		}
		
		/* input sanitization for searchBrand */
		if(searchBrand!=null){
			searchBrand = searchBrand.replace('<', 'S');
			searchBrand = searchBrand.replace('>', 'B');
			searchBrand = searchBrand.replace('&', 'A');
			searchBrand = searchBrand.replace('\"','C');
			out.println(searchBrand);
		}
		
		/* input sanitization for searchMaxPrice */
		if(searchMaxPrice!=null){
			if(!(searchMaxPrice.matches("\\d+"))){
				searchMaxPrice = "0";
				response.sendRedirect("a1Dashboard.jsp");
			}
		}
		
				
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
			PreparedStatement Pstmt_electronicProduct;
			if(searchName!=null && !searchType.equalsIgnoreCase("all")){
				Qstmt_electronicProduct = "SELECT * FROM electronic_product WHERE " + 
						"name LIKE ? AND brand LIKE ? AND type_id=? AND price<=?";
				Pstmt_electronicProduct = conn.prepareStatement(Qstmt_electronicProduct);
				Pstmt_electronicProduct.setString(1, '%'+searchName+'%');
				Pstmt_electronicProduct.setString(2, '%'+searchBrand+'%');
				Pstmt_electronicProduct.setInt(3, Integer.parseInt(searchType));
				Pstmt_electronicProduct.setInt(4, Integer.parseInt(searchMaxPrice));
				
			}
			else{
				if(searchMaxPrice!=null){
					Qstmt_electronicProduct = "SELECT * FROM electronic_product WHERE " + 
							"name LIKE ? AND brand LIKE ? AND price<=?";
					Pstmt_electronicProduct = conn.prepareStatement(Qstmt_electronicProduct);
					Pstmt_electronicProduct.setString(1, '%'+searchName+'%');
					Pstmt_electronicProduct.setString(2, '%'+searchBrand+'%');
					Pstmt_electronicProduct.setInt(3, Integer.parseInt(searchMaxPrice));
				}
				else{
					Qstmt_electronicProduct = "SELECT * FROM electronic_product";
					Pstmt_electronicProduct = conn.prepareStatement(Qstmt_electronicProduct);
				}
			}
			
						
			PreparedStatement Pstmt_productTypeName = conn.prepareStatement(Qstmt_productTypeName);
			PreparedStatement Pstmt_dropListProductTypeName = conn.prepareStatement(Qstmt_dropListProductTypeName);
			PreparedStatement Pstmt_productMaxPrice = conn.prepareStatement(Qstmt_productMaxPrice);
			//PreparedStatement Pstmt_electronicProduct = conn.prepareStatement(Qstmt_electronicProduct);
			
			
			//get resultset for droplist content
			ResultSet rs_dropListProductTypeName = Pstmt_dropListProductTypeName.executeQuery();
			//get resultset for product max price
			ResultSet rs_productMaxPrice = Pstmt_productMaxPrice.executeQuery();
			
			
			if(adminFound!=null||searchName!=null||backFrmAdd!=null||backFrmEdit!=null||backFrmDel!=null){

				%>			
				
				<!-- Search Product UI-->
				<div style="float:left; width:100%">
					<fieldset>
						<legend>Search Product</legend>
						<form action="a1Dashboard.jsp" method="post">
							Model :
							<input type="text" name="searchName" />
							Brand :
							<input type="text" name="searchBrand" />
							Type  :
							<select name="searchType">
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
							<input type="text" name="searchMaxPrice" value=
							<%
							rs_productMaxPrice.next();
							out.println(rs_productMaxPrice.getInt("max_price"));
							%> 
							/>
							<br/><br/>
							<input type="submit" name="btnSearch" value="Search Product" />		
						</form>
					</fieldset>						
				</div>
					
				<!-- Add Product, Update Product, Delete Product UI-->
				<div style="clear:both; padding-top:20px">
					<!-- Add Product -->
					<form style="display:inline" action="a1AddProduct.jsp" method="post">
						<input type="submit" name="btnAdd" value="Add Product" />
					</form>
					
					<!-- Delete Product -->
					<form id="formDeleteProduct" style="display:inline" action="DeleteProductServlet" method="post">
						<input type="submit" name="btnDelete" value="Delete Product" />
					</form>
				</div>
				
				<%
				//execute query to display electronic product data
				ResultSet rs_electronicProduct = Pstmt_electronicProduct.executeQuery();
				%>
				<!-- create table for electronic products -->
				<div style="padding-top:20px;">
					<table border=1 width=100% style="border-collapse:collapse">
						<tr>
							<th>
								<input type="checkbox" id="btn_multiselect" onclick="multi_select()" />
 							</th>
 							<th></th>
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
							<!-- checkbox to delete record -->		
							<td>
								<div style="text-align:center" class="item_select">
									<input type="checkbox" name="itemSelect" value=<%=rs_electronicProduct.getInt("product_id")%> 
									form="formDeleteProduct" onclick="check_delete()" />
								</div>
							</td>
							<!-- edit button to edit record -->
							<td>
								<!-- Edit Product -->
								<form id="form_viewEditProductServlet" style="text-align:center" action="ViewEditProductServlet" method="post">
									<input type="hidden" name="itemEdit" value=<%=rs_electronicProduct.getInt("product_id")%> />
									<input type="submit" name="btnEdit" value="Edit" />
								</form>
							</td>
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
							<td style="width:45%"><%=rs_electronicProduct.getString("description")%></td>				
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
			}else{
				response.sendRedirect("a1Login.jsp?loginFail=user id or password is incorrect!");
			}
			
			conn.close();
		}catch(Exception err){
			out.println(err.getMessage());
		}
		
	}else{
		response.sendRedirect("a1Login.jsp?loginFail=You have Logged Out.");
	}
	%>


</body>
</html>