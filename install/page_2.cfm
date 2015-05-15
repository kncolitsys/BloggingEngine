<cfif not len(application.key)>
	<cfset application.key = GenerateSecretKey('AES')>
</cfif>
<cfif not len(application.salt)>
	<cfset application.salt = CreateUUID()>
</cfif>
<!--- ********************************************************************* --->
<!--- Create Data Table                                                     --->
<!--- ********************************************************************* --->
<cfset createTable = "0">
<cftry>
	<cfquery name="chk" datasource="#form.ds#" username="#form.un#" password="#form.pw#">
		select blogpostid from blogpost where blogpostid = 1
	</cfquery>
	<cfcatch>
		<cfif trim(cfcatch.Message) eq "Datasource #form.ds# could not be found.">
				<cfoutput>
				<div style="font-size:18px; font-family:Georgia, 'Times New Roman', Times, serif">
					Oh Snap! We just started and this happened. Datasource #form.ds# could not be found. 
				</div>
				<div style="font-size:14px; font-family:Georgia, 'Times New Roman', Times, serif; padding-top:20px">
					Don't worry though, easy to fix.
					Please Create a DSN name #form.ds# using #server.coldfusion.productname# Administrator or enter correct Datasource name. <br /><br />
					ColdFusion server said : <cfoutput> "#cfcatch.Cause.Message#" </cfoutput> <br /><br />
				</div>	
				<a href="#cgi.HTTP_REFERER#">Back</a>
				</cfoutput>
			<cfabort>
		</cfif>
		<cfset createTable = "1">
	</cfcatch>
</cftry>

<cfif val(createTable)>
<cftry>
<cftransaction>
<cfswitch expression="#form.dbtype#">
	<cfcase value="mssql">
		<!--- create mssql database ---->
		<cfquery name="create" datasource="#form.ds#" username="#form.un#" password="#form.pw#">
			<cfinclude template="mssql.txt">
		</cfquery>
	</cfcase>
	<cfcase value="mysql">
		<!--- create mysql database ---->
		<cfsavecontent variable="mysql"><cfinclude template="mysql.txt"></cfsavecontent>
		<cfloop list="#mysql#" delimiters="##" index="i">
			<cfquery name="create" datasource="#form.ds#" username="#form.un#" password="#form.pw#">#i#</cfquery>
		</cfloop>
		<cfabort>
	</cfcase>
	<cfcase value="PostgreSQL">
		<!--- create postgres database ---->
		<cfquery name="create" datasource="#form.ds#" username="#form.un#" password="#form.pw#">
			<cfinclude template="PostgreSQL.txt">
		</cfquery>
	</cfcase>
</cfswitch>			
</cftransaction>
<!--- ********************************************************************* --->
<!--- Database Creation Error                                               --->
<!--- ********************************************************************* --->
	<cfcatch>
		<div style="font-size:18px; font-family:Georgia, 'Times New Roman', Times, serif">Oh Snap! We just started and this happened. Table Creation failed.<br /><br />
		Don't worry though, easy to fix.
		</div>
		<div style="font-size:14px; font-family:Georgia, 'Times New Roman', Times, serif; padding-top:20px">
			 <a target="_blank" href="<cfoutput>#form.dbtype#.txt</cfoutput>">Download SQL script file</a> and run it manually, come back here and refresh the page. 
			<br /><br />
			Probably your DSN do not allow Table Creation or some tables already exists in your database.<br /><br />
			ColdFusion server said :
			<cfoutput> "#cfcatch.Cause.Message#" </cfoutput> and <a href="javascript:$('#moreinfo').slideDown('slow')">lot of other things</a>
		</div><br /><br />

		<div id="moreinfo" style="display:none">
		<cfdump var="#cfcatch#">
		</div>
		<cfabort>
	</cfcatch>
</cftry>
</cfif>

<!--- ********************************************************************* --->
<!--- Create Login                                                          --->
<!--- ********************************************************************* --->
<cfset salt			= CreateUUID()>
<cfset EnPassword	= hash("#trim(form.password)##salt##application.salt#","SHA-256")>
<cfquery name="chk" datasource="#form.ds#" username="#form.un#" password="#form.pw#">
	select bloguserid, cookiekey, blogusername from bloguser where 
	username 		= <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.username)#">
	and password 	= <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.password)#"> 
	and email 		= <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">
