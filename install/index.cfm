<cfparam name="url.action" default="">
<cfinclude template="header.cfm">

<cfswitch expression="#url.action#">
	<cfcase value="3">
		<cfinclude template="page_3.cfm">
	</cfcase>
	<cfcase value="2">
		<cfinclude template="page_2.cfm">
	</cfcase>
	<cfcase value="1">
		<cfinclude template="page_1.cfm">
	</cfcase>
	<cfcase value="unix">
		<cfinclude template="page_unix.cfm">
	</cfcase>
	<cfdefaultcase>
		<cfinclude template="view_license.cfm">
	</cfdefaultcase>
</cfswitch>
<cfinclude template="footer.cfm">