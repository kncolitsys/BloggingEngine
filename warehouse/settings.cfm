<cfsilent>
[General Settings]
<!--- Site Name                                                           --->
<cfset Application.sti.sitename		 		= "BlogCFC">
<!--- Site Description                                                    --->
<cfset Application.sti.sitedesc		 		= "My Blog">
<!--- Number of Posts to be displayed on main page [5,10,15,20,40,50,100] --->
<cfset Application.sti.Posts_Per_Page 		= "10">
<!--- Show Related Posts [Yes,No]                                         --->
<cfset Application.sti.ShowRelated		  	= "Yes">
<!--- Enable Favorite Link Button set (FaceBook, Dig, Etc..) [Yes,No]     --->
<cfset application.sti.smbttnset			= "Yes">
<!--- Header Logo Image (File name from "images" folder.)                 --->
<cfset Application.sti.logoImage		 	= "">
<!--- Enable Mobile Version [Yes,No]                                      --->
<cfset Application.sti.mobile			 	= "No">

(!)<cfset Application.sti.layout			= "Gray_Owl">

[Comments]
<!--- Notify Admin New Comments [Yes,No]                                   --->
<cfset Application.sti.Notify_Comments 		= "Yes">
<!--- Comment Enabled by Default on New Posts [Yes,No]                     --->
<cfset Application.sti.Default_Comment 		= "Yes">
<!--- Enable HTML Code in Comments [Yes,No]                                --->
<cfset Application.sti.html_Comment 		= "Yes">
<!--- Enable Thread Comment [Yes,No]                                       --->
<cfset Application.sti.Thread_Comment 		= "Yes">
<!--- Comment moderation  [0-Never,1-Always,2-Suspected Spam]              --->
<cfset Application.sti.CommentMod			= "2">
<!--- Enable Comment Subscription [Yes,No]                                 --->
<cfset Application.sti.Comment_Subs			= "Yes">
<!--- Enable Comment Reply Subscription [Yes,No]                           --->
<cfset Application.sti.Comment_ReplySubs	= "Yes">
<!--- Comments Display Order [desc-New to Old,asc-Old to New]              --->
<cfset Application.sti.Comment_Order		= "asc">

[Spam Protection]
<!--- Enable Basic Spam Validation [Yes,No]                                --->
<cfset Application.sti.BasicSapmVali		= "Yes">
<!--- Form submission delay for suspected spam comments, in seconds (Annoying Captcha replace by more human friendly delay) [3,5,10,15,20,25,30,60]--->
<cfset Application.sti.SpamDelay			= "10">
<!--- Project HoneyPot Key. (HoneyPot Rocks! Identifies spammers accurately than basic Spam Validation. Accrue a key at www.projecthoneypot.org.) --->
<cfset Application.sti.HoneyPotKey			= "">
<!--- Blacklist Spam IP address for [0-Never,3-3 Days,7-Week,14-2 Weeks,30-Month]                                --->
<cfset Application.sti.BasicSapmVali		= "7">

[Mail Settings]
<!--- Mail From Address                                                    --->
<cfset application.sti.MailFrom				= "">
<!--- Mail Server                                                          --->
<cfset application.sti.MailServer			= "">
<!--- Mail Server User Name                                                --->
<cfset application.sti.MailUsername			= "">
<!--- Mail Server Password                                                 --->
<cfset application.sti.MailPassword			= "">
<!--- Mail Server Port                                                     --->
<cfset application.sti.MailPort				= "">

[Advanced Settings]
<!--- File extension of downloadable file                                  --->
<cfset Application.sti.Download_File_Type 	= "zip">
<!--- Delete attached files when deleting a post [Yes,No]                  --->
<cfset Application.sti.Deletefile 			= "Yes">
<!--- Enable ColdFusion Search Indexing. (If cfcollection tag is disabled in your server, disable this option) [Yes,No] --->
<cfset Application.sti.cfindex	 			= "Yes">
</cfsilent>