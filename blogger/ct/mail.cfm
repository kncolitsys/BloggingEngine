<cfparam name="attributes.from" 		default="#application.sti.MailFrom# (#Application.sti.sitename#)">
<cfparam name="attributes.to" 			default="">
<cfparam name="attributes.subject" 		default="">

<cfswitch expression="#ThisTag.ExecutionMode#">
<cfcase value="Start"></cfcase>
<cfdefaultcase>

<!--- ************************************************************************************ --->
<!--- User may not pass server/username/passwrd. Need to handle that                       --->
<!--- ************************************************************************************ --->
	<cfif listfirst(server.coldfusion.productversion) gte 8>
		<!--- ************************************************************************************ --->
		<!--- CF 8 & greater use [attributecollection].                                            --->
		<!--- ************************************************************************************ --->
		<cfset attributecollection.from		="#attributes.from#">
		<cfset attributecollection.to		="#attributes.to#">
		<cfset attributecollection.type		="html">
		<cfset attributecollection.subject	="#attributes.subject#">
		<cfif len(application.sti.MailServer)>
			<cfset attributecollection.server	="#application.sti.MailServer#">
		</cfif>
		<cfif len(application.sti.MailUsername)>
			<cfset attributecollection.username	="#application.sti.MailUsername#">
		</cfif>
		<cfif len(application.sti.MailPassword)>
			<cfset attributecollection.password	="#application.sti.MailPassword#">
		</cfif>
		<cfif len(application.sti.MailPort)>
			<cfset attributecollection.port		="#application.sti.MailPort#">
		</cfif>
		<cfmail attributecollection="#attributecollection#"><cfoutput>#thisTag.GeneratedContent#</cfoutput></cfmail>
	<cfelse>
		<!--- ************************************************************************************ --->
		<!--- On older CF version have to use reasonable IF conditions                             --->
		<!--- ************************************************************************************ --->
		<cfif len(application.sti.MailServer)>
			<cfmail 
				from		="#application.sti.MailFrom# (#Application.sti.sitename#)" 
				to			="#attributes.to#" 
				type		="html"
				subject		="#attributes.subject#"
				server		="#application.sti.MailServer#" 
				username	="#application.sti.MailUsername#" 
				password	="#application.sti.MailPassword#" 
				port		="#application.sti.MailPort#">
					<cfoutput>#thisTag.GeneratedContent#</cfoutput>
			</cfmail>
		<cfelse>
			<cfmail 
				from		="#application.sti.MailFrom# (#Application.sti.sitename#)" 
				to			="#attributes.to#" 
				subject		="#attributes.subject#"
				type		="html">
					<cfoutput>#thisTag.GeneratedContent#</cfoutput>
			</cfmail>
		</cfif>
	</cfif>
	<cfset thisTag.GeneratedContent 	= "">
</cfdefaultcase>
</cfswitch>