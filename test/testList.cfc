component extends="mxunit.framework.TestCase"
	output="false"
	hint="Test Basic API." {

	variables.autopilotapikey="74bed9e4c36b4177b646df14d54428d7";
	variables.serviceUrl="private-anon-46599800c-autopilot.apiary-mock.com/v1/";
    variables.autopilot= new src.autopilot(autopilotapikey);
    //variables.autopilot= new src.autopilot(autopilotapikey,serviceUrl);


	public void function testlist()
	{
	
		response=autopilot.list.list();

		// Save the lists for futur tests
		if (isDefined("response.lists")) {
			variables.lists=autopilot.list.list().lists;
		}

		assertIsDefined("response.lists");

	}

	public void function testcreate()
	{
	
		response=autopilot.list.create("testname");
		assertIsDefined("response.name");

	}

	public void function testcontacts()
	{
	
		// Get a list_id is not defined
		if (not isDefined("variable.lists")) {
			variables.lists=autopilot.list.list().lists;
		}
		//debug(lists);
		response=autopilot.list.contacts(lists[1].list_id);
		debug(response);
		assertIsDefined("response.contacts");

	}


	public void function testadd()
	{
	
		// Get a list_id is not defined
		if (not isDefined("variable.lists")) {
			variables.lists=autopilot.list.list().lists;
		}
		debug(lists);
		response=autopilot.list.add(lists[1].list_id,"john.smith@mail.com");
		assert(isBoolean(response), 'why?');
		assertTrue(response);

	}


	public void function testhas()
	{
	
		// Get a list_id is not defined
		if (not isDefined("variable.lists")) {
			variables.lists=autopilot.list.list().lists;
		}
		debug(lists);
		response=autopilot.list.has(lists[1].list_id,"john.smith@mail.com");
		debug(response);
		assert(isBoolean(response), 'why?');
		assertTrue(response);

	}

	public void function testremove()
	{
	
		// Get a list_id is not defined
		if (not isDefined("variable.lists")) {
			variables.lists=autopilot.list.list().lists;
		}
		debug(lists);
		response=autopilot.list.remove(lists[1].list_id,"john.smith@mail.com");
		debug(response);
		assert(isBoolean(response), 'why?');
		assertTrue(response);

	}


}