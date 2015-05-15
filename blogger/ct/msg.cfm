<cfif IsDefined('session.error')>
	<div id="errormsg"><div class="bdr">
		<cfoutput><img src="#application.root#images/erroricon.gif" align="middle"> #session.error#</cfoutput>
		<cfset StructDelete(session, "error")>
	</div></div>
</cfif>
<cfif IsDefined('session.msg')>
	<div id="msg"><div class="bdr">
		<cfoutput><img src="#application.root#images/msgicon.gif" align="middle"> #session.msg#</cfoutput>
		<cfset StructDelete(session, "msg")>
	</div></div>
</cfif>