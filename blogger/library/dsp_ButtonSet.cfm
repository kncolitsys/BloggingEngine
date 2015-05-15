<!--- **************************************************** --->
<!--- button set                                           --->
<!--- **************************************************** --->

<ul class="buttonset"><cfoutput>
<cfif YesNoFormat(application.sti.smbttnset)>
<li><div class="g-plusone" data-size="small" data-annotation="none"></div></li>
<li><a href="http://del.icio.us/post?url=#thisurl#&title=#title#"><img border="0" src="#application.root#/images/del-ico-us.png" title="Add to del.icio.us" /></a></li>
<li><a href="http://digg.com/submit?phase=2&url=#thisurl#"><img border="0" src="#application.root#/images/digg.png" title="Digg" /></a></li>
<li><a href="http://technorati.com/cosmos/search.html?url=#thisurl#"><img border="0" src="#application.root#/images/technorati.png" title="Technorati" /></a></li>
<li><a href="http://blinklist.com/index.php?Action=Blink/addblink.php&url=#thisurl#&Title=#title#" ><img border="0" src="#application.root#/images/blinklist.png" title="Blinklist" /></a></li>
<li><a href="http://reddit.com/submit?url=#thisurl#&title=#title#"><img border="0" src="#application.root#/images/reddit.png" title="Reddit" /></a></li>
<li><a href="http://www.mixx.com/submit?page_url=#thisurl#"><img border="0" src="#application.root#/images/mixx.png" title="Mixx" /></a></li>
<li><a href="http://www.stumbleupon.com/submit?url=#thisurl#&title=#title#"><img border="0" src="#application.root#/images/stumbleupon.png" title="StumbleUpon" /></a></li>
<li><a href="http://www.designfloat.com/submit.php?url=#thisurl#&title=#title#"><img border="0" src="#application.root#/images/designfloat.png" title="DesignFloat" /></a></li>
<li><a href="http://twitter.com/share" class="twitter-share-button" data-count="horizontal">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></li>
<li><iframe src="http://www.facebook.com/plugins/like.php?href=#URLEncodedFormat(thisurl)#&amp;layout=button_count&amp;show_faces=true&amp;width=80&amp;action=like&amp;font&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:300px; height:21px;" allowTransparency="true"></iframe></li>
<script type="text/javascript">
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>
</cfif>
</cfoutput></ul>
<div style="clear:both"></div>
<br /><br />