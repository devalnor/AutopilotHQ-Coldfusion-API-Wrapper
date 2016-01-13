/**
*
* @file  /src/contact.cfc
* @author Maxime de Visscher 
* @description
*
*/

component output="false" displayname=""  {

	variables.component="Contact";

	public any function init(
		required any api,
		required any utils	
	){

		variables.api = arguments.api;
		variables.utils = arguments.utils;

		return this;
	}

	/**
	* Add or update new contact(s)
	* http://docs.autopilot.apiary.io/#reference/api-methods/addupdate-contact/add-or-update-contact
	* @contact struct or array of contact(s)
	*/
	public any function upsert (
		required any data
	){
		var body={};
		var reponse={};

		if (!isArray(data) and !isStruct(data)) {  
			response.error = "Data must be a struct are array"; 			
			return response;
		}

		if (isArray(data)) {
			body["contacts"]=data;
			response = apiCall('POST','contacts',utils.serializeJSON(body));
		} else {
			body["contact"]=data;
			response = apiCall('POST','contact',utils.serializeJSON(body));
		}

		return response.responseJson;
	}

	/**
	* Add new contact
	* http://docs.autopilot.apiary.io/#reference/api-methods/addupdate-contact/add-or-update-contact
	* @contact struct of contact
	*/
	public any function add (
		required struct contact
	){
		return this.upsert(contact);
	}

	/**
	* Change contact mail
	* http://docs.autopilot.apiary.io/#reference/api-methods/addupdate-contact/add-or-update-contact
	* @email old email
	* @newemail new email
	*/
	public any function changeEmail (
		required string email,
		required string newemail
	) {
		var body={};
		body["contact"]={}
		body["contact"]["Email"]=email;
		body["contact"]["_NewEmail"]=newemail;

		response = apiCall('POST','contact',utils.serializeJSON(body));	

		if (response.statuscode is 200) 
			return true; 
		else 
			return response;
	}

	/**
	* Update contact
	* http://docs.autopilot.apiary.io/#reference/api-methods/addupdate-contact/add-or-update-contact
	* @contact struct of contact
	*/
	public any function update (
		required struct contact
	){
		return this.upsert(contact);
	}

	/**
	* Bulk add contact
	* http://docs.autopilot.apiary.io/#reference/api-methods/bulk-add-contacts/add-or-update-contact
	* @contacts array of struct contact
	*/
	public any function  bulk(
		required array contacts
	) {
		/*var body={};

		body["contacts"]=arguments.contacts;
		response = apiCall('POST','contacts',utils.serializeJSON(body));*/
		return this.upsert(contacts);	
	}

	/**
	* Get contact
	* http://docs.autopilot.apiary.io/#reference/api-methods/contact-operations/add-or-update-contact
	* @contact_id_or_email Either the Autopilot contact_id e.g. person_9EAF39E4-9AEC-4134-964A-D9D8D54162E7, or the contact's email address.
	*/
	public any function get (
		required string contact_id_or_email,
	) 
	{
		response = apiCall('get','contact/#contact_id_or_email#');
		return response.responseJson;
	}

	/**
	* Delete contact
	* http://docs.autopilot.apiary.io/#reference/api-methods/contact-operations/add-or-update-contact
	* @contact_id_or_email Either the Autopilot contact_id e.g. person_9EAF39E4-9AEC-4134-964A-D9D8D54162E7, or the contact's email address.
	*/
	public any function delete (
		required string contact_id_or_email,
	) 
	{
		response = apiCall('DELETE','contact/#contact_id_or_email#');
		if (response.statuscode is 200) 
			return true; 
		else 
			return response.responseJson;
	}

	/**
	* Unsubscribe contact
	* http://docs.autopilot.apiary.io/#reference/api-methods/unsubscribe-contact/get-contact
	* @contact_id_or_email Either the Autopilot contact_id e.g. person_9EAF39E4-9AEC-4134-964A-D9D8D54162E7, or the contact's email address.
	*/
	public any function unsubscribe (
		required string contact_id_or_email,
	) 
	{
		response = apiCall('POST','contact/#contact_id_or_email#/unsubscribe');
		if (response.statuscode is 200) 
			return true; 
		else 
			return response.responseJson;
	}

	/**
	* Unsubscribe contact
	* Not clearly in the official API but the methode is still usefull
	* @email The contact's email address.
	*/
	public any function subscribe (
		required string email,
	) 
	{
		var body={};
		body["contact"]={}
		body["contact"]["Email"]=email;
		body["contact"]["unsubscribed"]=false;
		response = apiCall('POST','contact',utils.serializeJSON(body));
		if (response.statuscode is 200) 
			return true; 
		else 
			return response;
	}

	private any function apiCall (
		string httpMethod = 'GET',
		string path = '/',
		any body,
		struct queryParams = {},
		struct headers = {}
		)
	{

		var apiResponse = variables.api.call(arguments.httpMethod,arguments.path,arguments.body);
		apiResponse[ 'responseJson' ] = {}

		if (not structKeyExists(apiResponse, "error"))	{
			
			// Parse API answer
			apiResponse[ 'responseJson' ] = deserializeJSON(apiResponse.rawData);

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