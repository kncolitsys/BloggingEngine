<cfparam name="url.retry" 		default="">
<cfparam name="url.sendmail" 	default="No">
<cfimport 
	taglib =	"../ct"  
	prefix =	"ct">

<cfset commentid 		= Decrypt(url.id, session.key, 'AES', 'hex')>

<!--- ************************************************************************************ --->
<!--- Suspected Spam Activation                                                            --->
<!--- ************************************************************************************ --->
<cfif StructKeyExists(session,'spamkey#listfirst(commentid,'-')#') and not len(url.retry)>
	<cfset stime 	= session['spamkey#listfirst(commentid,'-')#']>
	<cfset StructDelete(session,'spamkey#listfirst(commentid,'-')#')>
	
	<cfif DateDiff('s',stime,now()) gt Application.sti.SpamDelay>
		<cfquery name="up" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
			update comments set 
			valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
			where commentid = <cfqueryparam cfsqltype="cf_sql_char" value="#commentid#">
		</cfquery>
		<cfset url.sendmail = "Yes">
	<cfelse>
		<cflocation addtoken="no" url="#application.root#index.cfm?action=spamcomment&id=#url.id#&retry=yes">
	</cfif>
</cfif>

<!--- ************************************************************************************ --->
<!--- Email. Suspected Spam Do Not Generate Email                                          --->
<!--- ************************************************************************************ --->
<cfif YesNoFormat(url.sendmail)>
	<!--- ************************************************************************************ --->
	<!--- Email Notification to admin                                                          --->
	<!--- ************************************************************************************ --->
	<cfquery name="thispost" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		SELECT blogpost.blogpostname, blogpost.url, bloguser.email, blogpost.created, blogpost.blogpostid,
		comments.name, comments.comments, comments.publish
		FROM blogpost INNER JOIN
		bloguser ON blogpost.bloguser = bloguser.bloguserid INNER JOIN
		comments ON blogpost.blogpostid = comments.blogpostid
		where commentid =  <cfqueryparam cfsqltype="cf_sql_char" value="#commentid#">
	</cfquery>
	<cfswitch expression="#Application.sti.Notify_Comments#">
	<cfcase value="Yes">
		<ct:mail
			to			= "#application.sti.MailFrom#" 
			subject		= '(#Application.sti.sitename#) New comment on "#thispost.blogpostname#"'><cfoutput>
				<cfif not val(thispost.publish)><b>Approval Pending</b><br /><br /></cfif>
				#trim(thispost.name)# has left a new comment on your post "#thispost.blogpostname#": <br />
				#application.root##DateFormat(thispost.created,'yyyy')#/#DateFormat(thispost.created,'mm')#/#thispost.url#.cfm
				<br /><br />
				#trim(thispost.comments)#
				<br /><br />
				Posted by #trim(thispost.name)# to #Application.sti.sitename# at #dateformat(now(),'mmmm dd, yyyy')# #timeformat(now(),'hh:mm tt')#</cfoutput>
		</ct:mail>
	</cfcase>
	</cfswitch>
	
	
	<!--- ************************************************************************************ --->
	<!--- Email Subscription                                                                   --->
	<!--- ************************************************************************************ --->
	<cfinclude template="act_commentSubscription.cfm">
	<cfheader name="location" value = "#application.root##DateFormat(thispost.created,'yyyy')#/#DateFormat(thispost.created,'mm')#/#thispost.url#.cfm">
	<cfheader statusCode="302" statusText="Document Moved">
</cfif>