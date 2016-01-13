component extends="mxunit.framework.TestCase"
    output="false"
    hint="Test Basic API." {

    variables.autopilotapikey="74bed9e4c36b4177b646df14d54428d7";
    variables.serviceUrl="private-anon-46599800c-autopilot.apiary-mock.com/v1/"
    variables.autopilot= new src.autopilot(autopilotapikey,serviceUrl);

    public void function testadd()
    {
        contact={};
        contact["FirstName"]="John";
        contact["LastName"]="Doe";
        contact["Email"]="john.doe@mail.com";
        contact["custom"]={};
        contact["custom"]["string--Test--Field"]="That's work!";

        response=autopilot.contact.add(contact);
 
        debug(response);

        assertFalse(isDefined("response.error"),response.message ?: "")
        assertIsDefined("response.contact_id");
    
    }

    public void function testchangeEmail()
    {
      
        // Wait the server to get the first john doe
        //sleep(2000);
        response=autopilot.contact.changeEmail("john.doe@mail.com","john.smith@mail.com");
        
        debug(response);
        writeOutput("string")
        assertTrue(response,"Cannot change email");
    }


    public void function testbulk()
    {
      
        contacts=[];
        contacts[1]={};
        contacts[1]["FirstName"]="Slarty";
        contacts[1]["LastName"]="Bartfast";
        contacts[1]["Email"]="test@slarty.com";
        contacts[2]={};
        contacts[2]["FirstName"]="Jerry";
        contacts[2]["LastName"]="Seinfeld";
        contacts[2]["Email"]="jerry@seinfeld.com";
        contacts[3]={};
        contacts[3]["FirstName"]="Elaine";
        contacts[3]["LastName"]="Benes";
        contacts[3]["Email"]="elaine@seinfeld.com";


        response=autopilot.contact.bulk(contacts);

        assertFalse(isDefined("response.error"),response.message ?: "")
        assertIsDefined("response.contact_ids");
    }


    public void function testget()
    {
      
        response=autopilot.contact.get("john.smith@mail.com");
        assertIsDefined("response.contact_id");

    }

    public void function testunsubscribe()
    {
      
        response=autopilot.contact.unsubscribe("john.smith@mail.com");
        debug(response);
        assertTrue(response,"Cannot unsubscribe john.smith@mail.com");
    }

    public void function testsubscribe()
    {
      
        response=autopilot.contact.subscribe("john.smith@mail.com");
        debug(response);
        assertTrue(response,"Cannot subscribe john.smith@mail.com");
    }

    public void function testdelete()
    {
      
        response=autopilot.contact.delete("john.smith@mail.com");
        assertTrue(response,"Cannot delete john.smith@mail.com");
    }

}
