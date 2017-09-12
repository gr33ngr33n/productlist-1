<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.io.*, eadassignment2.model.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add Product</title>
	
	<link rel="stylesheet" type="text/css" href="css/invalid.css">
	
	<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
	<!--<script type="text/javascript" src="js/a1AddProduct.js"></script>-->
	<script type="text/javascript" src="js/a1AddProductJQuery.js"></script>
	
</head>
<body>

<h2>WiLL-Commerce Add Product</h2>
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
		
		//get value of addOutput passed by AddProductServlet 
		String addOutput = request.getParameter("addOutput");
	
		//clarification! print out number of added record if add record is successful
		if(addOutput!=null){
		%>
			<div style="color:blue; font-size:15px; font-style:italic;"><%=addOutput %></div>
		<%
		}
		
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/eadassignment?user=root&password=wiwi12345";
			Connection conn = DriverManager.getConnection(connURL);
			
			/* query to load all product type into droplist */
			String Qstmt_addDropListProductTypeName = "SELECT * FROM product_type";
						
			PreparedStatement Pstmt_addDropListProductTypeName = conn.prepareStatement(Qstmt_addDropListProductTypeName);
						
			/* get resultset for droplist content */
			ResultSet rs_addDropListProductTypeName = Pstmt_addDropListProductTypeName.executeQuery();
					
			%>
			
			
			<div style="margin-left:50px">
				<form id="formAddPicFile" action="a1AddProduct.jsp" method="post" enctype="multipart/form-data" >
					<%
					String productPicName = new String(); //productPicName stores the pic filename
					String productPicContentType = request.getContentType(); //productPicContentType stores content-type and is used to indicate boundary of file content

					
					while((productPicContentType!=null) && (productPicContentType.indexOf("multipart/form-data")>=0)){
						DataInputStream dis = new DataInputStream(request.getInputStream());
						
						int productPicContentLength = request.getContentLength();
						byte[] productPicContentBuffer = new byte[productPicContentLength];
						
						int readBuffer=0;
						int ttlReadBuffer=0;
						
						while(ttlReadBuffer < productPicContentLength){
							readBuffer = dis.read(productPicContentBuffer, ttlReadBuffer, productPicContentLength);
							ttlReadBuffer += readBuffer;
						}
						
						String productPicContentString = new String(productPicContentBuffer);
						
						productPicName = productPicContentString.substring(productPicContentString.indexOf("filename=\"")+10);
						productPicName = productPicName.substring(0, productPicName.indexOf("\n"));
						productPicName = productPicName.substring(productPicName.indexOf("\\")+1, productPicName.indexOf("\""));
						
						/* testing */
						//out.println(productPicName);
						//out.println(productPicContentType);
						//break;
						
						String fileContentBoundary = productPicContentType.substring(productPicContentType.indexOf("=")+1,
								productPicContentType.length());
						
						/* testing */
						//out.println(fileContentBoundary);
						//break;
						
						int fileContentBeginPos;
						fileContentBeginPos = productPicContentString.indexOf("filename=\"");
						fileContentBeginPos = productPicContentString.indexOf("\n", fileContentBeginPos)+1;
						fileContentBeginPos = productPicContentString.indexOf("\n", fileContentBeginPos)+1;
						fileContentBeginPos = productPicContentString.indexOf("\n", fileContentBeginPos)+1;
						
						int fileContentEndPos;
						fileContentEndPos = productPicContentString.indexOf(fileContentBoundary, fileContentBeginPos)-4;
						
						/*fileHeaderLength & wholeFileLength are both used to indicate start & end of file content (same as 
						fileContentBeginPos & fileContentEndPos). The difference between fileContentBeginPos & fileContentEndPos is
						just their length are counted in bytes -- just to be safe since file content is in bytes*/
						int fileHeaderLength = (productPicContentString.substring(0, fileContentBeginPos).getBytes()).length;
						int wholeFileLength = (productPicContentString.substring(0, fileContentEndPos).getBytes()).length;
						
						/* localPicLocation to get pic file location in local machine */
						String localPicLocation = getServletContext().getRealPath("/").replace("\\", "/");
						
						/* create or save file to both location in local & web(server) */
						File productPicFile = new File(localPicLocation.substring(0, localPicLocation.lastIndexOf(".metadata")-1) +
								request.getContextPath() + "/WebContent/img/" + productPicName); /*copy files to local client machine*/
						File productPicFileWeb = new File(getServletContext().getRealPath("/img/" + productPicName).replace("\\", "/"));
						
								
						/* testing -- to get local client machine URI(local pic file path) */
						//String localLocation = getServletContext().getRealPath("/").replace("\\", "/");
						//out.println(localLocation.substring(0, localLocation.lastIndexOf(".metadata")-1)+request.getContextPath()+"/WebContent/img/");
	
						/* testing -- to get path of server (/web folder) */
						//out.println(request.getContextPath() + "\n");
						//out.println(application.getRealPath("/").replace("\\", "/") + "img/" + productPicName);
						//out.println(getServletContext().getRealPath("/img/" + productPicName).replace("\\", "/"));
						
						/* testing -- similar to the above -- to get path of server (/web folder) */
						//ServletContext context = request.getServletContext();
						//out.println(context.getRealPath("/"));
												
						/* both getServletContext().getRealPath("") & application.getRealPath("") to get full path (absolutePath)
						replace to replace old char with new char */
						//out.println(getServletContext().getRealPath("/").replace("\\", "/") + "img/");
						//out.println(application.getRealPath("/").replace("\\", "/") + "img/");
						
						
						try{
							FileOutputStream productPicFileOut = new FileOutputStream(productPicFile); /* to local client machine */
							FileOutputStream productPicFileWebOut = new FileOutputStream(productPicFileWeb); /* to /web folder */
							
							productPicFileOut.write(productPicContentBuffer, fileHeaderLength, (wholeFileLength-fileHeaderLength)); /* to local client machine */
							productPicFileWebOut.write(productPicContentBuffer, fileHeaderLength, (wholeFileLength-fileHeaderLength)); /* to /web folder */
							
							productPicFileOut.flush(); /* to local client machine */
							productPicFileWebOut.flush(); /* to /web folder */
							
							productPicFileOut.close(); /* to local client machine */
							productPicFileWebOut.close(); /* to /web folder */
							
							break;
						}catch(Exception err){
							out.println(err.getMessage());
						}
						
					}
					
					%>
					<br/>
					Choose Pic.: <br/>
					<input type="file" name="addPicFile" form="formAddPicFile"  accept="image/*" id="add_pic" onchange="check_upload()"/>
					<input type="submit" name="btnAddPicFile" value="Upload" form="formAddPicFile" id="upload_pic" />
					<br/>
				</form>	
				
				<form id="form_submit" action="AddProductServlet" method="post" onsubmit="return check_emptyInput()" >
					Model: <br/>
					<input type="text" name="addName" id="add_name" />
					<br/>
					Type: <br/>
					<select name="addType" id="add_type" >
					<%
					while(rs_addDropListProductTypeName.next()){
						%>
						<option value=<%=rs_addDropListProductTypeName.getInt("type_id") %>>
							<%=rs_addDropListProductTypeName.getString("type_name") %>
						</option>
						<%	
					}
					%>
					</select>
					<br/>
					Pic. Name: <br/>
					<input type="text" name="addPicName" readonly="readonly" id="add_pic_name"
					value=<%=(productPicName!=null && productPicName.length()>0)? productPicName: "-" %> />
					<br/>
					Brand: <br/>
					<input type="text" name="addBrand" id="add_brand" />
					<br/>
					Price: <br/>
					<input type="text" name="addPrice" id="add_price"/>
					<br/>
					Description: <br/>
					<textarea rows="10" cols="40" name="addDesc" id="add_desc" onkeyup="textarea_charCount(this)" placeholder="key in product description here..."></textarea>
					<br/>
					<div class="textareaCharCount" style="color:grey; font-size:10px"></div>
					<br/><br/>
					<input type="submit" name="btnAddSubmit" value="Submit" id="add_product_submit" />
					<input type="reset" name="btnAddReset" value="Reset" />
					<a style="margin-left:20px" href="
					<%=request.getContextPath() + "/a1Dashboard.jsp?backFrmAdd=yes" %>
					">Back to DashBoard</a>
				</form>
			</div>
			
			<%
			
			conn.close();
		}catch(Exception err){
			%>
			<div style="color:red; font-size:15px; font-style:italic; margin-left:50px">
				Please Enter Correct Input!
			</div>
			<%
		}
	
	}else{
		response.sendRedirect("a1Login.jsp?loginFail=You have Logged Out.");
	}
	%>


</body>
</html>