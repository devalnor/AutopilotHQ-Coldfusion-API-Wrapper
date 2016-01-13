<cfcomponent
    extends="mxunit.framework.TestCase"
    output="false"
    hint="Test Basic API.">

    <cffunction name="testComponents" access="public" returntype="void">
        <cfscript>
        api = createObject("component","src.api");
        autopilot = createObject("component","src.autopilot");
        contact = createObject("component","src.contact");
        
        assertTrue(isObject(api));
        assertTrue(isObject(autopilot));
        assertTrue(isObject(contact));
       </cfscript>
   </cffunction>


</cfcomponent>