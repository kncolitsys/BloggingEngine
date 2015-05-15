<cfparam name="attributes.title" 		default="">
<cfparam name="attributes.fulltitle" 	default="">
<cfparam name="cookie.bc" 				default="">
<cfparam name="attributes.start" 		default="">
<cfparam name="attributes.end" 			default="">

<cfif len(attributes.start)>
	<cfcookie name="bc" value="">
</cfif>

<!--- if breadcrumb is long than 10, remove first position --->
<cfif listlen(cookie.bc) gt 7>
	<cfset thisbc	= ListDeleteAt(cookie.bc,1)>
<cfelse>
	<cfset thisbc	= cookie.bc>
</cfif>

<cfif not len(attributes.title)>
	<cfset newbc	= ''>
    <cfcookie name="bc" value="">
<cfelse>
	<!--- First check if this title in the list already  --->
	<cfset thislocation	= '#cgi.QUERY_STRING#|#attributes.title#'>
    <cfset thissting	= '#thisbc#,#thislocation#'>
    
    <!--- Remove anything after this title               --->
    <cfset firstloc	= findnocase(attributes.title,thissting)>
    <cfset newbc	= mid(thissting,1,firstloc+len(attributes.title))>
    <cfcookie name="bc" value="#newbc#">
</cfif>

<table cellpadding="0" cellspacing="0" width="100%" border="0">
<tr>
<td id="breadCrumb" align="left" style="background-image:url(images/bcbg.png); overflow:hidden"><img src="images/bcbg.png" align="absmiddle" />

<cfoutput>
	<cfloop list="#newbc#" index="i">
		<cfset link		= listfirst(i,'|')>
        <cfset label	= listlast(i,'|')>
	 <a href="?#link#">#label#</a> <img align="absmiddle" src="images/bcarow.gif" />
	</cfloop>
</cfoutput>
</td>
</tr>
</table>
<cfif len(attributes.end)>
	<cfcookie name="bc" value="">
</cfif>