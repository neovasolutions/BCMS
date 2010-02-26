/**
 * @author tushar_gandhi
 */

//These functions are for creating the save article.

function show_save_article_div(){
       document.getElementById('savearticle').style.display = 'block';
}

function save_article(){
   // var url = '/save-article';
    var page_url = window.location.href;
    var host_name = window.location.host
    var base_url = "http://" + host_name;
    var link_url = page_url.substring(base_url.length);
    var article_name = document.getElementById('article_name').value;
    $.ajax({
				url: '/save-article?article_name=' + article_name +"&link_url="+link_url,
				complete: function(data){
					document.getElementById('savearticle').style.display = 'none'
				}
			});
}

function cancel_article(){
    document.getElementById('article_name').value = '';
    document.getElementById('savearticle').style.display = 'none';
}
//This function to save the profile information of user.
function save_account_information(){
		var bstate='';
		var sstate='';
		var bstate_name='';
		var sstate_name='';
		var email=document.getElementById('email').value;
		var company=document.getElementById('company').value;
		var job=document.getElementById('job').value;
		var bfname=document.getElementById('bf_name').value;
		var blname=document.getElementById('bl_name').value;
		var baddress_1=document.getElementById('baddress_1').value;
		var baddress_2=document.getElementById('baddress_2').value;
		var bcity=document.getElementById('bcity').value;
		var bphone=document.getElementById('bphone').value;
		var bzip=document.getElementById('bzip').value;
		var bcountry=document.getElementById('bcountry').value;
		var sfname=document.getElementById('sf_name').value;
		var slname=document.getElementById('sl_name').value;
		var saddress_1=document.getElementById('saddress_1').value;
		var saddress_2=document.getElementById('saddress_2').value;
		var scity=document.getElementById('scity').value;
		var sphone=document.getElementById('sphone').value;
		var szip=document.getElementById('szip').value;
		var scountry=document.getElementById('scountry').value;
		if (document.getElementById('bstate'))
			bstate=document.getElementById('bstate').value;
		if (document.getElementById('sstate'))
			sstate=document.getElementById('sstate').value;
		//alert(bstate);
		if(document.getElementById('bstate_name'))
			bstate_name=document.getElementById('bstate_name').value;
		if(document.getElementById('sstate_name'))
			sstate_name=document.getElementById('sstate_name').value;
		//alert(bstate);
		var request_url='/save-account-information?email='+ email +'&company='+company+ '&job='+job+'&bstate='+bstate+ '&sstate='+sstate+'&bstate_name='+bstate_name + '&sstate_name='+sstate_name;
		request_url+='&bfname='+bfname+"&blname="+ blname+ '&bad1='+ baddress_1+ '&bad2='+baddress_2+'&bcity='+bcity+"&bphone="+bphone+'&bzip='+bzip+'&bcountry='+bcountry;
		request_url+='&sfname='+sfname+"&slname="+ slname+ '&sad1='+ saddress_1+ '&sad2='+saddress_2+'&scity='+scity+"&sphone="+sphone+'&szip='+szip+'&scountry='+scountry;
		//alert(request_url);
		//Check whether First name for billing address is present or not.
		if(trim(bfname)==""){
			alert("First name for billing address should not be blank.");
			return false;
		}
		//Check whether Last name for billing address is present or not.
		if(trim(blname)==""){
			alert("Last name for billing address should not be blank.");
			return false;
		}
		//Check whether Last name for shipping address is present or not.
		if(trim(slname)==""){
			alert("Last name for shipping address should not be blank.");
			return false;
		}
		//Check whether First name for shipping address is present or not.
		if(trim(sfname)==""){
			alert("First name for shipping address should not be blank.");
			return false;
		}
		if(validate(email)){
			$.ajax({
				url: request_url,
				complete: function(data){
					document.getElementById('account_message').style.display='block';
				}
			});
		}
		
	}
	//This function validates the email address
	function validate(email) {
   			var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	  		 if(reg.test(email) == false) {
    	 		 alert('Email Address is not valid');
      			return false;
   		}else{
			return true;
		}
	}
	//This function to populate the states.
	function populate_states(updateDiv, which_address_state){
		if (which_address_state == 'bs') {
			var country_id = document.getElementById('bcountry').value;
		}
		else {
			var country_id = document.getElementById('scountry').value;
		}
		//alert("country_id" +country_id);
		$.ajax({
				url: 'show-state-list?country_id='+ country_id +'&address_type=' +which_address_state,
				success: function(data, status, httpobj){
					document.getElementById(updateDiv).innerHTML=data;
				}
			});
	}
