<cfprocessingdirective pageEncoding="utf-8">
<cfsilent>
<!--- year/month folder index --->
<cfif StructKeyExists(variables,'thismonth')>
	<cfquery name="q" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		SELECT blogpost.blogpostid from blogpost
		WHERE 
	<cfswitch expression="#application.dbtype#">
		<cfcase value="mssql">
			(YEAR(blogpost.publisheddate) =  #val(thisyear)# and MONTH(blogpost.publisheddate) =  #val(thismonth)#) 
		</cfcase>
		<cfcase value="mysql">
			(DATE_FORMAT(blogpost.publisheddate,'%Y') =  #val(thisyear)# and DATE_FORMAT(blogpost.publisheddate,'%m') =  #val(thismonth)#) 
		</cfcase>
		<cfcase value="PostgreSQL">
			(EXTRACT (YEAR FROM blogpost.publisheddate) =  #val(thisyear)# and EXTRACT (MONTH FROM blogpost.publisheddate) =  #val(thismonth)#)  
		</cfcase>
	</cfswitch>
		and blogpost.valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
		order by publisheddate desc
	</cfquery>
</cfif>
<cfif not StructKeyExists(variables,'q')>
	<cfif len(url.key)>
		<!--- keyword search ---->
		<cfquery name="q" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
			SELECT blogpost.blogpostid, bloglabel.bloglabelname
			FROM blogpost INNER JOIN
			blogpost_bloglabel ON blogpost.blogpostid = blogpost_bloglabel.blogpostid INNER JOIN
			bloglabel ON blogpost_bloglabel.bloglabelid = bloglabel.bloglabelid
			WHERE 
			bloglabel.bloglabelname = <cfqueryparam value="#url.key#" cfsqltype="CF_SQL_VARCHAR"> and 
			blogpost.valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
			order by blogpostid desc
		</cfquery>
	<cfelse>
		<!--- full list      --->
		<cfquery name="q" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
			SELECT blogpost.blogpostid
			from blogpost where 
			blogpost.valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
			order by blogpostid desc
		</cfquery>
	</cfif>
</cfif>
</cfsilent>