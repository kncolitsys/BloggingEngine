<!--- get saved values from the cookie --->
<cfset uid	 	= ''>
<cfset myname 	= ''>
<cfset myemail 	= ''>
<cfset website	= ''>
<cfif StructKeyExists(cookie,'uid')>
	<cftry>
	<cfset uid	 	= cookie.uid>
	<cfset myname 	= cookie.myname>
	<cfset myemail 	= cookie.myemail>
	<cfset website	= cookie.website>
		<cfcatch></cfcatch>
	</cftry>
</cfif>