<cflocation addtoken="no" url="install"><cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="blogger/library/global.cfm">

<cfswitch expression="#url.action#">
<cfcase value="search">
	<cfinclude template = "blogger/library/dsp_header.cfm">
	<cfinclude template = "blogger/search/index.cfm">
</cfcase>
<cfcase value="unsub">
	<cfinclude template="blogger/comments/unsubscribe.cfm">
</cfcase>
<cfcase value="spamcomment">
	<cfinclude template = "blogger/comments/act_commentFinal.cfm">
</cfcase>
<cfcase value="commentSubmit">
	<cfinclude template = "blogger/library/dsp_header.cfm">
	<cfinclude template = "blogger/comments/act_comments.cfm">
	<cfinclude template = "blogger/comments/act_spamDelay.cfm">
</cfcase>
<cfcase value="download">
	<cfinclude template = "blogger/post/act_download.cfm">
</cfcase>
<cfdefaultcase>
	<cfinclude template = "blogger/library/dsp_header.cfm">
	<cfinclude template = "blogger/post/qry_fulllist.cfm">
	<cfinclude template = "blogger/post/index.cfm">
</cfdefaultcase>
</cfswitch>

<cfinclude template = "blogger/library/dsp_footer.cfm">