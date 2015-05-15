<cfparam name="form.search" default="">
<cfparam name="url.page" 	default="1">
<cfif len(form.search)>
	<!--- convert the form value to url value --->
	<cfset url.search 	= form.search>
</cfif>
<cfif not len(url.search)>
	<!--- if no search string provided, send back to home page ---->
	<cflocation addtoken="no" url="#application.root#">
</cfif>

<cfinclude template="cfsearch.cfm">
<cfinclude template="../../#application.warehouse#/widget_list.cfm">