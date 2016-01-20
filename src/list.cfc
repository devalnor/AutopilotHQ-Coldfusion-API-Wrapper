/**
*
* @file  /src/trigger.cfc
* @author Maxime de Visscher 
* @description
*
*/

component output="false" displayname=""  {

	variables.component="List";

	public any function init(
		required any api,
		required any utils	
	){
		variables.api = arguments.api;
		variables.utils = arguments.utils;
		return this;
	}


	/**
	* Get list of lists
	* http://docs.autopilot.apiary.io/#reference/api-methods/lists/get-list-of-lists
	*/
	public any function list(
	) {		
		response = apiCall('GET','lists');
		return response.responseJson;		
	}


	/**
	* Create a new list
	* http://docs.autopilot.apiary.io/#reference/api-methods/lists/get-list-of-lists
	* @name name of the new list
	*/
	public any function create(
		required string name
	) {		
		var body={};
		body["name"]=arguments.name;
		response = apiCall('POST','list',utils.serializeJSON(body));
		return response.responseJson;		
	}


	/**
	* Get contact on list
	* http://docs.autopilot.apiary.io/#reference/api-methods/get-contacts-on-list
	* @list_id id of the list
	* @bookmark bookmark when more than 100 contacts
	*/
	public any function contacts(
		required string list_id,
		string bookmark = "void"
		
	) {		
		response = apiCall('GET','list/#list_id#/contacts/#bookmark#');
		return response.responseJson;		
	}


	/**
	* Check if contact is on list
	* @list_id ID of the list
	* @contact_id_or_email Either the Autopilot contact_id e.g. person_9EAF39E4-9AEC-4134-964A-D9D8D54162E7, or the contact's email address.
	 */
	public any function has(
		required string list_id,
		required string contact_id_or_email
	) {
		response = apiCall('GET','list/#list_id#/contact/#contact_id_or_email#');
		if (response.statuscode is 200) 
			return true; 
		else 
			return response.responseJson;		
	}


	/**
	* Add contact to list
	* @list_id ID of the list
	* @contact_id_or_email Either the Autopilot contact_id e.g. person_9EAF39E4-9AEC-4134-964A-D9D8D54162E7, or the contact's email address.
	 */
	public any function add(
		required string list_id,
		required string contact_id_or_email
	) {
		response = apiCall('POST','list/#list_id#/contact/#contact_id_or_email#');
		if (response.statuscode is 200) 
			return true; 
		else 
			return response.responseJson;		
	}


	/**
	* Remove a contact from a list
	* @list_id ID of the list
	* @contact_id_or_email Either the Autopilot contact_id e.g. person_9EAF39E4-9AEC-4134-964A-D9D8D54162E7, or the contact's email address.
	 */
	public any function remove(
		required string list_id,
		required string contact_id_or_email
	) {
		response = apiCall('DELETE','list/#list_id#/contact/#contact_id_or_email#');
		if (response.statuscode is 200) 
			return true; 
		else 
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
			if (apiResponse[ 'responseHeaders' ]['Content-Type'] is "application/json") {
				if (isJson(apiResponse.rawData)) {
					apiResponse[ 'responseJson' ] = deserializeJSON(apiResponse.rawData);
				} else {
					apiResponse[ 'responseJson' ] = {};
				}
			} else { 
				apiResponse[ 'responseJson' ]['error']="Non Json answer";	
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