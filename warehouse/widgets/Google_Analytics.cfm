<cfinclude template="settings/Google_Analytics.cfm">
<cfif len(widget.GoogleID)>
<cfsavecontent variable="js">
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '<cfoutput>#widget.GoogleID#</cfoutput>']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
</cfsavecontent>
<cfhtmlhead text="#js#">
</cfif>