<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">root = '#application.root#'</script>
<script src="http://code.jquery.com/jquery-1.5.2.min.js"></script>
<script type='text/javascript' src='#application.root#js/jquery/autoresize.jquery.min.js'></script>
<script type='text/javascript' src='#application.root#js/blogger.js'></script>
<script type='text/javascript' src='#application.root#styles/#Application.sti.layout#/layout.js'></script>
<link rel="stylesheet" type="text/css" href="#application.root#styles/#Application.sti.layout#/style.css"/>
<link rel="stylesheet" type="text/css" href="#application.root#styles/#Application.sti.layout#/post.css"/>
<title><cfif len(title)>#title#</cfif> : #Application.sti.sitename# - #Application.sti.sitedesc#</title>
</head>
<body>
<div id="hContainer"><div id="header"><a href="#application.root#index.cfm"><cfif len(Application.sti.logoImage)><img src="#application.root#images/#Application.sti.logoImage#" title="#Application.sti.sitename# - #Application.sti.sitedesc#" border="0" /><cfelse>#Application.sti.sitename#</cfif></a></div></div>
<div id="body">
</cfoutput>