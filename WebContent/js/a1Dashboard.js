
//select all
function select_all(){
	var multi_select = document.querySelectorAll(".item_select input[type=checkbox]");
	
	for(i=0; i<multi_select.length; i++){
		multi_select[i].checked=true;
	}
	
	console.log(multi_select);
}

//unselect all
function unselect_all(){
	var multi_select = document.querySelectorAll(".item_select input[type=checkbox]");
	
	for(i=0; i<multi_select.length; i++){
		multi_select[i].checked=false;
	}
}

//click to select or unselect all
function multi_select(){
	var btn_multiselect = document.getElementById("btn_multiselect");
	
	if(btn_multiselect.checked){
		select_all();
	}else{
		unselect_all();
	}

}

//load when window is activated
window.onload = function(){
	
}
