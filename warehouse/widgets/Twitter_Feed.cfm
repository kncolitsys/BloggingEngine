<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="settings/Twitter_Feed.cfm">
<cfif len(widget.user)>
<cfif not StructKeyExists(application,'tweets') or (StructKeyExists(application,'tweets') and ArrayLen(application.tweets.feed) lt widget.tweets)>
	<cftry>
	<cfset application.tweets.lastsync	= now()>
	<cfset application.tweets.feed		= ArrayNew(1)>
	<cfhttp url="http://search.twitter.com/search.atom?q=from:#widget.user#"></cfhttp>

	<cfif StructKeyExists(cfhttp.Responseheader,'Status_Code') and listfirst(cfhttp.Responseheader.Status_Code,' ') eq 200 
			 and IsXML(cfhttp.Filecontent)>
		<cfset feed	= XMLParse(cfhttp.Filecontent).feed>
		<cfif StructKeyExists(feed,'entry')>
			<cfloop from="1" to="#ArrayLen(feed.entry)#" index="i">
				<cfset ArrayAppend(application.tweets.feed,feed.entry[i].content.XmlText)>
				<cfif i gte widget.tweets>
					<cfbreak>
				</cfif>
			</cfloop>
		</cfif>
	</cfif>
		<cfcatch></cfcatch>
	</cftry>
</cfif>
<cfif ArrayLen(application.tweets.feed)>
<ul class="list" id="Twitter_Feed"><li class="title"><cfoutput>#widget.title#</a></cfoutput></li>
<cfloop from="1" to="#ArrayLen(application.tweets.feed)#" index="i">
<li class="item"><cfoutput>#application.tweets.feed[i]#</cfoutput><div id="tweetextra"><a target="_blank" href="http://twitter.com/#!/<cfoutput>#widget.user#">#widget.followme#</cfoutput></a></div></li>
<cfif i gte widget.tweets><cfbreak></cfif>
</cfloop>
</ul>
</cfif>

<cfif DateDiff('n',application.tweets.lastsync,now()) gt widget.synchmin>
	<cfset StructDelete(application,'tweets')>
</cfif>

</cfif>