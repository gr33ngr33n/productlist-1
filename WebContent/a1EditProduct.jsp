<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, eadassignment2.model.*, java.util.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit Product</title>
	
	<link rel="stylesheet" type="text/css" href="css/invalid.css">
	
	<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
	<!-- <script type="text/javascript" src="js/a1EditProduct.js"></script> -->
	<script type="text/javascript" src="js/a1EditProductJQuery.js"></script>
	
</head>
<body>

<h2>WiLL-Commerce Edit Product</h2>
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

		//get edited product data forwarded by ViewEditProductServlet(either frm a1Dashboard.jsp or UploadPicServlet)
		electronicproduct viewEditOutput = (electronicproduct)request.getAttribute("viewEditOutput");
	
		//double check! if viewEditOutput is null, move back to a1Dashboard.jsp
		if(viewEditOutput!=null){
			//continue to the rest of the code
		}else{
			response.sendRedirect("a1Dashboard.jsp?backFrmEdit=yes_viewEditOutput_"+viewEditOutput);
		}
		
		
		try{
			//get selected item product_id passed either frm a1Dashboard.jsp or a1EditProduct.jsp(when btnEditSubmit is executed)
			//String itemEdit = request.getParameter("itemEdit");
			
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/eadassignment?user=root&password=wiwi12345";
			Connection conn = DriverManager.getConnection(connURL);
			
			//query to load all product type into droplist
			String Qstmt_editDropListProductTypeName = "SELECT * FROM product_type";
			//query to filter out record of selected item to be edited
			//String Qstmt_itemEdit = "SELECT * FROM electronic_product WHERE product_id=?";
			
			PreparedStatement Pstmt_editDropListProductTypeName = conn.prepareStatement(Qstmt_editDropListProductTypeName);
			//PreparedStatement Pstmt_itemEdit = conn.prepareStatement(Qstmt_itemEdit);
			//Pstmt_itemEdit.setInt(1, Integer.parseInt(itemEdit));	
			
			//get resultset for droplist content
			ResultSet rs_editDropListProductTypeName = Pstmt_editDropListProductTypeName.executeQuery();
			//get resultset for selected item to be edited
			//ResultSet rs_itemEdit = Pstmt_itemEdit.executeQuery();			
			
			
			//if(rs_itemEdit.next()){
				%>
				
				<div style="margin-left:50px">		
					<form id="formEditPicFile" action="UploadPicServlet" method="post" enctype="multipart/form-data"></form>
					
					<form id="form_update" action="EditProductServlet" method="post" >
						<input type="hidden" name="itemEdit" value=<%=viewEditOutput.getProduct_id() %> /> 
						<!-- ^ to keep and maintain selected item id for updating -->
						Model: <br/>
						<!-- need to surround attribute value with quotes.Otherwise the white space will be interpreted as HTML element attribute
						separator and the next String(right after white space) will be interpreted as another HTML element attribute -->
						<input type="text" name="editName" id="edit_name" value="<%=viewEditOutput.getName()%>" />
						<br/>
						Type: <br/>
						<select name="editType" id="edit_type" >
						<%
						while(rs_editDropListProductTypeName.next()){
							%>
							<option value=<%=rs_editDropListProductTypeName.getInt("type_id") %> 
							<%
							//set the value of droplist equals to the one selected to be edited 
							if(rs_editDropListProductTypeName.getInt("type_id")==viewEditOutput.getType_id())
								out.println("selected");
							%>
							>
								<%=rs_editDropListProductTypeName.getString("type_name") %>
							</option>
							<%	
						}
						%>
						</select>
						<br/>
						
							<!-- Change Pic. is under form 'editPicFile' which is written above^ -->
							Change Pic.:<br/>
							<input type="file" name="editPicFile" form="formEditPicFile" accept="image/*" id="edit_pic" onchange="check_upload_edit()" />
							<input type="hidden" name="passItemEdit" form="formEditPicFile" value=<%=viewEditOutput.getProduct_id() %> />
							<input type="submit" name="btnEditPicFile" value="Upload" form="formEditPicFile" id="upload_edit_pic" />
							<br/>
							
						Pic. Name: <br/>
						<!-- need to surround attribute value with quotes.Otherwise the white space will be interpreted as HTML element attribute
						separator and the next String(right after white space) will be interpreted as another HTML element attribute -->
						<input type="text" name="editPicName" readonly="readonly" id="edit_pic_name" value=
						"<%=viewEditOutput.getPicture_name()%>" />
						<br/>
						Pic. Preview:<br/>
						<img style="height:150px" src=<%=request.getContextPath()+"/img/"+viewEditOutput.getPicture_name() %> />
						<br/>
						<!-- need to surround attribute value with quotes.Otherwise the white space will be interpreted as HTML element attribute
						separator and the next String(right after white space) will be interpreted as another HTML element attribute -->
						Brand: <br/>
						<input type="text" name="editBrand" id="edit_brand" value="<%=viewEditOutput.getBrand() %>" />
						<br/>
						Price: <br/>
						<input type="text" name="editPrice" id="edit_price" value=<%=viewEditOutput.getPrice() %> />
						<br/>
						Description: <br/>
						<!-- since it is textarea with out.println no worries abt the String gets cut off -->
						<textarea rows="10" cols="40" name="editDesc" id="edit_desc" onkeyup="textarea_charCount(this)"><% out.println(viewEditOutput.getDescription()); %></textarea>
						<br/>
						<div class="textareaCharCount" style="color:grey; font-size:10px"></div>
						<br/><br/>
						<input type="submit" name="btnEditSubmit" value="Update" id="edit_product_submit" onclick="return check_emptyInput()" />
						<a style="margin-left:20px" href="
						<%=request.getContextPath() + "/a1Dashboard.jsp?backFrmEdit=yes" %>
						">Back to DashBoard</a>
					</form>
				</div>
				
				<%
				
				
			//}			
			
			conn.close();
		}catch(Exception err){
			//out.println(err);
			
			%>
			<div style="color:red; font-size:15px; font-style:italic; margin-left:50px">
				Please Enter Correct Input!!
			</div>
			<%
		}
		
	}else{
		response.sendRedirect("a1Login.jsp?loginFail=You have Logged Out.");
	}
	%>

</body>
</html>