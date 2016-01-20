component extends="mxunit.framework.TestCase"
    output="false"
    hint="Test Basic API." {

    variables.autopilotapikey="74bed9e4c36b4177b646df14d54428d7";
    variables.serviceUrl="private-anon-46599800c-autopilot.apiary-mock.com/v1/";
    variables.autopilot= new src.autopilot(autopilotapikey);
    //variables.autopilot= new src.autopilot(autopilotapikey,serviceUrl);

    public void function testadd()
    {
      
        response=autopilot.journey.add("0001","john.smith@mail.com");
        debug(response);

        message="No message";
        if (isDefined("response.message")) { message=response.message;}
        
        assertFalse(isDefined("response.error"),message);
        assertTrue(response,"Cannot add john.smith@mail.com to a journey ");
    }

    public void function testlist()
    {
      
        response=autopilot.journey.list();
        debug(response);
        assertIsDefined("response.triggers");

    }


}