
//select all
function select_all(){
	$(".item_select input:checkbox").each(function(){
		$(this).prop("checked",true);
	});
	
}

//unselect all
function unselect_all(){
	$(".item_select input:checkbox").each(function(){
		$(this).prop("checked",false);
	});
	
}

//click to select or unselect all
function multi_select(){
	//console.log("1)multiselect: "+$("#btn_multiselect:input:checkbox:checked").val());
	//console.log("2)multiselect: "+$("#btn_multiselect:input:checkbox").prop('checked'));
	
	if($("#btn_multiselect:input:checkbox").prop('checked')){
		select_all();
	}
	else{
		unselect_all();
	}
	
	check_delete();
	
}

function check_delete(){
	var check_item = 0;
	
	$(".item_select input:checkbox").each(function(){
		if($(this).prop('checked')==true)
			check_item += 1;
	});
	
	if(check_item<=0)
		$("#formDeleteProduct input:submit").prop("disabled",true);
	else
		$("#formDeleteProduct input:submit").prop("disabled",false);
	
}

$(document).ready(function(){
	check_delete();
	
});
