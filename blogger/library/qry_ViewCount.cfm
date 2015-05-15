<!--- **************************************************** --->
<!--- update view count                                    --->
<!--- **************************************************** --->
<cfquery name="up" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	update blogpost set
	pageviews = pageviews+1
	where blogpostid = #val(thispostid)#
</cfquery>
