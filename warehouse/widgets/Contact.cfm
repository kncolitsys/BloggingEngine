<cfprocessingdirective pageEncoding="utf-8">
<cfimport 
	taglib =	"../../blogger/ct"  
	prefix =	"ct">
<cfinclude template="settings/Contact.cfm">
<a name="ContactWidget" />
<ul class="list" id="ContactWidget">
<cfoutput>
<cfif StructKeyExists(form,'myemail')>
	<cfset valid 		= 1>
	<!--- **************************************************** --->
	<!--- Blacklist Check                                      --->
	<!--- **************************************************** --->
	<cfif val(Application.sti.BasicSapmVali)>
		<cftry>
			<cfquery name="Schk" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
				select ipaddress from blacklisted_ips where ipaddress = '#cgi.REMOTE_ADDR#' and lastfound >= #CreateODBCDate( DateAdd('d', - Application.sti.BasicSapmVali ,now()) )#
			</cfquery>
				<cfif Schk.recordCount>
					<cfset valid	= "0">
				</cfif>
			<cfcatch></cfcatch>
		</cftry>
	</cfif>
	<cfif len(Application.sti.HoneyPotKey) and val(valid)>
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
	<!--- Sent Email                                           --->
	<!--- **************************************************** --->
	<cfif val(valid)>
	<ct:mail 
		from		="#form.myemail#" 
		to			="#application.sti.MailFrom#" 
		subject		="Quick Note from #Application.sti.sitename#">
		
	You Just received a quick message from #form.myemail#<br /><br />
	
	Message : #form.contactmsg#<br /><br />
	
	<cfif StructKeyExists(variables,'title') and len(title)><hr />#Application.sti.sitename# - #title#</cfif>
	</ct:mail>
	</cfif>
	
	<li class="title">#widget.sucessmsg#</li>
<cfelse>
<li class="title">#widget.title#</li>
</cfif>
<cfform action="##ContactWidget" method="post" id="contactform">
<li class="item"><cfinput type="text" class="myemail" name="myemail" required="yes" message="Please Enter Email Address" validate="email"></li>
<li class="item"><textarea name="contactmsg" id="contactmsg"></textarea></li>
<li class="item"><input type="submit" class="sent" value="#widget.button#" /></li>
</cfform>
</ul>
</cfoutput>