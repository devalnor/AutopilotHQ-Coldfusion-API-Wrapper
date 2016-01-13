<cfcomponent
    extends="mxunit.framework.TestCase"
    output="false"
    hint="Test Basic API.">

    <cffunction name="testComponents" access="public" returntype="void">
        <cfscript>
        api = createObject("component","src.api");
        autopilot = createObject("component","src.autopilot");
        contact = createObject("component","src.contact");
        list = createObject("component","src.list");
        journey = createObject("component","src.journey");
        
        assertTrue(isObject(api));
        assertTrue(isObject(autopilot));
        assertTrue(isObject(contact));
        assertTrue(isObject(list));
        assertTrue(isObject(journey));
        
       </cfscript>
   </cffunction>


</cfcomponent>