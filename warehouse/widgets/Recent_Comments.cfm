<cfinclude template="settings/Recent_Comments.cfm">
<cfif not YesNoFormat(cookie.isMobile) or YesNoFormat(widget.ShowInMobile)>
<cfquery name="rcomments" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	<cfswitch expression="#application.dbtype#">
		<cfcase value="mssql">
			select top #val(widget.RecentComments)# comments.name, comments.commentid, blogpost.blogpostname, blogpost.created, blogpost.url
			FROM comments (nolock) INNER JOIN blogpost (nolock) ON comments.blogpostid = blogpost.blogpostid where comments.valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1"> and publish = <cfqueryparam cfsqltype="cf_sql_tinyint" value="1">
			order by comments.commentid desc
		</cfcase>
		<cfdefaultcase>
			select comments.name, comments.commentid, blogpost.blogpostname, blogpost.created, blogpost.url
			FROM comments (nolock) INNER JOIN blogpost (nolock) ON comments.blogpostid = blogpost.blogpostid where comments.valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1"> and publish = <cfqueryparam cfsqltype="cf_sql_tinyint" value="1">
			order by comments.commentid desc
			limit #val(widget.RecentComments)#
		</cfdefaultcase>
	</cfswitch>
</cfquery>
<cfif rcomments.RecordCount><ul class="list"><li class="title"><cfoutput>#widget.title#</cfoutput></li><cfoutput query="rcomments"><li class="item"><a href="#application.root##DateFormat(created,'yyyy')#/#DateFormat(created,'mm')#/#rcomments.url#.cfm###commentid#">#name# on <i>#fullLeft(blogpostname,30)#..</i></a></li></cfoutput></ul></cfif>
<cfscript>
//http://www.cflib.org/index.cfm?event=page.udfbyid&udfid=329//
function fullLeft(str, count) {
	if (not refind("[[:space:]]", str) or (count gte len(str)))
		return Left(str, count);
	else if(reFind("[[:space:]]",mid(str,count+1,1))) {
		return left(str,count);
	} else { 
		if(count-refind("[[:space:]]", reverse(mid(str,1,count)))) return Left(str, (count-refind("[[:space:]]", reverse(mid(str,1,count))))); 
		else return(left(str,1));
	}
}
</cfscript>
</cfif>