$(document).ready(function () {
	$('#slideShow1').cycle({ 
	    fx:     'fade', 
	    speed:  1000, 
	    timeout: 3000, 
	    pager:  '#nav',
		next:   '#next', 
    	prev:   '#prev',
		before:  onBefore, 
    	after:   onAfter   
	});
	
	
	$("#arrow A").click(function(){ $("#logarea").slideDown('normal'); });
	$("#login A").click(function(){ $("#logarea").slideDown('normal');/*$("#login").addClass('active');$("#register").removeClass('active');*/ });
	$("#register A").click(function(){ $("#regarea").slideDown('normal');/*$("#register").addClass('active');$("#login").removeClass('active');*/ });
	$("#uarrow A").click(function(){ $("#userarea").slideDown('normal'); });
	$("#mem A").click(function(){ $("#userarea").slideDown('normal'); });
	
	$("#log LI.arrow A").click(function(){ $("#logarea").slideUp('normal');/*$("#login").removeClass('active');*/ });
	$("#log LI.close A").click(function(){ $("#logarea").slideUp('normal');/*$("#login").removeClass('active');*/ });
	$("#log LI.reg A").click(function(){ 
		$("#logarea").slideUp('normal', function(){
			$("#regarea").slideDown('normal');
		});
	});
	$("#regyet").click(function(){ 
		$("#logarea").slideUp('normal', function(){
			$("#regarea").slideDown('normal');
		});
	});
	$("#reg LI.arrow A").click(function(){ $("#regarea").slideUp('normal');/*$("#register").removeClass('active');*/ });
	$("#reg LI.close A").click(function(){ $("#regarea").slideUp('normal');/*$("#register").removeClass('active');*/ });
	$("#reg LI.log A").click(function(){ 
		$("#regarea").slideUp('normal', function(){
			$("#logarea").slideDown('normal');
		});
	});
	$("#usr LI.arrow A").click(function(){ $("#userarea").slideUp('normal'); });
	$("#usr LI.close A").click(function(){ $("#userarea").slideUp('normal'); });
	//alert($(this).attr("rel"));
	$("#anav UL LI A").click(function(){
		$(".account .tab").hide('normal');
		
		switch ($(this).attr("rel")){
			case "history": 
				$("#" + $(this).attr("rel")).load('/purchase-details');
				break;
			case "articles":
				$("#" + $(this).attr("rel")).load('/saved-articles');
				break;
			case "account_subcription":
				$("#" + $(this).attr("rel")).load('/account-subscription', function() {$('#account_subscription').load('/acc-subscription');});
				break;
			case "account_email_alert":
				$("#" + $(this).attr("rel")).load('/email-alert-setting', function() {$('#email_alert_setting').load('/account-email-alert');});
			break;
			case "account_password":
				$("#" + $(this).attr("rel")).load('/account-password-setting');
			break;
			case "update_profile":
				$("#" + $(this).attr("rel")).load('/account-information', function() {$('#accont_information').load('/show-account-information');});
			break;
				
		}

		
		$("#" + $(this).attr("rel")).show('normal');
		$("#anav UL LI").removeClass("select");
		$(this).parent().addClass("select");
		$(this).parent().parent().parent().addClass("select");
	});
	
	//This is for home links
	$("#home UL LI A").click(function(){
		//alert($(this).attr("rel"));
		$(".account .tab").hide('normal');
		$("#" + $(this).attr("rel")).show('normal');
		$("#anav UL LI").removeClass("select");
		show_tabs(($(this).attr("rel")))
//		$(this).parent().parent().parent().addClass("select");
	});
	
	
	
});

function show_tabs(tabId){
	switch (tabId){
			case "history": 
				$("#pur_history").addClass("select");
				$("#" + tabId).load('/purchase-details');
				break;
			case "articles":
				$("#saved_art").addClass("select");
				$("#" + tabId).load('/saved-articles');
				break;
			case "account_subcription":
				$("#account").addClass("select");
				$("#acc_subscription").addClass("select");
				$("#" + tabId).load('/account-subscription', function() {$('#account_subscription').load('/acc-subscription');});
				break;
			case "account_email_alert":
				$("#account").addClass("select");
				$("#acc_email_alert").addClass("select");
				$("#" + tabId).load('/email-alert-setting', function() {$('#email_alert_setting').load('/account-email-alert');});
			break;
			case "account_password":
				$("#account").addClass("select");
				$("#acc_password").addClass("select");
				$("#" +tabId).load('/account-password-setting');
			break;
			case "update_profile":
				$("#account").addClass("select");
				$("#acc_profile").addClass("select");
				$("#" + tabId).load('/account-information', function() {$('#accont_information').load('/show-account-information');});
			break;
				
		}
}

function onBefore() {  } 
function onAfter() {
    $('#output').html( '<p>'+ $(this).children('p').text() + '</p>' );
}