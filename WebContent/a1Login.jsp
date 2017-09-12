<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Admin Login</title>

	<script type="text/javascript" src="js/a1Login.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/invalid.css">

</head>

<body>

	<div style="text-align:center; margin-top:10%">
		<%	
		String loginFail = request.getParameter("loginFail");

		if(loginFail!=null){
			%>
				<div style="color:red; font-size:15px; font-style:italic;"><%=loginFail %></div>
			<%
		}
		%>
		
		<h2>WiLL-Commerce Admin Login</h2>
		<hr width=300px style="box-shadow:0px 0px 5px #f48b00; color:#ff6600"></hr>
		<form action="LoginServlet" method="post">
		User ID:<br/>
		<input type="text" name="adminUserId" id="admin_id" maxlength="5" />
		<br/>
		Password:<br/>
		<input type="password" name="adminPassword" id="admin_pass" maxlength="10" />
		<br/><br/>
		<input type="submit" name="adminBtnLogin" value="Submit" id="admin_login" onclick="return check_adminLogin()" />
		<input type="reset" name="adminBtnReset" value="Reset" />
		</form>
	</div>
	
</body>
</html>