<cfimport taglib="../ct/" prefix="ct">
<!--- **************************************************** --->
<!--- Comments Form                                        --->
<!--- **************************************************** --->
<cfif not val(thispost.comment)>
<ct:msg>
<div id="comment0">
<div id="commentbox">
<a name="commentbox"></a>
<cfform action="#application.root#index.cfm?action=commentSubmit&key=#val(thispostid)#" method="post" id="commentform" class="formfield">
<input type="hidden" id="mcommentid" name="mcommentid" value="0" />

<ct:label label="Name">
<cfinput 
	name		= "myname" 
	value		= "#trim(myname)#"
	type		= "text" 
	validate	= "noblanks"
	required	= "yes" 
	message		= "Please Enter Your Name"
	class		= "text" 
	maxlength	= "30"/> (required) 
</ct:label>

<ct:label label="Email">
<cfinput 
	name		= "myemail" 
	type		= "text"
	class		= "text" 
	value		= "#trim(myemail)#"
	required	= "yes" 
	validate	= "email"
	message		= "Please Enter Email"
	maxlength	= "30"/> (required - never shown publicly) 
</ct:label>

<ct:label label="Web Site">
<cfinput 
	name		= "website" 
	value		= "#trim(website)#"
	type		= "text" 
	class		= "text" 
	maxlength	= "100"/> 
</ct:label>

<!--- a hidden field included as a trap for spammers --->
<cfif YesNoFormat(Application.sti.BasicSapmVali)>
<div class="hidden">
<textarea name="comment" class="hidden" id="comment" rows="4"></textarea>
</div>
</cfif>

<textarea name="texta" id="texta" rows="4"></textarea>
<div id="buttonline">
	<input title="Comment" class="buttonblu" type="submit" value="Comment" name="button" />
<cfswitch expression="#Application.sti.Comment_Subs#"><cfcase value="Yes">
	<div><input type="checkbox" name="subscribe" id="subscribe" value="1" /> Notify me of new comments via email.</div>
</cfcase></cfswitch>

<cfswitch expression="#Application.sti.Comment_ReplySubs#"><cfcase value="Yes">
	<div><input type="checkbox" name="followup" id="followup" value="1" checked="checked" /> Notify me of replies via email. </div>
</cfcase></cfswitch>
</div>

</cfform>
</div>
</div>

</cfif>