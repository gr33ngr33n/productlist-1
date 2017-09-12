<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>WiLL-Commerce Guest</title>
	
	<link rel="stylesheet" type="text/css" href="css/invalid.css">
	
	<link rel="icon" href="images/AuroraLogo-oriIcon.png">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<link rel="stylesheet" type="text/css" href="css/footer.css">
	
</head>

<body>

	<div id="header">
		<div id="header-wrapper">
			<div id="wrapper1">
				<div id="logo">
					<a href="a1GuestHome.jsp">
						<img src="images/orilogo.png"  />
					</a>
				</div>
				
				<div id="header-info">
					<ul>
						<li><a href="">WiLL-Commerce</a></li>				
					</ul>
				</div>
			</div>
			
			<div id="wrapper2">
				<ul>
					<li><a href="<%=request.getContextPath() + "/a1Login.jsp" %>">Login as Admin</a></li>
				</ul>
			</div>
		
		</div>
		
	</div>
	
	
	<div id="main-content">
		
		<div id="center-banner">
		
			<div id="main-banner">
				<h3>WiLL-Commerce are Popular and the Best Online Shop for IT Gadgets Island Wide.</h3>
				<p>Visit WiLL-Commerce Singapore site and buy online the best laptops, notebooks,
				ultrabooks, desktops and servers for your home and business. Computer accessories</p>
				
				Why is WiLL-Commerce the Best ?<br>
				Because we work closely together with IT gadgets manufacturers in order to deliver
				the best quality products to our customers both end consumer and corporate customer.
				<br><br>
				
				<div id="video-media">
					<video width="100%" height="auto" controls autoplay loop >
						<source src="videos/will_commerce_works.mp4" type="video/mp4" />
				</div>
				
				<br>
				
				<!--div id="reviews">
					<p style="text-decoration:underline;">Reviews</p>
					Please take a look at our satisfied customers' reviews by 
					Plese feel free to drop us any feedback or comment on our service.
				</div>
				
				<br-->
				
				
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
						<form action="a1GuestHome.jsp" method="post">
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
				<div class="main-item-wrapper">
					<%
					//view all data of electronic_product table
					while(rs_electronicProduct.next()){
						
					//execute query to filter type_name from table product_type
					Pstmt_productTypeName.setInt(1, rs_electronicProduct.getInt("type_id"));
					ResultSet rs_productTypeName = Pstmt_productTypeName.executeQuery();				
					%>
						
						<div class="main-item">		
							<div class="item-top">
								<img height=100% src=
											<%
											out.println(request.getContextPath()+"/img/"+rs_electronicProduct.getString("picture_name"));
											%>
											/>
							</div>
							<div class="item-bottom">
								<%=rs_electronicProduct.getString("brand")%> 
								<%
								rs_productTypeName.next();
								out.println(rs_productTypeName.getString("type_name"));
								%> <br/>
								<%=rs_electronicProduct.getString("name")%>
								<br/>
								$ <%=rs_electronicProduct.getInt("price")%>
								<span class="tooltip"><%=rs_electronicProduct.getString("description")%></span>
							</div>
						</div>
						
						
					<%
					}
				
					%>
				</div>
				
				<%
				
			conn.close();
		}catch(Exception err){
			out.println(err.getMessage());
		}
		
	
	%>
	
			</div>
		</div>
	</div>
	
	<div id="footer">
		<br>
		<div class="social">
			<b style="color:#f48b00;">FOLLOW US!!</b>
			<br><br>
			<a class="fb" href="http://www.facebook.com">
				Facebook
			</a>
			
			<a class="in" href="http://www.instagram.com">
				Instagram
			</a>
			
			<a class="tw" href="http://www.twitter.com">
				Twitter
			</a>
		</div>
		
		<div class="reference">
			<b style="color:#f48b00;">REFERENCE</b>
			<br><br>
			<a class="ref-info" href="" target="">
				Reference Information
			</a>
			<br><br>
			<div class="reference-text" style="color:#f48b00;">
				WiLL-Commerce is not a real eCommerce site. WiLL-Commerce site is created merely for 
				Non-commercial Singapore Polytechnic assignment purpose.
			</div>
		</div>	
	</div>	
	

</body>
</html>