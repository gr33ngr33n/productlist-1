var dropbox_val=[];
var dropbox_txt=[];


//validate product type (dropbox)
function check_dropbox(check_txt, check_val){
	var valid = 0;
	
	//console.log(dropbox_val);
	//console.log(dropbox_txt);
	
	for(i=0; i<dropbox_val.length; i++){
		//console.log("intial dropbox text: "+dropbox_txt[i]+" VS submitted dropbox text: "+check_txt);
		//console.log("intial dropbox value: "+dropbox_val[i]+" VS submitted dropbox text: "+check_val);

		//console.log(dropbox_val[i]==check_val);
		//console.log(dropbox_txt[i]==check_txt);
	
		if((dropbox_val[i]==check_val) && (dropbox_txt[i]==check_txt)){
			valid += 1;
		}
	
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
function check_upload_edit(){
	/*
	if file is not selected, upload button is disabled
	param:
	#edit_pic ... input txt (browse) to select pic
	#upload_edit_pic ... upload btn to upload selected pic (copy pic to server & get picname fr 'edit_pic_name')
	*/
	console.log("selected pic is: "+$("#edit_pic").val());
	if($("#edit_pic").val()!="")
		$("#upload_edit_pic").prop("disabled",false);
	else
		$("#upload_edit_pic").prop("disabled",true);
	
	
	/*
	if file is not uploaded, submit button is disabled
	param:
	#edit_pic_name ... input txt (pic name) to display picname
	#edit_product_submit ... submit btn to add new record to DB
	*/
	console.log("uploaded pic is: "+$("#edit_pic_name").val());
	if($("#edit_pic_name").val()!="-")
		$("#edit_product_submit").prop("disabled",false);
	else
		$("#edit_product_submit").prop("disabled",true);
	
}

//validate input price
function check_editPrice(){
	//console.log("slice: "+$("#edit_price").val().slice(1));
	//console.log("get 1st val: "+$("#edit_price").val()[0]);
	
	
	if($("#edit_price").val()[0]=='$'){
		if($.isNumeric($("#edit_price").val().slice(1))){
			console.log("input price is number");
			var valid_price = $("#edit_price").val().slice(1);
			$("#edit_price").val(parseInt(valid_price));
		}
		else{
			console.log("input price is NOT number");
			$("#edit_price").val("");
		}
			
	}else{
		if($.isNumeric($("#edit_price").val())){
			console.log("input price is number");
			var valid_price = $("#edit_price").val();
			$("#edit_price").val(parseInt(valid_price));
		}
		else{
			console.log("input price is NOT number");
			$("#edit_price").val("");
		}
	}
	
	var result = check_emptyInput();
	//console.log(result);
}

//check if there is any empty input
function check_emptyInput(){
		
	var result = "";	
	
	//console.log("submitted dropbox value: "+$("#edit_type option:selected").val());
	//console.log("submitted dropbox text: "+$("#edit_type option:selected").text());
	
	/*text of submitted dropbox must be trimmed bfr send to check_dropbox for validation(whitespace problem)*/
	//console.log("submitted dropbox text: "+$("#edit_type option:selected").text().trim());
	
	if(($("#edit_name").val().length<=0)||!(matches=$("#edit_name").val().match(/\S+/g))){
		result += "Product Name is Required!<br>";
		$("#edit_name").addClass("errIndicate");
	}else{
		$("#edit_name").removeClass("errIndicate"); //remove classname only
	}
	
	if($("#edit_type").val().length<=0)
		result += "Product Type is Required!<br>";
	else{
		//text of submitted dropbox must be trimmed bfr send to check_dropbox for validation(whitespace problem)
		result += check_dropbox($("#edit_type option:selected").text().trim(), $("#edit_type option:selected").val());
	}
	
	if(($("#edit_brand").val().length<=0)||!(matches=$("#edit_brand").val().match(/\S+/g))){
		result += "Product Brand is Required!<br>";
		$("#edit_brand").addClass("errIndicate");
	}else{
		$("#edit_brand").removeClass("errIndicate"); //remove classname only
	}
	
	if(($("#edit_price").val().length<=0)||!(matches=$("#edit_price").val().match(/\S+/g))){
		result += "Product Price is Required!<br>";
		$("#edit_price").addClass("errIndicate");
	}else{
		$("#edit_price").removeClass("errIndicate"); //remove classname only
	}
	
	if(($("#edit_desc").val().length<=0)||!(matches=$("#edit_desc").val().match(/\S+/g))){
		result += "Product Description is Required!";
		$("#edit_desc").addClass("errIndicate");
	}else{
		$("#edit_desc").removeClass("errIndicate"); //remove classname only
	}
	
		
	var search_divMessage = $("#form_update").parent().find(".divMessage");
	
	if(result.length>0){
		if(search_divMessage.length<=0){
			var div_message = document.createElement("div");
			div_message.className = "divMessage";
			div_message.innerHTML = result;
			
			$("#form_update").parent().append(div_message);
			
		}else{
			$(search_divMessage.get(0)).html(result);
		}
				
		return false;
	}else{
		if(search_divMessage.length>0){
			search_divMessage.remove();
		}
		
		return true;
	}
	
}


//count number of characters typed
function textarea_charCount(val){
	var charCount = val.value.length;
	$(".textareaCharCount").text("Number of Characters Typed: "+charCount);
	
}


//load when window is activated
$(document).ready(function(){
	console.log("JQuery Ready!");
	
	check_upload_edit();
	
	$("#edit_price").blur(function(){
		check_editPrice();
	});
	
	//var dropbox = document.getElementById("add_type");
	console.log($("#edit_type option").length);
	
	for(i=0; i<($("#edit_type option").length); i++){
		console.log($("#edit_type option").get(i).value);
		console.log($("#edit_type option").get(i).text);
		dropbox_val.push($("#edit_type option").get(i).value);
		dropbox_txt.push($("#edit_type option").get(i).text);
	}
	
});

