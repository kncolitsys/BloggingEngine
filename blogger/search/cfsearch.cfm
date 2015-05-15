<cfsilent>
<!--- **************************************************** ---->
<!--- run the search query                                 ---->
<!--- **************************************************** ---->

<cfsearch 
	name		="q" 
	collection	="#application.ds#" 
	criteria	="#trim(url.search)#"
	maxrows		= "100">

<cfif q.recordCount>
<!---- ********************************************************************** --->
<!---- page navigation calculation                                            --->
<!---- ********************************************************************** --->
<cfset grid	= StructNew()>
<cfset grid.searchlist	= valuelist(q.key)>
<cfset grid.shown		= Application.sti.Posts_Per_Page>
<cfset grid.thispage 	= val(url.page)>
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
			FROM blogpost INNER JOIN
			bloguser ON blogpost.bloguser = bloguser.bloguserid
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

</cfif>
</cfsilent>

<div id="posts">
<cfif q.recordCount>
<div class="breadcrumb">Search :<cfoutput> #url.search#</cfoutput></div>
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

<cfif grid.thispage gt 1>
	<cfoutput><a href="#application.root#index.cfm?page=#val(grid.thispage-1)#&key=#url.key#&search=#url.search#&action=search">&laquo; Back</a> &nbsp; </cfoutput>
</cfif>

<cfif pagecount gt grid.thispage>
	 <cfoutput>&nbsp; <a href="#application.root#index.cfm?page=#val(grid.thispage+1)#&key=#url.key#&search=#url.search#&action=search">More Results &raquo;</a></cfoutput> 
</cfif>

</div>
<cfelse>
	<div class="breadcrumb">Your Search <strong><cfoutput> "#url.search#"</cfoutput></strong> did not match any documents.</div>
</cfif>
</div>