// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//This function removes the blank spaces.
function trim(str)
	{
	str = str.replace(/^\s+/, '');
	for (var i = str.length - 1; i >= 0; i--) {
		if (/\S/.test(str.charAt(i))) {
			str = str.substring(0, i + 1);
			break;
		}
	}
	return str;
}
