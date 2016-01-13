component extends="mxunit.framework.TestCase"
    output="false"
    hint="Test Basic API." {

    variables.autopilotapikey="74bed9e4c36b4177b646df14d54428d7";
    variables.serviceUrl="private-anon-46599800c-autopilot.apiary-mock.com/v1/"
    variables.autopilot= new src.autopilot(autopilotapikey,serviceUrl);

    public void function testadd()
    {
      
        response=autopilot.trigger.add("0001","john.smith@mail.com");

        assertTrue(response,"Cannot trigger john.smith@mail.com");
    }

    public void function testlist()
    {
      
        response=autopilot.trigger.list();
        debug(response)
        assertIsDefined("response.triggers");

    }


}