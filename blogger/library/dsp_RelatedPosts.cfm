<!--- **************************************************** --->
<!--- Show Related Posts                                   --->
<!--- **************************************************** --->
<cfif YesNoFormat(Application.sti.ShowRelated) and c.recordCount and not YesNoFormat(cookie.isMobile)>
	<cfquery name="rel" datasource="#application.ds#" username="#application.un#" password="#application.pw#">
		<cfswitch expression="#application.dbtype#">
			<cfcase value="mssql">
				SELECT top 6 blogpost_bloglabel.blogpostid, blogpost.blogpostname, blogpost.url, blogpost.created
				FROM blogpost_bloglabel INNER JOIN
				blogpost ON blogpost_bloglabel.blogpostid = blogpost.blogpostid
				WHERE (blogpost_bloglabel.bloglabelid IN (#QuotedValueList(c.bloglabelid)#) and blogpost.blogpostid <> #val(thispostid)#)
				GROUP BY blogpost_bloglabel.blogpostid, blogpost.blogpostname, blogpost.url, blogpost.created
				HAVING (COUNT(blogpost_bloglabel.blogpostid) = #c.recordCount#) order by created desc
			</cfcase>
			<cfcase value="PostgreSQL,mysql">
				SELECT blogpost_bloglabel.blogpostid, blogpost.blogpostname, blogpost.url, blogpost.created
				FROM blogpost_bloglabel INNER JOIN
				blogpost ON blogpost_bloglabel.blogpostid = blogpost.blogpostid
				WHERE (blogpost_bloglabel.bloglabelid IN (#QuotedValueList(c.bloglabelid)#) and blogpost.blogpostid <> #val(thispostid)#)
				GROUP BY blogpost_bloglabel.blogpostid, blogpost.blogpostname, blogpost.url, blogpost.created
				HAVING (COUNT(blogpost_bloglabel.blogpostid) = #c.recordCount#) order by created desc
				Limit 6
			</cfcase>
		</cfswitch>
	</cfquery>

	<cfif rel.recordCount>
	<div class="postinfo">
	<span class="smalltitle">You May Also Like :</span>
	<ul id="relatedlist">
	<cfoutput query="rel" maxrows="5"><li><a href="#application.root##DateFormat(created,'yyyy')#/#DateFormat(created,'mm')#/#rel.url#.cfm">#blogpostname#</a></li></cfoutput>
    <cfif rel.recordCount gt 5><cfoutput><li id="morerpost"><a id="#val(thispostid)#" href="javascript:morerelated('#Encrypt( val(thispostid) , session.key, 'AES', 'hex')#')">More...</a></li></cfoutput></cfif>
	</ul>
	</div>
	</cfif>
</cfif>