</cfquery>
<cfif chk.recordCount>
	<cfcookie name="blogid" value="#Encrypt(cookiekey, application.key, 'AES', 'hex')#">
	<cfcookie name="name" 	value="#chk.blogusername#">
<cfelse>
	<cfset cookiekey = CreateUUID()>
	<cftransaction>
		<cfquery name="ins" datasource="#form.ds#" username="#form.un#" password="#form.pw#">
			insert into bloguser
			(blogusername,cookiekey,username,password,salt,email,valid,createdate) values
			('#form.blogusername#', '#cookiekey#', '#form.username#', '#EnPassword#','#salt#' ,'#form.email#',<cfqueryparam cfsqltype="cf_sql_bit" value="1">, #CreateODBCDateTime(now())#)
		</cfquery>
	</cftransaction>
	<cfcookie name="blogid" value="#Encrypt(cookiekey, application.key, 'AES', 'hex')#">
	<cfcookie name="name" 	value="#form.blogusername#">
</cfif>

<!--- ********************************************************************* --->
<!--- Fillup Application.cfm                                                --->
<!--- ********************************************************************* --->
<cfif right(form.root,'1') neq '/'>
	<cfset form.root	= '#form.root#/'>
</cfif>

<cffile action="read" file="#ExpandPath('../Application.cfc')#" variable="app" charset = "utf-8">
<cfset app = replace(app,'<cfset this.name 				= "blogger_blog">','<cfset this.name 				= "blogger_#form.ds#">')>
<cfset app = replace(app,'<cfset application.ds		= "">','<cfset application.ds		= "#form.ds#">')>
<cfset app = replace(app,'<cfset application.un		= "">','<cfset application.un		= "#form.un#">')>
<cfset app = replace(app,'<cfset application.pw		= "">','<cfset application.pw		= "#form.pw#">')>
<cfset app = replace(app,'<cfset application.dbtype	= "">','<cfset application.dbtype	= "#form.dbtype#">')>
<cfset app = replace(app,'<cfset application.root		= "">','<cfset application.root		= "#form.root#">')>
<cfset app = replace(app,'<cfset application.key 		= "">','<cfset application.key 		= "#application.key#">')>
<cfset app = replace(app,'<cfset application.salt 	= "">','<cfset application.salt 	= "#application.salt#">')>
<cffile action="write" mode = "#application.chomd#" file="#ExpandPath('../Application.cfc')#" output="#app#" charset = "utf-8">

<!--- ********************************************************************* --->
<!--- Fix index file                                                        --->
<!--- ********************************************************************* --->
<cfif FileExists(ExpandPath('../index.cfm'))>
	<cffile action="read" file="#ExpandPath('../index.cfm')#" variable="index" charset = "utf-8">
	<cfset index = Replace(index,'<cflocation addtoken="no" url="install">','')>
	<cffile action="write" file="#ExpandPath('../index.cfm')#" output="#index#" addnewline="no">
</cfif>

<!--- ********************************************************************* --->
<!--- Add the email address to setting file                                 --->
<!--- ********************************************************************* --->
<cfset var 			= "application.sti.MailFrom">
<cfset settingfile	= ExpandPath('../warehouse/settings.cfm')>
<cffile action="read" file="#settingfile#" variable="set" charset = "utf-8">

<cfset pos			= findnocase(var,set)>
<!--- find the list position of this variable --->
<cfset pos			= listlen(left(set,pos),'#chr(10)#')>
<!--- get the full string                     --->
<cfset thisString	= listgetat(set,pos,chr(10))>
<cfset string 		= left(thisString,find('= "',thisString)+2)>
<!--- update this string                     --->
<cfset string		= '#string##replace(trim(form.email),'"','""','all')#">'>
<!--- update the file                        --->
<cfset set			= ListSetAt(set,pos,string,chr(10))>
<!--- save the setting file                  --->
<cffile
	action 		= "write"
	mode		= "#application.chomd#"
	file 		= "#settingfile#"
	output 		= "#set#"
	addnewline 	= "No" 
	charset 	= "utf-8" >
	
<!--- ********************************************************************* --->
<!--- Reset Application                                                     --->
<!--- ********************************************************************* --->
<cfset session.ApplicationReset = ''>

<cfset session.msg = "Installation all done. Let's update Teapot Settings.">
<cflocation addtoken="no" url="index.cfm?action=3">