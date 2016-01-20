/**
*
* @file  /src/trigger.cfc
* @author Maxime de Visscher 
* @description
*
*/

component output="false" displayname=""  {

	variables.component="Trigger";

	public any function init(
		required any api,
		required any utils	
	){
		variables.api = arguments.api;
		variables.utils = arguments.utils;
		return this;
	}

	/**
	* Add a contact to a journey
	* http://docs.autopilot.apiary.io/#reference/api-methods/trigger-journey/add-a-contact-to-a-journey
	* @trigger_id ID of the trigger
	* @contact_id_or_email Either the Autopilot contact_id e.g. person_9EAF39E4-9AEC-4134-964A-D9D8D54162E7, or the contact's email address.
	*/
	public any function add(
		required string trigger_id,
		required string contact_id_or_email
	) {
		response = apiCall('POST','trigger/#trigger_id#/contact/#contact_id_or_email#');
		if (response.statuscode is 200) 
			return true; 
		else 
			return response.responseJson;		
	}

	/**
	* Get list of journeys containing API triggers
	* http://docs.autopilot.apiary.io/#reference/api-methods/get-list-of-journeys-containing-api-triggers/add-a-contact-to-a-journey
	*/
	public any function list(
	) {		
		response = apiCall('GET','triggers');
		return response.responseJson;		
	}

	private any function apiCall (
		string httpMethod = 'GET',
		string path = '/',
		any body = '',
		struct queryParams = {},
		struct headers = {}
		)
	{

		var apiResponse = variables.api.call(arguments.httpMethod,arguments.path,arguments.body);
		apiResponse[ 'responseJson' ] = {};

		if (not structKeyExists(apiResponse, "error"))	{
			
			// Parse API answer
			if (isJson(apiResponse.rawData)) {
				apiResponse[ 'responseJson' ] = deserializeJSON(apiResponse.rawData);
			} else {
				apiResponse[ 'responseJson' ] = {};
			}

			// API issue
			if ( apiResponse.statusCode != 200) {
				apiResponse[ 'error' ] = apiResponse[ 'responseJson' ];
			} 

		} else {
			// Connection issue
			apiResponse[ 'responseJson' ] = apiResponse[ 'error' ];
		}

		return apiResponse;
	}

}