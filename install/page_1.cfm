<cfform id="formfield" action="index.cfm?action=2" method="post">
<div class="accordinghead">Teapot Installation . Page 1 of 1</div>

<div class="settingitem">
	<div class="label">Datasource</div>
	<div class="item"><cfinput type="text" required="yes" message="Please Enter Datasource" style="width:100px" name="ds" id="ds" class="text" /></div>
</div>

<div class="settingitem" style="color:#666">
	<div class="label">Datasource User Name</div>
	<div class="item"><input type="text" style="width:100px" name="un" id="un" class="text" /> (leave blank if not applicable)</div>
</div>

<div class="settingitem" style="color:#666">
	<div class="label">Datasource Password</div>
	<div class="item"><input type="text" style="width:100px" name="pw" id="pw" class="text" /> (leave blank if not applicable)</div>
</div>

<div class="settingitem">
	<div class="label">Database Type</div>
	<div class="item">
	<input type="radio" value="mssql" name="dbtype" />  MS SQL &nbsp; 
	<input type="radio" value="mysql" name="dbtype" />  My SQL &nbsp;
	<input type="radio" value="PostgreSQL" name="dbtype" />  PostgreSQL &nbsp;
	</div>
</div>	
<div class="settingitem">
	<div class="label">URL to Teapot</div>
	<!--- include the post, if is not on 80 --->
	<cfif StructKeyExists(cgi,'SERVER_PORT') and cgi.SERVER_PORT neq 80>
		<cfset port = ':#cgi.SERVER_PORT#'>
	<cfelse>
		<cfset port = ''>
	</cfif>
	<cfset root = 'http://#cgi.SERVER_NAME##port##cgi.SCRIPT_NAME#'>
	<cfset root	= ListDeleteAt(root,listlen(root,'/\'),'\/')>
	<cfset root	= ListDeleteAt(root,listlen(root,'/\'),'\/')>
	<div class="item"><cfinput type="text" required="yes" message="Please Enter URL to Teapot" style="width:300px" value="#root#/" name="root" id="root" class="text" /></div>
</div>
<br />
<strong>Teapot Login Details :</strong><br /><br />
<div class="settingitem">
	<div class="label">User Name</div>
	<div class="item"><cfinput type="text" required="yes" message="Please Enter User Name<" style="width:200px" maxlength="20" name="username" id="username" value="Teapot" class="text" /></div>
</div>
<div class="settingitem">
	<div class="label">Password</div>
	<div class="item"><cfinput type="text" required="yes" message="Please Enter Password" style="width:200px" maxlength="20" name="password" id="password" value="Teapot" class="text" /></div>
</div>
<div class="settingitem">
	<div class="label">E-mail</div>
	<div class="item"><cfinput type="text" required="yes" message="Please Enter E-mail" style="width:200px" maxlength="40" name="email" id="email" class="text" /></div>
</div>
<div class="settingitem">
	<div class="label">Your Name Please</div>
	<div class="item"><cfinput type="text" required="yes" message="Please Enter Your Name" style="width:200px" maxlength="20" name="blogusername" id="blogusername" class="text" /></div>
</div>

<cfif listfirst(server.coldfusion.productversion) gte 10>
	<!--- *********************************************************** --->
	<!--- CF 10 table creation warning                                --->
	<!--- *********************************************************** --->
	<div id="tablewarming" style="padding:10px; display:none; margin:10px; background-color:#E7F4DD; border-radius: 5px; -moz-border-radius: 5px; -webkit-border-radius: 5px;">
		Your server seems to be running on ColdFusion <cfoutput>#listfirst(server.coldfusion.productversion)#</cfoutput> and in this CF version 
		"Create Table" SQL statement is not allowed by default. 
		TeaPot really like to get the tables ready.<br /><br />
		Could you please allow "Create Table" SQL in your DSN if it not already enabled? You can always set it back once the installation complete.<br /><br />
		You can also <a target="_blank" id="downloadlink" href="">download Create Table SQL scripts here</a> and create tables manually before click on the "Continue" button.
	</div>
	<script type="text/javascript">
		$(document).ready(function(e) {
			$('input:radio[name=dbtype]').click(function(e) {
				$('#tablewarming').slideDown('slow')
				$('#downloadlink').attr('href','./'+$(this).val()+'.txt')
			});
		});
	</script>
</cfif>

<br />
<div class="settingitem">
	<div class="label">&nbsp;</div>
	<div class="item">
	<input title="Click Here to Save" class="button" id="next" type="submit" value="Continue" name="submit" />
	</div>
</div>

</cfform>

<script type="text/javascript">
$('#formfield').submit(function() {
	if ( !$('input:radio[name=dbtype]:checked').length ) {
		alert("Please Select Database Type")
		return false
	}
})
</script>