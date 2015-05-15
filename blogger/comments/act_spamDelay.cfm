<cfquery name="get" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
	SELECT blogpost.url, blogpost.created, comments.valid
	FROM comments INNER JOIN
	blogpost ON comments.blogpostid = blogpost.blogpostid
	where commentid = <cfqueryparam cfsqltype="cf_sql_char" value="#commentid#">
</cfquery>
		
<cfif not val(get.valid)>
<!--- **************************************************** --->
<!--- Suspected Spam. Lets add the delay message           --->
<!--- **************************************************** --->
	<div class="blog"><br /><br />
	<div class="title" id="msgline">Please Wait 10 Seconds...</div>
	<div class="titlelist" id="msgline2"><img src="<cfoutput>#application.root#images/load.gif</cfoutput>" width="16" height="16" align="absmiddle" /> We Are verifying this comment is not an spam. Please Hold.</div>
	<br /> 

<cfswitch expression="#RandRange(1,9)#">
<cfcase value="1">
When it comes, will it come without warning<br />
Just as I'm picking my nose?<br />
Will it knock on my door in the morning<br />
Or tread in the bus on my toes?<br />
Will it come like a change in the weather?<br />
Will its greeting be courteous or rough?<br />
Will it alter my life altogether?<br />
O tell me the truth about love.<br />
<i>~ W. H.Auden</i><br />
</cfcase>
<cfcase value="2">
Your baby grows a tooth, then two, and four, and five, 
then she wants some meat directly from the bone.<br />
It’s all over: she’ll learn some words,<br /> 
she’ll fall in love with cretins, dolts, a sweettalker on his way to jail.<br /> 
And you, your wife, get old, flyblown, and rue nothing. <br />
You did, you loved, your feet are sore.<br /> 
It’s dusk. Your daughter’s tall.<br />
<i>~ Thomas Lux</i><br />
</cfcase>
<cfcase value="3">
You are the man<br />
You are my other country<br />
and I find it hard going<br />
You are the prickly pear<br />
You are the sudden violent storm<br />
the torrent to raise the river<br />
to float the wounded doe<br />
<i>~ Lorine Niedecker</i><br />
</cfcase>
<cfcase value="4">
I am talking to you about poetry<br />
and you say<br />
when do we eat.<br />
The worst of it is<br />
I’m hungry too.<br />
<i>~ Alicia Partnoy</i><br />
</cfcase>
<cfcase value="5">
If there is something to desire,<br />
there will be something to regret.<br />
If there is something to regret,<br />
there will be something to recall.<br />
<br />
If there is something to recall,<br />
there was nothing to regret.<br />
If there was nothing to regret,<br />
there was nothing to desire.<br /><br />
<i>~ Alicia Partnoy</i><br />
</cfcase>
<cfcase value="6">
If there is something to desire,<br />
there will be something to regret.<br />
If there is something to regret,<br />
there will be something to recall.<br />
<br />
If there is something to recall,<br />
there was nothing to regret.<br />
If there was nothing to regret,<br />
there was nothing to desire.<br /><br />
<i>~ Alicia Partnoy</i><br />
</cfcase>
<cfcase value="7">
Good name in man and woman, dear my lord,<br />
Is the immediate jewel of their souls:<br />
Who steals my purse steals trash; tis something, nothing;<br />
Twas mine, tis his, and has been slave to thousands;<br />
But he that filches from me my good name<br />
Robs me of that which not enriches him<br />
And makes me poor indeed.<br />
<i>~ William Shakespeare</i><br />
</cfcase>
<cfcase value="8">
Good name in man and woman, dear my lord,<br />
Is the immediate jewel of their souls:<br />
Who steals my purse steals trash; tis something, nothing;<br />
Twas mine, tis his, and has been slave to thousands;<br />
But he that filches from me my good name<br />
Robs me of that which not enriches him<br />
And makes me poor indeed.<br />
<i>~ William Shakespeare</i><br />
</cfcase>
<cfcase value="9">
A leaf, one of the last, parts from a maple branch:<br />
it is spinning in the transparent air of October, falls<br />
on a heap of others, stops, fades. No one<br />
admired its entrancing struggle with the wind,<br />
followed its flight, no one will distinguish it now<br />
as it lies among other leaves, no one saw<br />
what I did. I am the only one.<br />
<i>~ Bronislaw Maj</i><br />
</cfcase>
</cfswitch>
<blockquote></blockquote>

<cfoutput>

<script type="text/javascript">
	count = #val(Application.sti.SpamDelay+1)#
	function timedMsg()
	{
		if (count == 0 ) {
			window.location="#application.root#index.cfm?action=spamcomment&id=#Encrypt(commentid, session.key, 'AES', 'hex')#";
			$('##msgline2').html("")
			$('##msgline').html('<a href="#application.root#index.cfm?action=spamcomment&id=#Encrypt(commentid, session.key, 'AES', 'hex')#">Click Here to Publish Your Comment</a>')

		} else {
			count = count - 1
			$('##msgline').html("Please Wait "+count+" Seconds...")
			var t=setTimeout("timedMsg()",1000)
		}
	}
	timedMsg()
</script>
</cfoutput>
	<cfset SetVariable("session.spamkey#listfirst(commentid,'-')#",now())>
	</div></div></body></html>
<cfelse>
	<!--- true comments jump directly to the final page --->
	<cfheader name="location" value = "#application.root#index.cfm?action=spamcomment&sendmail=Yes&id=#Encrypt(commentid, session.key, 'AES', 'hex')#">
	<cfheader statusCode="302" statusText="Document Moved">
</cfif>