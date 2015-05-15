<!--- ********************************************************************* --->
<!--- Lets Delete Installation folder                                       --->
<!--- ********************************************************************* --->

<!---
Recursively delete a directory.
@param directory      The directory to delete. (Required)
@param recurse      Whether or not the UDF should recurse. Defaults to false. (Optional)
@return Return a boolean. 
@author Rick Root (rick@webworksllc.com) 
@version 1, July 28, 2005 
--->

<cftry>
<cfset deleteDirectory(ExpandPath('.\'),true)>
<cffunction name="deleteDirectory" returntype="boolean" output="false">
    <cfargument name="directory" type="string" required="yes" >
    <cfargument name="recurse" type="boolean" required="no" default="false">
    
    <cfset var myDirectory = "">
    <cfset var count = 0>

    <cfif right(arguments.directory, 1) is not "/">
        <cfset arguments.directory = arguments.directory & "/">
    </cfif>
    
    <cfdirectory action="list" directory="#arguments.directory#" name="myDirectory">

    <cfloop query="myDirectory">
        <cfif myDirectory.name is not "." AND myDirectory.name is not "..">
            <cfset count = count + 1>
            <cfswitch expression="#myDirectory.type#">
            
                <cfcase value="dir">
                    <!--- If recurse is on, move down to next level --->
                    <cfif arguments.recurse>
                        <cfset deleteDirectory(
                            arguments.directory & myDirectory.name,
                            arguments.recurse )>
                    </cfif>
                </cfcase>
                
                <cfcase value="file">
                    <!--- delete file --->
                    <cfif arguments.recurse>
                        <cffile action="delete" file="#arguments.directory##myDirectory.name#">
                    </cfif>
                </cfcase>
            </cfswitch>
        </cfif>
    </cfloop>
    <cfif count is 0 or arguments.recurse>
        <cfdirectory action="delete" directory="#arguments.directory#">
    </cfif>
    <cfreturn true>
</cffunction>
	<cfcatch>
		<cfset session.msg = "Installation all done. Lets update Teapot Settings.">
		<div class="bigbox">
		<strong>Hmmm..</strong> <br /><br />
		The "<cfoutput>#ExpandPath('.\')#</cfoutput>" folder could not be deleted automatically. <br />
		Don't worry though. <strong>Log into your web server and delete it manually.</strong> You should be alright.<br /><br />
		<a href="../administrator/index.cfm?path=4,4">Let's go to Teapot administrator. Cool Stuff Waiting...</a>
		</div>
		<cfabort>
	</cfcatch>
</cftry>

<cfset session.msg = "Installation all done. Lets update Teapot Settings.">
<div class="bigbox">
<strong>Well Done..</strong> <br /><br />
Installation is done. That was easy.<br /><br />
<a href="../administrator/index.cfm?path=4,4">Let's go to Teapot administrator. Cool Stuff Waiting...</a>
<META HTTP-EQUIV="refresh" CONTENT="5;URL=../administrator/index.cfm?path=4,4"> 
</div>
<cfabort>