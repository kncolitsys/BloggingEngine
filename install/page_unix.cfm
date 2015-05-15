<cfif not findnocase('Windows',server.os.name)>
<div class="bigbox">
<strong>Teapot need read & write access to following files and folders.</strong> 
</div>
<br />

<cfoutput>
<table cellspacing="10">
<tr><td><img src="../images/bult.gif" align="absmiddle"> #ExpandPath('/')# (root)</td><td>Permanent.</td></tr>
<tr><td><img src="../images/bult.gif" align="absmiddle"> #ExpandPath('/index.cfm')#</td><td>During Installation.</td></tr>
<tr><td><img src="../images/bult.gif" align="absmiddle"> #ExpandPath('/Application.cfm')#</td><td>During Installation.</td></tr>
<tr><td><img src="../images/bult.gif" align="absmiddle"> #ExpandPath('/install')# (Recurse into Files & folders)</td><td>During Installation.</td></tr>
<tr><td><img src="../images/bult.gif" align="absmiddle"> #ExpandPath('/warehouse')# (Recurse into Files & folders)</td><td>Permanent.</td></tr>
</table>

</cfoutput>
	<div align="center" class="bigbox"><a href="index.cfm?action=1"><strong>Let's start the setup</strong></a></div>
<cfelse>
	<cflocation addtoken="no" url="index.cfm?action=1">
</cfif>