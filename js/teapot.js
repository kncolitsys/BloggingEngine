// nested comment //
commentpos = 0
function replycomment(i) {
	$('#comment'+commentpos).css('display','none')
	$('#comment'+i).html( $('#comment'+commentpos).html() ).css('display','')
	$('form #mcommentid').val(i)
	commentpos = i
	cmtresize()
}

// get more related posts //
function morerelated(i) {
	$('#morerpost').html('<img src="'+root+'images/loading1.gif">')
	$.ajax({url: root+"js/blogger.cfc?method=morerelated&returnformat=plain&thispostid="+i, dataType: "text", cache:false, success: function(data){ $('#relatedlist').html(data) }})
}
		
// create popup layer
function showpopup() {
	if ( $('#onionskin').length == 0 ) { // add new layers onclick="closepop()"
		$('#footer').add('<div id="onionskin"></div><div id="popuptoolbar"><div id="closetitle">Close</div></div><div id="popupdiv"></div>').appendTo(document.body)
	}
	$('#onionskin').fadeTo('slow', 0.9)
	$('#popuptoolbar, #popupdiv').fadeIn("slow").children('.close').css('display','inline-block')
	$('.blog iframe, .blog object, .blog embed').attr('blogger','hide').css('visibility','hidden') // hide objects that dont respect z-index
	$('#closetitle').click(function(){
		$('#onionskin, #popuptoolbar, #popupdiv').fadeOut('fast', function(){ $(this).remove() } )
		$('[blogger="hide"]').removeAttr('blogger').css('visibility','visible') // bring hidden objects back again
	})
}

$(document).ready( function(){
// IE even at ver 8 does not support max-height correctly. pathatic! JQuery to rescue
// fix code-block  max-height when overflow active. 
	IEmaxHeightFix('.codeblock','500')
	cmtresize() 
	$('#commentform').submit(function() {
		if( $('#commentform #texta').val() == '' ) {
			alert("Please Enter Comment")
			return false
		}
		// block the spam submits
		if ( $('#commentform #comment').val() !== '' ) {
			return false
		}
	})

// contact me textarea resize
$('#contactmsg').autoResize({
	onResize : function() {$(this).css({opacity:0.8});},animateCallback : function() {$(this).css({opacity:1}); }, animateDuration : 300, extraSpace : 1
});

// widget //
$('li.title:empty').remove()
// image Gallery //
function iresize() {
	$('#imgholder').css({'height': $('#popupdiv').innerHeight() }).children('#bigimgpre').css({'max-height': $('#popupdiv').height()-10- $('#igallerybar').height() ,'max-width':$('#popupdiv').width()-25})
	if ( $('#igallerybar').length == 0 ) {
		$('#imgholder').children('#bigimgpre').css({'max-height': $('#popupdiv').height()-20 })
	}
	$('.igalleryitemsml').css('border-color','#CCC').fadeTo('slow', 1)
	$('.igalleryitemsml[img="'+$('#bigimgpre').attr('src')+'"]').css('border-color','#F60').fadeTo('slow', 0.5)
}

$('.igalleryitem').click(function(){
	showpopup()
	$('#popupdiv').html('<div id="imgholder"><img id="bigimgpre" src="'+$(this).attr('img')+'" /></div>')
	$('#bigimgpre').click(function(){
		if ( $('.igalleryitemsml').length == 0) {
			$('#closetitle').click()
		} else {
			if ( $('.igalleryitemsml[img="'+$(this).attr('src')+'"]').next().length == 0 ) {
				$('.igalleryitemsml:first-child').click()
			} else {
				$('.igalleryitemsml[img="'+$(this).attr('src')+'"]').next().click()
			}
		}
	})
	// display navigation
	if ( $('#igallerybox .igalleryitem').length > 1 ) {
		$('#imgholder').append('<div id="igallerybar">'+$('#igallerybox').html()+'</div>') // bring the image gallery in to new layer
		$('#igallerybar .igalleryitem').addClass('igalleryitemsml').removeClass('igalleryitem').click( function () { // change the class
			$('#bigimgpre').attr('src',$(this).attr('img')) // change the big picture
			iresize()
			}
		)
	}
	iresize()
})

$(window).resize(function(){ iresize() })
})

// comment editor resize
function cmtresize() {
	$('form #texta').autoResize({
		onResize : function() {$(this).css({opacity:0.8});},animateCallback : function() { $(this).css({opacity:1}); }, animateDuration : 300, extraSpace : 1
	});
}
	
function IEmaxHeightFix(selector,size){ 
try
  {
	if($.browser.msie){
		$(selector).each( function() {
			var wraper = $('<div></div>').css({margin: 0, padding: 0}); 
			$(this).wrapInner(wraper);
			var realhight = $(this).children('div').innerHeight();
			if (realhight < size && $(this).children('div').textWidth() > $(this).width()) {
				$(this).height( realhight + 18 );
			}
			wraper.remove(); 
		} )
	}
  } catch(e) {}
};

$.fn.textWidth = function(){ 
	var html_org = $(this).html(); 
	var html_calc = '<span>' + html_org + '</span>' 
	$(this).html(html_calc); 
	var width = $(this).find('span:first').width(); 
	$(this).html(html_org); 
	return width; 
};

// code coloring box, line number show hide //
function copyview(e) {
	if ($('#'+e+' .lineNumber').css('display') == 'none')  {
		$('#'+e+' .lineNumber').css('display','')
	} else {
		$('#'+e+' .lineNumber').css('display','none')
	}
}

// code popup //
function codepop(e) {
	showpopup()
	$('#'+e+' .codeblock').clone().prependTo('#popupdiv').css({'border':'none','width':'auto','overflow':'visible','display':'block'})
	$('#popuptoolbar').append('<span class="tools" onclick="copyview(\'popupdiv\')">Show/Hide Line Numbers</span>')
	$('#popupdiv').scroll( function() { 
		if ( $('#popupdiv').scrollLeft() > 0 ) {
			$('#popupdiv .linebreaker').css('width', $(this).width() + $('#popupdiv').scrollLeft() - 1)
		}
	} )
}
//<div id="cb1"><div class="codeblock">
// code, copy to clipboard //
function codecopy(e) {
	if ( $('#'+e+' .codeblock:visible').length == 1 ) {
		var code = $('#'+e+' .codeblock').html()
		$('#'+e+' .codeblock .lineNumber').html('\n')
		$('#'+e+' .codeblock .codespace').remove()
		$('#'+e).before('<textarea></textarea>').prev('textarea').height( $('#'+e+' .codeblock').height()-5 ).width( $('#'+e+' .codeblock').width()-5 ).val( jQuery.trim( $('#'+e+' .codeblock').text() ) ).select()
		$('#'+e+' .codeblock').html( code ).css('display','none')
	} else {
		$('#'+e).prev('textarea').remove()
		$('#'+e+' .codeblock').css('display','block')
	}
}