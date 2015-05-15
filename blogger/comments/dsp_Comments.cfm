<cfimport taglib="../ct/" prefix="ct">
<!--- **************************************************** --->
<!--- display comments                                     --->
<!--- **************************************************** --->

<cffunction name="getC" access="private" returntype="query" output="No" hint="Possible Malicious html code from a given string">
	<!--- comment Query ---->
	<cfargument name="m"    type="string" required="yes">
		<cfquery name="local.cmt" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
			select commentid, comments, name, email, website, created, publish from comments where blogpostid = #val(thispostid)# and 
			<cfif len(uid)>
				((publish >= 1 and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">) or uid = '#uid#')
			<cfelse>
				publish >= 1 and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
			</cfif>
			and mcommentid= <cfqueryparam cfsqltype="cf_sql_char" value="#arguments.m#"> 
			<cfif not val(arguments.m)>
				order by created #Application.sti.Comment_Order#
			</cfif>
		</cfquery>
	
	<cfreturn local.cmt>
</cffunction>

<cffunction name="getCblock" access="private" returntype="string" output="yes" hint="Possible Malicious html code from a given string">
<!--- Comment html block ---->
	<cfargument name="commentid"	type="string" required="yes">
	<cfargument name="comments"		type="string" required="yes">
	<cfargument name="name"			type="string" required="yes">
	<cfargument name="email"		type="string" required="yes">
	<cfargument name="website"		type="string" required="yes">
	<cfargument name="created"		type="string" required="yes">
	<cfargument name="publish"		type="string" required="yes">
	<cfargument name="Thread"		type="string" required="No" default="#Application.sti.Thread_Comment#">

<cfsavecontent variable="local.str">
	<cfoutput>
	<div class="nm"><a name="#commentid#" />
	<a href="http://www.gravatar.com/#lcase(Hash(lcase(arguments.email)))#"><img class="gravatar" src="http://www.gravatar.com/avatar/#lcase(Hash(lcase(arguments.email)))#?default=#URLDecode('#application.root#images/gravatar.png')#&s=30" /></a>
	<cfif len(arguments.website)><a href="#arguments.website#">#arguments.name#</a><cfelse>#arguments.name#</cfif></div>
	<div class="light">on #dateformat(arguments.created,'dddd dd mmmm yyyy')# #timeformat(arguments.created,'hh:mm tt')#</div>
	<div class="txt" id="cmt#arguments.commentid#">
	
	<cfif not val(arguments.publish)><u>Your comment is awaiting moderation</u><br /><br /></cfif>
	<cfswitch expression="#arguments.publish#">
		<cfcase value="2"><i>Comment removed by Administrator</i></cfcase>
		<cfdefaultcase>#arguments.comments#</cfdefaultcase>
	</cfswitch>
	</div>
	<cfswitch expression="#arguments.Thread#">
		<cfcase value="Yes">
			<div id="commentlink#arguments.commentid#" class="replytothis"><a href="javascript:replycomment('#arguments.commentid#')">Reply</a></div>
			<div id="comment#arguments.commentid#" style="display:none"></div>
		</cfcase>
		<cfdefaultcase>
			<br />
		</cfdefaultcase>
	</cfswitch>
	</cfoutput>
</cfsavecontent>
	<cfreturn local.str>
</cffunction>

<cfquery name="chk" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	select commentid from comments where blogpostid = #val(thispostid)# and
	<cfif len(uid)>
		((publish >= 1 and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">) or uid = '#uid#')
	<cfelse>
		publish >= 1 and valid = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
	</cfif>
</cfquery>

<!--- comment block --->
<cfif chk.recordCount>
<div id="commentinfo" class="redsmall">
	<cfoutput>#val(chk.RecordCount)# Comment<cfif val(chk.RecordCount) gt 1>s</cfif> : </cfoutput>
</div>
<cfset cmt = getC(0)>
<cfoutput query="cmt">
	<div class="cmts zebra1">
		#getCblock(commentid, comments, name, email, website, created, publish)#
		<cfset cmt1 = getC(commentid)>
		<cfif cmt1.recordCount>
		<cfloop query="cmt1">
			<div class="cmts zebra2">
			#getCblock(commentid, comments, name, email, website, created, publish)#
			<cfset cmt2 = getC(commentid)>
				<cfif cmt2.recordCount>
				<cfloop query="cmt2">
				<div class="cmts zebra1">
				#getCblock(commentid, comments, name, email, website, created, publish,'No')#
				</div>
				</cfloop>
				</cfif>
			</div>
		</cfloop>
		</cfif>
	</div>
</cfoutput>
</cfif>