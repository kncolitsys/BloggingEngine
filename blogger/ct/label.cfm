<cfparam name="attributes.label" 			default="">

<cfswitch expression="#ThisTag.ExecutionMode#">
<cfcase value="Start">
<div class="label"><cfoutput>#attributes.label#</cfoutput> <cfif IsDefined('attributes.required')>*</cfif>&nbsp; </div><div class="field">
</cfcase>
<cfdefaultcase>
</div>
<div style="clear:both; padding:3px"></div>
</cfdefaultcase>
</cfswitch>