<cfparam name="url.path" default="">
<cfif len(url.key)>
	<!--- download button carry the encrypted path in url.key [hotlink blocked] --->
	<!--- Need more work in this logic. This should encrypt by session.key, but onSessionStart seems 
	randomly firing for unknown reason. Fix later --->
	<cftry>
		<cfset path 	= Decrypt( trim(url.key) , application.key, 'AES', 'hex') >
		<cfcatch><cflocation addtoken="no" url="#cgi.HTTP_REFERER#"></cfcatch>
	</cftry>
</cfif>
<cfif len(url.path)>
	<!--- direct link carry the path in the url.path [hotlink possible]         --->
	<cfset url.path		= url.path>
</cfif>

<cfset blogpostid	= listfirst(path,'\/')>
<cfset filename		= listdeleteat(path,1,'\/')>
<!--- **************************************************** --->
<!--- Store Basic File Download Count                      --->
<!--- **************************************************** --->

<cfquery name="chk" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	select downloadcountid,downloads from downloadcount where blogpostid = #val(blogpostid)# and filename = <cfqueryPARAM value="#left(filename,50)#" CFSQLType='CF_SQL_VARCHAR'>
</cfquery>
<cfif chk.recordCount>
	<cfquery name="update" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		update downloadcount set downloads = #val(chk.downloads)# + 1
		where blogpostid = #val(blogpostid)# and filename = <cfqueryPARAM value="#left(filename,50)#" CFSQLType='CF_SQL_VARCHAR'>
	</cfquery>
<cfelse>
	<cfquery name="insert" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		insert into downloadcount
		(downloadcountid,downloads,blogpostid,filename)
		values
		('#CreateUUID()#',1,#val(blogpostid)#,<cfqueryPARAM value="#left(filename,50)#" CFSQLType='CF_SQL_VARCHAR'>)
	</cfquery>
</cfif>

<cfif FileExists("#application.wh#posts/#path#")>
	<cfset FileName=listlast(path,'/\')>
	<cfheader name="Content-Disposition" value="attachment;filename=#FileName#">
	<cfcontent type="application/x-unknown" file="#application.wh#posts\#path#">
<cfelse>
	<cfset session.error	= "Sorry! File you are trying to download does not exist.">
	<cflocation addtoken="no" url="#cgi.HTTP_REFERER#">
</cfif>