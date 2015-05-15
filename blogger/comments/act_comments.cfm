<cfparam name="form.myname" 	default="">
<cfparam name="form.myemail" 	default="">
<cfparam name="form.website" 	default="">
<cfparam name="form.texta" 		default="">
<!--- **************************************************** --->
<!--- Comments Submit                                      --->
<!--- **************************************************** --->
<cfif not len(trim(form.myname))>
	<cfset session.error = "Please Enter Name">
</cfif>
<cfif not len(trim(form.myemail))>
	<cfset session.error = "Please Enter Email Address">
</cfif>
<cfif not len(trim(form.texta))>
	<cfset session.error = "Please Enter Comment">
</cfif>

<cfif IsDefined('session.error')>
	<cfif len(cgi.HTTP_REFERER)>
		<cflocation addtoken="no" url="#cgi.HTTP_REFERER###commentbox">
	<cfelse>
		<cflocation addtoken="no" url="#application.root#">
	</cfif>
<cfelse>
<!--- basic error check end. submit starts                --->

<cfinclude template="act_spamCheck.cfm">

<!--- **************************************************** --->
<!--- Comments Moderation                                  --->
<!--- **************************************************** --->
<cfswitch expression="#Application.sti.CommentMod#">
	<cfcase value="0">
		<cfset publish = 1>
	</cfcase>
	<cfcase value="1">
		<cfset publish = 0>
		<cfset session.msg = "Your Comment will be visible after approval">
	</cfcase>
	<cfcase value="2">
		<cfswitch expression="#valid#">
			<cfcase value="1">
				<cfset publish = 1>
			</cfcase>
			<cfdefaultcase>
				<cfset publish = 0>
				<cfset session.msg = "Your Comment will be visible after approval">
			</cfdefaultcase>
		</cfswitch>
	</cfcase>
</cfswitch>

<cfinclude template="qry_comments.cfm">

</cfif>
