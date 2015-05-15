<cfimport 
	taglib =	"../ct"  
	prefix =	"ct">
<cfset this.commentid 	= commentid>
<cfset mailist	 		= ''>

<cfquery name="thisCom" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	select email, name,comments from comments where commentid = <cfqueryparam cfsqltype="cf_sql_char" value="#commentid#">
</cfquery>

<!--- ************************************************************************************ --->
<!--- followup email list                                                                  --->
<!--- ************************************************************************************ --->
<cfswitch expression="#Application.sti.Comment_ReplySubs#">
<cfcase value="Yes">

<cfloop from="1" to="4" index="i">
	<cfquery name="follow" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		select mcommentid from comments where commentid = <cfqueryparam cfsqltype="cf_sql_char" value="#commentid#">
		and publish = <cfqueryparam cfsqltype="cf_sql_tinyint" value="1"> 
		and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
	</cfquery>
	<cfset this.commentid = follow.mcommentid>
	<cfif follow.recordCount>
		<cfquery name="subs" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
			select distinct email from comments where commentid = <cfqueryparam cfsqltype="cf_sql_char" value="#this.commentid#"> and publish = <cfqueryparam cfsqltype="cf_sql_tinyint" value="1"> and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1"> and followup = <cfqueryparam cfsqltype="cf_sql_bit" value="1"> and email <> <cfqueryPARAM value="#trim(thisCom.email)#" CFSQLType='CF_SQL_VARCHAR'>
		</cfquery>
		<cfif subs.recordCount>
			<cfset mailist 		= '#mailist#,#ValueList(subs.email)#'>
		</cfif>
	<cfelse>
		<cfbreak>	
	</cfif>
</cfloop>

</cfcase>
</cfswitch>

<!--- ************************************************************************************ --->
<!--- subscriber email list                                                                --->
<!--- ************************************************************************************ --->
<cfswitch expression="#Application.sti.Comment_Subs#">
<cfcase value="Yes">

<cfquery name="follow" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	select distinct email from comments where blogpostid = #val(thispost.blogpostid)# and 
	publish = <cfqueryparam cfsqltype="cf_sql_tinyint" value="1"> and 
	valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1"> and 
	subscribe = <cfqueryparam cfsqltype="cf_sql_bit" value="1"> and 
	email <> <cfqueryPARAM value="#trim(thisCom.email)#" CFSQLType='CF_SQL_VARCHAR'>
</cfquery>

<cfif follow.recordCount>
	<cfset mailist 		= '#mailist#,#ValueList(follow.email)#'>
</cfif>
		
<cfif listlen(mailist)>
	<!--- remove duplicate --->
	<cfset fixlist = ''>
	<cfloop list="#mailist#" index="i">
		<cfif not listfind(fixlist,i)>
			<cfset fixlist = '#fixlist#,#i#'>
		</cfif>
	</cfloop>

<cfloop list="#fixlist#" index="i">
<ct:mail
	to			="#i#" 
	subject		='[#Application.sti.sitename#] New Comment On: "#thispost.blogpostname#"'>
<cfoutput>
There is a new comment on the post "#thispost.blogpostname#". <br />
#thispost.url#<br />
<br />
Author: #trim(thisCom.name)#<br />
Comment:<br />
#trim(thisCom.comments)#<br />
<br />
To unsubscribe to this post, click the link below:<br />
#application.root#index.cfm?action=unsub&id=#this.commentid#
<br /><br /></cfoutput>
</ct:mail>

</cfloop>
</cfif>

</cfcase>
</cfswitch>