<cfinclude template="settings/HonyPot_Trap.cfm">
<!--- **************************************************** --->
<!--- Project Honeypot Tracking URL                        --->
<!--- **************************************************** --->
<cfif len(widget.HoneyPotURL)>
<cfoutput><div style="display:none"><a href="#widget.HoneyPotURL#">Add Comments</a></div></cfoutput>
</cfif>