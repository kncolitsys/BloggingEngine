<cfinclude template="dsp_DownloadButton.cfm">
<cfinclude template="dsp_PostInfo.cfm">
<cfinclude template="dsp_ExternalResources.cfm">
<cfinclude template="dsp_RelatedPosts.cfm">
<cfinclude template="act_UserCookie.cfm">
<cfswitch expression="#Application.sti.Comment_Order#">
<cfcase value="desc">
	<cfinclude template="../comments/form_Comment.cfm">
	<cfinclude template="../comments/dsp_Comments.cfm">
</cfcase>
<cfdefaultcase>
	<cfinclude template="../comments/dsp_Comments.cfm">
	<cfinclude template="../comments/form_Comment.cfm">
</cfdefaultcase>
</cfswitch>
<cfinclude template="dsp_ButtonSet.cfm">
<cfinclude template="qry_ViewCount.cfm">