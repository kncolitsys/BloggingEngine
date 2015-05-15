<cfif StructKeyExists(thispost,'bloguserid')>
	<cfinclude template="settings/About.cfm">
	<cfinclude template="../users/about_#thispost.bloguserid#.cfm">
</cfif>