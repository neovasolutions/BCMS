/**
 * @author tushar_gandhi
 */
function search_url(){
		var url="/search";
		var search_text=$('search_text').value;
		new Ajax.Updater('search', url, {
			asynchronous: false,
			evalScripts: true, 
			parameters: {
				search_text:search_text
			}
		});
		$('search').style.display='block';
	}

