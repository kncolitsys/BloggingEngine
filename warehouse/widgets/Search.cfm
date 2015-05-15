<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="settings/Search.cfm">
<ul class="list" id="SearchWidget">
<cfoutput>
<li class="title">#widget.title#</li>
<form action="#application.root#index.cfm?action=search" method="post" id="searchform">
<li class="item"><div style="float:left"><input type="text" class="text" value="#url.search#" name="search"></div><div style="float:left"><img class="searchbtn" align="middle" src="#application.root#styles/#Application.sti.layout#/images/search.gif" onClick="$('##searchform').submit()" style="cursor:pointer" /></div><div style="clear:both"></div></cfoutput></li>
</form>
</ul>
