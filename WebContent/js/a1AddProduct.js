var dropbox_val=[];
var dropbox_txt=[];

function check_dropbox(check_txt, check_val){
	var valid = 0;
	
	console.log(dropbox_val);
	console.log(dropbox_txt);
	
	for(i=0; i<dropbox_val.length; i++){
	console.log("intial dropbox text: "+dropbox_txt[i]+" VS submitted dropbox text: "+check_txt);
	console.log("intial dropbox value: "+dropbox_val[i]+" VS submitted dropbox text: "+check_val);
	
	if((dropbox_val[i]==check_val) && (dropbox_txt[i]==check_txt))
		valid += 1;
	
	}
	
	if(valid<1){
		//console.log("Product Type is Invalid!<br>");
		return "Product Type is Invalid!<br>";
	}
	else{
		//console.log("nothing");
		return "";
	}
}


//if uploaded file is null, disable the upload button
function check_upload(){
	var check_add_pic = document.getElementById("add_pic");
	var check_upload_pic = document.getElementById("upload_pic");
	var check_add_pic_name = document.getElementById("add_pic_name");
	var check_add_product_submit = document.getElementById("add_product_submit");
	
	//if file is not selected, upload button is disabled
	//console.log(check_add_pic.value);
	if(check_add_pic.value=="")
		check_upload_pic.disabled = true;
	else
		check_upload_pic.disabled = false;
	
	//if file is not uploaded, submit button is disabled
	console.log(check_add_pic_name.value);
	if(check_add_pic_name.value!="-")
		check_add_product_submit.disabled = false;
	else
		check_add_product_submit.disabled = true;
	
}


//validate input price
function check_addPrice(){
	var check_add_price = document.getElementById("add_price");
	var check_add_price_value = check_add_price.value;
	var digit_check = 0;
	
	for(i=0; i<check_add_price_value.length; i++){
		for(k=48; k<=57; k++){
			if(check_add_price.value[i]==String.fromCharCode(k)){
				digit_check += 1;
				/*console.log(digit_check + ".add_price_value:" + check_add_price.value[i] + 
						".k value:" + String.fromCharCode(k));*/
				break;
			}
		}
	}
	
	if(digit_check<check_add_price_value.length){
		check_add_price.value="";
		
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
	
	var check_add_name = document.getElementById("add_name");
	var check_add_type = document.getElementById("add_type");
	var check_add_brand = document.getElementById("add_brand");
	var check_add_price = document.getElementById("add_price");
	var check_add_desc = document.getElementById("add_desc");
	var form_submit = document.getElementById("form_submit");
	
	
	console.log(check_add_type.value);
	console.log(check_add_type.options[check_add_type.selectedIndex].text);
	
	
	if(check_add_name.value.length<=0)
		result += "Product Name is Required!<br>";
	
	if(check_add_type.value.length<=0)
		result += "Product Type is Required!<br>";
	else{
		result += check_dropbox(check_add_type.options[check_add_type.selectedIndex].text, check_add_type.value);
	}
	
	if(check_add_brand.value.length<=0)
		result += "Product Brand is Required!<br>";
	if(check_add_price.value.length<=0)
		result += "Product Price is Required!<br>";
	if(check_add_desc.value.length<=0)
		result += "Product Description is Required!";
	
	/*testing*/
	//console.log(result);
	
	if(result.length>0){
		
		/*testing*/
		//alert(result);
		//console.log(form_submit.parentNode.getElementsByClassName("divMessage").length);
		
		if(form_submit.parentNode.getElementsByClassName("divMessage").length<=0){
			var div_message = document.createElement("div");
			div_message.className = "divMessage";
			div_message.innerHTML = result;
			form_submit.parentNode.appendChild(div_message);
		}else{
			var div_message = document.getElementsByClassName("divMessage");
			div_message[0].innerHTML = result;
			//console.log(document.getElementsByClassName("divMessage") +"@Waahhhh  " + result);
		}
		
		/*testing*/
		//console.log(document.getElementsByClassName("divMessage"));
		
		return false;
	}else{
		if(form_submit.parentNode.getElementsByClassName("divMessage").length>0){
			var last_childNode_divMessage = form_submit.parentNode.childNodes.length-1;
			form_submit.parentNode.removeChild(form_submit.parentNode.childNodes[last_childNode_divMessage]);
			//console.log(document.getElementsByClassName("divMessage"));
		}
		
		return true;
	}
	
		
}

//load when window is activated
window.onload = function(){
	check_upload();
	
	var check_add_price = document.getElementById("add_price");
	check_add_price.addEventListener("blur",check_addPrice);
	
	var dropbox = document.getElementById("add_type");
	
	for(i=0; i<dropbox.options.length; i++){
		console.log(dropbox.options[i].value);
		console.log(dropbox.options[i].text);
		dropbox_val.push(dropbox.options[i].value);
		dropbox_txt.push(dropbox.options[i].text);
		
	}
		
	
	
}



