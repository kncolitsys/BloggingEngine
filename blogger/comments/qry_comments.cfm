<!--- remeber the user information --->
<cfif StructKeyExists(cookie,'me')>
	<cfset uid = listfirst(cookie.me,'|')>
<cfelse>
	<cfset uid = CreateUUID()>
</cfif>
<!--- cookie up user info          --->
<cfcookie expires="never" name="uid" 		value="#uid#">
<cfcookie expires="never" name="myname" 	value="#form.myname#">
<cfcookie expires="never" name="myemail" 	value="#form.myemail#">
<cfcookie expires="never" name="website"	value="#form.website#">

<!--- fix url errors --->
<cfset websiteF	= replacenocase(form.website,';',':')>
<cfset websiteF = replacenocase(websiteF,'htttp://','http://')>
<cfset websiteF = replacenocase(websiteF,'http//','http://')>
<cfif len(websiteF)>
	<cfif not findnocase('http://',websiteF)>
		<cfset websiteF = 'http://#websiteF#'>
	</cfif>
<cfelse>
	<cfset websiteF = ''>
</cfif>

<!--- *********************************************** --->
<!--- enable/disable HTML comments                    --->
<!--- *********************************************** --->
<cfswitch expression="#Application.sti.html_Comment#">
	<cfcase value="Yes">
		<cfset commentsF = cleanup(trim(form.texta))>
		<!--- If invalid XML passed in, disable html. This can be improve by prompting the user to correct it, or end any open tags automatically. --->
		<cfif not IsXML('<xml>#commentsF#</xml>')>
			<cfset commentsF = replacenocase(commentsF,'<','&lt;','all')>
		</cfif> 
	</cfcase>
	<cfdefaultcase>
		<cfset commentsF = trim(form.texta)>
		<cfset commentsF = replacenocase(commentsF,'&','&amp;','all')>
		<cfset commentsF = replacenocase(commentsF,'<','&lt;','all')>
		<cfset commentsF = replacenocase(commentsF,'>','&gt;','all')>
	</cfdefaultcase>
</cfswitch>

<cfset commentsF = replacenocase(commentsF,chr(13),'<br />','all')>
<cfparam name="form.subscribe" 	default="0">
<cfparam name="form.followup" 	default="0">

<cfset commentid = CreateUUID()>
<cfquery name="addc" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	INSERT INTO comments
		(commentid,blogpostid,mcommentid,comments,name,email,website,created,valid,publish,uid,subscribe,followup,ipaddress)
	VALUES
	('#commentid#',#val(url.key)#,
	<cfqueryPARAM value="#form.mcommentid#" CFSQLType='CF_SQL_VARCHAR'>,
	<cfqueryPARAM value="#trim(commentsF)#" CFSQLType='CF_SQL_VARCHAR'>,
	<cfqueryPARAM value="#trim(replacenocase(form.myname,'<','&lt;','all'))#" CFSQLType='CF_SQL_VARCHAR'>,
	<cfqueryPARAM value="#trim(replacenocase(form.myemail,'<','&lt;','all'))#" CFSQLType='CF_SQL_VARCHAR'>,
	<cfqueryPARAM value="#replacenocase(websiteF,'<','&lt;','all')#" CFSQLType='CF_SQL_VARCHAR'>,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(now())#">,
	<cfqueryparam cfsqltype="cf_sql_bit" value="#valid#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#publish#">,'#uid#',
	<cfqueryPARAM value="#val(form.subscribe)#" CFSQLType='cf_sql_bit'>,
	<cfqueryPARAM value="#val(form.followup)#" CFSQLType='cf_sql_bit'>,
	<cfqueryPARAM value="#cgi.REMOTE_ADDR#" CFSQLType='CF_SQL_VARCHAR'>)
</cfquery>

<cffunction name="cleanup" access="private" returntype="string" output="no" hint="Possible Malicious html code from a given string">
	<cfargument name="str"    type="string" required="yes" hint="String">

	<cfset srchstring = '<script.*?</*.script*.>|<applet.*?</*.applet*.>|<embed.*?</*.embed*.>|<ilayer.*?</*.ilayer*.>|<frame.*?</*.frame*.>|<object.*?</*.object*.>|<iframe.*?</*.iframe*.>|<style.*?</*.style*.>|<meta([^>]*[^/])>|<link([^>]*[^/])>|<script([^>]*[^/])>'>
	<cfset srchstring = '#srchstring#|<[^>]*(javascript:)[^>]*>|<[^>]*(onClick:)[^>]*>|<[^>]*(onDblClick:)[^>]*>|<[^>]*(onMouseDown:)[^>]*>|<[^>]*(onMouseOut:)[^>]*>|<[^>]*(onMouseUp:)[^>]*>|<[^>]*(onMouseOver:)[^>]*>|<[^>]*(onBlur:)[^>]*>|<[^>]*(onFocus:)[^>]*>|<[^>]*(onSelect:)[^>]*>'>
	
	<cfset str = ReReplaceNoCase(str,srchstring, "", "ALL")>
	<cfset str = reReplaceNoCase(str, "</?(div|table|tr|td|span|html|body|ul|li|ol|input|select|textarea|script|applet|embed|ilayer|frame|iframe|frameset|style|link)[^>]*>","","all")>
	<cfset str = str.ReplaceAll("<\w+[^>]*\son\w+=.*[ /]*>|<script.*/*>|</script>","") >
	
	<cfreturn str>
</cffunction>