<!--- **************************************************** --->
<!--- Blacklist Check                                      --->
<!--- **************************************************** --->
<cfif val(Application.sti.BasicSapmVali)>
	<cftry>
		<cfquery name="Schk" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
			select ipaddress from blacklisted_ips where ipaddress = '#cgi.REMOTE_ADDR#' and lastfound >= #CreateODBCDate( DateAdd('d', - Application.sti.BasicSapmVali ,now()) )#
		</cfquery>
			<cfif Schk.recordCount>
				<cflocation addtoken="no" url="#application.root#">
			</cfif>
		<cfcatch></cfcatch>
	</cftry>
</cfif>

<cfset valid 		= 1>
<cfif len(Application.sti.HoneyPotKey)>
<!--- **************************************************** --->
<!--- HoneyPot Spam Block                                  --->
<!--- **************************************************** --->
	<cftry>
	<cfset ra = ListToArray(cgi.REMOTE_ADDR,'.')>
	<cfset ra = '#ra[4]#.#ra[3]#.#ra[2]#.#ra[1]#'>
	<cfset ad = '#Application.sti.HoneyPotKey#.#ra#.dnsbl.httpbl.org'>
	<cfset ia = CreateObject("java", "java.net.InetAddress").getByName(ad).getHostAddress()>
	<cfif listlast(ia,'.') gte 4>
		<cfset valid		= "0">
	</cfif>
	<cfcatch></cfcatch>
	</cftry>
</cfif>

<!--- **************************************************** --->
<!--- Basic Spam Validation                                --->
<!--- **************************************************** --->
<cfif val(valid) and YesNoFormat(Application.sti.BasicSapmVali)>
<cfparam name="form.comment" default="">
	<cfif len(form.comment)>
		<cfset valid		= "0">
	</cfif>
	<cfif val(valid) and (findnocase('[url=',form.texta) or findnocase('http:',form.texta)) >
		<cfset valid		= "0">
	</cfif>
</cfif>