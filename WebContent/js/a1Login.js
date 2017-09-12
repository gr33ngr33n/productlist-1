
//validate adminId which is 5 characters
function check_adminId(){
	var admin_id = document.getElementById("admin_id");
	var admin_id_value = admin_id.value;
	
	//console.log(admin_id_value);
	if(admin_id_value.length!=5){
		//admin_id.value="";
		
		if(admin_id.parentNode.getElementsByClassName("invalid").length<=0){
			var admin_id_invalid = document.createElement("div");
			admin_id_invalid.className = "invalid";
			admin_id_invalid.innerHTML = "admin ID (5 characters)<br/>admin Pwd (only alphabet or/and digit)";
			admin_id.parentNode.appendChild(admin_id_invalid);
			console.log(document.getElementsByClassName("invalid"));
		}
		return false;
		
	}else{
		if(admin_id.parentNode.getElementsByClassName("invalid").length>0){
			var last_childNode_id = admin_id.parentNode.childNodes.length-1;
			admin_id.parentNode.removeChild(admin_id.parentNode.childNodes[last_childNode_id]);
			console.log(document.getElementsByClassName("invalid"));
		}
		return true;
		
	}
	
}

//validate adminPassword(max. 10 characters). no special character is allowed (only alphabet and number)
function check_adminPass(){
	var admin_pass = document.getElementById("admin_pass");
	var admin_pass_value = admin_pass.value;
	
	console.log(admin_pass_value);
	
	for(i=0; i<admin_pass_value.length; i++){
		var alphabet_check = 0;
		var digit_check = 0;
		//console.log(admin_pass.value[i]);
		
		for(j=65; j<=90; j++){
			if((admin_pass.value[i]==String.fromCharCode(j)) || (admin_pass.value[i]==String.fromCharCode(j+32))){
				alphabet_check += 1;
			}
		}
		
		//console.log(alphabet_check);
		if(alphabet_check<=0){
			console.log("NOT alphabet");
			for(k=0; k<=9; k++){
					if(admin_pass.value[i]==k){
						digit_check += 1;
					}
			}
		}
		
		//console.log(digit_check);
		if(alphabet_check<=0 && digit_check<=0){
			console.log("special");
			//admin_pass.value="";
			
			if(admin_pass.parentNode.getElementsByClassName("invalid").length<=0){
				var admin_pass_invalid = document.createElement("div");
				admin_pass_invalid.className = "invalid";
				admin_pass_invalid.innerHTML = "admin ID (5 characters)<br/>admin Pwd (only alphabet or/and digit)";
				admin_pass.parentNode.appendChild(admin_pass_invalid);
				console.log(document.getElementsByClassName("invalid"));
			}
			return false;
			
		}else{
			if(admin_pass.parentNode.getElementsByClassName("invalid").length>0){
				var last_childNode_pass = admin_pass.parentNode.childNodes.length-1;
				admin_pass.parentNode.removeChild(admin_pass.parentNode.childNodes[last_childNode_pass]);
				console.log(document.getElementsByClassName("invalid"));
			}
			return true;
			
		}
	}
		
}

//validate both adminId & adminPassword when adminBtnLogin (submit) button is clicked
function check_adminLogin(){
	var admin_id = document.getElementById("admin_id");
	var admin_pass = document.getElementById("admin_pass");
	
	var result_check_adminId = check_adminId();
	var result_check_adminPass = check_adminPass();
	
	if(admin_id.value.length<=0 || admin_pass.value.length<=0){
		alert("Both Admin ID & Password Must be Filled!");
		return false;
	}
	
	if(!result_check_adminId || !result_check_adminPass){
		alert("admin ID (5 characters)<br/>admin Pwd (only alphabet or/and digit)");
		return false;
	}
	
	
}

//load the functions when window is activated
window.onload = function(){
	//alert("halo");
	
	var admin_id = document.getElementById("admin_id");
	admin_id.addEventListener("blur",check_adminId);
	
	var admin_pass = document.getElementById("admin_pass");
	admin_pass.addEventListener("blur",check_adminPass);
	
	/*var admin_login = document.getElementById("admin_login");
	admin_login.addEventListener("click", check_adminLogin);*/
	
	
}