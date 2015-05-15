<cfdirectory
	action 		= "list"
	directory 	= "#application.wh#posts/#thispostid#/igallery/"
	type 		= "file"
	name 		= "ifiles" />

<cfif ifiles.recordCount>
<div id="igallerybox">
<cfoutput query="ifiles">
<div class="igalleryitem" id="#ifiles.name#" img="#application.root##application.warehouse#/posts/#thispostid#/igallery/#ifiles.name#" style="background-image:url(#application.root##application.warehouse#/posts/#thispostid#/igallery/_thumb/#lcase(ifiles.name)#)"></div>
</cfoutput>
</div>
</cfif>