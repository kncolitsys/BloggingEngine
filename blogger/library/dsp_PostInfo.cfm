<!--- **************************************************** --->
<!--- poster and time                                      --->
<!--- **************************************************** --->
<cfquery name="c" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	SELECT bloglabel.bloglabelname, bloglabel.bloglabelid
	FROM blogpost_bloglabel INNER JOIN
	bloglabel ON blogpost_bloglabel.bloglabelid = bloglabel.bloglabelid
	where blogpostid = #val(thispostid)# and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
</cfquery>
<div class="postinfo">
<cfoutput>Posted by #thispost.blogusername# at #dateformat(thispost.created,'dddd dd mmmm yyyy')# #timeformat(thispost.created,'hh:mm tt')#</cfoutput>

<cfoutput query="c"> . <a href="#application.root#index.cfm?key=#URLEncodedFormat(c.bloglabelname)#">#bloglabelname#</a>
</cfoutput>
</div>