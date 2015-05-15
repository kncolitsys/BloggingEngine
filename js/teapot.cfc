<cfcomponent 
	displayname	="framwork">

<cffunction name="morerelated" access="remote" output="no">
	<cfargument name="thispostid" required="Yes" type="string">
	
	<cfset local.postid = val( Decrypt( arguments.thispostid , session.key, 'AES', 'hex') )>
	
	<cfquery name="local.this" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		select bloglabelid from blogpost_bloglabel where blogpostid = #local.postid#
	</cfquery>

	<cfquery name="rel" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		SELECT blogpost_bloglabel.blogpostid, blogpost.blogpostname, blogpost.url, blogpost.created
		FROM blogpost_bloglabel INNER JOIN
		blogpost ON blogpost_bloglabel.blogpostid = blogpost.blogpostid
		WHERE 
		<cfif local.this.recordCount>blogpost_bloglabel.bloglabelid IN (#QuotedValueList(local.this.bloglabelid)#) and </cfif>
		blogpost.blogpostid <> #local.postid# 
		GROUP BY blogpost_bloglabel.blogpostid, blogpost.blogpostname, blogpost.url, blogpost.created
		HAVING (COUNT(blogpost_bloglabel.blogpostid) = #val(local.this.recordCount)#) order by created desc
	</cfquery>

	<cfsavecontent variable="out"><cfoutput query="rel"><li><a href="#application.root##DateFormat(created,'yyyy')#/#DateFormat(created,'mm')#/#rel.url#.cfm">#blogpostname#</a></li></cfoutput></cfsavecontent>

	<cfreturn out>
</cffunction>

</cfcomponent>