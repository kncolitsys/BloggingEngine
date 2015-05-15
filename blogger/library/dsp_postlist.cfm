<cfprocessingdirective pageEncoding="utf-8">
<ul class="titlelist">
<cfoutput query="thispost" maxrows="#Application.sti.Posts_Per_Page#">
	<cfset thislink = "#application.root##DateFormat(created,'yyyy')#/#DateFormat(created,'mm')#/#thispost.url#.cfm">
	<li><div class="link"><a href="#thislink#">#blogpostname#</a></div>
	<div class="smalldes"><div class="light"></div>#trim(smalldes)# <span class="more">(<a href="#thislink#">more</a>..)</span></div>
	<div class="listfooter">
	<cfquery name="thisC" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		select count(commentid) as comments from comments where blogpostid = #blogpostid# and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
	</cfquery>
	<cfif thisC.recordCount><a href="#thislink###commentbox">#val(thisC.comments)# Comment<cfif val(thisC.comments) gt 1>s</cfif></a> <img src="#application.root#styles/#Application.sti.layout#/images/divtiny.gif" align="absmiddle" /> </cfif>
	<a href="#thislink###commentbox">Post Comment</a> <img src="#application.root#styles/#Application.sti.layout#/images/divtiny.gif" align="absmiddle" />
	#DateFormat(created,'dddd dd.mm.yyyy')# by #blogusername#
	</div>
	</li>
</cfoutput>
</ul>