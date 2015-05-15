<cfprocessingdirective pageEncoding="utf-8">
<div id="posts">
<div class="breadcrumb"><cfoutput><a href="#application.root#">Home</a>
<cfif StructKeyExists(variables,'thismonth')>  &raquo; #MonthAsString(thismonth)#, #thisyear#</cfif>
<cfif len(url.key)>&raquo; <a href="#application.root#index.cfm/1/#url.key#">#url.key#</a></cfif>
<cfif val(url.action) gt 1>&raquo; Page #url.action#</cfif></cfoutput></div>

<cfsilent>
<!---- ********************************************************************** --->
<!---- page navigation calculation                                            --->
<!---- ********************************************************************** --->
<cfset grid	= StructNew()>
<cfset grid.searchlist	= valuelist(q.blogpostid)>
<cfset grid.shown		= Application.sti.Posts_Per_Page>
<cfset grid.thispage 	= val(url.action)>
<cfset grid.total 		= q.recordCount>
<cfset grid.getlist		= ''>
<cfset grid.endpage		= grid.thispage*grid.shown>
<cfset grid.stpage		= grid.endpage-grid.shown+1>
<cfif grid.endpage gt grid.total>
	<cfset grid.endpage = grid.total>
</cfif>

<cfloop from="#grid.stpage#" to="#grid.endpage#" index="i"> 
    <cfset grid.getlist	= ListAppend(grid.getlist, listgetat(grid.searchlist,i))>
</cfloop>
<cfset grid.searchlist = grid.getlist>

<!---- ********************************************************************** --->
<!---- display post list                                                      --->
<!---- ********************************************************************** --->
<cfquery name="thispost" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	<cfswitch expression="#application.dbtype#">
		<cfcase value="mssql">
			select top #Application.sti.Posts_Per_Page+1# blogpost.blogpostid, blogpost.blogpostname, blogpost.created, blogpost.url, blogpost.smalldes, blogpost.comment, bloguser.blogusername
			FROM blogpost (nolock) INNER JOIN
			bloguser (nolock) ON blogpost.bloguser = bloguser.bloguserid
			WHERE (blogpost.valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1"> )
			<cfif listlen(grid.searchlist)>and blogpost.blogpostid in (#grid.searchlist#)</cfif>
			order by blogpost.blogpostid desc
		</cfcase>
		<cfdefaultcase>
			select blogpost.blogpostid, blogpost.blogpostname, blogpost.created, blogpost.url, blogpost.smalldes, blogpost.comment, bloguser.blogusername
			FROM blogpost INNER JOIN
			bloguser ON blogpost.bloguser = bloguser.bloguserid
			WHERE (blogpost.valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1"> )
			<cfif listlen(grid.searchlist)>and blogpost.blogpostid in (#grid.searchlist#)</cfif>
			order by blogpost.blogpostid desc
			Limit #Application.sti.Posts_Per_Page+1#
		</cfdefaultcase>
	</cfswitch>
</cfquery>
</cfsilent>

<cfinclude template="../library/dsp_postlist.cfm">

<!---- ********************************************************************** --->
<!---- page navigation links                                                  --->
<!---- ********************************************************************** --->
<div class="pagespan">
<cfset pagecount	= Ceiling(grid.total/grid.shown)>

<cfset Start = (Ceiling(grid.thispage/10)*10)-9>
<cfset end	 = (Ceiling(grid.thispage/10)*10)>
<cfif end gt pagecount>
	<cfset end = pagecount>
</cfif>

<cfif pagecount gt grid.thispage>
	 <cfoutput><a href="#cgi.script_name#?key=#url.key#&action=#val(grid.thispage+1)#">Previous Posts</a></cfoutput> 
</cfif>

<cfif grid.thispage neq 1> &nbsp; <cfoutput><a href="#application.root#">Home</a></cfoutput></cfif>

<cfif grid.thispage gt 1>
	&nbsp; <cfoutput><a href="#cgi.script_name#?key=#url.key#&action=#val(grid.thispage-1)#">Recent Posts</a></cfoutput>
</cfif>

</div>

</div>
<cfinclude template="../../#application.warehouse#/widget_list.cfm">