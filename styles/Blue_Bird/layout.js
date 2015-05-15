$(document).ready(function(){
	if ( $('#right').height() > $('#posts').height()) {
		$('#posts').height( $('#right').outerHeight() )	
	} else {
		$('#right').height( $('#posts').outerHeight() )
	}
})