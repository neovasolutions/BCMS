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
