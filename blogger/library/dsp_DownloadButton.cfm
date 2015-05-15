<!--- **************************************************** --->
<!--- Demo URL & Downloads                                 --->
<!--- **************************************************** --->
<cfquery name="demo" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	select demourl from blogpost where blogpostid = #val(thispostid)#
</cfquery>
<cfdirectory action="list" type="file" name="download" directory="#application.wh#posts/#val(thispostid)#">

<cfif len(demo.demourl) or download.recordCount>
<div class="btnbar">
	<cfif len(demo.demourl)>
		<cfoutput>
		<div class="demobttn"><a href="#demo.demourl#">Demo</a></div>
		</cfoutput>
	</cfif>
	<cfif download.recordCount>
		<cfoutput query="download">
		<div class="demobttn" onclick="window.location='#application.root#index.cfm?action=download&key=#Encrypt( "#val(thispostid)#/#trim(name)#" , application.key, 'AES', 'hex')#'">Download (#name#)</div>
		</cfoutput>
	</cfif>
</div>
</cfif>