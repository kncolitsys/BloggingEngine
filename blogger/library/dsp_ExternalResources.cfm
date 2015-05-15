<!--- **************************************************** --->
<!--- External Resources Links                             --->
<!--- **************************************************** --->
<cfquery name="ext" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	select externallinkName, externallinkURL from externallink where blogpostID = #val(thispostid)# and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
</cfquery>

<cfif ext.recordCount>
	<div class="postinfo" id="ExternalReso">
	<span class="smalltitle">External Resources :</span>
	<ul>
	<cfoutput query="ext"><li><a href="#externallinkURL#">#externallinkName#</a></li></cfoutput>
	</ul>
	</div>
</cfif>