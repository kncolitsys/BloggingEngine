<cfquery name="unsub" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	update comments set
	subscribe	= 0,
	followup	= 0
	where commentid = <cfqueryPARAM value="#trim(url.id)#" CFSQLType='CF_SQL_VARCHAR'>
</cfquery>
<cfquery name="get" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	SELECT comments.blogpostid, blogpost.url, blogpost.created
	FROM comments INNER JOIN
	blogpost ON comments.blogpostid = blogpost.blogpostid
	WHERE (comments.commentid = <cfqueryPARAM value="#trim(url.id)#" CFSQLType='CF_SQL_VARCHAR'>)
	ORDER BY comments.created DESC
</cfquery>
<cfset session.msg = "You are unsubscribed from this post">
<cflocation addtoken="no" url="#application.root##DateFormat(get.created,'yyyy')#/#DateFormat(get.created,'mm')#/#get.url#.cfm">