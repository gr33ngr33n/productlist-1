
//if uploaded file is null, disable the upload button
function check_upload_edit(){
	var check_edit_pic = document.getElementById("edit_pic");
	var check_upload_edit_pic = document.getElementById("upload_edit_pic");
	var check_edit_pic_name = document.getElementById("edit_pic_name");
	var check_edit_product_submit = document.getElementById("edit_product_submit");
	
	//if file is not selected, upload button is disabled
	console.log(check_edit_pic.value);
	if(check_edit_pic.value=="")
		check_upload_edit_pic.disabled = true;
	else
		check_upload_edit_pic.disabled = false;
	
	//if file is not uploaded, submit button is disabled
	console.log(check_edit_pic_name.value);
	if(check_edit_pic_name.value!="-")
		check_edit_product_submit.disabled = false;
	else
		check_edit_product_submit.disabled = true;
	
}

//validate input price
function check_editPrice(){
	var check_edit_price = document.getElementById("edit_price");
	var check_edit_price_value = check_edit_price.value;
	var digit_check = 0;
	
	for(i=0; i<check_edit_price_value.length; i++){
		for(k=48; k<=57; k++){
			if(check_edit_price.value[i]==String.fromCharCode(k)){
				digit_check += 1;
				/*console.log(digit_check + ".edit_price_value:" + check_edit_price.value[i] + 
						".k value:" + String.fromCharCode(k));*/
				break;
			}
		}
	}
	
	if(digit_check<check_edit_price_value.length){
		check_edit_price.value="";
		
		/*testing*/
		//console.log("Invalid Price");
		//alert("Invalid Price");
	}
	
	var result = check_emptyInput();
	console.log(result);
}

//check if there is any empty input
function check_emptyInput(){
	var result = "";
	
	var check_edit_name = document.getElementById("edit_name");
	var check_edit_type = document.getElementById("edit_type");
	var check_edit_brand = document.getElementById("edit_brand");
	var check_edit_price = document.getElementById("edit_price");
	var check_edit_desc = document.getElementById("edit_desc");
	var form_update = document.getElementById("form_update");
	
	/*testing*/
	/*if(matches = check_edit_name.value.match(/[a-z0-9-_]+/gi)){
		console.log("whitespace: " + matches);
	}else{
		console.log("invalid");
	}*/
	
	/*testing*/
	//matches = check_edit_name.value.match(/\S+/g) 
	//^-- matches is not defined(means it is null). if match cannot find the value of whitespace(right side equation value is null).
	//null=null returns true !(null=null) returns false and vice-versa !(null='whitespace found') returns true
	
	/*testing*/
	//matches = check_edit_name.value.split(/\s+/g) 
	//^-- means you split the content each time whitespace is found (including empty string)
	//try matches.length and console.log(matches).Since empty string is counted, it represents a value in an array as well
	
	/*testing*/
	/*if((matches = check_edit_name.value.match(/\S+/g))!=null){
		console.log("NOT whitespace: " + matches + "\nlength: " + matches.length);
	}else{
		console.log("Invalid");
	}*/
	
	
	/*!(...) similar as ==null. The result is false if the argument is the empty String 
	  (its length is zero), otherwise the result is true*/
	if((check_edit_name.value.length<=0) || !(matches=check_edit_name.value.match(/\S+/g)))
		result += "Product Name is Required!<br>";
	if((check_edit_type.value.length<=0) || !(matches=check_edit_type.value.match(/\S+/g)))
		result += "Product Type is Required!<br>";
	if((check_edit_brand.value.length<=0) || !(matches=check_edit_brand.value.match(/\S+/g)))
		result += "Product Brand is Required!<br>";
	if((check_edit_price.value.length<=0) || !(matches_digit=check_edit_price.value.match(/\d+/))) // similar to [0-9]+
		result += "Product Price is Required!<br>";
	if((check_edit_desc.value.length<=0) || !(matches=check_edit_desc.value.match(/\S+/g))) 
		result += "Product Description is Required!";
	
	console.log(matches_digit[0].length);
	console.log(matches_digit);	
	if(result.length>0){
		if(form_update.parentNode.getElementsByClassName("divMessage").length<=0){
			var div_message = document.createElement("div");
			div_message.className = "divMessage";
			div_message.innerHTML = result;
			form_update.parentNode.appendChild(div_message);
		}else{
			var div_message = document.getElementsByClassName("divMessage");
			div_message[0].innerHTML = result;
		}
		
		return false;
	}else{
		
		if(form_update.parentNode.getElementsByClassName("divMessage").length>0){
			var last_childNode_divMessage = form_update.parentNode.childNodes.length-1;
			form_update.parentNode.removeChild(form_update.parentNode.childNodes[last_childNode_divMessage]);
		}
		
		return true;
	}
	
}


//load when window is activated
window.onload = function(){
	check_upload_edit();	
	
	var check_edit_price = document.getElementById("edit_price");
	check_edit_price.addEventListener("blur",check_emptyInput);
	
	document.getElementById("formDropList").submit();
	//document.forms['formDropList'].submit();
	
}
