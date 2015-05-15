<cfsilent>
<cfquery name="thispost" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
SELECT blogpost.comment, blogpost.blogpostname, blogpost.smalldes, bloguser.blogusername, bloguser.bloguserid, bloguser.email, blogpost.created, blogpost.url
FROM blogpost INNER JOIN
bloguser ON blogpost.bloguser = bloguser.bloguserid
where blogpostid = #val(thispostid)#
</cfquery>
<cfset title 	= "#thispost.blogpostname#">
<cfset thisurl	= "#application.root##DateFormat(thispost.created,'yyyy')#/#DateFormat(thispost.created,'mm')#/#thispost.url#.cfm">

<cfhtmlhead text = '<meta name="description" content="#HTMLEditFormat(thispost.smalldes)#" />'>

</cfsilent>